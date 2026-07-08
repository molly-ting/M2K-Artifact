// dynamic_scaled_int8_azp_quant_buggy.cu
// Minimal buggy example inspired by vLLM's dynamic_scaled_int8_azp_quant_kernel
// before PR #9391: int32 token_idx instead of int64_t causing overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <limits>
#include <cmath>
#include <torch/all.h>
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

// Simplified block reduce for max and min (without CUB dependency)
template <int BLOCK_SIZE>
__device__ float blockReduceMax(float val) {
    __shared__ float shared[BLOCK_SIZE];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    for (int s = BLOCK_SIZE / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared[tid] = shared[tid] > shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

template <int BLOCK_SIZE>
__device__ float blockReduceMin(float val) {
    __shared__ float shared[BLOCK_SIZE];
    int tid = threadIdx.x;
    
    shared[tid] = val;
    __syncthreads();
    
    for (int s = BLOCK_SIZE / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared[tid] = shared[tid] < shared[tid + s] ? shared[tid] : shared[tid + s];
        }
        __syncthreads();
    }
    
    return shared[0];
}

// BUGGY VERSION: using int instead of int64_t for token_idx
template <typename scalar_t, typename scale_type, typename azp_type>
__global__ void dynamic_scaled_int8_azp_quant_kernel(
    scalar_t const* __restrict__ input,
    int8_t* __restrict__ out,
    scale_type* scale,
    azp_type* azp,
    const int hidden_size) {
    
    int const token_idx = blockIdx.x;  // ❌ BUG: should be int64_t

    // Scan for the min and max value for this token
    float max_val = -3.402823466e+38F;  // std::numeric_limits<float>::min()
    float min_val = 3.402823466e+38F;   // std::numeric_limits<float>::max()
    
    for (int i = threadIdx.x; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        auto val = static_cast<float>(input[token_idx * hidden_size + i]);
        max_val = val > max_val ? val : max_val;
        min_val = val < min_val ? val : min_val;
    }
    
    // Reduce the max and min values across the block
    max_val = blockReduceMax<1024>(max_val);
    __syncthreads();  // Make sure min doesn't mess with max shared memory
    min_val = blockReduceMin<1024>(min_val);
    
    __shared__ scale_type scale_sh;
    __shared__ azp_type azp_sh;
    
    // Compute the scale and zero point and store them, only on the first thread
    if (threadIdx.x == 0) {
        float const scale_val = (max_val - min_val) / 255.0f;
        // Use rounding to even (same as torch.round)
        auto const azp_float = nearbyintf(-128.0f - min_val / scale_val);
        auto const azp_val = static_cast<azp_type>(azp_float);
        // Store the scale and azp into shared and global
        scale[token_idx] = scale_sh = scale_val;
        azp[token_idx] = azp_sh = azp_val;
    }
    
    // Wait for the scale and azp to be computed
    __syncthreads();
    float const scale_val = scale_sh;
    azp_type const azp_val = azp_sh;

    // Quantize the values
    for (int i = threadIdx.x; i < hidden_size; i += blockDim.x) {
        // ❌ BUG: token_idx * hidden_size can overflow with int32
        auto const val = static_cast<float>(input[token_idx * hidden_size + i]);
        auto const quant_val = int32_to_int8(float_to_int32_rn(val / scale_val) + azp_val);
        out[token_idx * hidden_size + i] = quant_val;
    }
}

void dynamic_scaled_int8_quant(
    torch::Tensor& out,          // [..., hidden_size]
    torch::Tensor const& input,  // [..., hidden_size]
    torch::Tensor& scales, c10::optional<torch::Tensor> const& azp) {
  TORCH_CHECK(input.is_contiguous());
  TORCH_CHECK(out.is_contiguous());
  TORCH_CHECK(scales.is_contiguous());
  TORCH_CHECK(!azp || azp->is_contiguous());

  int const hidden_size = input.size(-1);
  int const num_tokens = input.numel() / hidden_size;
  dim3 const grid(num_tokens);
  dim3 const block(std::min(hidden_size, 1024));
  VLLM_DISPATCH_FLOATING_TYPES(
      input.scalar_type(), "dynamic_scaled_int8_quant_kernel", [&] {
  dynamic_scaled_int8_azp_quant_kernel<scalar_t, float, int32_t>
              <<<grid, block, 0>>>(
                  input.data_ptr<scalar_t>(), out.data_ptr<int8_t>(),
                  scales.data_ptr<float>(), azp->data_ptr<int32_t>(),
                  hidden_size);
                  });
}