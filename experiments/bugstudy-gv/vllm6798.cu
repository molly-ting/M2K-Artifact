// Extracted kernel from vllm6798.cu
// Bug: Channelwise scales nullptr bug with tensor parallel
// When TP>1 and channelwise quantization:
//   scales_size = input_size_per_partition // group_size = 4096 // 8192 = 0 → nullptr
// GPUVerify configuration: blockDim=(16,16), gridDim=(8,8)

__global__ void marlin_w8a16_gemm_kernel(
    const float* input,          // [M, K_partition] - fp16 activations (using fp32 for simplicity)
    const char* qweight,         // [K_partition, N] - int8 quantized weights
    float* output,               // [M, N] - fp16 output (using fp32 for simplicity)
    const float* scales,         // Per-channel scales [num_groups, N] - NULLPTR in bug case!
    int M, int K_partition, int N, int group_size) {
    
    // Thread indexing - each thread computes one output element
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (row < M && col < N) {
        // Registers for accumulation
        float acc0 = 0.0f;
        float acc1 = 0.0f;
        float acc2 = 0.0f;
        float acc3 = 0.0f;
        
        // Compute matrix multiplication with 4-way unrolling
        int k = 0;
        for (; k + 3 < K_partition; k += 4) {
            // Vectorized loads
            int8_t qw0 = qweight[(k + 0) * N + col];
            int8_t qw1 = qweight[(k + 1) * N + col];
            int8_t qw2 = qweight[(k + 2) * N + col];
            int8_t qw3 = qweight[(k + 3) * N + col];
            
            float inp0 = input[row * K_partition + k + 0];
            float inp1 = input[row * K_partition + k + 1];
            float inp2 = input[row * K_partition + k + 2];
            float inp3 = input[row * K_partition + k + 3];
            
            // Fused multiply-accumulate
            acc0 += inp0 * (float)qw0;
            acc1 += inp1 * (float)qw1;
            acc2 += inp2 * (float)qw2;
            acc3 += inp3 * (float)qw3;
        }
        
        // Handle remaining elements
        for (; k < K_partition; k++) {
            int8_t qw = qweight[k * N + col];
            float inp = input[row * K_partition + k];
            acc0 += inp * (float)qw;
        }
        
        // Sum all accumulators
        float acc = acc0 + acc1 + acc2 + acc3;
        
        // Apply dequantization scales
        int scale_idx;
        
        if (group_size == -1 || group_size >= K_partition) {
            // Channelwise quantization: one scale per output channel
            // BUG: When TP>1, scales tensor size computed as 0, scales is nullptr
            scale_idx = col;  // Index into [1, N] or [N]
        } else {
            // Groupwise quantization
            int group_idx = 0;  // Simplified: use first group
            scale_idx = group_idx * N + col;  // Index into [num_groups, N]
        }
        
        // BUG TRIGGER: nullptr dereference when scales_size = 0
        float scale = scales[scale_idx];  // <-- SEGMENTATION FAULT!
        
        // Dequantize
        float result = acc * scale;
        
        // Write output
        output[row * N + col] = result;
    }
}
