// rms_norm_stride_buggy.cu
//
// Minimal buggy example inspired by vLLM PR #26192:
//
// [ROCm][Bugfix][Model] Fix illegal memory access when running qwen3_moe
// models with rms_norm under certain torch.compile configs.
//
// Bug pattern: host passes a bogus (too-large) row stride to rms_norm_kernel
// because the tensor wasn't properly viewed as [-1, hidden_size]. The kernel
// uses that stride to index into a *contiguous* buffer, causing OOB access.

#include <cstdio>
#include <cmath>
#include <cuda_runtime.h>

__global__ void rms_norm_kernel_buggy(
    float* __restrict__ out,
    const float* __restrict__ input,
    long long input_stride,   // mimic int64_t stride from host
    int num_tokens,
    int hidden_size,
    float epsilon)
{
    int token_idx = blockIdx.x;
    int tid       = threadIdx.x;

    // Each block handles one "token row".
    if (token_idx >= num_tokens) {
        return;
    }

    // ❌ BUG: we trust input_stride blindly.
    // base index is token_idx * input_stride, which may be >> num_tokens*hidden_size.
    long long base = (long long)token_idx * input_stride;

    // Compute mean square for this "row".
    float sum_sq = 0.0f;
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float v = input[base + i];  // <-- OOB if base is too large
        sum_sq += v * v;
    }

    // Simple block reduction (naive): just use shared memory for demo.
    __shared__ float shm[1024];  // assume blockDim.x <= 1024
    shm[tid] = sum_sq;
    __syncthreads();

    // Reduce in shared memory
    for (int offset = blockDim.x / 2; offset > 0; offset >>= 1) {
        if (tid < offset) {
            shm[tid] += shm[tid + offset];
        }
        __syncthreads();
    }

    float inv_rms = 0.0f;
    if (tid == 0) {
        float mean_sq = shm[0] / hidden_size;
        inv_rms = rsqrtf(mean_sq + epsilon);
        shm[0] = inv_rms;
    }
    __syncthreads();
    inv_rms = shm[0];

    // Normalize
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float v = input[base + i];  // <-- same buggy base
        out[token_idx * hidden_size + i] = v * inv_rms;
    }
}

int main() {
    // Match the PR's example logic:
    // input_shape = (32768, 1, 128)
    // input_stride = (128, 4194304, 1)
    //
    // The contiguous buffer size is 32768 * 128 = 4194304 floats.
    const int seq_len     = 32768;   // tokens
    const int hidden_size = 128;     // last dim
    const int num_tokens  = seq_len; // effectively [-1, hidden_size]
    const long long total_elems = (long long)seq_len * hidden_size; // 4194304

    const size_t bytes = (size_t)total_elems * sizeof(float);

    float* h_input  = new float[total_elems];
    float* h_output = new float[total_elems];

    // Initialize input with some values.
    for (long long i = 0; i < total_elems; ++i) {
        h_input[i] = (float)(i % 1000) * 0.001f;
    }

    float* d_input  = nullptr;
    float* d_output = nullptr;

    cudaMalloc(&d_input, bytes);
    cudaMalloc(&d_output, bytes);

    cudaMemcpy(d_input, h_input, bytes, cudaMemcpyHostToDevice);
    cudaMemset(d_output, 0, bytes);

    // ❌ BUGGY STRIDE:
    // We pretend the stride between "rows" is 4194304, taken from
    // the middle dimension of a (32768, 1, 128) tensor's strides.
    //
    // But the actual contiguous layout is just [num_tokens, hidden_size]
    // with a logical row stride of hidden_size (=128).
    long long input_stride_buggy = 4194304;  // one full buffer-size

    dim3 grid(num_tokens);           // one block per token
    dim3 block(128);                 // up to hidden_size threads
    float epsilon = 1e-5f;

    rms_norm_kernel_buggy<<<grid, block>>>(
        d_output, d_input, input_stride_buggy,
        num_tokens, hidden_size, epsilon);

    cudaMemcpy(h_output, d_output, bytes, cudaMemcpyDeviceToHost);


    cudaFree(d_input);
    cudaFree(d_output);
    delete[] h_input;
    delete[] h_output;

    return 0;
}
