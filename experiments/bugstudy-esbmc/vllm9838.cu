// causal_conv1d_h100_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates out-of-bounds shared memory access bug from vLLM PR #9838

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define BLOCK_SIZE 32
#define K_NELTS 32

// // float2 structure for ESBMC
// typedef struct {
//     float x;
//     float y;
// } float2;

__device__ float2 make_float2(float x, float y) {
    float2 result;
    result.x = x;
    result.y = y;
    return result;
}

// Buggy kernel with out-of-bounds shared memory access
__global__ void causal_conv1d_final_state_buggy() {
    // Hardcoded parameters to reduce arguments
    const int kNElts = K_NELTS;
    
    // Fixed-size shared array
    __shared__ float smem_exchange[BLOCK_SIZE];

    int tid = threadIdx.x;

    // Initialize exactly kNElts shared elements (indices 0 to 31)
    if (tid < kNElts) {
        smem_exchange[tid] = (float)tid;
    }
    __syncthreads();

    // Mimic the "final state in between the threads data" path.
    const int last_thread = kNElts - 1;  // = 31

    // x_vals_load is treated as a small vector buffer
    float x_vals_load[4];
    typedef float2 vec_t;

    // ❌ BUG: Out-of-bounds shared memory access!
    // We only have valid smem_exchange[0 .. kNElts - 1] = smem_exchange[0..31]
    // But we unconditionally read smem_exchange[last_thread + 1],
    // i.e., smem_exchange[32], which is OUT OF BOUNDS!
    // 
    // Shared memory allocated: smem_exchange[32] (indices 0-31)
    // Valid elements: 0 to 31 (kNElts = 32)
    // Accessed index: last_thread + 1 = 31 + 1 = 32 (OUT OF BOUNDS!)
    // 
    // This triggers "illegal memory access" on H100 and other architectures
    // with strict memory checking.
    if (tid == 0) {
        // ❌ BUG: Reading smem_exchange[32] when only [0..31] exist!
        reinterpret_cast<vec_t*>(x_vals_load)[1] =
            make_float2(smem_exchange[last_thread + 1], 0.0f);  // OOB read

        vec_t v = reinterpret_cast<vec_t*>(x_vals_load)[1];
        
        // Use the value to prevent optimization
        if (v.x > 0.0f) {
            smem_exchange[0] = v.x;
        }
    }
}

int main() {
    // BUG SCENARIO from PR #9838:
    // In causal_conv1d kernel's "final state in between threads data" path,
    // the code unconditionally reads smem_exchange[last_thread + 1]
    // but only elements [0..last_thread] are valid.
    // 
    // With kNElts = 32, last_thread = 31:
    //   Allocated: smem_exchange[32] (indices 0-31)
    //   Valid data: indices 0-31
    //   Accessed: smem_exchange[32] (OUT OF BOUNDS!)
    // 
    // On H100 with strict memory checking, this triggers:
    // "an illegal memory access was encountered"
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);
    
    // BUG TRIGGER:
    // Thread 0 reads smem_exchange[last_thread + 1]
    // last_thread = 31, so reads smem_exchange[32]
    // But smem_exchange only has indices [0..31]
    // Out-of-bounds shared memory access!
    
    ESBMC_verify_kernel(causal_conv1d_final_state_buggy, grid, block);
    
    return 0;
}