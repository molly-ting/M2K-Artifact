//===-- Interpreter.h - Abstract Execution Engine Interface -----*- C++ -*-===//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//===----------------------------------------------------------------------===//

#ifndef KLEE_INTERPRETER_H
#define KLEE_INTERPRETER_H

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <vector>

struct KTest;

namespace llvm {
class Function;
class LLVMContext;
class Module;
class raw_ostream;
class raw_fd_ostream;
}

namespace klee {
class ExecutionState;
class Interpreter;
class TreeStreamWriter;

class InterpreterHandler {
public:
  InterpreterHandler() {}
  virtual ~InterpreterHandler() {}

  virtual llvm::raw_ostream &getInfoStream() const = 0;

  virtual std::string getOutputFilename(const std::string &filename) = 0;
  virtual std::unique_ptr<llvm::raw_fd_ostream> openOutputFile(const std::string &filename) = 0;

  virtual void incPathsCompleted() = 0;
  virtual void incPathsExplored(std::uint32_t num = 1) = 0;

  virtual void processTestCase(const ExecutionState &state,
                               const char *err,
                               const char *suffix) = 0;
};

class Interpreter {
public:
  /// ModuleOptions - Module level options which can be set when
  /// registering a module with the interpreter.
  struct ModuleOptions {
    std::string LibraryDir;
    std::string EntryPoint;
    std::string OptSuffix;
    bool Optimize;
    bool CheckDivZero;
    bool CheckOvershift;
    bool isCUDA;
    bool hasLaunchKernel;

    ModuleOptions(const std::string &_LibraryDir,
                  const std::string &_EntryPoint, const std::string &_OptSuffix,
                  bool _Optimize, bool _CheckDivZero, bool _CheckOvershift, bool _isCuda = false, bool _hasLaunchKernel=false)
        : LibraryDir(_LibraryDir), EntryPoint(_EntryPoint),
          OptSuffix(_OptSuffix), Optimize(_Optimize),
          CheckDivZero(_CheckDivZero), CheckOvershift(_CheckOvershift), isCUDA(_isCuda), hasLaunchKernel(_hasLaunchKernel){}
  };

  enum LogType
  {
	  STP, //.CVC (STP's native language)
	  KQUERY, //.KQUERY files (kQuery native language)
	  SMTLIB2 //.SMT2 files (SMTLIB version 2 files)
  };

  /// InterpreterOptions - Options varying the runtime behavior during
  /// interpretation.
  struct InterpreterOptions {
    /// A frequency at which to make concrete reads return constrained
    /// symbolic values. This is used to test the correctness of the
    /// symbolic execution on concrete programs.
    unsigned MakeConcreteSymbolic;

    InterpreterOptions()
      : MakeConcreteSymbolic(false)
    {}
  };

  struct ParameterValue {
    std::string type;
    std::string valueStr;
    unsigned dim;
    std::map<int, int64_t> shape;
    // unsigned elementSize;
    std::string elementType;
    int64_t maxVal;
    int64_t minVal;
    bool hasDuplicateVal;
    std::vector<ParameterValue> content;
    bool isOutput;
    bool isConstTensor;

    ParameterValue(const std::string &_type, const std::string &_valueStr, unsigned _dim, const std::string &_elementType, 
      int64_t _maxVal=INT64_MAX, int64_t _minVal=INT64_MIN, bool _hasDuplicateVal=true, bool _isOutput=false, bool _isConstTensor=false)
      :type(_type), valueStr(_valueStr), dim(_dim), elementType(_elementType), maxVal(_maxVal), minVal(_minVal), hasDuplicateVal(_hasDuplicateVal),
      isOutput(_isOutput), isConstTensor(_isConstTensor) {}
  };

protected:
  const InterpreterOptions interpreterOpts;

  Interpreter(const InterpreterOptions &_interpreterOpts)
    : interpreterOpts(_interpreterOpts)
  {}

public:
  virtual ~Interpreter() {}

  static Interpreter *create(llvm::LLVMContext &ctx,
                             const InterpreterOptions &_interpreterOpts,
                             InterpreterHandler *ih);

  /// Register the module to be executed.
  /// \param modules A list of modules that should form the final
  ///                module
  /// \return The final module after it has been optimized, checks
  /// inserted, and modified for interpretation.
  virtual llvm::Module *
  setModule(std::vector<std::unique_ptr<llvm::Module>> &modules,
            const ModuleOptions &opts) = 0;

  // supply a tree stream writer which the interpreter will use
  // to record the concrete path (as a stream of '0' and '1' bytes).
  virtual void setPathWriter(TreeStreamWriter *tsw) = 0;

  // supply a tree stream writer which the interpreter will use
  // to record the symbolic path (as a stream of '0' and '1' bytes).
  virtual void setSymbolicPathWriter(TreeStreamWriter *tsw) = 0;

  // supply a test case to replay from. this can be used to drive the
  // interpretation down a user specified path. use null to reset.
  virtual void setReplayKTest(const struct KTest *out) = 0;

  // supply a list of branch decisions specifying which direction to
  // take on forks. this can be used to drive the interpretation down
  // a user specified path. use null to reset.
  virtual void setReplayPath(const std::vector<bool> *path) = 0;

  // supply a set of symbolic bindings that will be used as "seeds"
  // for the search. use null to reset.
  virtual void useSeeds(const std::vector<struct KTest *> *seeds) = 0;

  virtual void setMainModule(llvm::Module *module) = 0;

  virtual void setKernelNames(std::vector<std::string> &_kernelNames) = 0;

  virtual void setOutputDir(const std::string &_dir) = 0;

  // virtual void initializeLoopInfo(llvm::Module *M) = 0;

  virtual void setArgumentValues(std::map<unsigned, Interpreter::ParameterValue> &_argumentValues) = 0;

  virtual void setArgumentCons(std::map<std::string, std::vector<std::tuple<int, int, int>>> equals) = 0;

  virtual void setVRangeCons(std::map<std::string, std::pair<int, int>> ranges)  = 0;

  virtual void setPromptCons(std::map<std::string, unsigned> _promptCons) = 0;

  virtual void runKernelFunction(llvm::Function *f, bool hasLaunchKernel) = 0;

  virtual void runFunctionAsMain(llvm::Function *f,
                                 int argc,
                                 char **argv,
                                 char **envp) = 0;

  /*** Runtime options ***/

  virtual void setHaltExecution(bool value) = 0;

  virtual void setInhibitForking(bool value) = 0;

  virtual void prepareForEarlyExit() = 0;

  /*** State accessor methods ***/

  virtual unsigned getPathStreamID(const ExecutionState &state) = 0;

  virtual unsigned getSymbolicPathStreamID(const ExecutionState &state) = 0;

  virtual void getConstraintLog(const ExecutionState &state,
                                std::string &res,
                                LogType logFormat = STP) = 0;

  virtual bool getSymbolicSolution(const ExecutionState &state,
                                   std::vector<
                                   std::pair<std::string,
                                   std::vector<unsigned char> > >
                                   &res) = 0;

  virtual void getCoveredLines(const ExecutionState &state,
                               std::map<const std::string*, std::set<unsigned> > &res) = 0;
};

} // End klee namespace

#endif /* KLEE_INTERPRETER_H */
