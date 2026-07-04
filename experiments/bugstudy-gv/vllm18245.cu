// Extracted kernel from vllm18245.cu
// Bug: act_order OOB access when slice_k_start >= prob_k
// slice_k_start = slice_k_start_base + tb_k * stages can exceed prob_k
// but g_idx[slice_k_start] is accessed anyway → OOB read
// GPUVerify configuration: blockDim=32, gridDim=1

__global__ void marlin_act_order_kernel_buggy(
    const int* __restrict__ g_idx,
    int prob_k,
    int tb_k,
    int stages,
    int slice_k_start_base)
{
    int slice_k_start = slice_k_start_base;

    // slice_k_start += tb_k * stages;
    slice_k_start += tb_k * stages;

    // Compute last_g_idx with clamp
    int last_g_idx = slice_k_start + stages * tb_k * 2;
    if (last_g_idx >= prob_k) {
        last_g_idx = prob_k - 1;
    }

    // BUG: slice_k_start can be >= prob_k, but we still index g_idx[slice_k_start]
    // This is an out-of-bounds global memory read
    int first_group_id = g_idx[slice_k_start];  // <-- OOB read if slice_k_start >= prob_k
    int last_group_id  = g_idx[last_g_idx];     // this one is clamped and safe

    // Use the values to prevent optimization
    if (threadIdx.x == 0 && blockIdx.x == 0) {
        // Prevent dead code elimination
        if (first_group_id + last_group_id > 0) {
            // No-op
        }
    }
}
