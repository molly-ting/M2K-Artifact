#ifndef KLEE_CUDAKernelConfig_H
#define KLEE_CUDAKernelConfig_H

#include "klee/Expr/Expr.h"

namespace klee { 

class CUDAKernelConfig {
public:
    struct Dim3 {
        ref<Expr> x;  // Use ref<Expr> for dimensions
        ref<Expr> y;  
        ref<Expr> z;

        // Constructor
        Dim3(ref<Expr> x = ConstantExpr::create(1, Expr::Int32), 
              ref<Expr> y = ConstantExpr::create(1, Expr::Int32), 
              ref<Expr> z = ConstantExpr::create(1, Expr::Int32))
            : x(x), y(y), z(z) {}
        
        bool operator==(const Dim3 &other) const {
            if (!x.isNull() && !y.isNull() && !z.isNull() && !other.x.isNull() && !other.y.isNull() && !other.z.isNull())
                return x == other.x && y == other.y && z == other.z;
            if (x.isNull() && other.x.isNull()) {
                if (y.isNull() && other.y.isNull()) {
                    if (z.isNull() && other.z.isNull()) {
                        return true;
                    }
                    return z == other.z;
                } else {
                    if (z.isNull() && other.z.isNull()) {
                        return y == other.y;
                    }
                    return y == other.y && z == other.z;
                }
            } else {
                if (y.isNull() && other.y.isNull()) {
                    if (z.isNull() && other.z.isNull()) {
                        return x == other.x;
                    }
                    return x == other.x && z == other.z;
                } else if (z.isNull() && other.z.isNull()) {
                    return x == other.x && y == other.y;
                }
            }
            return false;
        }

        bool operator!=(const Dim3 &other) const {
            return !(*this == other);
        }
    };

private:
    Dim3 gridDim;          // Dimensions of the grid, TempReadExpr if it's symbolic, address otherwise 
    Dim3 blockDim;         // Dimensions of the block
    ref<Expr> sharedMemSize;  // number of bytes of shared memory allocated per block
    Dim3 blockIdx; // blockIdx.x/y/z, TempReadExpr if it's symbolic, address otherwise 
    Dim3 threadIdx;
    // Dim3 gridDimTempRead; // TempReadExpr
    // Dim3 blockDimTempRead;
    // Dim3 blockIdxTempRead; 
    // Dim3 threadIdxTempRead;

public:
    // Constructor
    // CUDAKernelConfig(const Dim3& grid, const Dim3& block, ref<Expr> sharedMem = ConstantExpr::create(0, Expr::Int32), 
    //    const Dim3& bidx = Dim3(ConstantExpr::create(0, Expr::Int32),ConstantExpr::create(0, Expr::Int32),ConstantExpr::create(0, Expr::Int32)), 
    //     const Dim3& tidx = Dim3(ConstantExpr::create(0, Expr::Int32),ConstantExpr::create(0, Expr::Int32),ConstantExpr::create(0, Expr::Int32)))
    //     : gridDim(grid), blockDim(block), sharedMemSize(sharedMem), blockIdx(bidx), threadIdx(tidx) {}
    
    CUDAKernelConfig(const Dim3& grid, const Dim3& block, ref<Expr> sharedMem = ConstantExpr::create(0, Expr::Int32))
        : gridDim(grid), blockDim(block), sharedMemSize(sharedMem), blockIdx(Dim3(0,0,0)), threadIdx(Dim3(0,0,0)) {}

    CUDAKernelConfig() 
        : gridDim(), // Defaults to Dim3(1, 1, 1)
          blockDim(), // Defaults to Dim3(1, 1, 1)
          sharedMemSize(ConstantExpr::create(0, Expr::Int32)), 
          blockIdx(Dim3(0,0,0)),
          threadIdx(Dim3(0,0,0)){}

    // Getters
    Dim3 getGridDim() const { return gridDim; }
    Dim3 getBlockDim() const { return blockDim; }
    ref<Expr> getSharedMemSize() const { return sharedMemSize; }
    Dim3 getBlockIdx() const { return blockIdx; }
    Dim3 getThreadIdx() const { return threadIdx; }
    // Dim3 getGridDimTempRead() const { return gridDimTempRead; }
    // Dim3 getBlockDimTempRead() const { return blockDimTempRead; }
    // Dim3 getBlockIdxTempRead() const { return blockIdxTempRead; }
    // Dim3 getThreadIdxTempRead() const { return threadIdxTempRead; }

    // Setters
    void setGridDim(const Dim3& grid) { gridDim = grid; }
    void setBlockDim(const Dim3& block) { blockDim = block; }
    void setSharedMemSize(ref<Expr> size) { sharedMemSize = size; }
    void setBlockIdx(const Dim3& bid) { blockIdx = bid; }
    void setThreadIdx(const Dim3& tid) { threadIdx = tid; }
    // void setGridDimTempRead(const Dim3& grid) { gridDimTempRead = grid; }
    // void setBlockDimTempRead(const Dim3& block) { blockDimTempRead = block; }
    // void setBlockIdxTempRead(const Dim3& bid) { blockIdxTempRead = bid; }
    // void setThreadIdxTempRead(const Dim3& tid) { threadIdxTempRead = tid; }
};

} // namespace klee

#endif // KLEE_CUDAKernelConfig_H
