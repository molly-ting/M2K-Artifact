// Extracted kernel from vllm5169.cu
// Bug: grid.x = seq_len instead of batch * num_heads
// Causes OOB writes when seq_len > batch * num_heads
// GPUVerify configuration: blockDim=64, gridDim=8

__global__ void rotary_kernel(float* out,
                              const float* in,
                              int batch,
                              int num_heads,
                              int seq_len) {

    int row = blockIdx.x;      // WRONG MAPPING: should be batch*num_heads, not seq_len
    int col = threadIdx.x;

    int true_rows = batch * num_heads;

    // Indexing assumes row < batch*num_heads
    if (row < true_rows && col < seq_len) {
        int idx = row * seq_len + col;
        out[idx] = in[idx] * 0.5f;
    }
}
