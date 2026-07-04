// Extracted kernel from vllm6649.cu
// Bug: OOB access when head_size % pack_size != 0
// Kernel launch uses blockDim.x = head_size
// But kernel indexing assumes <= head_size / pack_size
// GPUVerify configuration: blockDim=128, gridDim=1

__global__ void qattention_buggy_kernel(
    const float* __restrict__ q,
    const float* __restrict__ k,
    float* __restrict__ out,
    int head_size,
    int pack_size)
{
    int tok = blockIdx.x;
    int tid = threadIdx.x;

    // BUG: bound check ignores pack_size packing
    if (tid >= head_size) return;

    // packed length is smaller
    int packed_len = head_size / pack_size;

    // ❌ BUG: tid may exceed packed_len → OOB read
    int pack_idx = tid;  // should be tid < packed_len

    // dummy packed dot product
    float acc = 0.f;
    for (int i = 0; i < pack_size; ++i) {
        int idx = pack_idx * pack_size + i; // <-- may overflow
        acc += q[idx] * k[idx];
    }

    out[tid] = acc;
}
