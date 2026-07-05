#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;

// =======================
// Helpers
// =======================

static std::string getMD(Value *V, StringRef Kind) {
    if (auto *I = dyn_cast<Instruction>(V)) {
        if (auto *MD = I->getMetadata(Kind)) {
            if (auto *S = dyn_cast<MDString>(MD->getOperand(0)))
                return S->getString().str();
        }
    }
    return "";
}

static void setMD(Instruction *I, StringRef Kind, StringRef Val) {
    LLVMContext &Ctx = I->getContext();
    Metadata *MDVals[] = { MDString::get(Ctx, Val) };
    MDNode *MD = MDNode::get(Ctx, MDVals);
    I->setMetadata(Kind, MD);
}

// =======================
// Pass
// =======================

struct SignednessPropagationPass
    : public PassInfoMixin<SignednessPropagationPass> {

    PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

        bool Changed = false;

        for (auto &I : instructions(F)) {

            // =========================
            // STORE: value → memory
            // =========================
            if (auto *SI = dyn_cast<StoreInst>(&I)) {
                Value *Val = SI->getValueOperand();
                Value *Ptr = SI->getPointerOperand();

                std::string varSign = getMD(Ptr, "var.signedness");
                if (varSign != "signed")
                    continue;
                
                // check bitwidth match
                auto *ValTy = dyn_cast<IntegerType>(Val->getType());
                auto *PtrTy = dyn_cast<PointerType>(Ptr->getType());

                if (!ValTy || !PtrTy)
                    continue;
                
                auto *EltTy = dyn_cast<IntegerType>(PtrTy->getPointerElementType());
                if (!EltTy)
                    continue;

                if (ValTy->getBitWidth() != EltTy->getBitWidth())
                    continue;

                // override signedness of the value
                if (auto *ValI = dyn_cast<Instruction>(Val)) {
                    setMD(ValI, "signedness", "signed");
                    Changed = true;
                }
            }

            // =========================
            // LOAD: memory → SSA
            // =========================
            if (auto *LI = dyn_cast<LoadInst>(&I)) {
                Value *Ptr = LI->getPointerOperand();

                std::string memSign = getMD(Ptr, "mem.signedness");

                if (memSign.empty())
                    memSign = getMD(Ptr, "var.signedness");

                if (!memSign.empty()) {
                    setMD(LI, "signedness", memSign);
                    Changed = true;
                }
            }
        }

        return Changed ? PreservedAnalyses::none()
                       : PreservedAnalyses::all();
    }

    // Without isRequired returning true, this pass will be skipped for functions
    // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
    // all functions with optnone.
    static bool isRequired() { return true; }
};

// =======================
// Registration
// =======================

PassPluginLibraryInfo getPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION,
        "SignednessPropagationPass",
        LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name,
                   FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "signedness-prop") {
                        FPM.addPass(SignednessPropagationPass());
                        return true;
                    }
                    return false;
                });
        }
    };
}

extern "C" LLVM_ATTRIBUTE_WEAK
PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getPluginInfo();
}