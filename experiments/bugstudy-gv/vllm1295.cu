// Extracted kernel from vllm1295.cu
// Bug: 32-bit int overflow in pointer offset calculation
// offset = blockIdx.z * M * OC can overflow for large M/OC/blockIdx.z
// GPUVerify configuration: blockDim=64, gridDim=(1,1,2)

__global__ void gemm_forward_4bit_cuda_m16n128k32_buggy(
    int G,   // groups
    int M,   // rows
    int OC,  // output channels
    float* __restrict__ C)
{
    int blockIdx_z = blockIdx.z;
    int blockIdx_y = blockIdx.y;

    // BUG: 32-bit int multiplication can overflow for large M/OC/blockIdx_z
    int offset_base =
        blockIdx_z * M * OC        // <-- int overflow risk
        + (blockIdx_y % 1) * 128;

    int row = threadIdx.y * 16;
    int col = (threadIdx.x % 8) * 2;

    int linear_index = offset_base + row * OC + col;

    // Bounds check
    if (linear_index < 0 || linear_index >= M * OC) {
        return;
    }

    float* C_ptr = C + linear_index;

    // Write something deterministic
    float value = (float)blockIdx_z * 1000.0f
                + (float)blockIdx_y * 100.0f
                + (float)threadIdx.y * 10.0f
                + (float)threadIdx.x;

    *C_ptr = value;
}
