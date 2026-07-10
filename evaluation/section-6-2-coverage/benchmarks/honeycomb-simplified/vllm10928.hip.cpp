#include "hip/hip_runtime.h"
// causal_conv1d_conv_states_buggy.cu
//
// Minimal buggy example inspired by vLLM PR #10928:
//
// [BugFix][Kernel]: fix illegal memory access in causal_conv1d
// when conv_states is None.
//
// The real PR changes:
//   if (final_state_position < 0 && seqlen > kWidth) {
// to
//   if (conv_states != nullptr && final_state_position < 0 && seqlen > kWidth) {
//
// Here we intentionally *omit* the conv_states null check to reproduce the bug.

#include <cstdio>
#include <hip/hip_runtime.h>

// Pretend this is part of a more complex causal_conv1d kernel.
__global__ void causal_conv1d_fwd_kernel_buggy(
    float* __restrict__ conv_states,
    int seqlen,
    int kWidth,
    int final_state_position)
{
    int chunk     = blockIdx.x;        // which chunk of the sequence
    int n_chunks  = gridDim.x;
    int tidx      = threadIdx.x;       // thread index within block
    int kNThreads = blockDim.x;

    // In the real kernel this branch is taken for certain shapes when
    // final_state_position is negative and seq length is larger than width.
    //
    // ❌ BUG: no conv_states != nullptr guard here.
    if (final_state_position < 0 && seqlen > kWidth) {
        // Some local values loaded from shared memory in the real code.
        // We just fake it here.
        float vals_load[4] = {1.0f, 2.0f, 3.0f, 4.0f};

        // This "final state" write is meant to happen only on one thread
        // in the second-to-last chunk (n_chunks - 2).
        if ((chunk == n_chunks - 2) && (tidx == kNThreads - 1)) {
            // ❌ BUG: conv_states may be nullptr, so this write becomes
            // an illegal global memory access.
            conv_states[0] = vals_load[0];
        }
    }
}

int main() {
    // Match the shape pattern from the issue a bit (seqlen > kWidth, final_state_position < 0)
    const int seqlen               = 1026;
    const int kWidth               = 4;
    const int final_state_position = -1;   // negative → trigger branch

    // We'll launch 3 chunks so that n_chunks - 2 == 1
    const int n_chunks   = 3;
    const int kNThreads  = 32;

    // ❌ We deliberately pass conv_states = nullptr to simulate "no initial state".
    float* d_conv_states = nullptr;

    dim3 grid(n_chunks);
    dim3 block(kNThreads);

    causal_conv1d_fwd_kernel_buggy<<<grid, block>>>(
        d_conv_states, seqlen, kWidth, final_state_position);


    return 0;
}
