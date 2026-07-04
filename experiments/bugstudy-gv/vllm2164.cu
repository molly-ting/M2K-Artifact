// Extracted kernel from vllm2164.cu
// Bug: Kernel launched with gridDim.x == 0 when num_tokens == 0
// This is illegal and causes CUDA errors
// GPUVerify configuration: blockDim=64, gridDim=0 (special case)

__global__ void example_kernel(float* out, const float* in, int d) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (idx < d) {
        out[idx] = in[idx];
    }
}
