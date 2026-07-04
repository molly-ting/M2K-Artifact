// buggy_paged_attention_overflow_demo.cu
//
// Minimal CUDA example mimicking the overflow bug from
// vllm-project/vllm PR #1514 in paged attention.
//
// In the original code, block_table entries are int32,
// and they are multiplied by a large kv_block_stride.
// This can overflow in 32-bit math.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>

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

// Buggy version: 32-bit multiplication for
//   physical_block_number * kv_block_stride
// so large values overflow.
__global__ void paged_attention_kernel_buggy(
    const int* __restrict__ block_table,  // [num_blocks], int32
    float* __restrict__ kv_cache,         // flat KV buffer
    std::int64_t kv_block_stride,         // stride between blocks (elements)
    int num_blocks)
{
    int block_idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (block_idx >= num_blocks) {
        return;
    }

    // In vLLM before the fix:
    //   const int physical_block_number = block_table[block_idx];
    int physical_block_number = block_table[block_idx];

    // BUG: 32-bit int multiplication; if physical_block_number or
    // kv_block_stride is large, this can overflow.
    int offset_elements = physical_block_number * (int)kv_block_stride;

    // Just write something so the kernel does "work".
    // For safety in this demo, we assume kv_cache is large enough for the
    // small values we actually use in main().
    if (offset_elements >= 0) {
        kv_cache[offset_elements] = (float)physical_block_number;
    }
}

// Test demonstrating the overflow bug with large stride values.
// the structure of the bug.
int main() {
    const int num_blocks = 4;
    // BUG TRIGGER: Use large stride value that causes overflow
    // physical_block_number (max 100000) * kv_block_stride (200000)
    // = 20000000000 which overflows 32-bit int (max ~2.1 billion)
    const std::int64_t kv_block_stride = 200000;  // Large stride to trigger overflow

    // Block table with large block numbers
    int h_block_table[num_blocks];
    h_block_table[0] = 10000;
    h_block_table[1] = 50000;
    h_block_table[2] = 100000;  // This * 200000 = overflow!
    h_block_table[3] = 150000;

    // Allocate large cache (we won't access all of it safely)
    const size_t kv_cache_size = 1000000;  // 1M elements
    
    int* d_block_table = nullptr;
    float* d_kv_cache = nullptr;

    CUDA_CHECK(cudaMalloc(&d_block_table, num_blocks * sizeof(int)));
    CUDA_CHECK(cudaMalloc(&d_kv_cache, kv_cache_size * sizeof(float)));

    CUDA_CHECK(cudaMemcpy(
        d_block_table, h_block_table,
        num_blocks * sizeof(int), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemset(d_kv_cache, 0, kv_cache_size * sizeof(float)));

    dim3 block(32);
    dim3 grid((num_blocks + block.x - 1) / block.x);

    printf("Launching buggy kernel with overflow-prone values:\n");
    printf("  num_blocks=%d, kv_block_stride=%lld\n", num_blocks, kv_block_stride);
    printf("  block_table[2] * kv_block_stride = %d * %lld = overflow!\n", 
           h_block_table[2], kv_block_stride);

    paged_attention_kernel_buggy<<<grid, block>>>(
        d_block_table, d_kv_cache, kv_block_stride, num_blocks);

    CUDA_CHECK(cudaDeviceSynchronize());
    printf("Kernel completed (bug may cause incorrect memory access)\n");

    CUDA_CHECK(cudaFree(d_block_table));
    CUDA_CHECK(cudaFree(d_kv_cache));

    return 0;
}
