// fp8_dynamic_per_token_quant_buggy.cu
// Minimal buggy example inspired by vLLM PR #9425:
//
// [Bugfix][Kernel] Prevent integer overflow in fp8 dynamic per-token quantize kernel
//
// The bug: token_idx * hidden_size is computed in 32-bit int and can overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <torch/all.h>

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

void dynamic_per_token_scaled_fp8_quant(
    torch::Tensor& out,          // [..., d]
    torch::Tensor const& input,  // [..., d]
    torch::Tensor& scales) {
  TORCH_CHECK(input.is_contiguous());
  TORCH_CHECK(out.is_contiguous());

  int const hidden_size = input.size(-1);
  int const num_tokens = input.numel() / hidden_size;
  dim3 const grid(num_tokens);
  dim3 const block(std::min(hidden_size, 1024));

  dynamic_per_token_scaled_fp8_quant_kernel_buggy
            <<<grid, block, 0>>>(
                input.data_ptr<float>(),
                out.data_ptr<std::uint8_t>(), scales.data_ptr<float>(), hidden_size);
}