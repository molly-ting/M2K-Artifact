// moe_align_block_shared_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates shared memory out-of-bounds bug from vLLM PR #12413

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define NUM_EXPERTS 4
#define BLOCK_SIZE 32
#define SHARED_SIZE ((NUM_EXPERTS + 1) + 1)

// -------------------------------------------------------
// BUGGY KERNEL using static shared memory
// Shared memory allocated for (num_experts + 1) + 1 elements
// But tokens_cnts offset assumes (blockDim.x + 1)
// -------------------------------------------------------
__global__ void moe_align_block_buggy() {
    // Hardcoded parameters to reduce arguments
    const int num_experts = NUM_EXPERTS;
    
    // Static shared memory - size determined at compile time
    __shared__ int shared_mem[SHARED_SIZE];

    int tid = threadIdx.x;

    // cumsum conceptually needs (num_experts + 1) elements
    int* cumsum = shared_mem;

    // ❌ BUG: tokens_cnts offset calculated using blockDim.x instead of num_experts
    // This assumes cumsum has (blockDim.x + 1) elements, not (num_experts + 1)
    // 
    // Allocated: shared_mem[SHARED_SIZE] = shared_mem[6]
    //   - cumsum uses indices [0..4] (num_experts + 1 = 5 elements)
    //   - tokens_cnts should start at index 5
    // 
    // But buggy code places it at: blockDim.x + 1 = 33
    // 
    // Result: tokens_cnts[0] accesses shared_mem[33]
    // But only shared_mem[0..5] exists!
    // Out-of-bounds by: 33 - 5 = 28 elements!
    int* tokens_cnts = shared_mem + blockDim.x + 1;  // ❌ BUG: index 33

    // Initialize cumsum within valid range
    if (tid < num_experts + 1) {
        cumsum[tid] = tid * 100;
    }

    __syncthreads();

    // ❌ OUT-OF-BOUNDS: When blockDim.x > num_experts, this writes beyond
    // the allocated shared memory!
    // 
    // tokens_cnts[0] = shared_mem[blockDim.x + 1]
    //                = shared_mem[33]
    // 
    // But shared_mem only has 6 elements [0..5]!
    // This is an illegal shared memory access!
    if (tid == 0) {
        tokens_cnts[0] = 1234;  // Writes to shared_mem[33] - OUT OF BOUNDS!
    }

    __syncthreads();

    // Try to read it back (will read garbage or cause error)
    if (tid == 0) {
        int val = tokens_cnts[0];  // Reads from shared_mem[33] - OUT OF BOUNDS!
        // Use val to prevent optimization
        if (val > 0) {
            cumsum[0] = val;
        }
    }
}

int main() {
    // BUG SCENARIO from PR #12413:
    // Shared memory is allocated for (num_experts + 1) + 1 elements
    // But kernel calculates tokens_cnts offset using blockDim.x
    // When blockDim.x > num_experts, this causes out-of-bounds access
    //
    // Configuration:
    //   num_experts = 4
    //   block_size = 32
    //   Allocated shared memory: (4 + 1) + 1 = 6 int32_t elements
    //   tokens_cnts offset: blockDim.x + 1 = 33
    //   Out-of-bounds: 33 > 5 (exceeds by 28 elements!)
    //
    // Bug Analysis:
    //   - Allocated: shared_mem[0..5] (6 elements)
    //   - cumsum uses: shared_mem[0..4] (5 elements)
    //   - tokens_cnts should be at: shared_mem[5] (1 element)
    //   - tokens_cnts ACTUALLY at: shared_mem[33] (OUT OF BOUNDS!)
    //   - Memory violation: accesses 28 elements beyond allocation
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG TRIGGER:
    // Thread 0 writes to tokens_cnts[0]
    // tokens_cnts = shared_mem + blockDim.x + 1
    //             = shared_mem + 33
    // 
    // tokens_cnts[0] = shared_mem[33]
    // 
    // But shared_mem only allocated as shared_mem[6]
    // Valid indices: 0 to 5
    // Accessed index: 33
    // 
    // OUT-OF-BOUNDS: 33 >> 5
    // Illegal shared memory access!
    
    ESBMC_verify_kernel(moe_align_block_buggy, grid, block);
    
    return 0;
}