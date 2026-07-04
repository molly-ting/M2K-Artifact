
#include <cuda_runtime_api.h>

// CUDA FP16 definitions for older CUDA versions without cuda_fp16.h
#if !defined(__CUDA_FP16_H__)
struct __half {
    unsigned short x;
};

typedef __half half;
typedef __half float16_t;

__device__ __forceinline__ __half __float2half(float f) {
    __half h;
    // asm("cvt.rn.f16.f32 %0, %1;" : "=h"(h.x) : "f"(f));
    return h;
}

__device__ __forceinline__ float __half2float(__half h) {
    float f;
    // asm("cvt.f32.f16 %0, %1;" : "=f"(f) : "h"(h.x));
    return f;
}
#endif

#define CUDA_CHECK(expr)                                              \
    do {                                                              \
        cudaError_t err__ = (expr);                                   \
    } while (0)

#define BLOCK_SIZE 16
#define max_context_len 256
#define shared_mem_size ((max_context_len + BLOCK_SIZE - 1) / BLOCK_SIZE) * BLOCK_SIZE

// A toy "attention-like" kernel that uses a shared float buffer.
// Make BLOCK_SIZE a non-type template parameter so shared buffer has fixed size.
__global__ void single_query_cached_kv_attention_kernel(
    float* __restrict__ out,
    const float* __restrict__ in,
    int n) {

    // GKLEE's __shared__ macro produces a static array; unsized is not allowed.
    __shared__ float16_t shared_mem[shared_mem_size];

    float* logits = reinterpret_cast<float*>(shared_mem);
    int token_idx = blockIdx.x*BLOCK_SIZE+threadIdx.x;

    float val = static_cast<float>(in[threadIdx.x]);
    // BUG: shared_mem is float16_t[256] = 512 bytes = 128 floats
    // but token_idx can be up to 255, causing out-of-bounds write
    logits[token_idx] = val * 0.5f;
    // __syncthreads();

    out[threadIdx.x] = static_cast<float>(logits[token_idx]);
}

// Launcher: avoid constexpr; use enum for compile-time constant.
void single_query_cached_kv_attention_launcher(
    float* out,
    const float* in,
    int n,
    cudaStream_t stream = 0) {

    // enum { BLOCK_SIZE = 16 }; // compile-time constant without C++11
    int grid_size = (max_context_len + BLOCK_SIZE - 1) / BLOCK_SIZE;

    int padded_max_context_len = ((max_context_len + BLOCK_SIZE - 1) / BLOCK_SIZE) * BLOCK_SIZE;
    int logits_size = padded_max_context_len * sizeof(float);  // still the intentional bug

    // GKLEE will rewrite <<< >>> via fix_kernel; keep standard launch here.
    // single_query_cached_kv_attention_kernel
    //     <<<grid_size, BLOCK_SIZE, shared_mem_size, stream>>>(out, in, n);
    dim3 grid(2);
    dim3 block(2);
    ESBMC_verify_kernel(single_query_cached_kv_attention_kernel, grid, block, out, in, n);
}

int main() {
    const int n = 256;
    const size_t bytes = n * sizeof(float);

    float* d_in = 0;
    float* d_out = 0;

    // cudaMalloc(&d_in, bytes);
    // cudaMalloc(&d_out, bytes);

    float h_in[n];
    for (int i = 0; i < n; ++i) {
        h_in[i] = static_cast<float>(i);
    }
    float h_out[n];

    // cudaMemcpy(d_in, h_in, bytes, cudaMemcpyHostToDevice);

    single_query_cached_kv_attention_launcher(h_out, h_in, n);

    // cudaDeviceSynchronize();

    // float h_out[n];
    // cudaMemcpy(h_out, d_out, bytes, cudaMemcpyDeviceToHost);


    // cudaFree(d_in);
    // cudaFree(d_out);

    return 0;
}
// ...existing code...