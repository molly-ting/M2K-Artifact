// fp8_dynamic_per_token_quant_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates integer overflow bug from vLLM PR #9425

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration - large enough to trigger int32 overflow
#define HIDDEN_SIZE 4096
#define NUM_TOKENS 600000
#define TOTAL_ELEMS ((long)HIDDEN_SIZE * NUM_TOKENS)

// Simple "fp8-like" quantization: scale, clamp to [0, 255], store as uint8.
__device__ inline unsigned char fake_fp8_quant(float x) {
    int v = (int)(x + 0.5f);
    if (v < 0)   v = 0;
    if (v > 255) v = 255;
    return (unsigned char)v;
}

// BUGGY VERSION: uses 32-bit token_idx * hidden_size for the offset,
// just like the pre-fix dynamic_per_token_scaled_fp8_quant_kernel.
__global__ void dynamic_per_token_scaled_fp8_quant_kernel_buggy(
    const float* __restrict__ input,
    unsigned char* __restrict__ out,
    const float* __restrict__ scales)
{
    // Hardcoded parameters to reduce arguments
    const int hidden_size = HIDDEN_SIZE;
    
    int tid       = threadIdx.x;
    int token_idx = blockIdx.x;

    // ❌ BUG: token_idx * hidden_size is done in 32-bit int.
    // For sufficiently large token_idx / hidden_size this can overflow.
    // token_idx * hidden_size = 600000 * 4096 = 2,457,600,000
    // INT32_MAX = 2,147,483,647
    // This causes integer overflow!
    const float* __restrict__ token_input  = &input[token_idx * hidden_size];
    unsigned char* __restrict__ token_output = &out[token_idx * hidden_size];

    float scale = scales[token_idx];

    // Simple per-token row quantization
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float x = token_input[i] * scale;
        token_output[i] = fake_fp8_quant(x);
    }
}

int main() {
    // BUG TRIGGER from PR #9425:
    // token_idx * hidden_size with token_idx=600000, hidden_size=4096
    // = 2,457,600,000 > INT32_MAX (2,147,483,647)
    // 
    // When token_idx >= 524288:
    // token_idx * 4096 >= 2,147,483,648 (overflow!)
    // 
    // This causes integer overflow in the pointer arithmetic:
    // &input[token_idx * hidden_size] computes wrong address
    // &out[token_idx * hidden_size] computes wrong address
    // Leading to out-of-bounds memory access and corruption.
    
    // Allocate host memory for ESBMC verification
    float h_input[TOTAL_ELEMS];
    unsigned char h_output[TOTAL_ELEMS];
    float h_scales[NUM_TOKENS];
    
    // Initialize input and scales
    for (long i = 0; i < TOTAL_ELEMS; i++) {
        h_input[i] = 1.0f;
    }
    for (int i = 0; i < NUM_TOKENS; i++) {
        h_scales[i] = 1.0f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG TRIGGER:
    // When blockIdx.x (token_idx) = 600000:
    //   offset = 600000 * 4096 = 2,457,600,000
    //   INT32_MAX = 2,147,483,647
    //   Overflow: 2,457,600,000 > INT32_MAX
    // 
    // Result: offset wraps around, causing:
    // - Wrong pointer arithmetic in &input[offset]
    // - Wrong pointer arithmetic in &out[offset]
    // - Out-of-bounds memory access
    // - Memory corruption
    // - Wrong quantization results
    
    ESBMC_verify_kernel(dynamic_per_token_scaled_fp8_quant_kernel_buggy, grid, block,
        h_input,
        h_output,
        h_scales);
    
    return 0;
}