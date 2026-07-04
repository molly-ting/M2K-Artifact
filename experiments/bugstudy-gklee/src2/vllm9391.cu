// static_scaled_int8_quant_buggy.cu
// Minimal buggy example inspired by vLLM's static_scaled_int8_quant_kernel
// before PR #9391: double-offset + 32-bit indexing style bug.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <torch/all.h>

// Simple "float -> int8" helper using round-to-nearest.
__device__ inline int8_t float_to_int8_rn(float x) {
    // clamp to [-128, 127] just to keep it sane
    int v = __float2int_rn(x);
    if (v < -128) v = -128;
    if (v > 127)  v = 127;
    return static_cast<int8_t>(v);
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

void static_scaled_int8_quant(torch::Tensor& out,          // [..., hidden_size]
                              torch::Tensor const& input,  // [..., hidden_size]
                              torch::Tensor const& scale) {
  TORCH_CHECK(input.is_contiguous());
  TORCH_CHECK(out.is_contiguous());
  TORCH_CHECK(scale.numel() == 1);

  int const hidden_size = input.size(-1);
  int const num_tokens = input.numel() / hidden_size;
  dim3 const grid(num_tokens);
  dim3 const block(std::min(hidden_size, 1024));
  static_scaled_int8_quant_kernel_buggy<<<grid, block, 0>>>(
                input.data_ptr<float>(), out.data_ptr<int8_t>(),
                scale.data_ptr<float>(), hidden_size);
}