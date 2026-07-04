#ifndef KLEE_SYMARRAYMEMORY_H
#define KLEE_SYMARRAYMEMORY_H


#include "klee/Expr/Expr.h"

#include <string>
#include <vector>

namespace klee {
    class SymArrayMemoryObject {
        friend class ExecutionState;
        // friend class ref<SymArrayMemoryObject>;
        // friend class ref<const SymArrayMemoryObject>;

        // private:
        //     static int counter;
        //     /// @brief Required by klee::ref-managed objects
        //     mutable class ReferenceCounter _refCount;
        public:
            // unsigned id;
            uint64_t arrayAddress;
            const Array * arrayName;
            const Array * sizeName;
            ref<Expr> size; // for tensor: the number of elements, others: bytes of the array
            // std::vector<ref<Expr>> sizeConstraints;
            std::map<int, ref<Expr>> dimensionSize;
            std::map<int, ref<Expr>> strides;
            std::vector<ref<Expr>> strides_bytes; // broadcast strides in bytes
            ref<Expr> shapeSize;
            ref<Expr> scalarType = nullptr;
            std::map<int, ref<Expr>> constantIndexAddress;
            std::map<ref<Expr>, ref<Expr>> symbolicIndexAddress;
            ref<Expr> elementSize = nullptr;
            ref<Expr> isQuantized = nullptr;
            ref<Expr> qscheme = nullptr;
            ref<Expr> zeroPoint = nullptr;
            ref<Expr> maxVal;
            ref<Expr> minVal;
            bool hasDuplicateVal = true;
            bool isFloat = false;

            SymArrayMemoryObject(uint64_t _address, const Array * _arrayName, const Array * _sizeName, ref<Expr> _size)
                : arrayAddress(_address),
                arrayName(_arrayName),
                sizeName(_sizeName),
                size(_size) {
            }

            SymArrayMemoryObject(const SymArrayMemoryObject& symObj)
                : arrayAddress(symObj.arrayAddress),
                arrayName(symObj.arrayName),
                sizeName(symObj.sizeName),
                size(symObj.size),
                dimensionSize(symObj.dimensionSize),
                strides(symObj.strides),
                shapeSize(symObj.shapeSize),
                scalarType(symObj.scalarType),
                constantIndexAddress(symObj.constantIndexAddress),
                symbolicIndexAddress(symObj.symbolicIndexAddress),
                elementSize(symObj.elementSize),
                isQuantized(symObj.isQuantized),
                qscheme(symObj.qscheme),
                zeroPoint(symObj.zeroPoint),
                maxVal(symObj.maxVal),
                minVal(symObj.minVal),
                hasDuplicateVal(symObj.hasDuplicateVal),
                isFloat(symObj.isFloat) {
            }

            ~SymArrayMemoryObject(){
                dimensionSize.clear();
                strides.clear();
                constantIndexAddress.clear();
                symbolicIndexAddress.clear();
            }

            // void addSizeConstraint(ref<Expr> cons) {
            //     auto it = std::find_if(sizeConstraints.begin(), sizeConstraints.end(),
            //         [&cons](const ref<Expr>& existingCons) {
            //             return existingCons == cons; // Compare the underlying expressions
            //         });
                    
            //     if (it == sizeConstraints.end())
            //         sizeConstraints.emplace_back(cons);
            // }
    };
}

#endif /* KLEE_SYMARRAYMEMORY_H */