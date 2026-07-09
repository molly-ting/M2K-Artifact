#include "hip/hip_runtime.h"
// causal_conv1d_h100_buggy.cu
//
// Minimal buggy example inspired by vLLM PR #9838:
//
// [BugFix][Kernel] Fix Illegal memory access in causal_conv1d in H100
//
// Bug pattern: in the "final state is in between threads data" path,
// the kernel unconditionally does something like
//
//   reinterpret_cast<vec_t*>(x_vals_load)[1] = smem_exchange[last_thread + 1];
//
// but only elements 0..last_thread of smem_exchange are actually valid.
// On H100 this extra read from [last_thread + 1] can hit invalid shared
// memory and trigger "an illegal memory access was encountered".

#include <cstdio>
#include <hip/hip_runtime.h>

// ...existing code...

// Make BLOCK_SIZE a template parameter so shared memory size is compile-time known
template<int BLOCK_SIZE>
__global__ void causal_conv1d_final_state_buggy(int kNElts) {
    // Fixed-size shared array instead of extern __shared__
    __shared__ float smem_exchange[BLOCK_SIZE];

    int tid = threadIdx.x;

    // Initialize exactly kNElts shared elements.
    if (tid < kNElts) {
        smem_exchange[tid] = static_cast<float>(tid);
    }

    // Mimic the "final state in between the threads data" path.
    const int last_thread = kNElts - 1;

    // x_vals_load is treated as a small vector buffer (like vec_t[2]).
    float x_vals_load[4];
    typedef float2 vec_t;  // C++03: use typedef instead of using

    // ❌ BUG:
    // We only have valid smem_exchange[0 .. kNElts - 1],
    // but we unconditionally read smem_exchange[last_thread + 1],
    // i.e., index kNElts, which is out of bounds.
    if (tid == 0) {
        reinterpret_cast<vec_t*>(x_vals_load)[1] =
            make_float2(smem_exchange[last_thread + 1], 0.0f);  // OOB read

        vec_t v = reinterpret_cast<vec_t*>(x_vals_load)[1];
    }
}

int main() {
    const int kNElts     = 32;   // number of valid shared entries
    const int block_size = 32;   // one thread per element
    const size_t smem_bytes = kNElts * sizeof(float);  // for display only



    // Launch with template parameter for compile-time shared memory size
    causal_conv1d_final_state_buggy<32><<<1, block_size>>>(kNElts);


    return 0;
}