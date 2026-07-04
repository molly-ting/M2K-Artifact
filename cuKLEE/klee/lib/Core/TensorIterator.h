#ifndef KLEE_TENSORITERATOR_H
#define KLEE_TENSORITERATOR_H


#include "klee/Expr/Expr.h"

#include <string>
#include <vector>

namespace klee {
    class TensorIterator {
        friend class ExecutionState;

        public:
            // unsigned id;
            uint64_t address;
            const Array * name;
            const Array * sizeName;
            ref<Expr> size; // number of tensor
            std::vector<std::string> tensors; // symName
            std::vector<bool> isConstTensor;
            std::vector<ref<Expr>> shape; //broadcast shape
            ref<Expr> numel; // multiplication of shape
            int noutputs; // number of output tensors
            bool checkAllSameDtype = true;
            bool resizeOutput = true;

            TensorIterator(uint64_t _address, const Array * _name, const Array * _sizeName, ref<Expr> _size, int _noutputs=0)
                : address(_address),
                name(_name),
                sizeName(_sizeName),
                size(_size),
                noutputs(_noutputs) {
            }

            TensorIterator(const TensorIterator& symObj)
                : address(symObj.address),
                name(symObj.name),
                sizeName(symObj.sizeName),
                size(symObj.size),
                tensors(symObj.tensors),
                isConstTensor(symObj.isConstTensor),
                shape(symObj.shape),
                numel(symObj.numel),
                noutputs(symObj.noutputs),
                checkAllSameDtype(symObj.checkAllSameDtype),
                resizeOutput(symObj.resizeOutput)  {
            }

            ~TensorIterator(){
                tensors.clear();
                isConstTensor.clear();
                shape.clear();
            }

            void addTensor(const std::string &tName, bool isConst = false) {
                tensors.push_back(tName);
                isConstTensor.push_back(isConst);
            }

            std::string getTensor(int index) {
                return tensors[index];
            }

            bool isConst(int index) {
                return isConstTensor[index];
            }
    };
}

#endif /* KLEE_TENSORITERATOR_H */