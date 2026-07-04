// Extracted kernel from vllm68.cu
// Bug: shared memory size calculation uses sizeof(T) instead of sizeof(float)
// GPUVerify configuration: blockDim=128, gridDim=2

__global__ void single_query_cached_kv_attention_kernel(
    float* __restrict__ out,
    const float* __restrict__ in,
    int n) {

    __shared__ float shared_logits[128];

    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    if (tid >= n) {
        return;
    }

    float val = in[tid];
    shared_logits[threadIdx.x] = val * 0.5f;
    __syncthreads();

    out[tid] = shared_logits[threadIdx.x];
}