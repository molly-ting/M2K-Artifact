// fp8_dynamic_per_token_quant_buggy.cu
// Minimal buggy example inspired by vLLM PR #9425:
//
// [Bugfix][Kernel] Prevent integer overflow in fp8 dynamic per-token quantize kernel
//
// The bug: token_idx * hidden_size is computed in 32-bit int and can overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>

// Simple "fp8-like" quantization: scale, clamp to [0, 255], store as uint8.
__device__ inline std::uint8_t fake_fp8_quant(float x) {
    int v = __float2int_rn(x);
    if (v < 0)   v = 0;
    if (v > 255) v = 255;
    return static_cast<std::uint8_t>(v);
}

// BUGGY VERSION: uses 32-bit token_idx * hidden_size for the offset,
// just like the pre-fix dynamic_per_token_scaled_fp8_quant_kernel.
__global__ void dynamic_per_token_scaled_fp8_quant_kernel_buggy(
    const float* __restrict__ input,
    std::uint8_t* __restrict__ out,
    const float* __restrict__ scales,
    int hidden_size)
{
    int tid       = threadIdx.x;
    int token_idx = blockIdx.x;

    // ❌ BUG: token_idx * hidden_size is done in 32-bit int.
    // For sufficiently large token_idx / hidden_size this can overflow.
    const float* __restrict__ token_input  = &input[token_idx * hidden_size];
    std::uint8_t* __restrict__ token_output = &out[token_idx * hidden_size];

    float scale = scales[token_idx];

    // Simple per-token row quantization
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float x = token_input[i] * scale;
        token_output[i] = fake_fp8_quant(x);
    }
}

int main() {
    // ---- 1) Demonstrate the integer-overflow pattern on host ----
    {
        std::int32_t big_token_idx   = 70000;   // 7e4
        std::int32_t big_hidden_size = 70000;   // 7e4
        // 7e4 * 7e4 = 4.9e9 > 2^31-1 → overflows 32-bit signed int
        std::int32_t offset32 = big_token_idx * big_hidden_size;   // overflow
        std::int64_t offset64 = static_cast<std::int64_t>(big_token_idx) *
                                static_cast<std::int64_t>(big_hidden_size);  // correct

    }

    // ---- 2) Run the buggy kernel with LARGE sizes to trigger overflow ----
    // ❌ BUG TRIGGER: token_idx * hidden_size with token_idx=600000, hidden_size=4096
    // = 2,457,600,000 (close to INT32_MAX)
    const int hidden_size = 4096;   // per-token length
    const int num_tokens  = 600000; // large number to trigger overflow
    const long long total_elems = (long long)hidden_size * num_tokens;

    const size_t in_bytes    = total_elems * sizeof(float);
    const size_t out_bytes   = total_elems * sizeof(std::uint8_t);
    const size_t scale_bytes = num_tokens * sizeof(float);

    // Device buffers only (host allocation would be too large)
    float*        d_input  = nullptr;
    std::uint8_t* d_output = nullptr;
    float*        d_scales = nullptr;

    cudaMalloc(&d_input,  in_bytes);
    cudaMalloc(&d_output, out_bytes);
    cudaMalloc(&d_scales, scale_bytes);

    cudaMemset(d_input, 0, in_bytes);   // Initialize to zero
    cudaMemset(d_output, 0, out_bytes);

    dim3 grid(num_tokens);
    dim3 block(256);

    dynamic_per_token_scaled_fp8_quant_kernel_buggy<<<grid, block>>>(
        d_input, d_output, d_scales, hidden_size);

    cudaDeviceSynchronize();

    // Cleanup
    cudaFree(d_input);
    cudaFree(d_output);
    cudaFree(d_scales);

    return 0;
}