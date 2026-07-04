#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include <string>
#include <unordered_map>

using namespace llvm;

namespace {
class ReplaceDeviceStubCallsPass : public PassInfoMixin<ReplaceDeviceStubCallsPass> {
    public:
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
            bool modified = false;
            std::string keyword = "__device_stub__";

            // Step 1: Collect all stub-real function pairs
            std::unordered_map<Function *, Function *> stubToRealFuncMap;
            for (Function &F : M) {
                if (F.getName().contains(keyword)) {
                    std::string realFunctionName = F.getName().str().substr(F.getName().str().find(keyword) + keyword.length());
                    // Find functions whose name contains realFunctionName
                    auto it = std::find_if(M.begin(), M.end(), [&](Function &realFunc) {
                        return realFunc.getName().contains(realFunctionName) && realFunc.getName()!=F.getName();
                    });

                    if (it != M.end()) {
                        stubToRealFuncMap[&F] = &(*it);
                        // errs() << "stub function name: " << F.getName() << " real function name: " << it->getName() << "\n";
                    } else {
                        errs() << "Warning: Real function containing " << realFunctionName << " not found for stub " << F.getName() << "\n";
                    }
                }
            }

            // Step 2: Traverse all instructions and replace stub calls with real function calls
            for (Function &F : M) {
                for (BasicBlock &BB : F) {
                    for (auto it = BB.begin(), end = BB.end(); it != end; ) {
                        Instruction &I = *it++;
                        if (auto *callInst = dyn_cast<CallInst>(&I)) {
                            Function *calledFunction = callInst->getCalledFunction();
                            if (stubToRealFuncMap.count(calledFunction)) {
                                Function *realFunction = stubToRealFuncMap[calledFunction];
                                callInst->setCalledFunction(realFunction);
                                // IRBuilder<> builder(callInst);
                                // std::vector<Value*> args;
                                // for (auto &arg : callInst->args()) {
                                //     args.push_back(arg.get());
                                // }
                                // errs() << "replace call " << calledFunction->getName() << " with " << realFunction->getName() << " in " << F.getName() << "\n";

                                // // Create a new call to the real function
                                // CallBase *newCall = builder.CreateCall(realFunction->getFunctionType(), realFunction, args);
                                // newCall->setCallingConv(callInst->getCallingConv());

                                // // Replace the old call with the new call
                                // callInst->replaceAllUsesWith(newCall);
                                // callInst->eraseFromParent();
                                modified = true;
                            }
                        } else if (auto *invokeIinst = dyn_cast<InvokeInst>(&I)) {
                            Function *calledFunction = invokeIinst->getCalledFunction();
                            if (stubToRealFuncMap.count(calledFunction)) {
                                Function *realFunction = stubToRealFuncMap[calledFunction];
                                invokeIinst->setCalledFunction(realFunction);
                                modified = true;
                                // errs() << "replace invoke " << calledFunction->getName() << " with " << realFunction->getName() << " in " << F.getName() << "\n";
                            }
                        } else if (auto *storeInst = dyn_cast<StoreInst>(&I)) {
                            Value *storedValue = storeInst->getValueOperand();
                            if (Function *func = dyn_cast<Function>(storedValue)) {
                                if (stubToRealFuncMap.count(func)) {
                                    Function *realFunction = stubToRealFuncMap[func];
                                    storeInst->setOperand(0, realFunction);
                                    modified = true;
                                    // errs() << "replace store " << func->getName() << " with " << realFunction->getName() << " in " << F.getName() << "\n";
                                }
                            }
                        } else if (auto *selectInst = dyn_cast<SelectInst>(&I)) {
                            Value *trueValue = selectInst->getTrueValue();
                            Value *falseValue = selectInst->getFalseValue();

                            if (Function *funcTrue = dyn_cast<Function>(trueValue)) {
                                if (stubToRealFuncMap.count(funcTrue)) {
                                    Function *realFunctionTrue = stubToRealFuncMap[funcTrue];
                                    selectInst->setOperand(1, realFunctionTrue);
                                    modified = true;
                                    // errs() << "replace select true " << funcTrue->getName() << " with " << realFunctionTrue->getName() << " in " << F.getName() << "\n";
                                }
                            }

                            if (Function *funcFalse = dyn_cast<Function>(falseValue)) {
                                if (stubToRealFuncMap.count(funcFalse)) {
                                    Function *realFunctionFalse = stubToRealFuncMap[funcFalse];
                                    selectInst->setOperand(2, realFunctionFalse);
                                    modified = true;
                                    // errs() << "replace select false " << funcFalse->getName() << " with " << realFunctionFalse->getName() << " in " << F.getName() << "\n";
                                }
                            }
                        }
                    }
                }
            }

            return modified ? PreservedAnalyses::none() : PreservedAnalyses::all();
        }

        // Without isRequired returning true, this pass will be skipped for functions
        // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
        // all functions with optnone.
        static bool isRequired() { return true; }
        
    };
} // namespace

// Register the pass using llvmGetPassPluginInfo
extern "C" ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION, "ReplaceDeviceStubCallsPass", LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "replace-stub-calls") {
                        MPM.addPass(ReplaceDeviceStubCallsPass());
                        return true;
                    }
                    return false;
                });
        }};
}
