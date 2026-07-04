// buggy_chatglm_rope_demo.cpp
// Minimal CUDA example for ESBMC verification
// Demonstrates buffer overflow bug from vLLM PR #1841

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Simplified configuration - keeping same proportions
#define BATCH_SIZE 1
#define SEQ_LEN 8192
#define NUM_HEADS 32
#define NUM_KV_HEADS 32
#define HEAD_SIZE 128
#define MAX_POSITION 8192
#define ACTUAL_CACHE_ROT_DIM 64
#define BUGGY_ROT_DIM 128
#define NUM_TOKENS (BATCH_SIZE * SEQ_LEN)
#define QUERY_STRIDE (NUM_HEADS * HEAD_SIZE)
#define KEY_STRIDE (NUM_KV_HEADS * HEAD_SIZE)


inline __device__ void apply_rotary_embedding(
  float* __restrict__ arr,
  const float* __restrict__ cos_ptr,
  const float* __restrict__ sin_ptr,
  int rot_offset,
  int embed_dim)
{
  int x_index, y_index;
  float cos, sin;
  // GPT-NeoX style rotary embedding.
  x_index = rot_offset;
  y_index = embed_dim + rot_offset;
  cos = cos_ptr[x_index];
  sin = sin_ptr[x_index];

  const float x = arr[x_index];
  const float y = arr[y_index];
  arr[x_index] = x * cos - y * sin;
  arr[y_index] = y * cos + x * sin;
}


__global__ void rotary_embedding_kernel(
  const long* __restrict__ positions,
  float* __restrict__ query,
  const float* __restrict__ cos_sin_cache)
{
  // Hardcoded parameters to reduce to 3 arguments
  const int rot_dim = BUGGY_ROT_DIM;  // BUG: Should be ACTUAL_CACHE_ROT_DIM (64)
  const int query_stride = QUERY_STRIDE;
  const int num_heads = NUM_HEADS;
  const int head_size = HEAD_SIZE;
  
  // Each thread block is responsible for one token.
  const int token_idx = blockIdx.x;
  
  // BUG: positions array bounds check
  if (token_idx >= NUM_TOKENS) return;
  
  long pos = positions[token_idx];
  
  // BUG: Buffer overflow here!
  // cache_ptr offset = pos * rot_dim
  // For pos=8191, rot_dim=128: offset = 1048448
  // But cache size = 8192 * 64 = 524288
  // This causes out-of-bounds access!
  const float* cache_ptr = cos_sin_cache + pos * rot_dim;

  const int embed_dim = rot_dim / 2;
  const float* cos_ptr = cache_ptr;
  const float* sin_ptr = cache_ptr + embed_dim;
  
  const int nq = num_heads * embed_dim;
  for (int i = threadIdx.x; i < nq; i += blockDim.x) {
    const int head_idx = i / embed_dim;
    const int token_head = token_idx * query_stride + head_idx * head_size;
    const int rot_offset = i % embed_dim;
    apply_rotary_embedding(query + token_head, cos_ptr,
                          sin_ptr, rot_offset, embed_dim);
  }
}

int main()
{
  // Allocate host memory for verification
  const int actual_cache_size = MAX_POSITION * ACTUAL_CACHE_ROT_DIM;
  
  long h_positions[NUM_TOKENS];
  float h_query[NUM_TOKENS * NUM_HEADS * HEAD_SIZE];
  float h_cos_sin_cache[actual_cache_size];
  
  // Initialize positions (simplified for ESBMC)
  for (int i = 0; i < NUM_TOKENS; i++) {
    h_positions[i] = i % SEQ_LEN;
  }
  
  // Launch kernel with BUGGY rot_dim using ESBMC_verify_kernel
  dim3 grid(2);
  dim3 block(2);
  
  // BUG TRIGGER:
  // When token_idx = 8191 (last token):
  //   pos = 8191
  //   cache_ptr = cos_sin_cache + 8191 * 128 = cos_sin_cache + 1048448
  //   But cos_sin_cache only has 8192 * 64 = 524288 elements
  //   Out-of-bounds access: 1048448 >= 524288
  
  // Now only 3 arguments (within ESBMC_verify_kernel limit)
  ESBMC_verify_kernel(rotary_embedding_kernel, grid, block,
      h_positions,
      h_query,
      h_cos_sin_cache);
  
  return 0;
}