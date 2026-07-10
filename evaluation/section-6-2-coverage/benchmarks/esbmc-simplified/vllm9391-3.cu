// dynamic_scaled_int8_quant_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates integer overflow bug from vLLM PR #9391

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration - large enough to trigger int32 overflow
#define HIDDEN_SIZE 4096
#define NUM_TOKENS 600000
#define TOTAL_ELEMS ((long)HIDDEN_SIZE * NUM_TOKENS)

// Simple "float -> int8" helper using round-to-nearest.
__device__ inline char float_to_int8_rn(float x) {
    // clamp to [-128, 127]
    int v = (int)(x + 0.5f);
    if (v < -128) v = -128;
    if (v > 127)  v = 127;
    return (char)v;
}

// Simplified block reduce for max value
__device__ float blockReduceMax(float val) {
    __shared__ float shared[256];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    // Tree reduction for max
    for (int s = 128; s > 0; s >>= 1) {
        if (tid < s && tid + s < 256) {
            shared[tid] = shared[tid] > shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

// BUGGY VERSION: using int instead of int64_t for token_idx
__global__ void dynamic_scaled_int8_quant_kernel(
    const float* __restrict__ input,
    char* __restrict__ out,
    float* scale)
{
    // Hardcoded parameters to reduce arguments
    const int hidden_size = HIDDEN_SIZE;
    
    int const tid = threadIdx.x;
    int const token_idx = blockIdx.x;  // ❌ BUG: should be int64_t
    float absmax_val = 0.0f;
    float const zero = 0.0f;

    // Find absolute maximum value in this token
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        // token_idx * hidden_size = 600000 * 4096 = 2,457,600,000
        // INT32_MAX = 2,147,483,647
        // This causes integer overflow and incorrect indexing!
        int index = token_idx * hidden_size + i;
        
        float val = input[index];
        val = val > zero ? val : -val;
        absmax_val = val > absmax_val ? val : absmax_val;
    }
    
    // Block-level reduction to find max across all threads
    float const block_absmax_val_maybe = blockReduceMax(absmax_val);
    
    __shared__ float block_absmax_val;
    if (tid == 0) {
        block_absmax_val = block_absmax_val_maybe;
        scale[token_idx] = block_absmax_val / 127.0f;
    }
    __syncthreads();

    // Quantize using computed scale
    float const tmp_scale = 127.0f / block_absmax_val;
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        int index = token_idx * hidden_size + i;
        out[index] = float_to_int8_rn(input[index] * tmp_scale);
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
    // - Out-of-bounds array access
    // - Memory corruption
    // - Wrong quantization results
    // - Incorrect scale computation
    
    ESBMC_verify_kernel(dynamic_scaled_int8_quant_kernel, grid, block,
        h_input,
        h_output,
        h_scales);
    
    return 0;
}