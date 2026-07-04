// static_scaled_int8_quant_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates double-offset bug from vLLM PR #9391

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define HIDDEN_SIZE 4096
#define NUM_TOKENS 600000
#define ALLOC_TOKENS 100
#define TOTAL_ELEMS_ALLOC (HIDDEN_SIZE * ALLOC_TOKENS)

// Simple "float -> int8" helper using round-to-nearest.
__device__ inline char float_to_int8_rn(float x) {
    // clamp to [-128, 127]
    int v = (int)(x + 0.5f);
    if (v < -128) v = -128;
    if (v > 127)  v = 127;
    return (char)v;
}

// BUGGY VERSION: pattern similar to pre-fix static_scaled_int8_quant_kernel
__global__ void static_scaled_int8_quant_kernel_buggy(
    const float* __restrict__ input,
    char* __restrict__ out)
{
    // Hardcoded parameters to reduce arguments
    const int hidden_size = HIDDEN_SIZE;
    const float scale = 10.0f;
    
    int tid       = threadIdx.x;
    int token_idx = blockIdx.x;  // NOTE: int, not 64-bit

    // Per-token base offset - pointers advanced to this token's row
    const float* input_row = input + token_idx * hidden_size;
    char* out_row = out + token_idx * hidden_size;

    // ❌ BUG: DOUBLE OFFSET!
    // We *already* advanced input/out to this token's row, but
    // we again add `token_idx * hidden_size` inside the index.
    // For later tokens this writes far past the end of the buffer.
    // 
    // When token_idx = 100:
    //   out_row already points to: out + 100 * 4096 = out + 409600
    //   But then we write to: out_row[100 * 4096 + i] = out[409600 + 409600 + i]
    //   This is DOUBLE the correct offset!
    //   Buffer only has 100 * 4096 = 409600 elements allocated
    //   But we're accessing index 819200+ which is OUT OF BOUNDS!
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        int idx = token_idx * hidden_size + i;  // ❌ BUG: double offset
        float v = input_row[idx] / scale;       // ❌ BUG: double offset on read
        out_row[idx] = float_to_int8_rn(v);     // ❌ BUG: double offset on write
    }
}

int main() {
    // BUG SCENARIO from PR #9391:
    // Kernel advances pointers by token_idx * hidden_size
    // But then AGAIN adds token_idx * hidden_size to the index
    // This causes double offset - accessing 2x the intended location!
    //
    // Allocated: 100 tokens * 4096 = 409600 elements
    // When token_idx = 100:
    //   Should access: indices 409600 to 413695 (out of bounds already)
    //   Actually accesses: indices 819200 to 823295 (DOUBLE out of bounds!)
    
    // Allocate host memory for ESBMC verification
    float h_input[TOTAL_ELEMS_ALLOC];
    char h_output[TOTAL_ELEMS_ALLOC];
    
    // Initialize input
    for (int i = 0; i < TOTAL_ELEMS_ALLOC; i++) {
        h_input[i] = 1.0f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);  // 2 tokens but only 100 allocated!
    dim3 block(2);
    
    // BUG TRIGGER:
    // grid.x = 600000 tokens
    // Only allocated for 100 tokens (409600 elements)
    // 
    // When blockIdx.x (token_idx) >= 100:
    //   Pointer offset: token_idx * 4096 >= 409600 (already OOB)
    //   Index offset: token_idx * 4096 >= 409600 (double offset!)
    //   Total access: 2 * token_idx * 4096 (MASSIVE out of bounds!)
    // 
    // Example at token_idx = 100:
    //   out_row = out + 409600
    //   out_row[409600 + i] accesses out[819200 + i]
    //   Buffer size: 409600
    //   Out-of-bounds by: 409600 elements!
    
    ESBMC_verify_kernel(static_scaled_int8_quant_kernel_buggy, grid, block,
        h_input,
        h_output);
    
    return 0;
}