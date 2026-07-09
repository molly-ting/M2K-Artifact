#include "hip/hip_runtime.h"
// fp8_quant_overflow_bug.cu
//
// Minimal standalone CUDA file reproducing the integer overflow bug fixed in
// https://github.com/vllm-project/vllm/pull/6649
//
// Bug summary:
//   - Loop counters use int32 instead of int64_t
//   - With large sequences (e.g., 1 million tokens), int32 overflows
//   - Causes illegal memory access and corruption
//
// PR #6649 fixes this by changing loop indices from int to int64_t

#include <cstdio>
#include <cstdint>
#include <hip/hip_runtime.h>

// FP16 type definition (replacement for hip/hip_fp16.h)
#if !defined(__CUDA_FP16_H__)
struct __half {
    unsigned short __x;
    
    __device__ __host__ __half() : __x(0) {}
    __device__ __host__ explicit __half(float f) {
        // Convert float to fp16 (simplified IEEE 754 half precision)
        unsigned int x = *reinterpret_cast<unsigned int*>(&f);
        unsigned int sign = (x >> 16) & 0x8000;
        unsigned int exp = ((x >> 23) & 0xff) - 127 + 15;
        unsigned int mantissa = (x >> 13) & 0x3ff;
        
        if (exp <= 0) {
            __x = sign;  // Zero or denormal
        } else if (exp >= 31) {
            __x = sign | 0x7c00;  // Infinity
        } else {
            __x = sign | (exp << 10) | mantissa;
        }
    }
    
    __device__ __host__ operator float() const {
        unsigned int sign = (__x >> 15) & 0x1;
        unsigned int exp = (__x >> 10) & 0x1f;
        unsigned int mantissa = __x & 0x3ff;
        
        if (exp == 0) {
            return sign ? -0.0f : 0.0f;  // Zero or denormal
        } else if (exp == 31) {
            return sign ? -1e38f : 1e38f;  // Infinity
        }
        
        unsigned int result = (sign << 31) | ((exp - 15 + 127) << 23) | (mantissa << 13);
        return *reinterpret_cast<float*>(&result);
    }
};

typedef __half half;
#endif

// Helper function to convert float to FP8 (simplified)
__device__ __forceinline__ unsigned char float_to_fp8(float val) {
    // Simplified FP8 conversion - clamp and scale
    float clamped = fminf(fmaxf(val, -448.0f), 448.0f);
    return static_cast<unsigned char>((clamped / 448.0f) * 127.0f + 128.0f);
}

// ❌ BUGGY KERNEL: Uses int32 for loop counter
// With num_elements > 2^31, this will overflow
template<typename scalar_t>
__global__ void scaled_fp8_quant_kernel_buggy(
    unsigned char* __restrict__ output,
    const scalar_t* __restrict__ input,
    const float* __restrict__ scale,
    int num_elements)  // ❌ BUG: Should be int64_t
{
    const float inv_scale = 1.0f / (*scale);
    
    // ❌ BUG: Loop counter 'i' is int32, will overflow with large num_elements
    for (int i = blockIdx.x * blockDim.x + threadIdx.x; 
         i < num_elements; 
         i += blockDim.x * gridDim.x) {
        // When i overflows (becomes negative), this causes:
        // 1. Illegal memory access (negative index)
        // 2. Wrong elements being quantized
        // 3. Memory corruption
        float val = static_cast<float>(input[i]) * inv_scale;
        output[i] = float_to_fp8(val);
    }
}

// ✅ FIXED KERNEL: Uses int64_t for loop counter  
template<typename scalar_t>
__global__ void scaled_fp8_quant_kernel_fixed(
    unsigned char* __restrict__ output,
    const scalar_t* __restrict__ input,
    const float* __restrict__ scale,
    int64_t num_elements)  // ✅ FIX: Use int64_t
{
    const float inv_scale = 1.0f / (*scale);
    
    // ✅ FIX: Loop counter 'i' is int64_t, handles large sequences
    for (int64_t i = blockIdx.x * blockDim.x + threadIdx.x; 
         i < num_elements; 
         i += blockDim.x * gridDim.x) {
        float val = static_cast<float>(input[i]) * inv_scale;
        output[i] = float_to_fp8(val);
    }
}

void test_overflow_bug() {
    // Scenario from PR #6649: neuralmagic/Mistral-Nemo-Instruct-2407-FP8
    // Maximum sequence length: 1 million tokens
    // Hidden size: 5120
    // Total elements: 1,000,000 * 5,120 = 5,120,000,000 > INT32_MAX (2,147,483,647)
    
    const int64_t num_tokens = 1000000;  // 1 million tokens
    const int64_t hidden_size = 5120;
    const int64_t num_elements = num_tokens * hidden_size;
    
    printf("Testing FP8 quantization overflow bug\n");
    printf("num_tokens: %ld\n", num_tokens);
    printf("hidden_size: %ld\n", hidden_size);
    printf("num_elements: %ld\n", num_elements);
    printf("INT32_MAX: %d\n", INT32_MAX);
    printf("Overflow: %s\n\n", num_elements > INT32_MAX ? "YES ❌" : "NO ✅");
    
    if (num_elements <= INT32_MAX) {
        printf("Note: num_elements fits in int32, use larger values to trigger bug\n");
        return;
    }
    
    // Allocate memory
    float* h_input = new float[num_elements];
    unsigned char* h_output_buggy = new unsigned char[num_elements];
    unsigned char* h_output_fixed = new unsigned char[num_elements];
    
    // Initialize input
    for (int64_t i = 0; i < num_elements; ++i) {
        h_input[i] = static_cast<float>((i % 100) - 50) / 10.0f;
    }
    
    // Device memory
    float *d_input;
    unsigned char *d_output;
    float *d_scale;
    
    hipMalloc(&d_input, num_elements * sizeof(float));
    hipMalloc(&d_output, num_elements * sizeof(unsigned char));
    hipMalloc(&d_scale, sizeof(float));
    
    hipMemcpy(d_input, h_input, num_elements * sizeof(float), hipMemcpyHostToDevice);
    
    float scale_val = 1.0f;
    hipMemcpy(d_scale, &scale_val, sizeof(float), hipMemcpyHostToDevice);
    
    // Launch buggy kernel
    dim3 block(256);
    dim3 grid((num_elements + block.x - 1) / block.x);
    if (grid.x > 65535) grid.x = 65535;  // Limit grid size
    
    printf("Launching BUGGY kernel (int32 loop counter)...\n");
    scaled_fp8_quant_kernel_buggy<float><<<grid, block>>>(
        d_output, d_input, d_scale, static_cast<int>(num_elements)  // ❌ Truncation here!
    );
    
    hipError_t err = hipGetLastError();
    if (err != hipSuccess) {
        printf("BUGGY kernel error: %s\n", hipGetErrorString(err));
    }
    
    hipMemcpy(h_output_buggy, d_output, num_elements * sizeof(unsigned char), hipMemcpyDeviceToHost);
    
    // Clear output for fixed kernel
    hipMemset(d_output, 0, num_elements * sizeof(unsigned char));
    
    // Launch fixed kernel
    printf("Launching FIXED kernel (int64_t loop counter)...\n");
    scaled_fp8_quant_kernel_fixed<float><<<grid, block>>>(
        d_output, d_input, d_scale, num_elements  // ✅ No truncation
    );
    
    err = hipGetLastError();
    if (err != hipSuccess) {
        printf("FIXED kernel error: %s\n", hipGetErrorString(err));
    }
    
    hipMemcpy(h_output_fixed, d_output, num_elements * sizeof(unsigned char), hipMemcpyDeviceToHost);
    
    // Compare results (sample first and last elements)
    printf("\nResults comparison (first and last 5 elements):\n");
    printf("Index        | Buggy | Fixed | Match\n");
    printf("-------------|-------|-------|-------\n");
    
    for (int i = 0; i < 5; ++i) {
        bool match = h_output_buggy[i] == h_output_fixed[i];
        printf("%12d | %5d | %5d | %s\n", i, h_output_buggy[i], h_output_fixed[i], match ? "✓" : "✗");
    }
    
    printf("...\n");
    
    for (int64_t i = num_elements - 5; i < num_elements; ++i) {
        bool match = h_output_buggy[i] == h_output_fixed[i];
        printf("%12ld | %5d | %5d | %s\n", i, h_output_buggy[i], h_output_fixed[i], match ? "✓" : "✗");
    }
    
    // Cleanup
    hipFree(d_input);
    hipFree(d_output);
    hipFree(d_scale);
    delete[] h_input;
    delete[] h_output_buggy;
    delete[] h_output_fixed;
}

int main() {
    test_overflow_bug();
    return 0;
}
