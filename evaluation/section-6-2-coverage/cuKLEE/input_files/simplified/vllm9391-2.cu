// static_scaled_int8_quant_buggy.cu
// Minimal buggy example inspired by vLLM's static_scaled_int8_azp_quant_kernel
// before PR #9391: int32 token_idx instead of int64_t causing overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <torch/all.h>
#include <cub/util_type.cuh>
#include <cub/cub.cuh>
#include "dispatch_utils.h"

// Helper to convert float to int32 with rounding
__device__ inline int32_t float_to_int32_rn(float x) {
    return __float2int_rn(x);
}

// Helper to clamp int32 to int8 range
__device__ inline int8_t int32_to_int8(int32_t x) {
    if (x < -128) return -128;
    if (x > 127) return 127;
    return static_cast<int8_t>(x);
}

// BUGGY VERSION: using int instead of int64_t for token_idx
template <typename scalar_t, typename scale_type, typename azp_type>
__global__ void static_scaled_int8_azp_quant_kernel(
    scalar_t const* __restrict__ input,
    int8_t* __restrict__ out,
    scale_type const* scale_ptr,
    azp_type const* azp_ptr,
    const int hidden_size) {
    
    int const tid = threadIdx.x;
    int const token_idx = blockIdx.x;  // ❌ BUG: should be int64_t
    scale_type const scale = *scale_ptr;
    azp_type const azp = *azp_ptr;

    for (int i = tid; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        // This causes incorrect indexing for large token_idx values
        auto const val = static_cast<float>(input[token_idx * hidden_size + i]);
        auto const quant_val = int32_to_int8(float_to_int32_rn(val / scale) + azp);
        out[token_idx * hidden_size + i] = quant_val;
    }
}

void static_scaled_int8_quant(torch::Tensor& out,          // [..., hidden_size]
                              torch::Tensor const& input,  // [..., hidden_size]
                              torch::Tensor const& scale,
                              c10::optional<torch::Tensor> const& azp) {
  TORCH_CHECK(input.is_contiguous());
  TORCH_CHECK(out.is_contiguous());
  TORCH_CHECK(scale.numel() == 1);
  TORCH_CHECK(!azp || azp->numel() == 1);

  int const hidden_size = input.size(-1);
  int const num_tokens = input.numel() / hidden_size;
  dim3 const grid(num_tokens);
  dim3 const block(std::min(hidden_size, 1024));
  VLLM_DISPATCH_FLOATING_TYPES(
      input.scalar_type(), "static_scaled_int8_quant_kernel", [&] {
    static_scaled_int8_azp_quant_kernel<scalar_t, float, int32_t>
        <<<grid, block>>>(
            input.data_ptr<scalar_t>(),
            out.data_ptr<int8_t>(),
            scale.data_ptr<float>(),
            azp->data_ptr<int32_t>(),
            hidden_size
        );
    });
}