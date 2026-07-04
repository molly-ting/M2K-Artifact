// Extracted kernel from vllm1514-1.cu
// Bug: 32-bit int overflow in paged attention offset calculation
// physical_block_number * kv_block_stride overflows for large values
// GPUVerify configuration: blockDim=64, gridDim=4

__global__ void paged_attention_kernel_buggy(
    const int* __restrict__ block_table,  // [num_blocks], int32
    float* __restrict__ kv_cache,         // flat KV buffer
    long long kv_block_stride,            // stride between blocks (elements)
    int num_blocks)
{
    int block_idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (block_idx >= num_blocks) {
        return;
    }

    int physical_block_number = block_table[block_idx];

    // BUG: 32-bit int multiplication; can overflow
    int offset_elements = physical_block_number * (int)kv_block_stride;

    if (offset_elements >= 0) {
        kv_cache[offset_elements] = (float)physical_block_number;
    }
}
