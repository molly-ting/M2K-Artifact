// buggy_cache_overflow_demo.cu
//
// Minimal CUDA example demonstrating the integer overflow bug from
// vllm-project/vllm PR #1514 in cache_kernels.cu (copy_blocks_kernel).
//
// The buggy kernel uses int for block_mapping indices and offsets,
// which causes integer overflow with large block numbers.

#include <cstdio>
#include <cstdint>
#include <vector>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr)                                                      \
    do {                                                                      \
        cudaError_t err__ = (expr);                                           \
        if (err__ != cudaSuccess) {                                           \
            std::fprintf(stderr, "CUDA error %s at %s:%d: %s\n",              \
                         #expr, __FILE__, __LINE__,                            \
                         cudaGetErrorString(err__));                          \
            std::exit(EXIT_FAILURE);                                          \
        }                                                                     \
    } while (0)

// -----------------------------------------------------------------------------
// copy_blocks_kernel: BUGGY version (from vllm PR #1514)
// Uses int instead of int64_t for block_mapping and offsets
// -----------------------------------------------------------------------------
__global__ void copy_blocks_kernel(
    float* key_cache,
    float* value_cache,
    const int* __restrict__ block_mapping,    // BUGGY: should be int64_t*
    const int numel_per_block)
{
    const int pair_idx = blockIdx.y;

    // BUGGY: These should be int64_t
    int src_block_number = block_mapping[2 * pair_idx];
    int dst_block_number = block_mapping[2 * pair_idx + 1];

    // BUGGY: These offsets should be int64_t to avoid overflow
    const int src_block_offset = src_block_number * numel_per_block;
    const int dst_block_offset = dst_block_number * numel_per_block;

    // Copy key cache
    for (int i = threadIdx.x; i < numel_per_block; i += blockDim.x) {
        int src_offset = src_block_offset + i;  // BUGGY: should be int64_t
        int dst_offset = dst_block_offset + i;  // BUGGY: should be int64_t
        key_cache[dst_offset] = key_cache[src_offset];
    }

    // Copy value cache
    for (int i = threadIdx.x; i < numel_per_block; i += blockDim.x) {
        int src_offset = src_block_offset + i;  // BUGGY: should be int64_t
        int dst_offset = dst_block_offset + i;  // BUGGY: should be int64_t
        value_cache[dst_offset] = value_cache[src_offset];
    }
}

// -----------------------------------------------------------------------------
// Host test to trigger the overflow bug
// -----------------------------------------------------------------------------
int main() {
    // ---------------------------
    // Test: copy_blocks with overflow-triggering inputs
    // ---------------------------
    // Use large block numbers to trigger integer overflow.
    // With numel_per_block = 10000, and src_block_number = 300000:
    // offset = 300000 * 10000 = 3,000,000,000 > INT_MAX (2,147,483,647)
    
    const int numel_per_block = 10000;
    const int num_pairs = 1;  // one (src, dst) pair

    // For practical demo, use smaller cache size and expect out-of-bounds access
    const int actual_cache_size = 1000000;  // 1M elements, ~4MB
    
    std::vector<float> h_key_cache(actual_cache_size);
    std::vector<float> h_value_cache(actual_cache_size);

    // block_mapping: [src_block, dst_block] = [300000, 350000]
    // These large values will cause overflow when multiplied by numel_per_block.
    // 300000 * 10000 = 3,000,000,000 > INT_MAX (2,147,483,647)
    int h_block_mapping[2] = {300000, 350000};

    // float* d_key_cache = nullptr;
    // float* d_value_cache = nullptr;
    // int* d_block_mapping = nullptr;

    // CUDA_CHECK(cudaMalloc(&d_key_cache, actual_cache_size * sizeof(float)));
    // CUDA_CHECK(cudaMemcpy(
    //     d_key_cache, h_key_cache.data(),
    //     actual_cache_size * sizeof(float), cudaMemcpyHostToDevice));

    // CUDA_CHECK(cudaMalloc(&d_value_cache, actual_cache_size * sizeof(float)));
    // CUDA_CHECK(cudaMemcpy(
    //     d_value_cache, h_value_cache.data(),
    //     actual_cache_size * sizeof(float), cudaMemcpyHostToDevice));

    // CUDA_CHECK(cudaMalloc(&d_block_mapping, 2 * sizeof(int)));
    // CUDA_CHECK(cudaMemcpy(
    //     d_block_mapping, h_block_mapping,
    //     2 * sizeof(int), cudaMemcpyHostToDevice));

    // dim3 block(32);
    // dim3 grid(1, num_pairs);  // only y-dim used for pair_idx
    dim3 block(2);
    dim3 grid(2);

    // copy_blocks_kernel<float><<<grid, block>>>(
        // d_key_cache, d_value_cache, d_block_mapping, numel_per_block);

    ESBMC_verify_kernel(copy_blocks_kernel, grid, block, h_key_cache.data(), h_block_mapping, numel_per_block);

    // CUDA_CHECK(cudaDeviceSynchronize());

    // // Print demonstration of overflow
    // std::printf("=== Integer Overflow Demonstration ===\n");
    // std::printf("copy_blocks_kernel (BUGGY version):\n");
    // std::printf("  src_block=300000, dst_block=350000, numel_per_block=10000\n");
    // std::printf("  Buggy (int): src_block_offset = 300000 * 10000 = %d (overflowed)\n", 
    //             300000 * 10000);
    // std::printf("  Expected: 3,000,000,000\n");
    // std::printf("  INT_MAX = 2,147,483,647\n");
    // std::printf("  Result: Integer overflow causes incorrect/negative indices!\n\n");

    // // Cleanup
    // CUDA_CHECK(cudaFree(d_key_cache));
    // CUDA_CHECK(cudaFree(d_value_cache));
    // CUDA_CHECK(cudaFree(d_block_mapping));

    return 0;
}