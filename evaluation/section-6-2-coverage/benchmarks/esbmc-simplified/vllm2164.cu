// rotary_embedding_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates integer overflow bug from vLLM PR #2164

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define NUM_TOKENS 600000
#define NUM_HEADS 32
#define NUM_KV_HEADS 8
#define HEAD_SIZE 128
#define ROT_DIM 128
#define MAX_POSITION 2048
#define QUERY_STRIDE (NUM_HEADS * HEAD_SIZE)
#define KEY_STRIDE (NUM_KV_HEADS * HEAD_SIZE)

// -------------------------------------------------------
// Helper function to apply rotary embedding
// -------------------------------------------------------
inline __device__ void apply_rotary_embedding(
    float* __restrict__ arr,
    const float* __restrict__ cos_ptr,
    const float* __restrict__ sin_ptr,
    int rot_offset,
    int embed_dim)
{
    int x_index, y_index;
    float cos, sin;
    // GPT-NeoX style rotary embedding
    x_index = rot_offset;
    y_index = embed_dim + rot_offset;
    cos = cos_ptr[x_index];
    sin = sin_ptr[x_index];

    const float x = arr[x_index];  // ❌ buffer overflow when token_head overflows
    const float y = arr[y_index];
    arr[x_index] = x * cos - y * sin;
    arr[y_index] = y * cos + x * sin;
}

// -------------------------------------------------------
// BUGGY KERNEL: using int instead of int64_t for token_head
// -------------------------------------------------------
__global__ void rotary_embedding_kernel(
    const long* __restrict__ positions,
    float* __restrict__ query,
    const float* __restrict__ cos_sin_cache)
{
    // Hardcoded parameters to reduce to 3 arguments
    const int rot_dim = ROT_DIM;
    const int query_stride = QUERY_STRIDE;
    const int num_heads = NUM_HEADS;
    const int head_size = HEAD_SIZE;
    
    // Each thread block is responsible for one token.
    const int token_idx = blockIdx.x;
    
    if (token_idx >= NUM_TOKENS) return;
    
    long pos = positions[token_idx];
    const float* cache_ptr = cos_sin_cache + pos * rot_dim;

    const int embed_dim = rot_dim / 2;
    const float* cos_ptr = cache_ptr;
    const float* sin_ptr = cache_ptr + embed_dim;

    // Process query heads
    const int nq = num_heads * embed_dim;
    for (int i = threadIdx.x; i < nq; i += blockDim.x) {
        const int head_idx = i / embed_dim;
        
        // ❌ BUG: integer overflow when token_idx * query_stride is large
        // token_idx * query_stride = 600000 * 4096 = 2,457,600,000
        // This exceeds INT32_MAX (2,147,483,647) causing overflow!
        const int token_head = token_idx * query_stride + head_idx * head_size;
        
        const int rot_offset = i % embed_dim;
        apply_rotary_embedding(query + token_head, cos_ptr,
                              sin_ptr, rot_offset, embed_dim);
    }
}

int main() {
    // Allocate host memory for ESBMC verification
    const int query_size = NUM_TOKENS * NUM_HEADS * HEAD_SIZE;
    const int cache_size = MAX_POSITION * ROT_DIM;
    
    long h_positions[NUM_TOKENS];
    float h_query[query_size];
    float h_cos_sin_cache[cache_size];
    
    // Initialize positions
    for (int i = 0; i < NUM_TOKENS; i++) {
        h_positions[i] = i % MAX_POSITION;
    }
    
    // Launch kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG TRIGGER:
    // When token_idx = 600000:
    //   token_head = 600000 * 4096 + head_idx * 128
    //              = 2,457,600,000 + offset
    // INT32_MAX = 2,147,483,647
    // This causes integer overflow: 2,457,600,000 > INT32_MAX
    // Result: negative or wrapped index causing out-of-bounds access!
    
    ESBMC_verify_kernel(rotary_embedding_kernel, grid, block,
        h_positions,
        h_query,
        h_cos_sin_cache);
    
    return 0;
}