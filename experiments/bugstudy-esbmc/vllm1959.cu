// silu_and_mul_buggy.cpp
// Minimal CUDA example for ESBMC verification
// Demonstrates device mismatch bug from vLLM PR #1959

#include <stdio.h>
#include <math.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define NUM_TOKENS 4
#define D 256
#define INPUT_ELEMS (NUM_TOKENS * 2 * D)
#define OUT_ELEMS (NUM_TOKENS * D)

// -------------------------------------------------------
// CUDA kernel (same mathematical operation as vLLM's)
// out = silu(x) * y where input = [x, y] concatenated
// -------------------------------------------------------
__global__ void silu_and_mul_kernel(
    float* out,
    const float* input)
{
    // Hardcoded parameters to reduce arguments
    const int d = D;
    
    int row = blockIdx.x;
    int col = threadIdx.x;
    if (col >= d) return;

    // input layout: [..., 2*d]
    float x = input[row * 2 * d + col];
    float y = input[row * 2 * d + col + d];

    // BUG: silu activation
    float sig = 1.f / (1.f + expf(-x));
    out[row * d + col] = sig * x * y;
}

int main() {
    // Allocate host memory for ESBMC verification
    float h_input[INPUT_ELEMS];
    float h_output[OUT_ELEMS];
    
    // Initialize input
    for (int i = 0; i < INPUT_ELEMS; i++) {
        h_input[i] = 1.0f;
    }
    
    // Launch kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG: In original code, kernel launches on wrong device
    // With ESBMC, we verify the kernel logic itself
    // The bug pattern: memory allocated on Device 1, kernel runs on Device 0
    // This causes cudaErrorInvalidDevicePointer or incorrect results
    
    ESBMC_verify_kernel(silu_and_mul_kernel, grid, block,
        h_output,
        h_input);
    
    return 0;
}