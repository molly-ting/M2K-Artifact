#include <cstdio>
#include <cuda_runtime.h>

// -----------------------------------------------------------------------------
// Reproduction of vLLM PR #6798 Scenario
//
// CONTEXT:
// When loading 'wNa16' (quantized weights) with compressed tensors in Row Parallel
// mode (Tensor Parallel > 1), the input dimension (K) is split across GPUs.
//
// THE BUG:
// If quantization is 'channelwise', the group_size covers the entire K dimension.
// The code calculated scale size as:
//      size = input_size_per_partition // group_size
//
// Example: K=8192, TP=2 => input_size_per_partition = 4096.
//          group_size = 8192.
//          size = 4096 // 8192 = 0.
//
// This resulted in a nullptr being passed to the kernel, causing a crash.
//
// THE FIX:
// Ensure scales are replicated or correctly sized (size >= 1) even on partitions.
// -----------------------------------------------------------------------------

// Error checking macro
#define CHECK_CUDA(call) \
    do { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA Error: %s\n", cudaGetErrorString(err)); \
            return; \
        } \
    } while (0)

// A mock "Marlin" kernel simulating the read of scales
__global__ void mock_marlin_kernel(float* output, const float* input, const float* scales, 
                                   int num_elements, int group_size, int k_partition) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (idx < num_elements) {
        // Logic: Map the element index to a row, then to a scale index.
        // In the bug scenario, we are processing rows 0..4095.
        // We need the scale for these rows.
        
        // Simulating access:
        // Even if the scale is "global" (index 0), if 'scales' is nullptr, this crashes.
        int scale_idx = 0; 
        
        // CRASH POINT: If scales was alloc'd with size 0, it is nullptr.
        float s = scales[scale_idx]; 
        
        output[idx] = input[idx] * s;
    }
}

void run_test_case(const char* test_name, int k_global, int tp_size, int group_size, bool apply_fix) {
    printf("Running Test: %s [Fix Applied: %s]\n", test_name, apply_fix ? "YES" : "NO");

    int k_partition = k_global / tp_size; // e.g., 4096
    int num_elements = k_partition * 128; // Arbitrary tensor size

    // --- LOGIC FROM PR ---
    int num_scales;
    if (apply_fix) {
        // Fix: Replicate scales or use global size calculation
        num_scales = k_global / group_size; // 8192 / 8192 = 1
    } else {
        // Bug: Local partition size calculation
        num_scales = k_partition / group_size; // 4096 / 8192 = 0
    }
    // ---------------------


    // Allocate Memory
    float *d_input, *d_output, *d_scales = NULL;
    CHECK_CUDA(cudaMalloc(&d_input, num_elements * sizeof(float)));
    CHECK_CUDA(cudaMalloc(&d_output, num_elements * sizeof(float)));

    if (num_scales > 0) {
        CHECK_CUDA(cudaMalloc(&d_scales, num_scales * sizeof(float)));
        // Initialize valid scale
        float h_scale = 0.5f;
        CHECK_CUDA(cudaMemcpy(d_scales, &h_scale, sizeof(float), cudaMemcpyHostToDevice));
    }
    // If num_scales == 0, d_scales remains NULL (simulating the empty tensor)

    // Launch Kernel
    int threads = 256;
    int blocks = (num_elements + threads - 1) / threads;
    
    mock_marlin_kernel<<<blocks, threads>>>(d_output, d_input, d_scales, num_elements, group_size, k_partition);   

    // Cleanup
    cudaFree(d_input);
    cudaFree(d_output);
    if (d_scales) cudaFree(d_scales);
}

int main() {
    // Parameters reflecting the PR description
    int K_GLOBAL = 8192;
    int GROUP_SIZE = 8192; // Channelwise
    int TP_SIZE = 2;       // Row Parallel split

    // 1. Run the FIXED version first (to show it works)
    run_test_case("Correct Logic", K_GLOBAL, TP_SIZE, GROUP_SIZE, true);

    // 2. Run the BUGGY version (to demonstrate the crash)
    // Note: An illegal memory access might corrupt the CUDA context, 
    // requiring a process restart in real scenarios.
    run_test_case("Bug Logic (PR #6798)", K_GLOBAL, TP_SIZE, GROUP_SIZE, false);

    return 0;
}