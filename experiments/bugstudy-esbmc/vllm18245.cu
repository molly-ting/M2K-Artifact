// marlin_act_order_buggy.cu
// Minimal CUDA example for ESBMC verification
// Demonstrates out-of-bounds access bug from vLLM PR #18245

#include <stdio.h>
#include <cuda_runtime_api.h>

#define CUDA_CHECK(expr) expr

// Configuration
#define PROB_K 16
#define PROB_N 32
#define TB_K 4
#define STAGES 4
#define SLICE_K_START_BASE 16
#define NUM_ITERS 2

// Buggy Marlin-like kernel with realistic structure
// This simulates the real Marlin kernel's act_order processing loop
// where slice_k_start can exceed prob_k, causing OOB access
__global__ void marlin_act_order_kernel_buggy(
    const int* __restrict__ g_idx,
    const float* __restrict__ scales,
    float* __restrict__ output)
{
    // Hardcoded parameters to reduce arguments
    const int prob_k = PROB_K;
    const int prob_n = PROB_N;
    const int tb_k = TB_K;
    const int stages = STAGES;
    const int slice_k_start_base = SLICE_K_START_BASE;
    const int num_iters = NUM_ITERS;
    
    int tid = threadIdx.x;
    int bid = blockIdx.x;
    
    // Simulate Marlin's main processing loop structure
    // Real Marlin processes multiple slices/tiles
    for (int iter = 0; iter < num_iters; iter++) {
        // Calculate slice starting position for this iteration
        // This mimics how real Marlin advances through K dimension
        int slice_k_start = slice_k_start_base + iter * tb_k;
        
        // Same pattern as the real kernel:
        //   slice_k_start += tb_k * stages;
        // Result: 16 + 4 * 4 = 32
        slice_k_start += tb_k * stages;
        
        // Compute last_g_idx with clamp (this part is safe)
        int last_g_idx = slice_k_start + stages * tb_k * 2;
        if (last_g_idx >= prob_k) {
            last_g_idx = prob_k - 1;
        }
        
        // ❌ BUG:
        // slice_k_start can be >= prob_k, but we still index g_idx[slice_k_start].
        // This will be an out-of-bounds global memory read when that happens.
        // 
        // BUG TRIGGER:
        // slice_k_start = 16 + 0 * 4 + 4 * 4 = 32
        // prob_k = 16
        // g_idx array has indices [0..15]
        // Accessing g_idx[32] is OUT OF BOUNDS!
        // 
        // This causes "an illegal memory access was encountered"
        int first_group_id = g_idx[slice_k_start];  // <-- OOB read if slice_k_start >= prob_k
        int last_group_id  = g_idx[last_g_idx];     // this one is clamped and safe
        
        // Simulate scale loading loop (typical in quantization kernels)
        // Real Marlin loads scales for dequantization based on group_id
        int num_groups = last_group_id - first_group_id + 1;
        for (int g = 0; g < num_groups; g++) {
            int group_idx = first_group_id + g;
            if (group_idx < prob_n && tid < 32) {  // warp-level processing
                // Load scale for this group
                float scale = scales[group_idx * 32 + tid];
                
                // Simulate some computation with the scale
                // Real Marlin uses this for dequantizing weights
                float result = scale * 127.0f;  // typical int8 dequant
                
                // Write to output (bounds checked to avoid secondary issues)
                int out_idx = (bid * num_iters * 32) + (iter * 32) + tid;
                if (out_idx < prob_n * 32) {
                    output[out_idx] = result;
                }
            }
        }
        
        // Synchronize threads in block (typical in tiled kernels)
        __syncthreads();
        
        // Simulate inner tile processing loop
        // Real Marlin processes 16x16 or similar tiles
        for (int tile = 0; tile < stages; tile++) {
            int k_idx = slice_k_start + tile * tb_k + tid;
            
            // Check if we're still in bounds for this tile
            // (but the damage is already done from the OOB g_idx access above)
            if (k_idx < prob_k) {
                // Simulate weight processing
                // Real Marlin loads and dequantizes weight tiles here
                int weight_group = g_idx[k_idx];
                float scale_val = scales[weight_group];
                
                // More computation...
                float tmp = scale_val * 2.0f;
                if (tid == 0) {
                    output[bid] += tmp;
                }
            }
        }
    }
}

int main() {
    // BUG SCENARIO from PR #18245:
    // Marlin kernel with act_order enabled computes slice_k_start
    // that can exceed prob_k, then accesses g_idx[slice_k_start]
    // without bounds checking, causing illegal memory access.
    //
    // Configuration:
    //   prob_k = 16 (size of g_idx array)
    //   slice_k_start_base = 16
    //   tb_k = 4, stages = 4
    //   slice_k_start = 16 + 4 * 4 = 32
    //
    // Bug Analysis:
    //   g_idx array size: 16 (indices 0-15)
    //   slice_k_start: 32 (exceeds array bounds!)
    //   Access: g_idx[32] when only g_idx[0..15] exist
    //   Out-of-bounds by: 32 - 15 = 17 elements!
    
    // Allocate host memory for ESBMC verification
    int h_g_idx[PROB_K];
    float h_scales[PROB_N * 32];
    float h_output[PROB_N * 32 * NUM_ITERS];
    
    // Initialize arrays
    for (int i = 0; i < PROB_K; i++) {
        h_g_idx[i] = i;
    }
    for (int i = 0; i < PROB_N * 32; i++) {
        h_scales[i] = 0.007874f;
    }
    for (int i = 0; i < PROB_N * 32 * NUM_ITERS; i++) {
        h_output[i] = 0.0f;
    }
    
    // Launch buggy kernel with ESBMC_verify_kernel
    dim3 grid(2);
    dim3 block(2);  // typical warp size
    
    // BUG TRIGGER:
    // In first iteration (iter=0):
    //   slice_k_start = slice_k_start_base + iter * tb_k + tb_k * stages
    //                 = 16 + 0 * 4 + 4 * 4
    //                 = 32
    //   prob_k = 16
    //   
    //   first_group_id = g_idx[slice_k_start] = g_idx[32]
    //   
    //   But g_idx only has indices [0..15]!
    //   OUT OF BOUNDS by 17 elements!
    //   
    //   This causes "an illegal memory access was encountered"
    //   Occurs in Marlin kernel with act_order when processing
    //   quantized weights with certain dimension configurations
    
    ESBMC_verify_kernel(marlin_act_order_kernel_buggy, grid, block,
        h_g_idx,
        h_scales,
        h_output);
    
    return 0;
}