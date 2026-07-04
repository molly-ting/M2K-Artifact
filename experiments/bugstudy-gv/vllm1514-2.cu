// Extracted kernel from vllm1514-2.cu
// Bug: 32-bit int overflow in reshape_and_cache offset calculation
// block_idx * num_heads * (head_size/x) * block_size * x overflows
// GPUVerify configuration: blockDim=128, gridDim=4

__global__ void reshape_and_cache_kernel_buggy(
    const float* __restrict__ key,      // [num_tokens, num_heads, head_size]
    float* __restrict__ key_cache,      // flattened layout
    const int* __restrict__ slot_mapping, // [num_tokens]
    int key_stride,                     // num_heads * head_size
    int num_heads,
    int head_size,
    int block_size,
    int x)
{
    int token_idx = blockIdx.x;
    int slot_idx = slot_mapping[token_idx];
    if (slot_idx < 0) {
        return;
    }

    int block_idx = slot_idx / block_size;
    int block_offset = slot_idx % block_size;

    int n = num_heads * head_size;
    for (int i = threadIdx.x; i < n; i += blockDim.x) {
        int src_key_idx = token_idx * key_stride + i;

        int head_idx = i / head_size;
        int head_offset = i % head_size;
        int x_idx = head_offset / x;
        int x_offset = head_offset % x;

        // BUG: 32-bit int multiplication overflows for large values
        int tgt_key_idx =
            block_idx * num_heads * (head_size / x) * block_size * x
            + head_idx * (head_size / x) * block_size * x
            + x_idx * block_size * x
            + block_offset * x
            + x_offset;

        key_cache[tgt_key_idx] = key[src_key_idx];
    }
}
