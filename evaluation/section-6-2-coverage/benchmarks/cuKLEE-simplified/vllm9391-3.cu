// dynamic_scaled_int8_quant_buggy.cu
// Minimal buggy example inspired by vLLM's dynamic_scaled_int8_quant_kernel
// before PR #9391: int32 token_idx instead of int64_t causing overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <torch/all.h>
#include "dispatch_utils.h"

// Simple "float -> int8" helper using round-to-nearest.
__device__ inline int8_t float_to_int8_rn(float x) {
    // clamp to [-128, 127] just to keep it sane
    int v = __float2int_rn(x);
    if (v < -128) v = -128;
    if (v > 127)  v = 127;
    return static_cast<int8_t>(v);
}

// Simplified block reduce for max value (without CUB dependency)
template <int BLOCK_SIZE>
__device__ float blockReduceMax(float val) {
    __shared__ float shared[BLOCK_SIZE];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    // Tree reduction for max
    for (int s = BLOCK_SIZE / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared[tid] = shared[tid] > shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

// BUGGY VERSION: using int instead of int64_t for token_idx
template <typename scalar_t, typename scale_type>
__global__ void dynamic_scaled_int8_quant_kernel(
    scalar_t const* __restrict__ input,
    int8_t* __restrict__ out,
    scale_type* scale,
    const int hidden_size) {
    
    int const tid = threadIdx.x;
    int const token_idx = blockIdx.x;  // ❌ BUG: should be int64_t
    float absmax_val = 0.0f;
    float const zero = 0.0f;

    // Find absolute maximum value in this token
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        float val = static_cast<float>(input[token_idx * hidden_size + i]);
        val = val > zero ? val : -val;
        absmax_val = val > absmax_val ? val : absmax_val;
    }
    
    // Block-level reduction to find max across all threads
    float const block_absmax_val_maybe = blockReduceMax<1024>(absmax_val);
    
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
        out[token_idx * hidden_size + i] = float_to_int8_rn(
            static_cast<float>(input[token_idx * hidden_size + i]) * tmp_scale);
    }
}

void dynamic_scaled_int8_quant(
    torch::Tensor& out,          // [..., hidden_size]
    torch::Tensor const& input,  // [..., hidden_size]
    torch::Tensor& scales) {
  TORCH_CHECK(input.is_contiguous());
  TORCH_CHECK(out.is_contiguous());
  TORCH_CHECK(scales.is_contiguous());

  int const hidden_size = input.size(-1);
  int const num_tokens = input.numel() / hidden_size;
  dim3 const grid(num_tokens);
  dim3 const block(std::min(hidden_size, 1024));
  VLLM_DISPATCH_FLOATING_TYPES(
      input.scalar_type(), "dynamic_scaled_int8_quant_kernel", [&] {
  dynamic_scaled_int8_quant_kernel<scalar_t, float>
              <<<grid, block, 0>>>(
                  input.data_ptr<scalar_t>(), out.data_ptr<int8_t>(),
                  scales.data_ptr<float>(), hidden_size);
                   });
}