// buggy_rotary_launch.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates grid dimension bug from vLLM PR #5169

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define BATCH 1
#define NUM_HEADS 2
#define SEQ_LEN 16
#define TRUE_ROWS (BATCH * NUM_HEADS)
#define CORRECT_ELEMS (TRUE_ROWS * SEQ_LEN)
#define BUGGY_ROWS SEQ_LEN
#define BUGGY_ACCESS (BUGGY_ROWS * SEQ_LEN)

// -------------------------------------------------------
// BUGGY rotary-like kernel
// Writes to out[ row * seq_len + col ] without bounds check
// -------------------------------------------------------
__global__ void rotary_kernel_buggy(
    float* out,
    const float* in)
{
    // Hardcoded parameters
    const int batch = BATCH;
    const int num_heads = NUM_HEADS;
    const int seq_len = SEQ_LEN;
    
    int row = blockIdx.x;      // WRONG MAPPING: uses blockIdx directly
    int col = threadIdx.x;

    // ❌ BUG: No bounds check! 
    // When grid.x = seq_len = 16, row ranges from 0 to 15
    // But allocated rows = batch * num_heads = 1 * 2 = 2
    // This causes out-of-bounds writes for row >= 2!
    // 
    // Allocated: 2 rows × 16 cols = 32 elements
    // Accessed: 16 rows × 16 cols = 256 elements
    // Out-of-bounds: 224 elements!
    int idx = row * seq_len + col;
    
    // Wrap around for input to avoid read errors, but write is still OOB
    int in_idx = idx % (batch * num_heads * seq_len);
    out[idx] = in[in_idx] * 0.5f;
}

int main() {
    // Allocate host memory for ESBMC verification
    float h_in[CORRECT_ELEMS];
    float h_out[CORRECT_ELEMS];
    
    // Initialize input
    for (int i = 0; i < CORRECT_ELEMS; i++) {
        h_in[i] = (float)i;
    }
    
    // ❌ BUG: Launch with wrong grid dimension
    // grid.x = seq_len = 16 (WRONG! should be batch * num_heads = 2)
    // block.x = seq_len = 16
    //
    // Kernel will try to write 16 * 16 = 256 elements
    // But only 2 * 16 = 32 elements are allocated!
    // Out-of-bounds writes from index 32 to 255!
    
    dim3 grid(2);   // ❌ BUG: should be BATCH * NUM_HEADS
    dim3 block(2);
    
    ESBMC_verify_kernel(rotary_kernel_buggy, grid, block,
        h_out,
        h_in);
    
    return 0;
}