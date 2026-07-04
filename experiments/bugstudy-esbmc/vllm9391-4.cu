// dynamic_scaled_int8_azp_quant_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates integer overflow bug from vLLM PR #9391

#include <stdio.h>
#include <math.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration - large enough to trigger int32 overflow
#define HIDDEN_SIZE 4096
#define NUM_TOKENS 600000
#define TOTAL_ELEMS ((long)HIDDEN_SIZE * NUM_TOKENS)

// Helper to convert float to int32 with rounding
__device__ inline int float_to_int32_rn(float x) {
    return (int)(x + 0.5f);
}

// Helper to clamp int32 to int8 range
__device__ inline char int32_to_int8(int x) {
    if (x < -128) return -128;
    if (x > 127) return 127;
    return (char)x;
}

// Simplified block reduce for max and min
__device__ float blockReduceMax(float val) {
    __shared__ float shared[256];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    for (int s = 128; s > 0; s >>= 1) {
        if (tid < s && tid + s < 256) {
            shared[tid] = shared[tid] > shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

__device__ float blockReduceMin(float val) {
    __shared__ float shared[256];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    for (int s = 128; s > 0; s >>= 1) {
        if (tid < s && tid + s < 256) {
            shared[tid] = shared[tid] < shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

// BUGGY VERSION: using int instead of int64_t for token_idx
__global__ void dynamic_scaled_int8_azp_quant_kernel(
    const float* __restrict__ input,
    char* __restrict__ out,
    float* scale)
{
    // Hardcoded parameters to reduce arguments
    const int hidden_size = HIDDEN_SIZE;
    
    int const token_idx = blockIdx.x;  // ❌ BUG: should be int64_t

    // Scan for the min and max value for this token
    float max_val = -3.402823466e+38F;
    float min_val = 3.402823466e+38F;
    
    for (int i = threadIdx.x; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        // token_idx * hidden_size = 600000 * 4096 = 2,457,600,000
        // INT32_MAX = 2,147,483,647
        // This causes integer overflow and incorrect indexing!
        int index = token_idx * hidden_size + i;
        float val = input[index];
        max_val = val > max_val ? val : max_val;
        min_val = val < min_val ? val : min_val;
    }
    
    // Reduce the max and min values across the block
    max_val = blockReduceMax(max_val);
    __syncthreads();
    min_val = blockReduceMin(min_val);
    
    __shared__ float scale_sh;
    __shared__ int azp_sh;
    
    // Compute the scale and zero point and store them
    if (threadIdx.x == 0) {
        float const scale_val = (max_val - min_val) / 255.0f;
        float const azp_float = nearbyintf(-128.0f - min_val / scale_val);
        int const azp_val = (int)azp_float;
        // Store the scale and azp into shared and global
        scale[token_idx] = scale_sh = scale_val;
        azp_sh = azp_val;
    }
    
    // Wait for the scale and azp to be computed
    __syncthreads();
    float const scale_val = scale_sh;
    int const azp_val = azp_sh;

    // Quantize the values
    for (int i = threadIdx.x; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        int index = token_idx * hidden_size + i;
        float const val = input[index];
        char const quant_val = int32_to_int8(float_to_int32_rn(val / scale_val) + azp_val);
        out[index] = quant_val;
    }
}

int main() {
    // BUG TRIGGER from PR #9391:
    // token_idx * hidden_size with token_idx=600000, hidden_size=4096
    // = 2,457,600,000 > INT32_MAX (2,147,483,647)
    // 
    // When token_idx >= 524288:
    // token_idx * 4096 >= 2,147,483,648 (overflow!)
    // 
    // This causes integer overflow in the index calculation,
    // leading to out-of-bounds memory access and corruption.
    
    // Allocate host memory for ESBMC verification
    float h_input[TOTAL_ELEMS];
    char h_output[TOTAL_ELEMS];
    float h_scales[NUM_TOKENS];
    
    // Initialize input
    for (long i = 0; i < TOTAL_ELEMS; i++) {
        h_input[i] = 1.0f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG TRIGGER:
    // When blockIdx.x (token_idx) = 600000:
    //   index = 600000 * 4096 + i = 2,457,600,000 + i
    //   INT32_MAX = 2,147,483,647
    //   Overflow: 2,457,600,000 > INT32_MAX
    // 
    // Result: index wraps around, causing:
    // - Out-of-bounds array access in min/max scan
    // - Out-of-bounds array access in quantization
    // - Memory corruption
    // - Wrong quantization results
    // - Incorrect scale and azp computation
    
    ESBMC_verify_kernel(dynamic_scaled_int8_azp_quant_kernel, grid, block,
        h_input,
        h_output,
        h_scales);
    
    return 0;
}