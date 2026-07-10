#include <stdio.h>
#include <cstdint> 
#include <cuda_runtime_api.h>

// Minimal FP16 support for older CUDA versions without cuda_fp16.h
// Define half type as unsigned short (16-bit)
typedef unsigned short half;

// Convert float to half (FP16) - inline assembly version
half __float2half(float f) {
    half result;
    // asm("cvt.rn.f16.f32 %0, %1;" : "=h"(result) : "f"(f));
    return result;
}

// Convert half to float - for debugging if needed
float __half2float(half h) {
    float result;
    // asm("cvt.f32.f16 %0, %1;" : "=f"(result) : "h"(h));
    return result;
}

uint4 make_uint4(unsigned int x, unsigned int y, unsigned int z, unsigned int w)
{
  uint4 t; t.x = x; t.y = y; t.z = z; t.w = w; return t;
}

uint4 dequantize_s4_to_fp16x2(uint32_t const& source)
{
    uint4 result;

    uint32_t*      h   = reinterpret_cast<uint32_t*>(&result);
    uint32_t const i4s = reinterpret_cast<uint32_t const&>(source);

    // First, we extract the i4s and construct an intermediate fp16 number.
    static  uint32_t immLut                = (0xf0 & 0xcc) | 0xaa;
    static  uint32_t BOTTOM_MASK           = 0x000f000f;
    static  uint32_t TOP_MASK              = 0x00f000f0;
    static  uint32_t I4s_TO_F16s_MAGIC_NUM = 0x64006400;

    const uint32_t top_i4s = i4s >> 8;
    asm volatile("lop3.b32 %0, %1, %2, %3, %4;\n"
                 : "=r"(h[0])
                 : "r"(i4s), "n"(BOTTOM_MASK), "n"(I4s_TO_F16s_MAGIC_NUM), "n"(immLut));
    asm volatile("lop3.b32 %0, %1, %2, %3, %4;\n"
                 : "=r"(h[1])
                 : "r"(i4s), "n"(TOP_MASK), "n"(I4s_TO_F16s_MAGIC_NUM), "n"(immLut));
    asm volatile("lop3.b32 %0, %1, %2, %3, %4;\n"
                 : "=r"(h[2])
                 : "r"(top_i4s), "n"(BOTTOM_MASK), "n"(I4s_TO_F16s_MAGIC_NUM), "n"(immLut));
    asm volatile("lop3.b32 %0, %1, %2, %3, %4;\n"
                 : "=r"(h[3])
                 : "r"(top_i4s), "n"(TOP_MASK), "n"(I4s_TO_F16s_MAGIC_NUM), "n"(immLut));

    static uint32_t FP16_TOP_MAGIC_NUM = 0x64006400;
    static uint32_t ONE_SIXTEENTH = 0x2c002c00;
    static uint32_t NEG_64 = 0xd400d400;

    asm volatile("sub.f16x2 %0, %1, %2;\n" : "=r"(h[0]) : "r"(h[0]), "r"(FP16_TOP_MAGIC_NUM));
    asm volatile("fma.rn.f16x2 %0, %1, %2, %3;\n" : "=r"(h[1]) : "r"(h[1]), "r"(ONE_SIXTEENTH), "r"(NEG_64));
    asm volatile("sub.f16x2 %0, %1, %2;\n" : "=r"(h[2]) : "r"(h[2]), "r"(FP16_TOP_MAGIC_NUM));
    asm volatile("fma.rn.f16x2 %0, %1, %2, %3;\n" : "=r"(h[3]) : "r"(h[3]), "r"(ONE_SIXTEENTH), "r"(NEG_64));

    return result;
}

struct GemmArgs {
    int G;
    int split_k_iters;
    half *A;
    int *B;
    half *scaling_factors;
    int *zeros;
    int M;
    int IC;
    int OC;
    half *C;
};

__global__ void gemm_forward_4bit_cuda_m16n128k32(GemmArgs* a)
{
    GemmArgs args = *a;
    int G   = args.G;
    int split_k_iters = args.split_k_iters;

    half* A = args.A;
    int*  B = args.B;
    half* scaling_factors = args.scaling_factors;
    int*  zeros = args.zeros;

    int M  = args.M;
    int IC = args.IC;
    int OC = args.OC;

    half* C = args.C;

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ < 750
  assert(false);
#else
  static uint32_t ZERO = 0x0;
  float C_warp[32];
  __shared__ half A_shared[16 * (32 + 8)];
  __shared__ half B_shared[32 * (128 + 8)];
  
  __shared__ half scaling_factors_shared[128];
  __shared__ half zeros_shared[128];

  int j_factors1 = ((OC + 128 - 1) / 128);
  int blockIdx_x = 0;
  int blockIdx_y = blockIdx.x % ((M + 16 - 1) / 16 * j_factors1);
  int blockIdx_z = blockIdx.x / ((M + 16 - 1) / 16 * j_factors1);

  half A_shared_warp[8];
  half B_shared_warp[32];
  for (int j_0_4_init = 0; j_0_4_init < 4; ++j_0_4_init) {
    for (int i = 0; i < 8; ++i) {
      C_warp[(j_0_4_init * 8) + i] = 0.0;
    }
  }

  static int row_stride_warp = 32 * 8 / 32;
  static int row_stride = 2 * 32 * 8 / 128;
  bool ld_zero_flag = (threadIdx.y * 32 + threadIdx.x) * 8 < 128;
  bool ld_A_flag = (blockIdx_y / j_factors1 * 16 + threadIdx.y * row_stride_warp + threadIdx.x * 8 / 32) < M;

  half* A_ptr = A 
                + (((int)blockIdx_y) / j_factors1 * 16 + (((int)threadIdx.y) * row_stride_warp) + ((int)threadIdx.x) / (32 / 8)) * IC
                + (((int)threadIdx.x) % (32 / 8)) * 8;
  
  int* B_ptr = B
            + ((int)threadIdx.y) * (OC / 8) * 2
            + (((int)threadIdx.x) / (128 / 8)) * (OC / 8)
            + (((int)blockIdx_y) % j_factors1) * (128 / 8)
            + (((int)threadIdx.x) % (128 / 8)) * 1;
                        
  half* A_shared_ptr = A_shared 
                    + ((int)threadIdx.y) * row_stride_warp * (32 + 8) 
                    + (((int)threadIdx.x) / (32 / 8)) * (32 + 8)
                    + (((int)threadIdx.x) % (32 / 8) ) * 8;

  half* B_shared_ptr = B_shared
                    + ((int)threadIdx.y) * (row_stride / 2) * (128 + 8)
                    + (((int)threadIdx.x) / (128 / 8)) * (128 + 8)
                    + (((int)threadIdx.x) % (128 / 8)) * 8;
  
  int* zeros_ptr = zeros
                + (((int)blockIdx_y) % j_factors1) * (128 / 8)
                + ((int)threadIdx.x) % (128 / 8);
  
  half* scaling_factors_ptr = scaling_factors
                            + (((int)blockIdx_y) % j_factors1) * (128) 
                            + (((int)threadIdx.x) % (128 / 8)) * 8;

  half* C_ptr = C 
              + blockIdx_z * M * OC
              + (((int)blockIdx_y) % j_factors1) * 128
              + ((int)threadIdx.y) * 64
              + (((int)threadIdx.x) % 4) * 2;

  for (int ax1_0_1 = 0; ax1_0_1 < 4; ++ax1_0_1) {
    for (int local_id = 0; local_id < 8; ++local_id) {
      int row_offset = (((int)blockIdx_y) / j_factors1) * 16 + ((int)threadIdx.x) / 4 + (local_id % 4) / 2 * 8;
      if (row_offset < M)
      {
        *(C_ptr + ax1_0_1 * 16 + row_offset * OC + (local_id / 4) * 8 + local_id % 2) = __float2half(C_warp[(ax1_0_1 * 8) + local_id]);
      }
    }
  }
#endif
}

int main() {
    // Bug trigger: M=17 (not multiple of 16) causes out-of-bounds access
    // The kernel expects M to be aligned to 16, but M=17 triggers the bug
    int M = 17;     // Buggy: not multiple of 16
    int IC = 128;   // Input channels
    int OC = 256;   // Output channels
    int G = 128;    // Group size
    int split_k_iters = 1;
    
    // Allocate device memory
    // half *d_A, *d_C, *d_scaling_factors;
    // int *d_B, *d_zeros;
    
    size_t A_size = M * IC * sizeof(half);
    size_t B_size = IC * (OC / 8) * sizeof(int);  // 4-bit packed
    size_t C_size = M * OC * sizeof(half);
    size_t scaling_factors_size = (IC / G) * OC * sizeof(half);
    size_t zeros_size = (IC / G) * (OC / 8) * sizeof(int);
    
    // cudaMalloc(&d_A, A_size);
    // cudaMalloc(&d_B, B_size);
    // cudaMalloc(&d_C, C_size);
    // cudaMalloc(&d_scaling_factors, scaling_factors_size);
    // cudaMalloc(&d_zeros, zeros_size);
    
    // // Initialize with dummy data
    // cudaMemset(d_A, 0, A_size);
    // cudaMemset(d_B, 0, B_size);
    // cudaMemset(d_C, 0, C_size);
    // cudaMemset(d_scaling_factors, 0, scaling_factors_size);
    // cudaMemset(d_zeros, 0, zeros_size);

    half d_A[M * IC];
    int d_B[IC * (OC / 8)];
    half d_C[M * OC];
    half d_scaling_factors[(IC / G) * OC];
    int d_zeros[(IC / G) * (OC / 8)];

    // Calculate grid dimensions
    int j_factors1 = (OC + 128 - 1) / 128;  // = 2 for OC=256
    int grid_x = ((M + 16 - 1) / 16) * j_factors1 * split_k_iters;  // = 2 * 2 * 1 = 4
    // dim3 grid(grid_x);
    // dim3 block(32, 2);  // 32 threads x 2 warps = 64 threads
    dim3 grid(2);
    dim3 block(2);
    
    // printf("Launching kernel with buggy input: M=%d (not multiple of 16)\n", M);
    // printf("Grid: (%d, 1, 1), Block: (%d, %d, 1)\n", grid_x, block.x, block.y);
    // printf("This triggers out-of-bounds access in A_shared loading\n");
    
    // Launch kernel - this should trigger the bug
    // gemm_forward_4bit_cuda_m16n128k32<<<grid, block>>>(
    //     G, split_k_iters, d_A, d_B, d_scaling_factors, d_zeros, M, IC, OC, d_C
    // );

    GemmArgs args;

    args.G = G;
    args.split_k_iters = split_k_iters;
    args.A = d_A;
    args.B = d_B;
    args.scaling_factors = d_scaling_factors;
    args.zeros = d_zeros;
    args.M = M;
    args.IC = IC;
    args.OC = OC;
    args.C = d_C;

    GemmArgs* args_ptr = &args;
    ESBMC_verify_kernel(gemm_forward_4bit_cuda_m16n128k32, grid, block, args_ptr);
    
    // cudaError_t err = cudaGetLastError();
    // if (err != cudaSuccess) {
    //     printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    // }
    
    // cudaDeviceSynchronize();
    // err = cudaGetLastError();
    // if (err != cudaSuccess) {
    //     printf("Kernel execution failed: %s\n", cudaGetErrorString(err));
    // } else {
    //     printf("Kernel executed (bug may be silent - use memory checker)\n");
    // }
    
    // // Cleanup
    // cudaFree(d_A);
    // cudaFree(d_B);
    // cudaFree(d_C);
    // cudaFree(d_scaling_factors);
    // cudaFree(d_zeros);
    
    return 0;
}
