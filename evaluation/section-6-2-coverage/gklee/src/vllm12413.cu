// moe_align_block_shared_buggy.cu
//
// Minimal buggy example inspired by vLLM PR #12413:
//
// [Bugfix][Kernel] Fix moe align block issue for mixtral
//
// Bug pattern: dynamic shared memory is sized as if cumsum has
// (num_experts + 1) elements, but the kernel offsets tokens_cnts
// as if cumsum had (blockDim.x + 1) elements.
// When blockDim.x > num_experts, tokens_cnts starts past the end
// of the allocated shared memory, causing illegal shared memory access.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>

#define CUDA_CHECK(expr)                                                      \
    do {                                                                      \
        cudaError_t err__ = (expr);                                           \
        if (err__ != cudaSuccess) {                                           \
            std::fprintf(stderr, "CUDA error %s at %s:%d: %s\n",              \
                         #expr, __FILE__, __LINE__,                            \
                         cudaGetErrorString(err__));                          \
            std::exit(EXIT_FAILURE);                                          \
        }                                                                     \
    } while (0)

typedef int32_t token_cnts_t;

// -------------------------------------------------------
// BUGGY KERNEL using dynamic shared memory
// Shared memory allocated for (num_experts + 1) + 1 elements
// But tokens_cnts offset assumes (blockDim.x + 1)
// -------------------------------------------------------
__global__ void moe_align_block_buggy(int num_experts) {
    // Dynamic shared memory - size determined at launch time
    extern int32_t shared_mem[];

    int tid = threadIdx.x;

    // cumsum conceptually needs (num_experts + 1) elements
    int32_t* cumsum = shared_mem;

    // ❌ BUG: tokens_cnts offset calculated using blockDim.x instead of num_experts
    // This assumes cumsum has (blockDim.x + 1) elements, not (num_experts + 1)
    token_cnts_t* tokens_cnts =
        reinterpret_cast<token_cnts_t*>(shared_mem + blockDim.x + 1);

    // Initialize cumsum within valid range
    if (tid < num_experts + 1) {
        cumsum[tid] = tid * 100;
    }

    __syncthreads();

    // ❌ OUT-OF-BOUNDS: When blockDim.x > num_experts, this writes beyond
    // the allocated shared memory!
    if (tid == 0) {
        tokens_cnts[0] = 1234;  // Writes to shared_mem[blockDim.x + 1]
    }

    __syncthreads();

    // Try to read it back (will read garbage or cause error)
    if (tid == 0) {
        int val = tokens_cnts[0];
        // In real code, this would be used for further computation
    }
}

// -------------------------------------------------------
// Main function to trigger the bug
// -------------------------------------------------------
int main() {
    // Configuration to trigger the bug
    const int num_experts = 4;    // Small number of experts
    const int block_size  = 32;   // Larger than num_experts

    std::printf("=== Shared Memory Bug Trigger Analysis ===\n");
    std::printf("Configuration:\n");
    std::printf("  num_experts = %d\n", num_experts);
    std::printf("  block_size (blockDim.x) = %d\n", block_size);
    std::printf("\nShared Memory Layout:\n");
    std::printf("  cumsum needs: (num_experts + 1) = %d int32_t elements\n", num_experts + 1);
    std::printf("  tokens_cnts needs: 1 int32_t element\n");
    std::printf("  BUGGY allocation: (%d + 1) + 1 = %d int32_t elements\n", 
                num_experts, num_experts + 2);
    std::printf("  Total bytes allocated: %d * 4 = %d bytes\n", 
                num_experts + 2, (num_experts + 2) * 4);
    
    std::printf("\nBug Analysis:\n");
    std::printf("  tokens_cnts placed at: shared_mem[blockDim.x + 1] = shared_mem[%d]\n", 
                block_size + 1);
    std::printf("  Valid indices: 0 to %d\n", num_experts + 1);
    std::printf("  ❌ OUT-OF-BOUNDS: index %d > %d (exceeds by %d elements)\n", 
                block_size + 1, num_experts + 1, block_size - num_experts);
    std::printf("  Memory violation: %d bytes beyond allocation!\n\n", 
                (block_size - num_experts) * 4);

    // Allocate shared memory incorrectly (based on num_experts, not blockDim.x)
    // This is what causes the bug!
    const int n_ints_alloc = (num_experts + 1) + 1;  // Should be (blockDim.x + 1) + 1
    const size_t shared_bytes = n_ints_alloc * sizeof(int32_t);

    std::printf("Launching buggy kernel...\n");
    std::printf("  Allocated shared memory: %zu bytes (%d int32_t)\n", 
                shared_bytes, n_ints_alloc);
    std::printf("  Kernel expects at least: %d int32_t (for tokens_cnts at index %d)\n",
                block_size + 2, block_size + 1);
    std::printf("  Shared memory underflow: %d - %d = %d elements short!\n\n",
                block_size + 2, n_ints_alloc, block_size + 2 - n_ints_alloc);

    // Launch kernel with insufficient shared memory
    moe_align_block_buggy<<<1, block_size, shared_bytes>>>(num_experts);

    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    std::printf("Kernel execution completed.\n");
    std::printf("(Out-of-bounds shared memory access occurred!)\n");

    return 0;
}