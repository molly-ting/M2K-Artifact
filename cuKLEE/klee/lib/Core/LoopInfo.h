#ifndef KLEE_KLOOPINFO_H
#define KLEE_KLOOPINFO_H


#include "klee/Expr/Expr.h"

#include <string>
// #include <vector>

namespace llvm {
  class BasicBlock;
}

namespace klee {
    class KLoopInfo {
        private:
            static int counter;
        public:
            enum IncreType {
                ADD,
                SUB,
                MUL,
                DIV
            };
            unsigned id;
            int times = 0;
            llvm::BasicBlock * backedge;
            ref<Expr> initialVal;
            ref<Expr> exitExpr;
            ref<Expr> indexExpr;
            ref<Expr> address;
            std::string indexName;
            bool symbolizeIndex;
            bool isSigned;
            int executedTimes = 0;
            ref<Expr> increment;
            IncreType increType;
            ref<Expr> cond;
            bool twoBlocks;
            // unsigned tripCount; 
            std::set<llvm::BasicBlock*> bodyBlocks;

            KLoopInfo(llvm::BasicBlock * _backedge, bool _symbolizeIndex, bool _twoBlocks,
            std::set<llvm::BasicBlock*> body)
                : id(counter),
                backedge(_backedge),
                indexExpr(nullptr),
                indexName("loop_index_"+std::to_string(counter++)),
                symbolizeIndex(_symbolizeIndex),
                twoBlocks(_twoBlocks), 
                // tripCount(tc),
                bodyBlocks(std::move(body)) {
            }

            KLoopInfo(const KLoopInfo& loopInfo)
                : id(loopInfo.id),
                times(loopInfo.times),
                backedge(loopInfo.backedge),
                initialVal(loopInfo.initialVal),
                exitExpr(loopInfo.exitExpr),
                indexExpr(loopInfo.indexExpr),
                address(loopInfo.address),
                indexName(loopInfo.indexName),
                symbolizeIndex(loopInfo.symbolizeIndex),
                isSigned(loopInfo.isSigned),
                executedTimes(loopInfo.executedTimes),
                increment(loopInfo.increment),
                increType(loopInfo.increType),
                cond(loopInfo.cond),
                twoBlocks(loopInfo.twoBlocks), 
                // tripCount(loopInfo.tripCount),
                bodyBlocks(loopInfo.bodyBlocks) {
            }

            ~KLoopInfo(){
                bodyBlocks.clear();
            }

            void incrIndexName() {
                indexName = "loop_index_"+std::to_string(++counter);
            }

            static ref<Expr> getIterationTimes(ref<Expr> _index, IncreType _increType, ref<Expr> _increment, ref<Expr> _initialV) {
                if (!_increment) {
                    return SubExpr::create(SExtExpr::create(_index, _initialV->getWidth()), _initialV);
                }

                switch (_increType) {
                    case ADD:
                        return SDivExpr::create(SExtExpr::create(SubExpr::create(SExtExpr::create(_index, _initialV->getWidth()), _initialV), _increment->getWidth()), _increment);
                    case SUB:
                        return SDivExpr::create(SExtExpr::create(SubExpr::create(_initialV, SExtExpr::create(_index, _initialV->getWidth())), _increment->getWidth()), _increment);
                    // case MUL: // TODO
                    // case DIV: 
                }
                return SubExpr::create(SExtExpr::create(_index, _initialV->getWidth()), _initialV);
            }

            ref<Expr> getTripCount() {
                if (increment.isNull() || initialVal.isNull() || exitExpr.isNull()) {
                    return nullptr;
                }

                switch (increType) {
                    case ADD:
                        return SDivExpr::create(SExtExpr::create(SubExpr::create(exitExpr, initialVal), increment->getWidth()), increment);
                    case SUB:
                        return SDivExpr::create(SExtExpr::create(SubExpr::create(initialVal, exitExpr), increment->getWidth()), increment);
                    case MUL: // TODO
                    case DIV: 
                        return nullptr;
                }
                return nullptr;
            }
    };
}

#endif /* KLEE_KLOOPINFO_H */