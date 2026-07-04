//===-- ExecutionState.cpp ------------------------------------------------===//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "ExecutionState.h"

#include "Memory.h"

#include "klee/Expr/Expr.h"
#include "klee/Module/Cell.h"
#include "klee/Module/InstructionInfoTable.h"
#include "klee/Module/KInstruction.h"
#include "klee/Module/KModule.h"
#include "klee/Support/Casting.h"
#include "klee/Support/OptionCategories.h"

#include "llvm/IR/Function.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

#include <cassert>
#include <iomanip>
#include <map>
#include <set>
#include <sstream>
#include <stdarg.h>

using namespace llvm;
using namespace klee;

namespace {
cl::opt<bool> DebugLogStateMerge(
    "debug-log-state-merge", cl::init(false),
    cl::desc("Debug information for underlying state merging (default=false)"),
    cl::cat(MergeCat));
  
}
namespace klee {
  extern cl::opt<bool> SingleObjectResolution; 
}

/***/

std::uint32_t ExecutionState::nextID = 1;

/***/

StackFrame::StackFrame(KInstIterator _caller, KFunction *_kf)
  : caller(_caller), kf(_kf), callPathNode(0), 
    minDistToUncoveredOnReturn(0), varargs(0) {
  locals = new Cell[kf->numRegisters];
}

StackFrame::StackFrame(const StackFrame &s) 
  : caller(s.caller),
    kf(s.kf),
    callPathNode(s.callPathNode),
    allocas(s.allocas),
    minDistToUncoveredOnReturn(s.minDistToUncoveredOnReturn),
    varargs(s.varargs) {
  locals = new Cell[s.kf->numRegisters];
  for (unsigned i=0; i<s.kf->numRegisters; i++)
    locals[i] = s.locals[i];
}

StackFrame::~StackFrame() { 
  delete[] locals; 
}

/***/

ExecutionState::ExecutionState(KFunction *kf, MemoryManager *mm)
    : pc(kf->instructions), prevPC(pc) {
  pushFrame(nullptr, kf);
  setID();
  if (mm->stackFactory && mm->heapFactory) {
    stackAllocator = mm->stackFactory.makeAllocator();
    heapAllocator = mm->heapFactory.makeAllocator();
  }
}

ExecutionState::~ExecutionState() {
  for (const auto &cur_mergehandler: openMergeStack){
    cur_mergehandler->removeOpenState(this);
  }

  while (!stack.empty()) popFrame();

  for (auto& pair : loopInfoMap) {
    delete pair.second; // Free allocated memory
  }
  loopInfoMap.clear();

  for (auto& pair : symbolicArrayMap) {
    delete pair.second; // Free allocated memory
  }
  symbolicArrayMap.clear();
  symNames.clear();
  symAddressMap.clear();

  for (auto& pair : tensorSizesMap) {
    delete pair.second; // Free allocated memory
  }
  tensorSizesMap.clear();
  intArgAddBound.clear();
}

ExecutionState::ExecutionState(const ExecutionState& state):
    pc(state.pc),
    prevPC(state.prevPC),
    stack(state.stack),
    incomingBBIndex(state.incomingBBIndex),
    depth(state.depth),
    addressSpace(state.addressSpace),
    stackAllocator(state.stackAllocator),
    heapAllocator(state.heapAllocator),
    constraints(state.constraints),
    pathOS(state.pathOS),
    symPathOS(state.symPathOS),
    coveredLines(state.coveredLines),
    symbolics(state.symbolics),
    cexPreferences(state.cexPreferences),
    arrayNames(state.arrayNames),
    openMergeStack(state.openMergeStack),
    steppedInstructions(state.steppedInstructions),
    instsSinceCovNew(state.instsSinceCovNew),
    unwindingInformation(state.unwindingInformation
                             ? state.unwindingInformation->clone()
                             : nullptr),
    coveredNew(state.coveredNew),
    forkDisabled(state.forkDisabled),
    base_addrs(state.base_addrs),
    base_mos(state.base_mos),
    kernelConfig(state.kernelConfig),
    inMergeRegion(state.inMergeRegion),
    symNames(state.symNames),
    symAddressMap(state.symAddressMap),
    inputIterator(state.inputIterator),
    intArgAddBound(state.intArgAddBound),
    allIntArgAddBound(state.allIntArgAddBound),
    intArrNames(state.intArrNames),
    addressInLoop(state.addressInLoop),
    dataRaces(state.dataRaces),
    io_expr_map(state.io_expr_map) {
  for (const auto &cur_mergehandler: openMergeStack)
    cur_mergehandler->addOpenState(this);
  
  for (const auto &pair : state.loopInfoMap) {
    loopInfoMap[pair.first] = new KLoopInfo(*pair.second);
  }

  for (const auto &pair : state.symbolicArrayMap) {
    symbolicArrayMap[pair.first] = new SymArrayMemoryObject(*pair.second);
  }

  for (const auto &pair : state.tensorSizesMap) {
    tensorSizesMap[pair.first] = new TensorSizesMemoryObject(*pair.second);
  }

  // for (const auto &pair : state.addressInLoop) {
  //   std::map<ref<Expr>, std::tuple<MemOp, MemoryObject::MemType, std::string>> tmpMap;
  //   for (const auto &innerPair : pair.second) {
  //     tmpMap[innerPair.first] = innerPair.second;
  //   }
  //   addressInLoop[pair.first] = tmpMap;
  // }
}

ExecutionState *ExecutionState::branch() {
  depth++;

  auto *falseState = new ExecutionState(*this);
  falseState->setID();
  falseState->coveredNew = false;
  falseState->coveredLines.clear();

  return falseState;
}

void ExecutionState::pushFrame(KInstIterator caller, KFunction *kf) {
  stack.emplace_back(StackFrame(caller, kf));
}

void ExecutionState::popFrame() {
  const StackFrame &sf = stack.back();
  for (const auto *memoryObject : sf.allocas) {
    deallocate(memoryObject);
    addressSpace.unbindObject(memoryObject);
  }
  stack.pop_back();
}

void ExecutionState::deallocate(const MemoryObject *mo) {
  // if (mo->isLocal != true && mo->isLocal != false) return; // invalid MemoryObject, TODO: identify the root cause

  if (SingleObjectResolution) {
    auto mos_it = base_mos.find(mo->address);
    if (mos_it != base_mos.end()) {
      for (auto it = mos_it->second.begin(); it != mos_it->second.end(); ++it) {
        base_addrs.erase(*it);
      }
      base_mos.erase(mos_it->first);
    }
  }

  if (!stackAllocator || !heapAllocator)
    return;

  auto address = reinterpret_cast<void *>(mo->address);
  if (mo->isLocal) {
    stackAllocator.free(address, std::max(mo->size, mo->alignment));
  } else {
    heapAllocator.free(address, std::max(mo->size, mo->alignment));
  }
}

void ExecutionState::addSymbolic(const MemoryObject *mo, const Array *array) {
  symbolics.emplace_back(ref<const MemoryObject>(mo), array);
}

/**/

llvm::raw_ostream &klee::operator<<(llvm::raw_ostream &os, const MemoryMap &mm) {
  os << "{";
  MemoryMap::iterator it = mm.begin();
  MemoryMap::iterator ie = mm.end();
  if (it!=ie) {
    os << "MO" << it->first->id << ":" << it->second.get();
    for (++it; it!=ie; ++it)
      os << ", MO" << it->first->id << ":" << it->second.get();
  }
  os << "}";
  return os;
}

bool ExecutionState::merge(const ExecutionState &b) {
  if (DebugLogStateMerge)
    llvm::errs() << "-- attempting merge of A:" << this << " with B:" << &b
                 << "--\n";
  if (pc != b.pc)
    return false;

  // XXX is it even possible for these to differ? does it matter? probably
  // implies difference in object states?

  if (symbolics != b.symbolics)
    return false;

  // if not the same kernel
  if (kernelConfig.getBlockIdx() != b.kernelConfig.getBlockIdx() || kernelConfig.getThreadIdx() != b.kernelConfig.getThreadIdx())
    return false;

  {
    std::vector<StackFrame>::const_iterator itA = stack.begin();
    std::vector<StackFrame>::const_iterator itB = b.stack.begin();
    while (itA!=stack.end() && itB!=b.stack.end()) {
      // XXX vaargs?
      if (itA->caller!=itB->caller || itA->kf!=itB->kf)
        return false;
      ++itA;
      ++itB;
    }
    if (itA!=stack.end() || itB!=b.stack.end())
      return false;
  }

  std::set< ref<Expr> > aConstraints(constraints.begin(), constraints.end());
  std::set< ref<Expr> > bConstraints(b.constraints.begin(), 
                                     b.constraints.end());
  std::set< ref<Expr> > commonConstraints, aSuffix, bSuffix;
  std::set_intersection(aConstraints.begin(), aConstraints.end(),
                        bConstraints.begin(), bConstraints.end(),
                        std::inserter(commonConstraints, commonConstraints.begin()));
  std::set_difference(aConstraints.begin(), aConstraints.end(),
                      commonConstraints.begin(), commonConstraints.end(),
                      std::inserter(aSuffix, aSuffix.end()));
  std::set_difference(bConstraints.begin(), bConstraints.end(),
                      commonConstraints.begin(), commonConstraints.end(),
                      std::inserter(bSuffix, bSuffix.end()));

  if (DebugLogStateMerge) {
    llvm::errs() << "\tconstraint prefix: [";
    for (std::set<ref<Expr> >::iterator it = commonConstraints.begin(),
                                        ie = commonConstraints.end();
         it != ie; ++it)
      llvm::errs() << *it << ", ";
    llvm::errs() << "]\n";
    llvm::errs() << "\tA suffix: [";
    for (std::set<ref<Expr> >::iterator it = aSuffix.begin(),
                                        ie = aSuffix.end();
         it != ie; ++it)
      llvm::errs() << *it << ", ";
    llvm::errs() << "]\n";
    llvm::errs() << "\tB suffix: [";
    for (std::set<ref<Expr> >::iterator it = bSuffix.begin(),
                                        ie = bSuffix.end();
         it != ie; ++it)
      llvm::errs() << *it << ", ";
    llvm::errs() << "]\n";
  }

  // We cannot merge if addresses would resolve differently in the
  // states. This means:
  // 
  // 1. Any objects created since the branch in either object must
  // have been free'd.
  //
  // 2. We cannot have free'd any pre-existing object in one state
  // and not the other

  if (DebugLogStateMerge) {
    llvm::errs() << "\tchecking object states\n";
    llvm::errs() << "A: " << addressSpace.objects << "\n";
    llvm::errs() << "B: " << b.addressSpace.objects << "\n";
  }
    
  std::set<const MemoryObject*> mutated;
  MemoryMap::iterator ai = addressSpace.objects.begin();
  MemoryMap::iterator bi = b.addressSpace.objects.begin();
  MemoryMap::iterator ae = addressSpace.objects.end();
  MemoryMap::iterator be = b.addressSpace.objects.end();
  for (; ai!=ae && bi!=be; ++ai, ++bi) {
    if (ai->first != bi->first) {
      if (DebugLogStateMerge) {
        if (ai->first < bi->first) {
          llvm::errs() << "\t\tB misses binding for: " << ai->first->id << "\n";
        } else {
          llvm::errs() << "\t\tA misses binding for: " << bi->first->id << "\n";
        }
      }
      return false;
    }
    if (ai->second.get() != bi->second.get()) {
      if (DebugLogStateMerge)
        llvm::errs() << "\t\tmutated: " << ai->first->id << "\n";
      mutated.insert(ai->first);
    }
  }
  if (ai!=ae || bi!=be) {
    if (DebugLogStateMerge)
      llvm::errs() << "\t\tmappings differ\n";
    return false;
  }
  
  // merge stack

  ref<Expr> inA = ConstantExpr::alloc(1, Expr::Bool);
  ref<Expr> inB = ConstantExpr::alloc(1, Expr::Bool);
  for (std::set< ref<Expr> >::iterator it = aSuffix.begin(), 
         ie = aSuffix.end(); it != ie; ++it)
    inA = AndExpr::create(inA, *it);
  for (std::set< ref<Expr> >::iterator it = bSuffix.begin(), 
         ie = bSuffix.end(); it != ie; ++it)
    inB = AndExpr::create(inB, *it);
  
  // ref<Expr> inArrA = ConstantExpr::alloc(1, Expr::Bool);
  // ref<Expr> inArrB = ConstantExpr::alloc(1, Expr::Bool);
  // for (std::set< ref<Expr> >::iterator it = aArrSuffix.begin(), 
  //         ie = aArrSuffix.end(); it != ie; ++it)
  //   inArrA = AndExpr::create(inArrA, *it);
  // for (std::set< ref<Expr> >::iterator it = bArrSuffix.begin(), 
  //         ie = bArrSuffix.end(); it != ie; ++it)
  //   inArrB = AndExpr::create(inArrB, *it);

  // XXX should we have a preference as to which predicate to use?
  // it seems like it can make a difference, even though logically
  // they must contradict each other and so inA => !inB

  std::vector<StackFrame>::iterator itA = stack.begin();
  std::vector<StackFrame>::const_iterator itB = b.stack.begin();
  for (; itA!=stack.end(); ++itA, ++itB) {
    StackFrame &af = *itA;
    const StackFrame &bf = *itB;
    for (unsigned i=0; i<af.kf->numRegisters; i++) {
      ref<Expr> &av = af.locals[i].value;
      const ref<Expr> &bv = bf.locals[i].value;
      if (!av || !bv) {
        // if one is null then by implication (we are at same pc)
        // we cannot reuse this local, so just ignore
      } else {
        av = SelectExpr::create(inA, av, bv);
      }
    }
  }

  for (std::set<const MemoryObject*>::iterator it = mutated.begin(), 
         ie = mutated.end(); it != ie; ++it) {
    const MemoryObject *mo = *it;
    const ObjectState *os = addressSpace.findObject(mo);
    const ObjectState *otherOS = b.addressSpace.findObject(mo);
    assert(os && !os->readOnly && 
           "objects mutated but not writable in merging state");
    assert(otherOS);

    ObjectState *wos = addressSpace.getWriteable(mo, os);
    if (symbolicArrayMap.find(mo->name)!=symbolicArrayMap.end()) {
      continue;
    }

    bool needWriteWhole = false;
    if (mo->size<=8 && !os->hasArray()) {
      ref<Expr> av = wos->read(0, mo->size*8);
      ref<Expr> bv = otherOS->read(0, mo->size*8);
      if (!isa<ConstantExpr>(av)) {
        needWriteWhole = true;
      }
      if (!isa<ConstantExpr>(bv)) {
        needWriteWhole = true;
      }
      // llvm::outs() << av << " " << bv << "\n";
    }
    if (needWriteWhole) {
      ref<Expr> av = wos->read(0, mo->size*8);
      ref<Expr> bv = otherOS->read(0, mo->size*8);
      wos->write(0, SelectExpr::create(inA, av, bv));
    } else {
      for (unsigned i=0; i<mo->size; i++) {
        ref<Expr> av = wos->read8(i);
        ref<Expr> bv = otherOS->read8(i);
        wos->write(i, SelectExpr::create(inA, av, bv));
      }
    }
  }

  constraints = ConstraintSet();

  ConstraintManager m(constraints);
  for (const auto &constraint : commonConstraints)
    m.addConstraint(constraint);
  m.addConstraint(OrExpr::create(inA, inB));

  for (auto &kv : b.symNames) {
    auto it = symNames.find(kv.first);
    if (it == symNames.end()) {
      symNames[kv.first] = kv.second;
    } else if (it->second != kv.second) {
      klee_warning("merge states, symNames[%ld]: %s is different from %s.", kv.first, kv.second.c_str(), it->second.c_str());
    }
  }

  for (auto &kv : b.symAddressMap) {
    auto it = symAddressMap.find(kv.first);
    if (it == symAddressMap.end()) {
      symAddressMap[kv.first] = kv.second;
    } else if (it->second != kv.second) {
      klee_warning("merge states, symAddressMap[%ld]: %ld is different from %ld.", kv.first, kv.second, it->second);
    }
  }

  for (auto &kv : b.symbolicArrayMap) {
    auto it = symbolicArrayMap.find(kv.first);
    if (it == symbolicArrayMap.end()) {
      symbolicArrayMap[kv.first] = kv.second;
    } else if (it->second != kv.second) {
      SymArrayMemoryObject *a = it->second;
      SymArrayMemoryObject *b = kv.second;
      if (a->maxVal.isNull() && !b->maxVal.isNull()) {
        a->maxVal = b->maxVal;
      }
      if (!a->maxVal.isNull() && !b->maxVal.isNull() && a->maxVal != b->maxVal) {
        klee_warning("merge states, symbolicArrayMap %s maxVal are different.", kv.first.c_str());
      }
      if (a->minVal.isNull() && !b->minVal.isNull()) {
        a->minVal = b->minVal;
      }
      if (!a->minVal.isNull() && !b->minVal.isNull() && a->minVal != b->minVal) {
        klee_warning("merge states, symbolicArrayMap %s maxVal are different.", kv.first.c_str());
      }
      if (a->arrayAddress != b->arrayAddress || a->dimensionSize.size() != b->dimensionSize.size() || a->size != b->size)
        klee_warning("merge states, symbolicArrayMap %s are different.", kv.first.c_str());
    }
  }

  for (auto &kv : b.tensorSizesMap) {
    auto it = tensorSizesMap.find(kv.first);
    if (it == tensorSizesMap.end()) {
      tensorSizesMap[kv.first] = kv.second;
    } else if (it->second != kv.second) {
      TensorSizesMemoryObject *a = kv.second;
      TensorSizesMemoryObject *b = it->second;
      if (a->address != b->address || a->tensorName != b->tensorName || a->elements.size() != b->elements.size())
        klee_warning("merge states, tensorSizesMap %s are different.", kv.first.c_str());
    }
  }

  for (auto &kv : b.intArrNames) {
    auto it = intArrNames.find(kv.first);
    if (it == intArrNames.end()) {
      intArrNames[kv.first] = kv.second;
    } else if (it->second != kv.second) {
      klee_warning("merge states, intArrNames[%s]: %d is different from %d.", kv.first.c_str(), kv.second, it->second);
    }
  }

  for (auto &kv : b.dataRaces) {
    auto &vec = dataRaces[kv.first];
    for (auto &expr : kv.second) {
      // only append if not already there
      if (std::find(vec.begin(), vec.end(), expr) == vec.end()) {
        vec.push_back(expr);
      }
    }
  }

  // for (auto &kv : b.io_expr_map) {
  //   auto it = io_expr_map.find(kv.first);
  //   if (it == io_expr_map.end()) {
  //     io_expr_map[kv.first] = kv.second;
  //   } else if (it->second != kv.second) {
  //     klee_warning("merge states, io_expr_map are different\n");
  //   }
  // }

  return true;
}

void ExecutionState::dumpStack(llvm::raw_ostream &out) const {
  unsigned idx = 0;
  const KInstruction *target = prevPC;
  for (ExecutionState::stack_ty::const_reverse_iterator
         it = stack.rbegin(), ie = stack.rend();
       it != ie; ++it) {
    const StackFrame &sf = *it;
    Function *f = sf.kf->function;
    const InstructionInfo &ii = *target->info;
    out << "\t#" << idx++;
    std::stringstream AssStream;
    AssStream << std::setw(8) << std::setfill('0') << ii.assemblyLine;
    out << AssStream.str();
    out << " in " << f->getName().str() << "(";
    // Yawn, we could go up and print varargs if we wanted to.
    unsigned index = 0;
    for (Function::arg_iterator ai = f->arg_begin(), ae = f->arg_end();
         ai != ae; ++ai) {
      if (ai!=f->arg_begin()) out << ", ";

      if (ai->hasName())
        out << ai->getName().str() << "=";

      ref<Expr> value = sf.locals[sf.kf->getArgRegister(index++)].value;
      if (isa_and_nonnull<ConstantExpr>(value)) {
        out << value;
      } else {
        out << "symbolic";
      }
    }
    out << ")";
    if (ii.file != "")
      out << " at " << ii.file << ":" << ii.line;
    out << "\n";
    target = sf.caller;
  }
}

void ExecutionState::addConstraint(ref<Expr> e) {
  ConstraintManager c(constraints);
  c.addConstraint(e);
}

void ExecutionState::addCexPreference(const ref<Expr> &cond) {
  cexPreferences = cexPreferences.insert(cond);
}

void ExecutionState::setCudaKernelConfig(const CUDAKernelConfig &config) {
    kernelConfig = config;
}

const CUDAKernelConfig& ExecutionState::getCudaKernelConfig() const {
    return kernelConfig;
}