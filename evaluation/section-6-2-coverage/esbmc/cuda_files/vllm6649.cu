// fp8_quant_overflow_bug.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates integer overflow bug from vLLM PR #6649

#include <stdio.h>
#include <cuda_runtime_api.h>
#include <math.h>

#define CUDA_CHECK(expr) expr

// Configuration - large enough to trigger int32 overflow
#define NUM_TOKENS 1000000
#define HIDDEN_SIZE 5120
#define NUM_ELEMENTS ((long)NUM_TOKENS * HIDDEN_SIZE)
#define INT32_MAX 2147483647

// Helper function to convert float to FP8 (simplified)
__device__ __forceinline__ unsigned char float_to_fp8(float val) {
    // Simplified FP8 conversion - clamp and scale
    float clamped = fminf(fmaxf(val, -448.0f), 448.0f);
    return (unsigned char)((clamped / 448.0f) * 127.0f + 128.0f);
}

// ❌ BUGGY KERNEL: Uses int32 for loop counter
// With num_elements > 2^31, this will overflow
__global__ void scaled_fp8_quant_kernel_buggy(
    unsigned char* __restrict__ output,
    const float* __restrict__ input)
{
    // Hardcoded to reduce arguments
    const int num_elements = (int)NUM_ELEMENTS;  // ❌ BUG: Cast to int32 causes truncation
    const float inv_scale = 1.0f;
    
    // ❌ BUG: Loop counter 'i' is int32, will overflow with large num_elements
    // NUM_ELEMENTS = 1,000,000 * 5,120 = 5,120,000,000
    // INT32_MAX = 2,147,483,647
    // When num_elements is cast to int32, it wraps around to negative value!
    // This causes:
    // 1. Loop never executes or executes with wrong bounds
    // 2. Illegal memory access (negative or out-of-bounds index)
    // 3. Memory corruption
    for (int i = blockIdx.x * blockDim.x + threadIdx.x; 
         i < num_elements; 
         i += blockDim.x * gridDim.x) {
        float val = input[i] * inv_scale;
        output[i] = float_to_fp8(val);
    }
}

int main() {
    // Scenario from PR #6649: neuralmagic/Mistral-Nemo-Instruct-2407-FP8
    // Maximum sequence length: 1 million tokens
    // Hidden size: 5120
    // Total elements: 1,000,000 * 5,120 = 5,120,000,000 > INT32_MAX (2,147,483,647)
    
    // Allocate host memory for ESBMC verification
    float h_input[NUM_ELEMENTS];
    unsigned char h_output[NUM_ELEMENTS];
    
    // Initialize input
    for (long i = 0; i < NUM_ELEMENTS; i++) {
        h_input[i] = 1.0f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 block(2);
    dim3 grid(2);  // Simplified grid for ESBMC
    
    // BUG TRIGGER:
    // NUM_ELEMENTS = 5,120,000,000
    // INT32_MAX = 2,147,483,647
    // Overflow: 5,120,000,000 > 2,147,483,647
    // 
    // When cast to int32: 5,120,000,000 % 2^32 = 825,033,696 (wrong!)
    // Or becomes negative after wraparound
    // 
    // This causes:
    // - Loop condition (i < num_elements) uses wrong value
    // - Array accesses go out of bounds
    // - Only partial data gets processed
    // - Memory corruption from invalid indices
    
    ESBMC_verify_kernel(scaled_fp8_quant_kernel_buggy, grid, block, h_output, h_input);
    
    return 0;
}