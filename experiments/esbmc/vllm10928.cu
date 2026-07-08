// causal_conv1d_conv_states_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates nullptr dereference bug from vLLM PR #10928

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define SEQLEN 1026
#define K_WIDTH 4
#define FINAL_STATE_POSITION -1
#define N_CHUNKS 3
#define K_NTHREADS 32

// Buggy kernel without nullptr check for conv_states
__global__ void causal_conv1d_fwd_kernel_buggy(float* __restrict__ conv_states)
{
    // Hardcoded parameters to reduce arguments
    const int seqlen = SEQLEN;
    const int kWidth = K_WIDTH;
    const int final_state_position = FINAL_STATE_POSITION;
    
    int chunk     = blockIdx.x;        // which chunk of the sequence
    int n_chunks  = gridDim.x;
    int tidx      = threadIdx.x;       // thread index within block
    int kNThreads = blockDim.x;

    // In the real kernel this branch is taken for certain shapes when
    // final_state_position is negative and seq length is larger than width.
    //
    // ❌ BUG: no conv_states != nullptr guard here.
    // The fix adds: if (conv_states != nullptr && final_state_position < 0 && seqlen > kWidth)
    // But buggy version omits the nullptr check!
    if (final_state_position < 0 && seqlen > kWidth) {
        // Some local values loaded from shared memory in the real code.
        float vals_load[4] = {1.0f, 2.0f, 3.0f, 4.0f};

        // This "final state" write is meant to happen only on one thread
        // in the second-to-last chunk (n_chunks - 2).
        if ((chunk == n_chunks - 2) && (tidx == kNThreads - 1)) {
            // ❌ BUG: conv_states may be nullptr, so this write becomes
            // an illegal global memory access (nullptr dereference)!
            // 
            // When conv_states = nullptr (no initial state provided):
            // This write to conv_states[0] causes illegal memory access
            // "an illegal memory access was encountered"
            conv_states[0] = vals_load[0];
        }
    }
}

int main() {
    // BUG SCENARIO from PR #10928:
    // When causal_conv1d is called with conv_states = None (nullptr),
    // and final_state_position < 0 and seqlen > kWidth,
    // the kernel unconditionally tries to write to conv_states[0]
    // without checking if conv_states is nullptr first.
    //
    // Configuration that triggers the bug:
    //   seqlen = 1026 > kWidth = 4 ✓
    //   final_state_position = -1 < 0 ✓
    //   conv_states = nullptr ✓
    //   chunk = 1 (n_chunks - 2 = 3 - 2 = 1) ✓
    //   tidx = 31 (kNThreads - 1 = 32 - 1 = 31) ✓
    //
    // Result: nullptr dereference → illegal memory access
    
    // Allocate host memory for ESBMC verification
    // We intentionally pass nullptr to trigger the bug
    float* h_conv_states = 0;  // nullptr in C style
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);    // 2 chunks
    dim3 block(2); // 2 threads
    
    // BUG TRIGGER:
    // Grid dimensions: 3 chunks
    // Block 1 (chunk = n_chunks - 2 = 1), thread 31 (tidx = kNThreads - 1):
    //   Conditions met:
    //     - final_state_position < 0: -1 < 0 ✓
    //     - seqlen > kWidth: 1026 > 4 ✓
    //     - chunk == n_chunks - 2: 1 == 1 ✓
    //     - tidx == kNThreads - 1: 31 == 31 ✓
    //   
    //   Missing check: conv_states != nullptr
    //   
    //   Result: Writes to conv_states[0] when conv_states is nullptr
    //   → Illegal memory access / nullptr dereference!
    
    ESBMC_verify_kernel(causal_conv1d_fwd_kernel_buggy, grid, block,
        h_conv_states);
    
    return 0;
}