// buggy_chatglm_rope_demo.cpp
//
// Minimal C++ example mimicking the configuration bugs fixed in
// https://github.com/vllm-project/vllm/pull/1841


#include <cstdio>
#include <cstdint>
#include <vector>
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

template<typename scalar_t, bool IS_NEOX>
inline __device__ void apply_rotary_embedding(
  scalar_t* __restrict__ arr,
  const scalar_t* __restrict__ cos_ptr,
  const scalar_t* __restrict__ sin_ptr,
  int rot_offset,
  int embed_dim)
{
  int x_index, y_index;
  scalar_t cos, sin;
  if (IS_NEOX) {
    // GPT-NeoX style rotary embedding.
    x_index = rot_offset;
    y_index = embed_dim + rot_offset;
    cos = __ldg(cos_ptr + x_index);
    sin = __ldg(sin_ptr + x_index);
  } else {
    // GPT-J style rotary embedding.
    x_index = 2 * rot_offset;
    y_index = 2 * rot_offset + 1;
    cos = __ldg(cos_ptr + x_index / 2);
    sin = __ldg(sin_ptr + x_index / 2);
  }

  const scalar_t x = arr[x_index];
  const scalar_t y = arr[y_index];
  arr[x_index] = x * cos - y * sin;
  arr[y_index] = y * cos + x * sin;
}

template<typename scalar_t, bool IS_NEOX>
__global__ void rotary_embedding_kernel(
  const int64_t* __restrict__ positions,        // [batch_size, seq_len] or [num_tokens]
  scalar_t* __restrict__ query,                 // [batch_size, seq_len, num_heads, head_size] or [num_tokens, num_heads, head_size]
  scalar_t* __restrict__ key,                   // [batch_size, seq_len, num_kv_heads, head_size] or [num_tokens, num_kv_heads, head_size]
  const scalar_t* __restrict__ cos_sin_cache,   // [max_position, 2, rot_dim // 2]
  const int rot_dim,
  const int query_stride,
  const int key_stride,
  const int num_heads,
  const int num_kv_heads,
  const int head_size) {
  // Each thread block is responsible for one token.
  const int token_idx = blockIdx.x;
  int64_t pos = positions[token_idx];
  const scalar_t* cache_ptr = cos_sin_cache + pos * rot_dim;

  const int embed_dim = rot_dim / 2;
  const scalar_t* cos_ptr = cache_ptr;
  const scalar_t* sin_ptr = cache_ptr + embed_dim;

  const int nq = num_heads * embed_dim;
  for (int i = threadIdx.x; i < nq; i += blockDim.x) {
    const int head_idx = i / embed_dim;
    const int token_head = token_idx * query_stride + head_idx * head_size;
    const int rot_offset = i % embed_dim;
    apply_rotary_embedding<scalar_t, IS_NEOX>(query + token_head, cos_ptr,
                                              sin_ptr, rot_offset, embed_dim);
  }

  const int nk = num_kv_heads * embed_dim;
  for (int i = threadIdx.x; i < nk; i += blockDim.x) {
    const int head_idx = i / embed_dim;
    const int token_head = token_idx * key_stride + head_idx * head_size;
    const int rot_offset = i % embed_dim;
    apply_rotary_embedding<scalar_t, IS_NEOX>(key + token_head, cos_ptr,
                                              sin_ptr, rot_offset, embed_dim);
  }
}



int main() {
   // Configuration from user's specification
    const int batch_size = 1;
    const int seq_len = 8192;
    const int num_heads = 32;
    const int num_kv_heads = 32;
    const int head_size = 128;
    
    // BUGGY CONFIGURATION:
    // cos_sin_cache is allocated with shape [8192, 64]
    // but rot_dim is set to 128 (should be 64 to match cache)
    const int max_position = 8192;
    const int actual_cache_rot_dim = 64;  // What cos_sin_cache was actually allocated for
    const int buggy_rot_dim = 128;        // What we wrongly pass to kernel
    
    const int num_tokens = batch_size * seq_len;  // 1 * 8192 = 8192
    const int query_stride = num_heads * head_size;  // 32 * 128 = 4096
    const int key_stride = num_kv_heads * head_size;  // 32 * 128 = 4096
    
    std::printf("=== Buffer Overflow Demo for vLLM PR #1841 ===\n");
    std::printf("Configuration:\n");
    std::printf("  batch_size=%d, seq_len=%d, num_tokens=%d\n", batch_size, seq_len, num_tokens);
    std::printf("  num_heads=%d, num_kv_heads=%d, head_size=%d\n", num_heads, num_kv_heads, head_size);
    std::printf("  cos_sin_cache allocated shape: [%d, %d] = %d elements\n", 
                max_position, actual_cache_rot_dim, max_position * actual_cache_rot_dim);
    std::printf("  BUGGY: kernel uses rot_dim=%d (should be %d)\n\n", buggy_rot_dim, actual_cache_rot_dim);
    
    // Allocate host memory
    std::vector<int64_t> h_positions(num_tokens);
    for (int i = 0; i < num_tokens; ++i) {
        h_positions[i] = i % seq_len;  // positions range from 0 to seq_len-1
    }
    
    std::vector<float> h_query(num_tokens * num_heads * head_size, 1.0f);
    std::vector<float> h_key(num_tokens * num_kv_heads * head_size, 1.0f);
    
    // cos_sin_cache: allocated with actual_cache_rot_dim (64), not buggy_rot_dim (128)
    const int actual_cache_size = max_position * actual_cache_rot_dim;
    std::vector<float> h_cos_sin_cache(actual_cache_size);
    for (int i = 0; i < actual_cache_size; ++i) {
        h_cos_sin_cache[i] = 0.5f;
    }
    
    // Allocate device memory
    int64_t* d_positions = nullptr;
    float* d_query = nullptr;
    float* d_key = nullptr;
    float* d_cos_sin_cache = nullptr;
    
    CUDA_CHECK(cudaMalloc(&d_positions, num_tokens * sizeof(int64_t)));
    CUDA_CHECK(cudaMalloc(&d_query, num_tokens * num_heads * head_size * sizeof(float)));
    CUDA_CHECK(cudaMalloc(&d_key, num_tokens * num_kv_heads * head_size * sizeof(float)));
    CUDA_CHECK(cudaMalloc(&d_cos_sin_cache, actual_cache_size * sizeof(float)));
    
    // Copy to device
    CUDA_CHECK(cudaMemcpy(d_positions, h_positions.data(), 
                         num_tokens * sizeof(int64_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_query, h_query.data(), 
                         num_tokens * num_heads * head_size * sizeof(float), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_key, h_key.data(), 
                         num_tokens * num_kv_heads * head_size * sizeof(float), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMemcpy(d_cos_sin_cache, h_cos_sin_cache.data(), 
                         actual_cache_size * sizeof(float), cudaMemcpyHostToDevice));
    
    // Launch kernel with BUGGY rot_dim
    dim3 grid(num_tokens);  // 8192 blocks
    dim3 block(256);        // 256 threads per block
    
    std::printf("Launching buggy kernel...\n");
    std::printf("Bug trigger analysis:\n");
    std::printf("  Last token: pos=%d\n", seq_len - 1);
    std::printf("  cache_ptr offset = pos * rot_dim = %d * %d = %d\n", 
                seq_len - 1, buggy_rot_dim, (seq_len - 1) * buggy_rot_dim);
    std::printf("  Allocated cache elements = %d * %d = %d\n", 
                max_position, actual_cache_rot_dim, actual_cache_size);
    std::printf("  Buffer overflow! %d > %d\n", 
                (seq_len - 1) * buggy_rot_dim, actual_cache_size);
    std::printf("  Out-of-bounds access by %d elements!\n\n", 
                (seq_len - 1) * buggy_rot_dim - actual_cache_size);
    
    rotary_embedding_kernel<float, true><<<grid, block>>>(
        d_positions, d_query, d_key, d_cos_sin_cache,
        buggy_rot_dim,  // BUGGY: should be actual_cache_rot_dim (64)
        query_stride, key_stride, num_heads, num_kv_heads, head_size);
    
    CUDA_CHECK(cudaDeviceSynchronize());
    std::printf("Kernel execution completed (or crashed with out-of-bounds access)\n");
    
    // Cleanup
    CUDA_CHECK(cudaFree(d_positions));
    CUDA_CHECK(cudaFree(d_query));
    CUDA_CHECK(cudaFree(d_key));
    CUDA_CHECK(cudaFree(d_cos_sin_cache));
    
    return 0;
}
