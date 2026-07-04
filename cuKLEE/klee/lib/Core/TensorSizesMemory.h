#ifndef KLEE_TENSORSIZESMEMORY_H
#define KLEE_TENSORSIZESMEMORY_H


#include "klee/Expr/Expr.h"

#include <string>
#include <vector>

namespace klee {
    class TensorSizesMemoryObject { // tensor.sizes(), tensor.sizes().vec()
        friend class ExecutionState;
        friend class ref<SymArrayMemoryObject>;

        // private:
        //     static int counter;
        //     /// @brief Required by klee::ref-managed objects
        //     mutable class ReferenceCounter _refCount;
        public:
            // unsigned id;
            uint64_t address;
            const Array * name;
            const std::string tensorName;
            ref<Expr> length;
            std::map<int, ref<Expr>> elements;

            TensorSizesMemoryObject(uint64_t _address, const Array * _name, const std::string _tensorName, ref<Expr> _length)
                : address(_address),
                name(_name),
                tensorName(_tensorName),
                length(_length) {
            }

            TensorSizesMemoryObject(const TensorSizesMemoryObject& sizesObj)
                : address(sizesObj.address),
                name(sizesObj.name),
                tensorName(sizesObj.tensorName),
                length(sizesObj.length),
                elements(sizesObj.elements) {
            }

            ~TensorSizesMemoryObject(){}
    };
}

#endif /* KLEE_TENSORSIZESMEMORY_H */