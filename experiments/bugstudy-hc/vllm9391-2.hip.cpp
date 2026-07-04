#include "hip/hip_runtime.h"
// static_scaled_int8_quant_buggy.cu
// Minimal buggy example inspired by vLLM's static_scaled_int8_azp_quant_kernel
// before PR #9391: int32 token_idx instead of int64_t causing overflow.

#include <cstdio>
#include <cstdint>
#include <hip/hip_runtime.h>

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

int main() {
    // ❌ BUG TRIGGER: Use large values to cause int32 overflow
    // token_idx * hidden_size with token_idx=600000, hidden_size=4096
    // = 2,457,600,000 (close to INT32_MAX = 2,147,483,647)
    const int hidden_size = 4096;   // typical hidden size
    const int num_tokens  = 600000; // large number to trigger overflow
    const long long total_elems = (long long)hidden_size * num_tokens;

    const size_t in_bytes  = total_elems * sizeof(float);
    const size_t out_bytes = total_elems * sizeof(int8_t);

    // Device buffers only (host allocation would be too large)
    float *d_input, *d_scale, *d_azp;
    int8_t *d_output;

    hipMalloc(&d_input, in_bytes);
    hipMalloc(&d_output, out_bytes);
    hipMalloc(&d_scale, sizeof(float));
    hipMalloc(&d_azp, sizeof(float));

    float scale = 10.0f;
    float azp = 0.0f;
    hipMemset(d_input, 0, in_bytes);   // Initialize to zero instead of copying
    hipMemset(d_output, 0, out_bytes);
    hipMemcpy(d_scale, &scale, sizeof(float), hipMemcpyHostToDevice);
    hipMemcpy(d_azp, &azp, sizeof(float), hipMemcpyHostToDevice);

    dim3 grid(num_tokens);
    dim3 block(256);

    // Launch buggy kernel
    static_scaled_int8_azp_quant_kernel<float, float, float><<<grid, block>>>(
        d_input, d_output, d_scale, d_azp, hidden_size);

    hipDeviceSynchronize();

    hipFree(d_input);
    hipFree(d_output);
    hipFree(d_scale);
    hipFree(d_azp);

    return 0;
}