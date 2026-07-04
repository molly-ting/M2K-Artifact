// rms_norm_stride_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates incorrect stride causing out-of-bounds access bug from vLLM PR #26192

#include <stdio.h>
#include <math.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define SEQ_LEN 32768
#define HIDDEN_SIZE 128
#define NUM_TOKENS SEQ_LEN
#define TOTAL_ELEMS ((long)SEQ_LEN * HIDDEN_SIZE)
#define INPUT_STRIDE_BUGGY 4194304

__global__ void rms_norm_kernel_buggy(
    float* __restrict__ out,
    const float* __restrict__ input)
{
    // Hardcoded parameters to reduce arguments
    const long input_stride = INPUT_STRIDE_BUGGY;
    const int num_tokens = NUM_TOKENS;
    const int hidden_size = HIDDEN_SIZE;
    const float epsilon = 1e-5f;
    
    int token_idx = blockIdx.x;
    int tid       = threadIdx.x;

    // Each block handles one "token row".
    if (token_idx >= num_tokens) {
        return;
    }

    // ❌ BUG: we trust input_stride blindly.
    // base index is token_idx * input_stride, which may be >> num_tokens*hidden_size.
    // 
    // BUG TRIGGER:
    // input_stride = 4194304 (BUGGY - should be 128)
    // Actual buffer size: 32768 * 128 = 4194304 elements (indices 0 to 4194303)
    // 
    // When token_idx = 1:
    //   base = 1 * 4194304 = 4194304
    //   input[base + i] = input[4194304 + i]
    //   But valid indices are only [0..4194303]!
    //   OUT OF BOUNDS!
    // 
    // When token_idx = 2:
    //   base = 2 * 4194304 = 8388608
    //   Even more out of bounds!
    long base = (long)token_idx * input_stride;

    // Compute mean square for this "row".
    float sum_sq = 0.0f;
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float v = input[base + i];  // <-- OOB if base is too large
        sum_sq += v * v;
    }

    // Simple block reduction (naive): just use shared memory for demo.
    __shared__ float shm[1024];  // assume blockDim.x <= 1024
    shm[tid] = sum_sq;
    __syncthreads();

    // Reduce in shared memory
    for (int offset = blockDim.x / 2; offset > 0; offset >>= 1) {
        if (tid < offset && tid + offset < blockDim.x) {
            shm[tid] += shm[tid + offset];
        }
        __syncthreads();
    }

    float inv_rms = 0.0f;
    if (tid == 0) {
        float mean_sq = shm[0] / hidden_size;
        inv_rms = 1.0f / sqrtf(mean_sq + epsilon);
        shm[0] = inv_rms;
    }
    __syncthreads();
    inv_rms = shm[0];

    // Normalize
    for (int i = tid; i < hidden_size; i += blockDim.x) {
        float v = input[base + i];  // <-- same buggy base
        out[token_idx * hidden_size + i] = v * inv_rms;
    }
}

int main() {
    // BUG SCENARIO from PR #26192:
    // Host passes incorrect stride to rms_norm_kernel
    // because tensor wasn't properly viewed as [-1, hidden_size]
    // 
    // input_shape = (32768, 1, 128)
    // input_stride = (128, 4194304, 1)
    // 
    // Contiguous buffer size: 32768 * 128 = 4194304 floats
    // Correct stride (for 2D view): 128
    // BUGGY stride (from 3D tensor): 4194304
    // 
    // When kernel uses stride 4194304:
    //   token_idx 0: base = 0 * 4194304 = 0 (OK)
    //   token_idx 1: base = 1 * 4194304 = 4194304 (OUT OF BOUNDS!)
    //   token_idx 2: base = 2 * 4194304 = 8388608 (WAY OUT OF BOUNDS!)
    // 
    // This causes "illegal memory access" in qwen3_moe models
    // when running with torch.compile under certain configurations
    
    // Allocate host memory for ESBMC verification
    float h_input[TOTAL_ELEMS];
    float h_output[TOTAL_ELEMS];
    
    // Initialize input
    for (long i = 0; i < TOTAL_ELEMS; i++) {
        h_input[i] = (float)(i % 1000) * 0.001f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);  // 2 blocks, one per token
    dim3 block(2);        // 2 threads per block
    
    // BUG TRIGGER:
    // Stride parameter: 4194304 (WRONG! Should be 128)
    // Buffer size: 32768 * 128 = 4194304 elements
    // Valid indices: [0..4194303]
    // 
    // Block 1 (token_idx=1) accesses:
    //   base = 1 * 4194304 = 4194304
    //   input[4194304 + 0..127]
    //   OUT OF BOUNDS! (4194304 > 4194303)
    // 
    // Block 2+ access even larger indices
    // Massive out-of-bounds access!
    
    ESBMC_verify_kernel(rms_norm_kernel_buggy, grid, block,
        h_output,
        h_input);
    
    return 0;
}