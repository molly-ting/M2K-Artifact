// dynamic_scaled_int8_azp_quant_buggy.cu
// Minimal buggy example inspired by vLLM's dynamic_scaled_int8_azp_quant_kernel
// before PR #9391: int32 token_idx instead of int64_t causing overflow.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>
#include <limits>
#include <cmath>

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

int main() {
    // ❌ BUG TRIGGER: Use large values to cause int32 overflow
    // token_idx * hidden_size with token_idx=600000, hidden_size=4096
    // = 2,457,600,000 (close to INT32_MAX = 2,147,483,647)
    const int hidden_size = 4096;   // typical hidden size
    const int num_tokens  = 600000; // large number to trigger overflow
    const long long total_elems = (long long)hidden_size * num_tokens;

    const size_t in_bytes    = total_elems * sizeof(float);
    const size_t out_bytes   = total_elems * sizeof(int8_t);
    const size_t scale_bytes = num_tokens * sizeof(float);
    const size_t azp_bytes   = num_tokens * sizeof(int32_t);

    // Device buffers only (host allocation would be too large)
    float *d_input, *d_scales;
    int8_t *d_output;
    int32_t *d_azps;

    cudaMalloc(&d_input, in_bytes);
    cudaMalloc(&d_output, out_bytes);
    cudaMalloc(&d_scales, scale_bytes);
    cudaMalloc(&d_azps, azp_bytes);

    cudaMemset(d_input, 0, in_bytes);   // Initialize to zero
    cudaMemset(d_output, 0, out_bytes);

    dim3 grid(num_tokens);
    dim3 block(256);

    // Launch buggy kernel
    dynamic_scaled_int8_azp_quant_kernel<float, float, int32_t><<<grid, block>>>(
        d_input, d_output, d_scales, d_azps, hidden_size);

    cudaDeviceSynchronize();

    cudaFree(d_input);
    cudaFree(d_output);
    cudaFree(d_scales);
    cudaFree(d_azps);

    return 0;
}