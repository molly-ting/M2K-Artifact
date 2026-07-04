// static_scaled_int8_quant_buggy.cu
// Minimal buggy example inspired by vLLM's static_scaled_int8_quant_kernel
// before PR #9391: double-offset + 32-bit indexing style bug.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>

// Simple "float -> int8" helper using round-to-nearest.
__device__ inline int8_t float_to_int8_rn(float x) {
    // clamp to [-128, 127] just to keep it sane
    return 0;
}

// BUGGY VERSION: pattern similar to pre-fix static_scaled_int8_quant_kernel
__global__ void static_scaled_int8_quant_kernel_buggy(
    const float* __restrict__ input,
    int8_t* __restrict__ out,
    const float* __restrict__ scale_ptr,
    int hidden_size) {

    int tid       = threadIdx.x;
    int token_idx = blockIdx.x;  // NOTE: int, not 64-bit
    float scale   = *scale_ptr;

    // Per-token base offset
    out   += token_idx * hidden_size;
    input += token_idx * hidden_size;

    // ❌ BUG:
    // We *already* advanced input/out to this token's row, but
    // we again add `token_idx * hidden_size` inside the index.
    // For later tokens this writes far past the end of the buffer.
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        int idx = token_idx * hidden_size + i;  // double offset
        float v = input[idx] / scale;           // also double offset on read
        out[idx] = float_to_int8_rn(v);
    }
}

int main() {
    // Make it small so it runs on any GPU, but still OOB with the bug.
    const int hidden_size = 4096;   // per-token length
    const int num_tokens  = 600000;      // number of rows
    // const int total_elems = hidden_size * num_tokens;
    const int alloc_tokens = 100;  // only allocate for 100 tokens
    const int total_elems_alloc = hidden_size * alloc_tokens;
    const size_t in_bytes  = total_elems_alloc * sizeof(float);
    const size_t out_bytes = total_elems_alloc * sizeof(int8_t);

    // Host buffers
    float* h_input  = new float[total_elems_alloc];
    int8_t* h_output = new int8_t[total_elems_alloc];


    // Device buffers
    float *d_input, *d_scale;
    int8_t *d_output;

    cudaMalloc(&d_input, in_bytes);
    cudaMalloc(&d_output, out_bytes);
    cudaMalloc(&d_scale, sizeof(float));

    float scale = 10.0f;
    cudaMemcpy(d_input, h_input, in_bytes, cudaMemcpyHostToDevice);
    cudaMemset(d_output, 0, out_bytes);
    cudaMemcpy(d_scale, &scale, sizeof(float), cudaMemcpyHostToDevice);

    dim3 grid(num_tokens);
    dim3 block(256);

    static_scaled_int8_quant_kernel_buggy<<<grid, block>>>(
        d_input, d_output, d_scale, hidden_size);

    cudaMemcpy(h_output, d_output, out_bytes, cudaMemcpyDeviceToHost);


    cudaFree(d_input);
    cudaFree(d_output);
    cudaFree(d_scale);
    delete[] h_input;
    delete[] h_output;

    return 0;
}
