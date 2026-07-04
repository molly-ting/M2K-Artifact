#include "hip/hip_runtime.h"
// buggy_rotary_launch.cpp
//
// Minimal standalone CUDA file reproducing the bug fixed in
// https://github.com/vllm-project/vllm/pull/5169
//
// Bug summary:
//   - Kernel grid dimension uses seq_len instead of (batch * num_heads)
//   - Indexing formula expects batch*num_heads rows
//   - When seq_len is larger → out-of-bounds memory writes
//
// PR #5169 fixes this by changing the grid dimension so that
// threads map correctly to the [batch, num_heads, seq_len] layout.

#include <cstdio>
#include <hip/hip_runtime.h>

#define CUDA_CHECK(expr)                                                      \
    do {                                                                      \
        hipError_t err__ = (expr);                                           \
        if (err__ != hipSuccess) {                                           \
            std::fprintf(stderr, "CUDA error %s at %s:%d: %s\n",              \
                         #expr, __FILE__, __LINE__,                            \
                         hipGetErrorString(err__));                          \
            std::exit(EXIT_FAILURE);                                          \
        }                                                                     \
    } while (0)

// -------------------------------------------------------
// BUGGY rotary-like kernel
// Writes to out[ row * seq_len + col ] without bounds check
// -------------------------------------------------------
__global__ void rotary_kernel_buggy(float* out,
                                    const float* in,
                                    int batch,
                                    int num_heads,
                                    int seq_len) {

    int row = blockIdx.x;      // WRONG MAPPING: uses blockIdx directly
    int col = threadIdx.x;

    // ❌ BUG: No bounds check! 
    // When grid.x = seq_len, row can be much larger than batch*num_heads
    // This causes out-of-bounds writes!
    int idx = row * seq_len + col;
    out[idx] = in[idx % (batch * num_heads * seq_len)] * 0.5f; // wrap around for input
}

// -------------------------------------------------------
// BUGGY launch function
// grid.x = seq_len   <-- WRONG! Should be batch * num_heads
// -------------------------------------------------------
void launch_buggy(float* out,
                  const float* in,
                  int batch,
                  int num_heads,
                  int seq_len) {

    dim3 grid(seq_len);   // ❌ BUG: should be batch * num_heads
    dim3 block(seq_len > 1024 ? 1024 : seq_len);

    rotary_kernel_buggy<<<grid, block>>>(out, in,
                                         batch,
                                         num_heads,
                                         seq_len);

    CUDA_CHECK(hipGetLastError());
    CUDA_CHECK(hipDeviceSynchronize());
}

// -------------------------------------------------------
// Demonstration with clear bug trigger
// -------------------------------------------------------
int main() {
    // ❌ BUG TRIGGER: seq_len >> batch*num_heads
    // Correct allocation: batch * num_heads * seq_len
    // Buggy kernel accesses: seq_len * seq_len (much larger!)
    
    int batch = 1;
    int num_heads = 2;
    int seq_len = 16;

    int true_rows = batch * num_heads;           // = 2 (correct)
    int buggy_rows = seq_len;                    // = 16 (wrong!)
    int correct_elems = true_rows * seq_len;     // = 32 elements allocated
    int buggy_access = buggy_rows * seq_len;     // = 256 elements accessed!

    std::printf("=== Bug Trigger Analysis ===\n");
    std::printf("Configuration:\n");
    std::printf("  batch=%d, num_heads=%d, seq_len=%d\n", batch, num_heads, seq_len);
    std::printf("  Correct rows (batch*num_heads) = %d\n", true_rows);
    std::printf("  Buggy rows (seq_len) = %d\n", buggy_rows);
    std::printf("\nMemory Analysis:\n");
    std::printf("  Allocated elements = %d * %d = %d\n", true_rows, seq_len, correct_elems);
    std::printf("  Buggy kernel accesses = %d * %d = %d\n", buggy_rows, seq_len, buggy_access);
    std::printf("  OUT-OF-BOUNDS: %d - %d = %d elements!\n\n", 
                buggy_access, correct_elems, buggy_access - correct_elems);

    // Allocate CORRECT size (what the code expects)
    float* h_in = new float[correct_elems];
    float* h_out = new float[correct_elems];

    for (int i = 0; i < correct_elems; ++i) h_in[i] = (float)i;

    float* d_in;
    float* d_out;
    CUDA_CHECK(hipMalloc(&d_in,  correct_elems * sizeof(float)));
    CUDA_CHECK(hipMalloc(&d_out, correct_elems * sizeof(float)));

    CUDA_CHECK(hipMemcpy(d_in, h_in,
                         correct_elems * sizeof(float),
                         hipMemcpyHostToDevice));

    std::printf("Launching buggy kernel...\n");
    std::printf("  grid.x = %d (WRONG! should be %d)\n", seq_len, true_rows);
    std::printf("  block.x = %d\n", seq_len);
    std::printf("  Kernel will try to write %d elements but only %d allocated!\n\n",
                buggy_access, correct_elems);

    // This will cause out-of-bounds memory access!
    launch_buggy(d_out, d_in,
                 batch,
                 num_heads,
                 seq_len);

    std::printf("Kernel execution completed.\n");
    std::printf("(Out-of-bounds writes occurred at indices %d to %d)\n",
                correct_elems, buggy_access - 1);

    CUDA_CHECK(hipMemcpy(h_out, d_out,
                         correct_elems * sizeof(float),
                         hipMemcpyDeviceToHost));

    CUDA_CHECK(hipFree(d_in));
    CUDA_CHECK(hipFree(d_out));
    delete[] h_in;
    delete[] h_out;

    return 0;
}