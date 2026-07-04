//===-- Z3Solver.cpp -------------------------------------------*- C++ -*-====//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "klee/Config/config.h"
#include "klee/Support/ErrorHandling.h"
#include "klee/Support/FileHandling.h"
#include "klee/Support/OptionCategories.h"

#include <csignal>

#ifdef ENABLE_Z3

#include "Z3Solver.h"
#include "Z3Builder.h"

#include "klee/Expr/Constraints.h"
#include "klee/Expr/Assignment.h"
#include "klee/Expr/ExprUtil.h"
#include "klee/Solver/Solver.h"
#include "klee/Solver/SolverImpl.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

#include <memory>
#include <cstdio>
#include <fstream>
// #include <atomic>            // for std::atomic
// #include <condition_variable> // for std::condition_variable
// #include <mutex>             // for std::mutex, std::lock_guard, std::unique_lock
// #include <thread>            // for std::thread

namespace {
// NOTE: Very useful for debugging Z3 behaviour. These files can be given to
// the z3 binary to replay all Z3 API calls using its `-log` option.
llvm::cl::opt<std::string> Z3LogInteractionFile(
    "debug-z3-log-api-interaction", llvm::cl::init(""),
    llvm::cl::desc("Log API interaction with Z3 to the specified path"),
    llvm::cl::cat(klee::SolvingCat));

llvm::cl::opt<std::string> Z3QueryDumpFile(
    "debug-z3-dump-queries", llvm::cl::init(""),
    llvm::cl::desc("Dump Z3's representation of the query to the specified path"),
    llvm::cl::cat(klee::SolvingCat));

llvm::cl::opt<bool> Z3ValidateModels(
    "debug-z3-validate-models", llvm::cl::init(false),
    llvm::cl::desc("When generating Z3 models validate these against the query"),
    llvm::cl::cat(klee::SolvingCat));

llvm::cl::opt<unsigned>
    Z3VerbosityLevel("debug-z3-verbosity", llvm::cl::init(0),
                     llvm::cl::desc("Z3 verbosity level (default=0)"),
                     llvm::cl::cat(klee::SolvingCat));
}

#include "llvm/Support/ErrorHandling.h"

namespace klee {

class Z3SolverImpl : public SolverImpl {
private:
  std::unique_ptr<Z3Builder> builder;
  time::Span timeout;
  SolverRunStatus runStatusCode;
  std::unique_ptr<llvm::raw_fd_ostream> dumpedQueriesFile;
  ::Z3_params solverParameters;
  // Parameter symbols
  ::Z3_symbol timeoutParamStrSymbol;
  std::unordered_map<std::string, bool> queryCache;
  // bool useIntFirst = false;

  // bool shouldUseQF(const Query &q);
  int checkSatWithZ3CLI(const std::string &smtQuery, unsigned timeout); // milliseconds
  bool internalRunSolverInt(const Query &,
    const std::vector<const Array *> *objects,
    std::vector<std::vector<unsigned char> > *values,
    bool &hasSolution, unsigned timeout, bool useCLI = false);
  bool internalRunSolverBV(const Query &,
      const std::vector<const Array *> *objects,
      std::vector<std::vector<unsigned char> > *values,
      bool &hasSolution, unsigned timeout);
  bool internalRunSolver(const Query &,
                         const std::vector<const Array *> *objects,
                         std::vector<std::vector<unsigned char> > *values,
                         bool &hasSolution);
  bool validateZ3Model(::Z3_solver &theSolver, ::Z3_model &theModel);

public:
  Z3SolverImpl();
  ~Z3SolverImpl();

  std::string getConstraintLog(const Query &) override;
  void setCoreSolverTimeout(time::Span _timeout) {
    timeout = _timeout;

    auto timeoutInMilliSeconds = static_cast<unsigned>((timeout.toMicroseconds() / 1000));
    if (!timeoutInMilliSeconds)
      timeoutInMilliSeconds = UINT_MAX;
    Z3_params_set_uint(builder->ctx, solverParameters, timeoutParamStrSymbol,
                       timeoutInMilliSeconds);
  }

  bool computeTruth(const Query &, bool &isValid);
  bool computeValue(const Query &, ref<Expr> &result);
  bool computeInitialValues(const Query &,
                            const std::vector<const Array *> &objects,
                            std::vector<std::vector<unsigned char> > &values,
                            bool &hasSolution);
  SolverRunStatus
  handleSolverResponse(::Z3_solver theSolver, ::Z3_lbool satisfiable,
                       const std::vector<const Array *> *objects,
                       std::vector<std::vector<unsigned char> > *values,
                       bool &hasSolution);
  SolverRunStatus
  handleSolverResponseForInt(::Z3_solver theSolver, ::Z3_lbool satisfiable,
                       const std::vector<const Array *> *objects,
                       std::vector<std::vector<unsigned char> > *values,
                       bool &hasSolution, std::map<std::string, unsigned> intArrNames);
  // SolverRunStatus
  // handleTempSolverResponse(::Z3_solver theSolver, ::Z3_lbool satisfiable, Z3Builder* tempBuilder,
  //                      const std::vector<const Array *> *objects,
  //                      std::vector<std::vector<unsigned char> > *values,
  //                      bool &hasSolution);
  SolverRunStatus getOperationStatusCode();
};

int QUERY_CACHE_THRESHOLD = 20;

Z3SolverImpl::Z3SolverImpl()
    : builder(new Z3Builder(
          /*autoClearConstructCache=*/false,
          /*z3LogInteractionFileArg=*/Z3LogInteractionFile.size() > 0
              ? Z3LogInteractionFile.c_str()
              : NULL)),
      runStatusCode(SOLVER_RUN_STATUS_FAILURE) {
  assert(builder && "unable to create Z3Builder");
  solverParameters = Z3_mk_params(builder->ctx);
  Z3_params_inc_ref(builder->ctx, solverParameters);

  Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "auto-config"), true);
  // Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "smt.random_seed"), 42);
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "phase_selection"), 6);
  
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "max_conflicts"), 500); // set max_conflict
  // Set parameters to reduce GC and defrag overhead
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.initial"), 50000); // Larger GC trigger
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.increment"), 1500);  // Less frequent GC
  // Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.defrag"), false);
  // Z3_params_set_symbol(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc"), Z3_mk_string_symbol(builder->ctx, "dyn_psm"));
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.small_lbd"), 6);
  // Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.k"), 10);
  // Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "gc.burst"), true);

  timeoutParamStrSymbol = Z3_mk_string_symbol(builder->ctx, "timeout");
  setCoreSolverTimeout(timeout);

  if (!Z3QueryDumpFile.empty()) {
    std::string error;
    dumpedQueriesFile = klee_open_output_file(Z3QueryDumpFile, error);
    if (!dumpedQueriesFile) {
      klee_error("Error creating file for dumping Z3 queries: %s",
                 error.c_str());
    }
    klee_message("Dumping Z3 queries to \"%s\"", Z3QueryDumpFile.c_str());
  }

  // Set verbosity
  if (Z3VerbosityLevel > 0) {
    std::string underlyingString;
    llvm::raw_string_ostream ss(underlyingString);
    ss << Z3VerbosityLevel;
    ss.flush();
    Z3_global_param_set("verbose", underlyingString.c_str());
  }
}

Z3SolverImpl::~Z3SolverImpl() {
  Z3_params_dec_ref(builder->ctx, solverParameters);
}

Z3Solver::Z3Solver() : Solver(std::make_unique<Z3SolverImpl>()) {}

std::string Z3Solver::getConstraintLog(const Query &query) {
  return impl->getConstraintLog(query);
}

void Z3Solver::setCoreSolverTimeout(time::Span timeout) {
  impl->setCoreSolverTimeout(timeout);
}

std::string Z3SolverImpl::getConstraintLog(const Query &query) {
  std::vector<Z3ASTHandle> assumptions;
  // We use a different builder here because we don't want to interfere
  // with the solver's builder because it may change the solver builder's
  // cache.
  // NOTE: The builder does not set `z3LogInteractionFile` to avoid conflicting
  // with whatever the solver's builder is set to do.
  Z3Builder temp_builder(/*autoClearConstructCache=*/false,
                         /*z3LogInteractionFile=*/NULL);
  ConstantArrayFinder constant_arrays_in_query;
  for (auto const &constraint : query.constraints) {
    // if (constraint == query.expr || constraint == NotExpr::create(query.expr)) {
    //   continue;
    // }
    assumptions.push_back(temp_builder.constructForInt(constraint, query.intArrNames, query.noCheckExprs));
    constant_arrays_in_query.visit(constraint);
  }

  for (auto const &constant_array : constant_arrays_in_query.results) {
    assert(temp_builder.constant_array_assertions.count(constant_array) <= 1 &&
           "Constant array found in query, but not handled by Z3Builder");
    for (auto const &arrayIndexValueExpr :
         temp_builder.constant_array_assertions[constant_array]) {
      assumptions.push_back(arrayIndexValueExpr);
    }
  }

  for (auto const &int_array_pair : temp_builder.int_array_bounds) {
    for (auto const &arrayIndexValueExpr : int_array_pair.second) {
      assumptions.push_back(arrayIndexValueExpr);
    }
  }

  // KLEE Queries are validity queries i.e.
  // ∀ X Constraints(X) → query(X)
  // but Z3 works in terms of satisfiability so instead we ask the
  // the negation of the equivalent i.e.
  // ∃ X Constraints(X) ∧ ¬ query(X)
  Z3ASTHandle formula;
  if (query.expr) {
    formula = Z3ASTHandle(
      Z3_mk_not(temp_builder.ctx, temp_builder.constructForInt(query.expr, query.intArrNames, query.noCheckExprs, true)),
      temp_builder.ctx);
    constant_arrays_in_query.visit(query.expr);
  }

  if (temp_builder.useInt2BV && !temp_builder.useReal) {
    assumptions.clear();
    ConstantArrayFinder constant_arrays_in_query_new;
    for (auto const &constraint : query.constraints) {
      // if (constraint == query.expr || constraint == NotExpr::create(query.expr)) {
      //   continue;
      // }
      assumptions.push_back(temp_builder.constructForBV(constraint, query.noCheckExprs));
      constant_arrays_in_query_new.visit(constraint);
    }

    for (auto const &constant_array : constant_arrays_in_query_new.results) {
      assert(temp_builder.constant_array_assertions.count(constant_array) == 1 &&
            "Constant array found in query, but not handled by Z3Builder");
      for (auto const &arrayIndexValueExpr :
          temp_builder.constant_array_assertions[constant_array]) {
        assumptions.push_back(arrayIndexValueExpr);
      }
    }

    for (auto const &int_array_pair : temp_builder.int_array_bounds) {
      for (auto const &arrayIndexValueExpr : int_array_pair.second) {
        assumptions.push_back(arrayIndexValueExpr);
      }
    }

    // KLEE Queries are validity queries i.e.
    // ∀ X Constraints(X) → query(X)
    // but Z3 works in terms of satisfiability so instead we ask the
    // the negation of the equivalent i.e.
    // ∃ X Constraints(X) ∧ ¬ query(X)
    Z3ASTHandle formula;
    if (query.expr) {
      formula = Z3ASTHandle(
        Z3_mk_not(temp_builder.ctx, temp_builder.constructForBV(query.expr, query.noCheckExprs, true)),
        temp_builder.ctx);
        constant_arrays_in_query_new.visit(query.expr);
    }
  }

  std::vector<::Z3_ast> raw_assumptions{assumptions.cbegin(),
                                        assumptions.cend()};
  ::Z3_string result = Z3_benchmark_to_smtlib_string(
      temp_builder.ctx,
      /*name=*/"Emited by klee::Z3SolverImpl::getConstraintLog()",
      /*logic=*/"",
      /*status=*/"unknown",
      /*attributes=*/"",
      /*num_assumptions=*/raw_assumptions.size(),
      /*assumptions=*/raw_assumptions.size() ? raw_assumptions.data() : nullptr,
      /*formula=*/formula);

  // We need to trigger a dereference before the `temp_builder` gets destroyed.
  // We do this indirectly by emptying `assumptions` and assigning to
  // `formula`.
  raw_assumptions.clear();
  assumptions.clear();
  formula = Z3ASTHandle(NULL, temp_builder.ctx);

  return {result};
}

bool Z3SolverImpl::computeTruth(const Query &query, bool &isValid) {
  bool hasSolution = false; // to remove compiler warning
  bool status =
      internalRunSolver(query, /*objects=*/NULL, /*values=*/NULL, hasSolution);
  isValid = !hasSolution;
  return status;
}

bool Z3SolverImpl::computeValue(const Query &query, ref<Expr> &result) {
  std::vector<const Array *> objects;
  std::vector<std::vector<unsigned char> > values;
  bool hasSolution;

  // Find the object used in the expression, and compute an assignment
  // for them.
  findSymbolicObjects(query.expr, objects);
  if (!computeInitialValues(query.withFalse(), objects, values, hasSolution))
    return false;
  assert(hasSolution && "state has invalid constraint set");

  // Evaluate the expression with the computed assignment.
  Assignment a(objects, values);
  result = a.evaluate(query.expr);

  return true;
}

bool Z3SolverImpl::computeInitialValues(
    const Query &query, const std::vector<const Array *> &objects,
    std::vector<std::vector<unsigned char> > &values, bool &hasSolution) {
  return internalRunSolver(query, &objects, &values, hasSolution);
}

// bool Z3SolverImpl::shouldUseQF(const Query &q) {
//   bool manyBoolLogic = false;
//   // 1. Skip if arrays are present
//   for (auto &c : q.constraints) {
//     if (Expr::containRem(c)) 
//       return false;
//     // const Array *array = nullptr;
//     // ref<Expr> indexExpr = ConcatExpr::getArrayIndex(c, &array);
//     // if (indexExpr)
//     //   return false;
//     if (Expr::countBoolLogic(c) > 30) {
//       manyBoolLogic = true;
//     }
//   }
//   // const Array *array = nullptr;
//   // ref<Expr> indexExpr = ConcatExpr::getArrayIndex(q.expr, &array);
//   // if (indexExpr)
//   //   return false;
//   if (Expr::countBoolLogic(q.expr) > 30) {
//     manyBoolLogic = true;
//   }

//   return manyBoolLogic;
// }

int Z3SolverImpl::checkSatWithZ3CLI(const std::string &smtQuery, unsigned timeout) {
    // 1. Create temporary file
    size_t lastSlash = Z3QueryDumpFile.find_last_of("/\\");
    std::string parentPath = (lastSlash == std::string::npos) ? "." : Z3QueryDumpFile.substr(0, lastSlash);

    // Temporary file path
    std::string tmpFileName = parentPath + "/z3_tmp_query.smt2";

    // 2. Write SMT query to file
    std::ofstream ofs(tmpFileName);
    if (!ofs.is_open()) {
        // std::cerr << "Failed to open temporary file\n";
        return -1;
    }
    ofs << smtQuery;
    ofs.close();

    // 3. Construct command line
    std::string cmd = "z3 -smt2 -t:" + std::to_string(timeout) + " " + std::string(tmpFileName) /*+ " 2>/dev/null"*/;

    // 4. Run command and capture output
    FILE *pipe = popen(cmd.c_str(), "r");
    if (!pipe) {
        // std::cerr << "Failed to run Z3\n";
        return -1;
    }

    char buffer[128];
    std::string result;
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        result += buffer;
    }
    pclose(pipe);

    // 5. Delete temporary file
    ::remove(tmpFileName.c_str());

    // 6. Check Z3 result
    if (result.find("unsat") != std::string::npos)
        return 0;
    else if (result.find("sat") != std::string::npos)
        return 1;

    // std::cerr << "Z3 returned unknown result: " << result << "\n";
    return 2;
}

bool Z3SolverImpl::internalRunSolverInt(
  const Query &query, const std::vector<const Array *> *objects,
  std::vector<std::vector<unsigned char> > *values, bool &hasSolution, unsigned timeout, bool useCLI) {
TimerStatIncrementer t(stats::queryTime);
// NOTE: Z3 will switch to using a slower solver internally if push/pop are
// used so for now it is likely that creating a new solver each time is the
// right way to go until Z3 changes its behaviour.
//
// TODO: Investigate using a custom tactic as described in
// https://github.com/klee/klee/issues/653
// Z3_solver theSolver;
// if (shouldUseQF(query)) {
//   theSolver = Z3_mk_solver_for_logic(builder->ctx, Z3_mk_string_symbol(builder->ctx, "QF_AUFLIRA"));
// } else {
//   theSolver = Z3_mk_solver(builder->ctx);
// }
// Z3_tactic simplify   = Z3_mk_tactic(builder->ctx, "simplify");
// Z3_tactic nlsat     = Z3_mk_tactic(builder->ctx, "qfnra-nlsat");      
// Z3_tactic then       = Z3_tactic_and_then(builder->ctx, simplify, nlsat);
// Z3_solver theSolver = Z3_mk_solver_from_tactic(builder->ctx, then);
Z3_solver theSolver = Z3_mk_solver(builder->ctx);
Z3_solver_inc_ref(builder->ctx, theSolver);
Z3_params_set_uint(builder->ctx, solverParameters, timeoutParamStrSymbol, timeout);
// Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "rlimit"), 0); 
Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "auto-config"), true);
Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "smt.auto-config"), true);
// Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "smt.arith.min"), true);
// Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "threads"), 6);
// Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "v2"), true);
Z3_solver_set_params(builder->ctx, theSolver, solverParameters);

runStatusCode = SOLVER_RUN_STATUS_FAILURE;

// std::vector<Z3_ast> assertions;

ConstantArrayFinder constant_arrays_in_query_new;
for (auto const &constraint : query.constraints) {
  Z3ASTHandle z3_build_handler = builder->constructForInt(constraint, query.intArrNames, query.noCheckExprs);
  // llvm::outs() << "Z3ASTHandler: " << ::Z3_ast_to_string(builder->ctx, z3_build_handler) << "\n";
  // assertions.push_back(z3_build_handler);
  Z3_solver_assert(builder->ctx, theSolver, z3_build_handler);
  constant_arrays_in_query_new.visit(constraint);
}
++stats::solverQueries;
if (objects)
  ++stats::queryCounterexamples;

Z3ASTHandle z3QueryExpr =
    Z3ASTHandle(builder->constructForInt(query.expr, query.intArrNames, query.noCheckExprs, true), builder->ctx);
//  llvm::outs() << "query.expr: " << query.expr << "\n";
//  llvm::outs() << "Z3ASTHandler: " << ::Z3_ast_to_string(builder->ctx, z3QueryExpr) << "\n";
constant_arrays_in_query_new.visit(query.expr);

for (auto const &constant_array : constant_arrays_in_query_new.results) {  
  assert(builder->constant_array_assertions.count(constant_array) <= 1 &&
         "Constant array found in query, but not handled by Z3Builder");
  for (auto const &arrayIndexValueExpr :
       builder->constant_array_assertions[constant_array]) {
    // llvm::outs() << "int constant_array_assertions: " << ::Z3_ast_to_string(builder->ctx, arrayIndexValueExpr) << "\n";    
    // assertions.push_back(arrayIndexValueExpr);
    Z3_solver_assert(builder->ctx, theSolver, arrayIndexValueExpr);
  }
}

for (auto const &int_array_pair : builder->int_array_bounds) {
  for (auto const &arrayIndexValueExpr : int_array_pair.second) {
    // llvm::outs() << "int int_array_bounds: " << ::Z3_ast_to_string(builder->ctx, arrayIndexValueExpr) << "\n"; 
    // assertions.push_back(arrayIndexValueExpr);
    Z3_solver_assert(builder->ctx, theSolver, arrayIndexValueExpr);
  }
}

// Z3ASTHandle notquery = Z3ASTHandle(Z3_mk_not(builder->ctx, z3QueryExpr), builder->ctx);
// assertions.push_back(notquery);
// Z3_solver_assert(builder->ctx, theSolver, Z3ASTHandle(Z3_mk_and(builder->ctx, assertions.size(), assertions.data()), builder->ctx));

Z3_solver_assert(
    builder->ctx, theSolver,
    Z3ASTHandle(Z3_mk_not(builder->ctx, z3QueryExpr), builder->ctx));

std::string queryStr = Z3_solver_to_string(builder->ctx, theSolver);
if (dumpedQueriesFile) {
  *dumpedQueriesFile << "; start Z3 query\n";
  *dumpedQueriesFile << queryStr;
  *dumpedQueriesFile << "(check-sat)\n";
  *dumpedQueriesFile << "(reset)\n";
  *dumpedQueriesFile << "; end Z3 query\n\n";
  dumpedQueriesFile->flush();
}

auto it = queryCache.find(queryStr);
if (it != queryCache.end()) {
  bool cachedResult = it->second;
  Z3_solver_dec_ref(builder->ctx, theSolver);
  builder->clearConstructCache();

  if (cachedResult) {
    hasSolution = true;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
    ++stats::queriesValid;
    return true;
  } else {
    hasSolution = false;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
    ++stats::queriesInvalid;
    return true;
  }
}

if (useCLI) {
  std::string cliQueryStr = "; start Z3 query\n" + queryStr + "(check-sat)\n" + "(reset)\n" + "; end Z3 query\n";
  int res = checkSatWithZ3CLI(cliQueryStr, timeout);
  Z3_solver_dec_ref(builder->ctx, theSolver);
  builder->clearConstructCache();

  if (res == 1) {
    hasSolution = true;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
    ++stats::queriesValid;

    if (query.constraints.size() >= QUERY_CACHE_THRESHOLD) {
      queryCache.insert({queryStr, hasSolution});
    }
    return true;
  } else if (res == 0) {
    hasSolution = false;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
    ++stats::queriesInvalid;

    if (query.constraints.size() >= QUERY_CACHE_THRESHOLD) {
      queryCache.insert({queryStr, hasSolution});
    }
    return true;
  } else {
    llvm::outs() << "z3 cli error\n";
    return false;
  }
}

if (builder->useInt2BV && !builder->useReal) {
  Z3_solver_dec_ref(builder->ctx, theSolver);
  builder->clearConstructCache();
  // Z3_solver_reset(builder->ctx, theSolver);
  // builder->useInt2BV = false;
  return false;
}

::Z3_lbool satisfiable = Z3_solver_check(builder->ctx, theSolver);
runStatusCode = handleSolverResponseForInt(theSolver, satisfiable, objects, values, hasSolution, query.intArrNames);

Z3_solver_dec_ref(builder->ctx, theSolver);
builder->clearConstructCache();
// Z3_solver_reset(builder->ctx, theSolver);

if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE ||
    runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE) {
  if (hasSolution) {
    ++stats::queriesInvalid;
  } else {
    ++stats::queriesValid;
  }
  if (query.constraints.size() >= QUERY_CACHE_THRESHOLD) {
    queryCache.insert({queryStr, hasSolution});
  }
  return true; // success
}
if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED) {
  raise(SIGINT);
}
return false; // failed
}

bool Z3SolverImpl::internalRunSolverBV(
  const Query &query, const std::vector<const Array *> *objects,
  std::vector<std::vector<unsigned char> > *values, bool &hasSolution, unsigned timeout) {

TimerStatIncrementer t(stats::queryTime);
// NOTE: Z3 will switch to using a slower solver internally if push/pop are
// used so for now it is likely that creating a new solver each time is the
// right way to go until Z3 changes its behaviour.
//
// TODO: Investigate using a custom tactic as described in
// https://github.com/klee/klee/issues/653
// Z3_tactic simplify   = Z3_mk_tactic(builder->ctx, "simplify");
// Z3_tactic qfbv = Z3_mk_tactic(builder->ctx, "qfbv");
// Z3_tactic then       = Z3_tactic_and_then(builder->ctx, simplify, qfbv);
// Z3_solver theSolver = Z3_mk_solver_from_tactic(builder->ctx, then);
// Z3_solver theSolver = Z3_mk_solver_for_logic(builder->ctx, Z3_mk_string_symbol(builder->ctx, "QF_ABV"));
Z3_solver theSolver = Z3_mk_solver(builder->ctx);
Z3_solver_inc_ref(builder->ctx, theSolver);
Z3_params_set_uint(builder->ctx, solverParameters, timeoutParamStrSymbol, timeout);
Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "auto-config"), true);
Z3_params_set_bool(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "smt.auto-config"), true);
// Z3_params_set_uint(builder->ctx, solverParameters, Z3_mk_string_symbol(builder->ctx, "threads"), 4);
Z3_solver_set_params(builder->ctx, theSolver, solverParameters);

runStatusCode = SOLVER_RUN_STATUS_FAILURE;

ConstantArrayFinder constant_arrays_in_query;
for (auto const &constraint : query.constraints) {
  Z3ASTHandle z3_build_handler = builder->constructForBV(constraint, query.noCheckExprs);
  Z3_solver_assert(builder->ctx, theSolver, z3_build_handler);
  constant_arrays_in_query.visit(constraint);
}
++stats::solverQueries;
if (objects)
  ++stats::queryCounterexamples;

Z3ASTHandle z3QueryExpr =
    Z3ASTHandle(builder->constructForBV(query.expr, query.noCheckExprs, true), builder->ctx);
constant_arrays_in_query.visit(query.expr);

for (auto const &constant_array : constant_arrays_in_query.results) {
  assert(builder->constant_array_assertions.count(constant_array) == 1 &&
         "Constant array found in query, but not handled by Z3Builder");
  for (auto const &arrayIndexValueExpr :
       builder->constant_array_assertions[constant_array]) {
        // llvm::outs() << "bv constant_array_assertions: " << ::Z3_ast_to_string(builder->ctx, arrayIndexValueExpr) << "\n";   
    Z3_solver_assert(builder->ctx, theSolver, arrayIndexValueExpr);
  }
}

for (auto const &int_array_pair : builder->int_array_bounds) {
  for (auto const &overflowExpr : int_array_pair.second) {
    // llvm::outs() << "bv overflowExpr: " << ::Z3_ast_to_string(builder->ctx, overflowExpr) << "\n"; 
    Z3_solver_assert(builder->ctx, theSolver, overflowExpr);
  }
}

// KLEE Queries are validity queries i.e.
// ∀ X Constraints(X) → query(X)
// but Z3 works in terms of satisfiability so instead we ask the
// negation of the equivalent i.e.
// ∃ X Constraints(X) ∧ ¬ query(X)
Z3_solver_assert(
    builder->ctx, theSolver,
    Z3ASTHandle(Z3_mk_not(builder->ctx, z3QueryExpr), builder->ctx));

std::string queryStr = Z3_solver_to_string(builder->ctx, theSolver);
if (dumpedQueriesFile) {
  *dumpedQueriesFile << "; start Z3 query\n";
  *dumpedQueriesFile << queryStr;
  *dumpedQueriesFile << "(check-sat)\n";
  *dumpedQueriesFile << "(reset)\n";
  *dumpedQueriesFile << "; end Z3 query\n\n";
  dumpedQueriesFile->flush();
}

auto it = queryCache.find(queryStr);
if (it != queryCache.end()) {
  bool cachedResult = it->second;
  Z3_solver_dec_ref(builder->ctx, theSolver);
  builder->clearConstructCache();
  if (cachedResult) {
    hasSolution = true;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
    ++stats::queriesValid;
    return true;
  } else {
    hasSolution = false;
    runStatusCode = SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
    ++stats::queriesInvalid;
    return true;
  }
}

::Z3_lbool satisfiable = Z3_solver_check(builder->ctx, theSolver);
runStatusCode = handleSolverResponse(theSolver, satisfiable, objects, values,
                                     hasSolution);

Z3_solver_dec_ref(builder->ctx, theSolver);
// Clear the builder's cache to prevent memory usage exploding.
// By using ``autoClearConstructCache=false`` and clearning now
// we allow Z3_ast expressions to be shared from an entire
// ``Query`` rather than only sharing within a single call to
// ``builder->construct()``.
builder->clearConstructCache();
// Z3_solver_reset(builder->ctx, theSolver);

if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE ||
    runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE) {
  if (hasSolution) {
    ++stats::queriesInvalid;
  } else {
    ++stats::queriesValid;  
  }
  if (query.constraints.size() >= QUERY_CACHE_THRESHOLD) {
    queryCache.insert({queryStr, hasSolution});
  }
  return true; // success
}
if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED) {
  raise(SIGINT);
}
return false; // failed
}

bool Z3SolverImpl::internalRunSolver(
    const Query &query, const std::vector<const Array *> *objects,
    std::vector<std::vector<unsigned char> > *values, bool &hasSolution) {
    // ref<Expr> combined = ConstantExpr::create(1, Expr::Bool);
    // for (auto const &constraint : query.constraints) {
    //   combined = AndExpr::create(combined, constraint);
    // }
    // ConstraintSet newConstraints;
    // newConstraints.push_back(combined);
    // Query combineQ = Query(newConstraints, query.expr, query.intArrNames, query.noCheckExprs);  
    // bool res = internalRunSolverInt(query, objects, values, hasSolution, 3.5*60000);
    // if (!res) {
    //   return internalRunSolverBV(query, objects, values, hasSolution, UINT_MAX);
    // }
    bool res = internalRunSolverInt(query, objects, values, hasSolution, 60*1000);
    if (!res) {
      if (builder->useReal) {
        res = internalRunSolverInt(query, objects, values, hasSolution, INT32_MAX, true);
        builder->useReal = false;
        return res;
      }
      if (builder->useInt2BV) {
        builder->useInt2BV = false;
        return internalRunSolverBV(query, objects, values, hasSolution, UINT_MAX);
      }
      res = internalRunSolverInt(query, objects, values, hasSolution, 2*60000, true);
      if (!res) {
        // return internalRunSolverBV(query, objects, values, hasSolution, 2*60000);
        return internalRunSolverBV(query, objects, values, hasSolution, UINT_MAX);
      }
      // res = internalRunSolverBV(query, objects, values, hasSolution, 2*60000);
      // if (!res) {
      //   res = internalRunSolverInt(query, objects, values, hasSolution, UINT_MAX, true);
      //   // res = internalRunSolverInt(query, objects, values, hasSolution, 5*60000);
      //   // if (!res) {
      //   //   return internalRunSolverBV(query, objects, values, hasSolution, UINT_MAX);
      //   // }
      // }
    }
    return res;
  
  // std::atomic<bool> done(false);
  // std::mutex resultMutex;
  // std::condition_variable cv;

  // std::thread tBV, tInt;
  // bool runSuccess;

  // // Thread A: Run BV solver
  // tBV = std::thread([&]() {
  //   Z3Builder temp_builder(/*autoClearConstructCache=*/false,
  //                        /*z3LogInteractionFile=*/NULL);
  //   TimerStatIncrementer t(stats::queryTime);
  //   Z3_solver theSolver = Z3_mk_solver(temp_builder.ctx);
  //   Z3_solver_inc_ref(temp_builder.ctx, theSolver);
  //   Z3_params_set_uint(temp_builder.ctx, solverParameters, timeoutParamStrSymbol, UINT_MAX);
  //   Z3_solver_set_params(temp_builder.ctx, theSolver, solverParameters);

  //   runStatusCode = SOLVER_RUN_STATUS_FAILURE;

  //   ConstantArrayFinder constant_arrays_in_query;
  //   for (auto const &constraint : query.constraints) {
  //     Z3ASTHandle z3_build_handler = temp_builder.construct(constraint);
  //     Z3_solver_assert(temp_builder.ctx, theSolver, z3_build_handler);
  //     constant_arrays_in_query.visit(constraint);
  //   }
  //   ++stats::solverQueries;
  //   if (objects)
  //     ++stats::queryCounterexamples;

  //   Z3ASTHandle z3QueryExpr =
  //       Z3ASTHandle(temp_builder.construct(query.expr), temp_builder.ctx);
  //   constant_arrays_in_query.visit(query.expr);

  //   for (auto const &constant_array : constant_arrays_in_query.results) {
  //     assert(temp_builder.constant_array_assertions.count(constant_array) == 1 &&
  //           "Constant array found in query, but not handled by Z3Builder");
  //     for (auto const &arrayIndexValueExpr :
  //         temp_builder.constant_array_assertions[constant_array]) {
  //       Z3_solver_assert(temp_builder.ctx, theSolver, arrayIndexValueExpr);
  //     }
  //   }

  //   for (auto const &int_array_pair : temp_builder.int_array_bounds) {
  //     for (auto const &overflowExpr : int_array_pair.second) {
  //       // llvm::outs() << "overflowExpr: " << ::Z3_ast_to_string(builder->ctx, overflowExpr) << "\n"; 
  //       Z3_solver_assert(temp_builder.ctx, theSolver, overflowExpr);
  //     }
  //   }
  //   Z3_solver_assert(
  //       temp_builder.ctx, theSolver,
  //       Z3ASTHandle(Z3_mk_not(temp_builder.ctx, z3QueryExpr), temp_builder.ctx));

  //   // if (dumpedQueriesFile) {
  //   //   *dumpedQueriesFile << "; start Z3 query\n";
  //   //   *dumpedQueriesFile << Z3_solver_to_string(builder->ctx, theSolver);
  //   //   *dumpedQueriesFile << "(check-sat)\n";
  //   //   *dumpedQueriesFile << "(reset)\n";
  //   //   *dumpedQueriesFile << "; end Z3 query\n\n";
  //   //   dumpedQueriesFile->flush();
  //   // }

  //   ::Z3_lbool satisfiable = Z3_solver_check(temp_builder.ctx, theSolver);

  //   if (!done.exchange(true)) {
  //     // First to finish: handle result
  //     std::lock_guard<std::mutex> lock(resultMutex);
  //     runStatusCode = handleTempSolverResponse(theSolver, satisfiable, &temp_builder, objects, values,
  //                                    hasSolution);
  //     Z3_solver_dec_ref(temp_builder.ctx, theSolver);
  //     temp_builder.clearConstructCache();

  //     if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE ||
  //         runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE) {
  //       if (hasSolution) {
  //         ++stats::queriesInvalid;
  //       } else {
  //         ++stats::queriesValid;
  //       }
  //       runSuccess =  true; // success
  //     } else if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED) {
  //       raise(SIGINT);
  //     } else {
  //       runSuccess =  false; // failed
  //     }
  //     cv.notify_all();
  //   } else {
  //     // Late thread: cancel Z3 safely
  //     Z3_solver_interrupt(temp_builder.ctx, theSolver);
  //     Z3_solver_dec_ref(temp_builder.ctx, theSolver);
  //     temp_builder.clearConstructCache();
  //   }
  // });

  // // Thread B: Run Int solver
  // tInt = std::thread([&]() {
  //   TimerStatIncrementer t(stats::queryTime);
  //   Z3_solver theSolver = Z3_mk_solver(builder->ctx);
  //   Z3_solver_inc_ref(builder->ctx, theSolver);
  //   Z3_params_set_uint(builder->ctx, solverParameters, timeoutParamStrSymbol, UINT_MAX);
  //   Z3_solver_set_params(builder->ctx, theSolver, solverParameters);

  //   runStatusCode = SOLVER_RUN_STATUS_FAILURE;

  //   ConstantArrayFinder constant_arrays_in_query_new;
  //   for (auto const &constraint : query.constraints) {
  //     Z3ASTHandle z3_build_handler = builder->constructForInt(constraint, query.intArrNames);
  //     Z3_solver_assert(builder->ctx, theSolver, z3_build_handler);
  //     constant_arrays_in_query_new.visit(constraint);
  //   }
  //   ++stats::solverQueries;
  //   if (objects)
  //     ++stats::queryCounterexamples;

  //   Z3ASTHandle z3QueryExpr =
  //       Z3ASTHandle(builder->constructForInt(query.expr, query.intArrNames), builder->ctx);
  //   constant_arrays_in_query_new.visit(query.expr);

  //   for (auto const &constant_array : constant_arrays_in_query_new.results) {
  //     assert(builder->constant_array_assertions.count(constant_array) == 1 &&
  //           "Constant array found in query, but not handled by Z3Builder");
  //     for (auto const &arrayIndexValueExpr :
  //         builder->constant_array_assertions[constant_array]) {  
  //       Z3_solver_assert(builder->ctx, theSolver, arrayIndexValueExpr);
  //     }
  //   }

  //   for (auto const &int_array_pair : builder->int_array_bounds) {
  //     for (auto const &arrayIndexValueExpr : int_array_pair.second) {
  //       Z3_solver_assert(builder->ctx, theSolver, arrayIndexValueExpr);
  //     }
  //   }

  //   Z3_solver_assert(
  //       builder->ctx, theSolver,
  //       Z3ASTHandle(Z3_mk_not(builder->ctx, z3QueryExpr), builder->ctx));

  //   if (dumpedQueriesFile) {
  //     *dumpedQueriesFile << "; start Z3 query\n";
  //     *dumpedQueriesFile << Z3_solver_to_string(builder->ctx, theSolver);
  //     *dumpedQueriesFile << "(check-sat)\n";
  //     *dumpedQueriesFile << "(reset)\n";
  //     *dumpedQueriesFile << "; end Z3 query\n\n";
  //     dumpedQueriesFile->flush();
  //   }

  //   // if (builder->useInt2BV) {
  //   //   Z3_solver_dec_ref(builder->ctx, theSolver);
  //   //   builder->clearConstructCache();
  //   //   builder->useInt2BV = false;
  //   //   return false;
  //   // }
  //   ::Z3_lbool satisfiable = Z3_solver_check(builder->ctx, theSolver);

  //   if (!done.exchange(true)) {
  //     std::lock_guard<std::mutex> lock(resultMutex);
  //     runStatusCode = handleSolverResponseForInt(theSolver, satisfiable, objects, values, hasSolution, query.intArrNames);
  //     Z3_solver_dec_ref(builder->ctx, theSolver);
  //     builder->clearConstructCache();

  //     if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE ||
  //         runStatusCode == SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE) {
  //       if (hasSolution) {
  //         ++stats::queriesInvalid;
  //       } else {
  //         ++stats::queriesValid;
  //       }
  //       runSuccess =  true; // success
  //     } else if (runStatusCode == SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED) {
  //       raise(SIGINT);
  //     } else { 
  //       runSuccess =  false; // failed
  //     }
  //     cv.notify_all();
  //   } else {
  //     Z3_solver_interrupt(builder->ctx, theSolver);
  //     Z3_solver_dec_ref(builder->ctx, theSolver);
  //     builder->clearConstructCache();
  //   }
  // });

  // {
  //   std::unique_lock<std::mutex> lock(resultMutex);
  //   cv.wait(lock, [&]() { return done.load(); });
  // }

  // if (tBV.joinable()) tBV.join();
  // if (tInt.joinable()) tInt.join();

  // return runSuccess;
}

SolverImpl::SolverRunStatus Z3SolverImpl::handleSolverResponseForInt(
    ::Z3_solver theSolver, ::Z3_lbool satisfiable,
    const std::vector<const Array *> *objects,
    std::vector<std::vector<unsigned char> > *values, bool &hasSolution, std::map<std::string, unsigned> intArrNames) {
  switch (satisfiable) {
  case Z3_L_TRUE: {
    hasSolution = true;
    if (!objects) {
      // No assignment is needed
      assert(values == NULL);
      return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
    }
    assert(values && "values cannot be nullptr");
    ::Z3_model theModel = Z3_solver_get_model(builder->ctx, theSolver);
    assert(theModel && "Failed to retrieve model");
    Z3_model_inc_ref(builder->ctx, theModel);
    values->reserve(objects->size());
    for (std::vector<const Array *>::const_iterator it = objects->begin(),
                                                    ie = objects->end();
         it != ie; ++it) {
      const Array *array = *it;
      std::vector<unsigned char> data;

      data.reserve(array->size);
      for (unsigned offset = 0; offset < array->size; offset++) {
        // llvm::outs() << array->name << " offset " << offset << "\n";
        // We can't use Z3ASTHandle here so have to do ref counting manually
        ::Z3_ast arrayElementExpr;
        Z3ASTHandle initial_read;
        bool isWholeInt = false;
        bool isReadArray = false;
        if (intArrNames.find(array->name) != intArrNames.end() && intArrNames[array->name] > 1) {
          initial_read = builder->getIntArrayInitialRead(array, offset);
          isReadArray = true;
          if (!initial_read || initial_read == Z3ASTHandle()) { 
            initial_read = builder->getInitialRead(array, offset);
            isReadArray = false;
          }
        } else if (array->isIntVar && offset == 0) {
          auto read_pair = builder->readIntExprInitial(array);
          initial_read = read_pair.first;
          isWholeInt = read_pair.second;
          if (!initial_read || initial_read == Z3ASTHandle()) 
            initial_read = builder->getInitialRead(array, offset);
        } else {
          initial_read = builder->getInitialRead(array, offset);
        }

        __attribute__((unused))
        bool successfulEval =
            Z3_model_eval(builder->ctx, theModel, initial_read,
                          /*model_completion=*/true, &arrayElementExpr);
        assert(successfulEval && "Failed to evaluate model");
        Z3_inc_ref(builder->ctx, arrayElementExpr);
        assert(Z3_get_ast_kind(builder->ctx, arrayElementExpr) ==
                   Z3_NUMERAL_AST &&
               "Evaluated expression has wrong sort");
        
        if (isWholeInt) {
          // const char* numStr = Z3_get_numeral_string(builder->ctx, arrayElementExpr);
          // llvm::outs() << array->name << " size " << array->size << " arrayElementExpr as string: " << numStr << "\n";
          if (array->size > 4) {
            int64_t arrayElementValue = 0;
            __attribute__((unused))
            bool successGet = Z3_get_numeral_int64(builder->ctx, arrayElementExpr,
                                                &arrayElementValue);
            // llvm::outs() << "arrayElementValue " << arrayElementValue << "\n";
            if(!successGet) {
              uint64_t arrayElementValue_unsigned = 0;
              successGet = Z3_get_numeral_uint64(builder->ctx, arrayElementExpr,
                                                &arrayElementValue_unsigned);
              // llvm::outs() << "arrayElementValue_unsigned " << arrayElementValue_unsigned << "\n";
              assert(successGet && "failed to get value back");
              
              for (unsigned i = 0; i < array->size; ++i) {
                data.push_back((arrayElementValue_unsigned >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            } else {
              for (unsigned i = 0; i < array->size; ++i) {
                data.push_back((arrayElementValue >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            }
            Z3_dec_ref(builder->ctx, arrayElementExpr);
            break;
          } else {
            int arrayElementValue = 0;
            __attribute__((unused))
            bool successGet = Z3_get_numeral_int(builder->ctx, arrayElementExpr,
                                                &arrayElementValue);
            // llvm::outs() << "arrayElementValue " << arrayElementValue << "\n";
            if(!successGet) {
              unsigned arrayElementValue_unsigned = 0;
              successGet = Z3_get_numeral_uint(builder->ctx, arrayElementExpr,
                                                &arrayElementValue_unsigned);
              // llvm::outs() << "arrayElementValue_unsigned " << arrayElementValue_unsigned << "\n";
              assert(successGet && "failed to get value back");

              for (unsigned i = 0; i < array->size; ++i) {
                data.push_back((arrayElementValue_unsigned >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            } else {
              for (unsigned i = 0; i < array->size; ++i) {
                data.push_back((arrayElementValue >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            }
            Z3_dec_ref(builder->ctx, arrayElementExpr);
            break;
          }
        } else if (isReadArray) {
          unsigned valueSize = intArrNames[array->name];
          // const char* numStr = Z3_get_numeral_string(builder->ctx, arrayElementExpr);
          // llvm::outs() << array->name << " size " << array->size << " " << valueSize << " arrayElementExpr as string: " << numStr << "\n";
          if (valueSize > 4) {
            int64_t arrayElementValue = 0;
            __attribute__((unused))
            bool successGet = Z3_get_numeral_int64(builder->ctx, arrayElementExpr,
                                                &arrayElementValue);
            // llvm::outs() << "arrayElementValue " << arrayElementValue << "\n";
            if(!successGet) {
              uint64_t arrayElementValue_unsigned = 0;
              successGet = Z3_get_numeral_uint64(builder->ctx, arrayElementExpr,
                                                &arrayElementValue_unsigned);
              // llvm::outs() << "arrayElementValue_unsigned " << arrayElementValue_unsigned << "\n";
              assert(successGet && "failed to get value back");
              
              for (unsigned i = 0; i < valueSize; ++i) {
                data.push_back((arrayElementValue_unsigned >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            } else {
              for (unsigned i = 0; i < valueSize; ++i) {
                data.push_back((arrayElementValue >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            }
            Z3_dec_ref(builder->ctx, arrayElementExpr);
            offset+=valueSize-1;
          } else {
            int arrayElementValue = 0;
            __attribute__((unused))
            bool successGet = Z3_get_numeral_int(builder->ctx, arrayElementExpr,
                                                &arrayElementValue);
            // llvm::outs() << "arrayElementValue " << arrayElementValue << "\n";
            if(!successGet) {
              unsigned arrayElementValue_unsigned = 0;
              successGet = Z3_get_numeral_uint(builder->ctx, arrayElementExpr,
                                                &arrayElementValue_unsigned);
              // llvm::outs() << "arrayElementValue_unsigned " << arrayElementValue_unsigned << "\n";
              assert(successGet && "failed to get value back");

              for (unsigned i = 0; i < valueSize; ++i) {
                data.push_back((arrayElementValue_unsigned >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            } else {
              for (unsigned i = 0; i < valueSize; ++i) {
                data.push_back((arrayElementValue >> (8 * i)) & 0xFF);  // Extract byte
                // llvm::outs() << i << " data " << (int)data.back() << "\n"; // Cast to int for decimal
              }
            }
            Z3_dec_ref(builder->ctx, arrayElementExpr);
            offset+=valueSize-1;
          }
        } else {
          int arrayElementValue = 0;
          __attribute__((unused))
          bool successGet = Z3_get_numeral_int(builder->ctx, arrayElementExpr,
                                              &arrayElementValue);
          // llvm::outs() << array->name << " size " << array->size << " offset " << offset << " arrayElementValue " << arrayElementValue << "\n";
          assert(successGet && "failed to get value back");
          assert(arrayElementValue >= 0 && arrayElementValue <= 255 &&
                "Integer from model is out of range");
          data.push_back(arrayElementValue);
          Z3_dec_ref(builder->ctx, arrayElementExpr);
        }
      }
      values->push_back(data);
    }

    // Validate the model if requested
    if (Z3ValidateModels) {
      bool success = validateZ3Model(theSolver, theModel);
      if (!success)
        abort();
    }

    Z3_model_dec_ref(builder->ctx, theModel);
    return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
  }
  case Z3_L_FALSE:
    hasSolution = false;
    return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
  case Z3_L_UNDEF: {
    ::Z3_string reason =
        ::Z3_solver_get_reason_unknown(builder->ctx, theSolver);
    if (strcmp(reason, "timeout") == 0 || strcmp(reason, "canceled") == 0 ||
        strcmp(reason, "(resource limits reached)") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_TIMEOUT;
    }
    if (strcmp(reason, "unknown") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_FAILURE;
    }
    if (strcmp(reason, "interrupted from keyboard") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED;
    }
    klee_warning("Unexpected solver failure. Reason is \"%s,\"\n", reason);
    abort();
  }
  default:
    llvm_unreachable("unhandled Z3 result");
  }
}

SolverImpl::SolverRunStatus Z3SolverImpl::handleSolverResponse(
    ::Z3_solver theSolver, ::Z3_lbool satisfiable,
    const std::vector<const Array *> *objects,
    std::vector<std::vector<unsigned char> > *values, bool &hasSolution) {
  switch (satisfiable) {
  case Z3_L_TRUE: {
    hasSolution = true;
    if (!objects) {
      // No assignment is needed
      assert(values == NULL);
      return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
    }
    assert(values && "values cannot be nullptr");
    ::Z3_model theModel = Z3_solver_get_model(builder->ctx, theSolver);
    assert(theModel && "Failed to retrieve model");
    Z3_model_inc_ref(builder->ctx, theModel);
    values->reserve(objects->size());
    for (std::vector<const Array *>::const_iterator it = objects->begin(),
                                                    ie = objects->end();
         it != ie; ++it) {
      const Array *array = *it;
      std::vector<unsigned char> data;

      data.reserve(array->size);
      for (unsigned offset = 0; offset < array->size; offset++) {
        // We can't use Z3ASTHandle here so have to do ref counting manually
        ::Z3_ast arrayElementExpr;
        Z3ASTHandle initial_read = builder->getInitialRead(array, offset);

        __attribute__((unused))
        bool successfulEval =
            Z3_model_eval(builder->ctx, theModel, initial_read,
                          /*model_completion=*/true, &arrayElementExpr);
        assert(successfulEval && "Failed to evaluate model");
        Z3_inc_ref(builder->ctx, arrayElementExpr);
        assert(Z3_get_ast_kind(builder->ctx, arrayElementExpr) ==
                   Z3_NUMERAL_AST &&
               "Evaluated expression has wrong sort");

        int arrayElementValue = 0;
        __attribute__((unused))
        bool successGet = Z3_get_numeral_int(builder->ctx, arrayElementExpr,
                                             &arrayElementValue);
        // llvm::outs() << array->name << " size " << array->size << " offset " << offset << " arrayElementValue " << arrayElementValue << "\n";
        assert(successGet && "failed to get value back");
        assert(arrayElementValue >= 0 && arrayElementValue <= 255 &&
               "Integer from model is out of range");
        data.push_back(arrayElementValue);
        Z3_dec_ref(builder->ctx, arrayElementExpr);
      }
      values->push_back(data);
    }

    // Validate the model if requested
    if (Z3ValidateModels) {
      bool success = validateZ3Model(theSolver, theModel);
      if (!success)
        abort();
    }

    Z3_model_dec_ref(builder->ctx, theModel);
    return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
  }
  case Z3_L_FALSE:
    hasSolution = false;
    return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
  case Z3_L_UNDEF: {
    ::Z3_string reason =
        ::Z3_solver_get_reason_unknown(builder->ctx, theSolver);
    if (strcmp(reason, "timeout") == 0 || strcmp(reason, "canceled") == 0 ||
        strcmp(reason, "(resource limits reached)") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_TIMEOUT;
    }
    if (strcmp(reason, "unknown") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_FAILURE;
    }
    if (strcmp(reason, "interrupted from keyboard") == 0) {
      return SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED;
    }
    klee_warning("Unexpected solver failure. Reason is \"%s,\"\n", reason);
    abort();
  }
  default:
    llvm_unreachable("unhandled Z3 result");
  }
}

// SolverImpl::SolverRunStatus Z3SolverImpl::handleTempSolverResponse(
//     ::Z3_solver theSolver, ::Z3_lbool satisfiable, Z3Builder *tempbuilder,
//     const std::vector<const Array *> *objects,
//     std::vector<std::vector<unsigned char> > *values, bool &hasSolution) {
//   switch (satisfiable) {
//   case Z3_L_TRUE: {
//     hasSolution = true;
//     if (!objects) {
//       // No assignment is needed
//       assert(values == NULL);
//       return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
//     }
//     assert(values && "values cannot be nullptr");
//     ::Z3_model theModel = Z3_solver_get_model(tempbuilder->ctx, theSolver);
//     assert(theModel && "Failed to retrieve model");
//     Z3_model_inc_ref(tempbuilder->ctx, theModel);
//     values->reserve(objects->size());
//     for (std::vector<const Array *>::const_iterator it = objects->begin(),
//                                                     ie = objects->end();
//          it != ie; ++it) {
//       const Array *array = *it;
//       std::vector<unsigned char> data;

//       data.reserve(array->size);
//       for (unsigned offset = 0; offset < array->size; offset++) {
//         // We can't use Z3ASTHandle here so have to do ref counting manually
//         ::Z3_ast arrayElementExpr;
//         Z3ASTHandle initial_read = tempbuilder->getInitialRead(array, offset);

//         __attribute__((unused))
//         bool successfulEval =
//             Z3_model_eval(tempbuilder->ctx, theModel, initial_read,
//                           /*model_completion=*/true, &arrayElementExpr);
//         assert(successfulEval && "Failed to evaluate model");
//         Z3_inc_ref(tempbuilder->ctx, arrayElementExpr);
//         assert(Z3_get_ast_kind(tempbuilder->ctx, arrayElementExpr) ==
//                    Z3_NUMERAL_AST &&
//                "Evaluated expression has wrong sort");

//         int arrayElementValue = 0;
//         __attribute__((unused))
//         bool successGet = Z3_get_numeral_int(tempbuilder->ctx, arrayElementExpr,
//                                              &arrayElementValue);
//         // llvm::outs() << array->name << " size " << array->size << " offset " << offset << " arrayElementValue " << arrayElementValue << "\n";
//         assert(successGet && "failed to get value back");
//         assert(arrayElementValue >= 0 && arrayElementValue <= 255 &&
//                "Integer from model is out of range");
//         data.push_back(arrayElementValue);
//         Z3_dec_ref(tempbuilder->ctx, arrayElementExpr);
//       }
//       values->push_back(data);
//     }

//     // Validate the model if requested
//     if (Z3ValidateModels) {
//       bool success = validateZ3Model(theSolver, theModel);
//       if (!success)
//         abort();
//     }

//     Z3_model_dec_ref(tempbuilder->ctx, theModel);
//     return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_SOLVABLE;
//   }
//   case Z3_L_FALSE:
//     hasSolution = false;
//     return SolverImpl::SOLVER_RUN_STATUS_SUCCESS_UNSOLVABLE;
//   case Z3_L_UNDEF: {
//     ::Z3_string reason =
//         ::Z3_solver_get_reason_unknown(tempbuilder->ctx, theSolver);
//     if (strcmp(reason, "timeout") == 0 || strcmp(reason, "canceled") == 0 ||
//         strcmp(reason, "(resource limits reached)") == 0) {
//       return SolverImpl::SOLVER_RUN_STATUS_TIMEOUT;
//     }
//     if (strcmp(reason, "unknown") == 0) {
//       return SolverImpl::SOLVER_RUN_STATUS_FAILURE;
//     }
//     if (strcmp(reason, "interrupted from keyboard") == 0) {
//       return SolverImpl::SOLVER_RUN_STATUS_INTERRUPTED;
//     }
//     klee_warning("Unexpected solver failure. Reason is \"%s,\"\n", reason);
//     abort();
//   }
//   default:
//     llvm_unreachable("unhandled Z3 result");
//   }
// }

bool Z3SolverImpl::validateZ3Model(::Z3_solver &theSolver, ::Z3_model &theModel) {
  bool success = true;
  ::Z3_ast_vector constraints =
      Z3_solver_get_assertions(builder->ctx, theSolver);
  Z3_ast_vector_inc_ref(builder->ctx, constraints);

  unsigned size = Z3_ast_vector_size(builder->ctx, constraints);

  for (unsigned index = 0; index < size; ++index) {
    Z3ASTHandle constraint = Z3ASTHandle(
        Z3_ast_vector_get(builder->ctx, constraints, index), builder->ctx);

    ::Z3_ast rawEvaluatedExpr;
    __attribute__((unused))
    bool successfulEval =
        Z3_model_eval(builder->ctx, theModel, constraint,
                      /*model_completion=*/true, &rawEvaluatedExpr);
    assert(successfulEval && "Failed to evaluate model");

    // Use handle to do ref-counting.
    Z3ASTHandle evaluatedExpr(rawEvaluatedExpr, builder->ctx);

    Z3SortHandle sort =
        Z3SortHandle(Z3_get_sort(builder->ctx, evaluatedExpr), builder->ctx);
    assert(Z3_get_sort_kind(builder->ctx, sort) == Z3_BOOL_SORT &&
           "Evaluated expression has wrong sort");

    Z3_lbool evaluatedValue =
        Z3_get_bool_value(builder->ctx, evaluatedExpr);
    if (evaluatedValue != Z3_L_TRUE) {
      llvm::errs() << "Validating model failed:\n"
                   << "The expression:\n";
      constraint.dump();
      llvm::errs() << "evaluated to \n";
      evaluatedExpr.dump();
      llvm::errs() << "But should be true\n";
      success = false;
    }
  }

  if (!success) {
    llvm::errs() << "Solver state:\n" << Z3_solver_to_string(builder->ctx, theSolver) << "\n";
    llvm::errs() << "Model:\n" << Z3_model_to_string(builder->ctx, theModel) << "\n";
  }

  Z3_ast_vector_dec_ref(builder->ctx, constraints);
  return success;
}

SolverImpl::SolverRunStatus Z3SolverImpl::getOperationStatusCode() {
  return runStatusCode;
}
}
#endif // ENABLE_Z3
