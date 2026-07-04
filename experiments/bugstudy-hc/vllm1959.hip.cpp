#include "hip/hip_runtime.h"
// silu_and_mul_buggy.cpp
//
// Minimal standalone CUDA file reproducing the issue fixed in
// https://github.com/vllm-project/vllm/pull/1959
//
// Bug summary:
//  - Kernel launch uses the *current CUDA device*
//  - But tensor memory may live on a different device
//  - Without OptionalCUDAGuard, this can cause invalid writes
//
// This file does NOT require PyTorch headers and will compile with nvcc.
// It does not *trigger* multi-GPU failure unless manually arranged,
// but it faithfully mirrors the missing-guard bug pattern.

#include <cstdio>
#include <hip/hip_runtime.h>

// -------------------------------------------------------
// CUDA kernel (same mathematical operation as vLLM's)
// out = silu(x) * y where input = [x, y] concatenated
// -------------------------------------------------------
__global__ void silu_and_mul_kernel(float* out,
                                    const float* input,
                                    int d) {
    int row = blockIdx.x;
    int col = threadIdx.x;
    if (col >= d) return;

    // input layout: [..., 2*d]
    float x = input[row * 2 * d + col];
    float y = input[row * 2 * d + col + d];

    float sig = 1.f / (1.f + expf(-x));
    out[row * d + col] = sig * y;
}

// -------------------------------------------------------
// BUGGY VERSION (matches PR 1959 before fix)
// No device guard: launches kernel on current device
// -------------------------------------------------------
void silu_and_mul(float* out,
                  const float* input,
                  int num_tokens,
                  int d) {

    dim3 grid(num_tokens);
    dim3 block(d > 1024 ? 1024 : d);

    // ❌ BUG: kernel always uses current device,
    //         not necessarily the device holding `input` or `out`
    hipStream_t stream;
    hipStreamCreate(&stream);

    silu_and_mul_kernel<<<grid, block, 0, stream>>>(out, input, d);

    hipStreamSynchronize(stream);
    hipStreamDestroy(stream);
}

// -------------------------------------------------------
// Tiny demonstration driver
// -------------------------------------------------------
int main() {
    int num_tokens = 4;
    int d = 256;
    int input_elems = num_tokens * 2 * d;
    int out_elems = num_tokens * d;

    int device_count;
    hipGetDeviceCount(&device_count);
    
    if (device_count < 2) {
        printf("ERROR: Need at least 2 GPUs to trigger this bug!\n");
        printf("Current system has only %d GPU(s)\n", device_count);
        printf("This bug requires memory on Device 1 but kernel launch on Device 0\n");
        return 1;
    }
    
    // Allocate host memory
    float* h_input = new float[input_elems];

    
    // Allocate memory on Device 1
    hipSetDevice(1);
    float* d_input;
    float* d_output;
    hipMalloc(&d_input, input_elems * sizeof(float));
    hipMalloc(&d_output, out_elems * sizeof(float));
    hipMemcpy(d_input, h_input, input_elems * sizeof(float), hipMemcpyHostToDevice);
    
    
    // Switch to Device 0 (BUG: memory is on Device 1!)
    hipSetDevice(0);
    
   
    // ❌ BUG TRIGGERED: Kernel launches on Device 0, but memory is on Device 1
    silu_and_mul(d_output, d_input, num_tokens, d);
    
    // This will cause:
    // - hipErrorInvalidDevicePointer
    // - or silent incorrect results
    // - or crashes
    
    hipError_t err = hipGetLastError();
    if (err != hipSuccess) {
        printf("CUDA Error detected: %s\n", hipGetErrorString(err));
    } else {
        printf("Kernel completed (may have wrong results)\n");
    }
    
    // Cleanup
    hipSetDevice(1);
    hipFree(d_input);
    hipFree(d_output);
    delete[] h_input;
    
    return 0;
}