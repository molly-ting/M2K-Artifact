// rotary_embedding_buggy.cu
//
// Minimal standalone CUDA file reproducing the integer overflow bug
// in vLLM's rotary_embedding kernel.
//
// Bug summary:
//   - token_head computed as: token_idx * query_stride + head_idx * head_size
//   - Using int32 causes overflow with large token_idx values
//   - Should use int64_t to prevent overflow
//
// This file contains the buggy behavior with int32 for token_head.

#include <cstdio>
#include <cstdint>
#include <cuda_runtime.h>

#ifndef VLLM_LDG
#define VLLM_LDG(arg) __ldg(arg)
#endif

// -------------------------------------------------------
// Helper function to apply rotary embedding
// -------------------------------------------------------
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
        cos = VLLM_LDG(cos_ptr + x_index);
        sin = VLLM_LDG(sin_ptr + x_index);
    } else {
        // GPT-J style rotary embedding.
        x_index = 2 * rot_offset;
        y_index = 2 * rot_offset + 1;
        cos = VLLM_LDG(cos_ptr + x_index / 2);
        sin = VLLM_LDG(sin_ptr + x_index / 2);
    }

    const scalar_t x = arr[x_index];  // ❌ buffer overflow happens when token_head overflows
    const scalar_t y = arr[y_index];
    arr[x_index] = x * cos - y * sin;
    arr[y_index] = y * cos + x * sin;
}

// -------------------------------------------------------
// BUGGY KERNEL: using int instead of int64_t for token_head
// -------------------------------------------------------
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

    // Process query heads
    const int nq = num_heads * embed_dim;
    for (int i = threadIdx.x; i < nq; i += blockDim.x) {
        const int head_idx = i / embed_dim;
        // ❌ BUG: integer overflow when token_idx * query_stride is large
        const int token_head = token_idx * query_stride + head_idx * head_size;
        const int rot_offset = i % embed_dim;
        apply_rotary_embedding<scalar_t, IS_NEOX>(query + token_head, cos_ptr,
                                                   sin_ptr, rot_offset, embed_dim);
    }

    // Process key heads
    const int nk = num_kv_heads * embed_dim;
    for (int i = threadIdx.x; i < nk; i += blockDim.x) {
        const int head_idx = i / embed_dim;
        // ❌ BUG: integer overflow when token_idx * key_stride is large
        const int token_head = token_idx * key_stride + head_idx * head_size;
        const int rot_offset = i % embed_dim;
        apply_rotary_embedding<scalar_t, IS_NEOX>(key + token_head, cos_ptr,
                                                   sin_ptr, rot_offset, embed_dim);
    }
}

// -------------------------------------------------------
// Small demonstration
// -------------------------------------------------------
int main() {
     // ❌ BUG TRIGGER: Use large num_tokens to cause int32 overflow
     // token_idx * query_stride = 600000 * 4096 = 2,457,600,000 (close to INT32_MAX)
     // This causes integer overflow in: const int token_head = token_idx * query_stride + head_idx * head_size;
     int num_tokens = 600000;
     int num_heads = 32;
     int num_kv_heads = 8;
     int head_size = 128;
     int rot_dim = 128;
     int max_position = 2048;

     int query_stride = num_heads * head_size;    // = 32 * 128 = 4096
     int key_stride = num_kv_heads * head_size;  // = 8 * 128 = 1024

    // Allocate host memory
    int64_t* h_positions = new int64_t[num_tokens];
    float* h_query = new float[num_tokens * num_heads * head_size];
    float* h_key = new float[num_tokens * num_kv_heads * head_size];
    float* h_cos_sin_cache = new float[max_position * rot_dim];

    // Initialize data
    for (int i = 0; i < num_tokens; i++) {
        h_positions[i] = i % max_position;
    }
    for (int i = 0; i < num_tokens * num_heads * head_size; i++) {
        h_query[i] = float(i % 100) / 100.0f;
    }
    for (int i = 0; i < num_tokens * num_kv_heads * head_size; i++) {
        h_key[i] = float(i % 100) / 100.0f;
    }
    for (int i = 0; i < max_position * rot_dim; i++) {
        h_cos_sin_cache[i] = float(i % 100) / 100.0f;
    }

    // Allocate device memory
    int64_t *d_positions;
    float *d_query, *d_key, *d_cos_sin_cache;

    cudaMalloc(&d_positions, num_tokens * sizeof(int64_t));
    cudaMalloc(&d_query, num_tokens * num_heads * head_size * sizeof(float));
    cudaMalloc(&d_key, num_tokens * num_kv_heads * head_size * sizeof(float));
    cudaMalloc(&d_cos_sin_cache, max_position * rot_dim * sizeof(float));

    // Copy to device
    cudaMemcpy(d_positions, h_positions, num_tokens * sizeof(int64_t), cudaMemcpyHostToDevice);
    cudaMemcpy(d_query, h_query, num_tokens * num_heads * head_size * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_key, h_key, num_tokens * num_kv_heads * head_size * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_cos_sin_cache, h_cos_sin_cache, max_position * rot_dim * sizeof(float), cudaMemcpyHostToDevice);

    // Launch buggy kernel
    dim3 grid(num_tokens);
    dim3 block(256);

    rotary_embedding_kernel<float, true><<<grid, block>>>(
        d_positions, d_query, d_key, d_cos_sin_cache,
        rot_dim, query_stride, key_stride,
        num_heads, num_kv_heads, head_size);

    // cudaError_t err = cudaGetLastError();
    // cudaDeviceSynchronize();

    // // Copy results back
    // cudaMemcpy(h_query, d_query, num_tokens * num_heads * head_size * sizeof(float), cudaMemcpyDeviceToHost);
    // cudaMemcpy(h_key, d_key, num_tokens * num_kv_heads * head_size * sizeof(float), cudaMemcpyDeviceToHost);

    // // Cleanup
    // cudaFree(d_positions);
    // cudaFree(d_query);
    // cudaFree(d_key);
    // cudaFree(d_cos_sin_cache);

    // delete[] h_positions;
    // delete[] h_query;
    // delete[] h_key;
    // delete[] h_cos_sin_cache;

    return 0;
}
