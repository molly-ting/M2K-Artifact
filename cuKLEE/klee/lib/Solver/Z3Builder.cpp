//===-- Z3Builder.cpp ------------------------------------------*- C++ -*-====//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
#include "klee/Config/config.h"
#ifdef ENABLE_Z3
#include "Z3Builder.h"

#include "klee/ADT/Bits.h"
#include "klee/Expr/Expr.h"
#include "klee/Solver/Solver.h"
#include "klee/Solver/SolverStats.h"
#include "klee/Support/ErrorHandling.h"

#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/iterator_range.h"
#include "llvm/Support/CommandLine.h"

using namespace klee;

namespace {
llvm::cl::opt<bool> UseConstructHashZ3(
    "use-construct-hash-z3",
    llvm::cl::desc("Use hash-consing during Z3 query construction (default=true)"),
    llvm::cl::init(true),
    llvm::cl::cat(klee::ExprCat));

bool Z3InterationLogOpen = false;
}

namespace klee {

// Declared here rather than `Z3Builder.h` so they can be called in gdb.
template <> void Z3NodeHandle<Z3_sort>::dump() {
  llvm::errs() << "Z3SortHandle:\n" << ::Z3_sort_to_string(context, node)
               << "\n";
}
template <> void Z3NodeHandle<Z3_ast>::dump() {
  llvm::errs() << "Z3ASTHandle:\n" << ::Z3_ast_to_string(context, as_ast())
               << "\n";
}

void custom_z3_error_handler(Z3_context ctx, Z3_error_code ec) {
  ::Z3_string errorMsg =
#ifdef HAVE_Z3_GET_ERROR_MSG_NEEDS_CONTEXT
      Z3_get_error_msg(ctx, ec);
#else
      // Z3 4.4.1
      Z3_get_error_msg(ec);
#endif
  // FIXME: This is kind of a hack. The value comes from the enum
  // Z3_CANCELED_MSG but this isn't currently exposed by Z3's C API
  if (strcmp(errorMsg, "canceled") == 0) {
    // Solver timeout is not a fatal error
    return;
  }
  llvm::errs() << "Error: Incorrect use of Z3. [" << ec << "] " << errorMsg
               << "\n";
  Z3_close_log();
  abort();
}

Z3ArrayExprHash::~Z3ArrayExprHash() {}

void Z3ArrayExprHash::clear() {
  _update_node_hash.clear();
  _array_hash.clear();
}

Z3Builder::Z3Builder(bool autoClearConstructCache, const char* z3LogInteractionFileArg)
    : autoClearConstructCache(autoClearConstructCache), z3LogInteractionFile("") {
  if (z3LogInteractionFileArg)
    this->z3LogInteractionFile = std::string(z3LogInteractionFileArg);
  if (z3LogInteractionFile.length() > 0) {
    klee_message("Logging Z3 API interaction to \"%s\"",
                 z3LogInteractionFile.c_str());
    assert(!Z3InterationLogOpen && "interaction log should not already be open");
    Z3_open_log(z3LogInteractionFile.c_str());
    Z3InterationLogOpen = true;
  }
  // FIXME: Should probably let the client pass in a Z3_config instead
  Z3_config cfg = Z3_mk_config();
  Z3_set_param_value(cfg, "auto_config", "true");
  // It is very important that we ask Z3 to let us manage memory so that
  // we are able to cache expressions and sorts.
  ctx = Z3_mk_context_rc(cfg);
  // Make sure we handle any errors reported by Z3.
  Z3_set_error_handler(ctx, custom_z3_error_handler);
  // When emitting Z3 expressions make them SMT-LIBv2 compliant
  Z3_set_ast_print_mode(ctx, Z3_PRINT_SMTLIB2_COMPLIANT);
  Z3_del_config(cfg);
}

Z3Builder::~Z3Builder() {
  // Clear caches so exprs/sorts gets freed before the destroying context
  // they aren associated with.
  clearConstructCache();
  _arr_hash.clear();
  _int_arr_hash.clear();
  int_ast_map.clear();
  intArrNames.clear();
  noCheckExprs.clear();
  constant_array_assertions.clear();
  
  Z3_del_context(ctx);
  if (z3LogInteractionFile.length() > 0) {
    Z3_close_log();
    Z3InterationLogOpen = false;
  }
}

Z3SortHandle Z3Builder::getIntSort() {
  return Z3SortHandle(Z3_mk_int_sort(ctx), ctx);
}

Z3SortHandle Z3Builder::getBvSort(unsigned width) {
  // FIXME: cache these
  return Z3SortHandle(Z3_mk_bv_sort(ctx, width), ctx);
}

Z3SortHandle Z3Builder::getArraySort(Z3SortHandle domainSort,
                                     Z3SortHandle rangeSort) {
  // FIXME: cache these
  return Z3SortHandle(Z3_mk_array_sort(ctx, domainSort, rangeSort), ctx);
}

Z3ASTHandle Z3Builder::buildArray(const char *name, unsigned indexWidth,
                                  unsigned valueWidth) {
  Z3SortHandle domainSort = getBvSort(indexWidth);
  Z3SortHandle rangeSort = getBvSort(valueWidth);
  Z3SortHandle t = getArraySort(domainSort, rangeSort);
  Z3_symbol s = Z3_mk_string_symbol(ctx, const_cast<char *>(name));
  return Z3ASTHandle(Z3_mk_const(ctx, s, t), ctx);
}

Z3ASTHandle Z3Builder::buildIntArray(const char *name) {
  Z3SortHandle domainSort = getIntSort();
  Z3SortHandle rangeSort = getIntSort();
  Z3SortHandle arr_sort = getArraySort(domainSort, rangeSort);
  Z3_symbol sym = Z3_mk_string_symbol(ctx, name);
  return Z3ASTHandle(Z3_mk_const(ctx, sym, arr_sort), ctx);
}

Z3ASTHandle Z3Builder::getTrue() { return Z3ASTHandle(Z3_mk_true(ctx), ctx); }

Z3ASTHandle Z3Builder::getFalse() { return Z3ASTHandle(Z3_mk_false(ctx), ctx); }

Z3ASTHandle Z3Builder::bvOne(unsigned width) { return bvZExtConst(width, 1); }

Z3ASTHandle Z3Builder::bvZero(unsigned width) { return bvZExtConst(width, 0); }

Z3ASTHandle Z3Builder::bvMinusOne(unsigned width) {
  return bvSExtConst(width, (int64_t)-1);
}

Z3ASTHandle Z3Builder::uintConst32(uint32_t value) {
  Z3SortHandle t = getIntSort();
  return Z3ASTHandle(Z3_mk_unsigned_int(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::intConst32(int32_t value) {
  Z3SortHandle t = getIntSort();
  return Z3ASTHandle(Z3_mk_int(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::uintConst64(uint64_t value) {
  Z3SortHandle t = getIntSort();
  return Z3ASTHandle(Z3_mk_unsigned_int64(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::intConst64(int64_t value) {
  Z3SortHandle t = getIntSort();
  return Z3ASTHandle(Z3_mk_int64(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::realConst(std::string value) {
  Z3SortHandle t = Z3SortHandle(Z3_mk_real_sort(ctx), ctx);
  return Z3ASTHandle(Z3_mk_numeral(ctx, value.c_str(), t), ctx);
}

Z3ASTHandle Z3Builder::bvConst32(unsigned width, uint32_t value) {
  Z3SortHandle t = getBvSort(width);
  return Z3ASTHandle(Z3_mk_unsigned_int(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::bvConst64(unsigned width, uint64_t value) {
  Z3SortHandle t = getBvSort(width);
  return Z3ASTHandle(Z3_mk_unsigned_int64(ctx, value, t), ctx);
}

Z3ASTHandle Z3Builder::bvZExtConst(unsigned width, uint64_t value) {
  if (width <= 64)
    return bvConst64(width, value);

  Z3ASTHandle expr = Z3ASTHandle(bvConst64(64, value), ctx);
  Z3ASTHandle zero = Z3ASTHandle(bvConst64(64, 0), ctx);
  for (width -= 64; width > 64; width -= 64)
    expr = Z3ASTHandle(Z3_mk_concat(ctx, zero, expr), ctx);
  return Z3ASTHandle(Z3_mk_concat(ctx, bvConst64(width, 0), expr), ctx);
}

Z3ASTHandle Z3Builder::bvSExtConst(unsigned width, uint64_t value) {
  if (width <= 64)
    return bvConst64(width, value);

  Z3SortHandle t = getBvSort(width - 64);
  if (value >> 63) {
    Z3ASTHandle r = Z3ASTHandle(Z3_mk_int64(ctx, -1, t), ctx);
    return Z3ASTHandle(Z3_mk_concat(ctx, r, bvConst64(64, value)), ctx);
  }

  Z3ASTHandle r = Z3ASTHandle(Z3_mk_int64(ctx, 0, t), ctx);
  return Z3ASTHandle(Z3_mk_concat(ctx, r, bvConst64(64, value)), ctx);
}

Z3ASTHandle Z3Builder::bvBoolExtract(Z3ASTHandle expr, int bit) {
  return Z3ASTHandle(Z3_mk_eq(ctx, bvExtract(expr, bit, bit), bvOne(1)), ctx);
}

Z3ASTHandle Z3Builder::bvExtract(Z3ASTHandle expr, unsigned top,
                                 unsigned bottom) {
  return Z3ASTHandle(Z3_mk_extract(ctx, top, bottom, expr), ctx);
}

Z3ASTHandle Z3Builder::eqExpr(Z3ASTHandle a, Z3ASTHandle b) {
  return Z3ASTHandle(Z3_mk_eq(ctx, a, b), ctx);
}

// logical right shift
Z3ASTHandle Z3Builder::bvRightShift(Z3ASTHandle expr, unsigned shift) {
  unsigned width = getBVLength(expr);

  if (shift == 0) {
    return expr;
  } else if (shift >= width) {
    return bvZero(width); // Overshift to zero
  } else {
    return Z3ASTHandle(
        Z3_mk_concat(ctx, bvZero(shift), bvExtract(expr, width - 1, shift)),
        ctx);
  }
}

// logical left shift
Z3ASTHandle Z3Builder::bvLeftShift(Z3ASTHandle expr, unsigned shift) {
  unsigned width = getBVLength(expr);

  if (shift == 0) {
    return expr;
  } else if (shift >= width) {
    return bvZero(width); // Overshift to zero
  } else {
    return Z3ASTHandle(
        Z3_mk_concat(ctx, bvExtract(expr, width - shift - 1, 0), bvZero(shift)),
        ctx);
  }
}

// left shift by a variable amount on an expression of the specified width
Z3ASTHandle Z3Builder::bvVarLeftShift(Z3ASTHandle expr, Z3ASTHandle shift) {
  unsigned width = getBVLength(expr);
  Z3ASTHandle res = bvZero(width);

  // amount
  for (int i = width - 1; i >= 0; i--) {
    res =
        iteExpr(eqExpr(shift, bvConst32(width, i)), bvLeftShift(expr, i), res);
  }

  Z3ASTHandle ex = bvLtExpr(shift, bvConst32(getBVLength(shift), width));
  res = iteExpr(ex, res, bvZero(width));
  return res;
}

// logical right shift by a variable amount on an expression of the specified
// width
Z3ASTHandle Z3Builder::bvVarRightShift(Z3ASTHandle expr, Z3ASTHandle shift) {
  unsigned width = getBVLength(expr);
  Z3ASTHandle res = bvZero(width);

  // amount
  for (int i = width - 1; i >= 0; i--) {
    res =
        iteExpr(eqExpr(shift, bvConst32(width, i)), bvRightShift(expr, i), res);
  }

  Z3ASTHandle ex = bvLtExpr(shift, bvConst32(getBVLength(shift), width));
  res = iteExpr(ex, res, bvZero(width));
  return res;
}

// arithmetic right shift by a variable amount on an expression of the specified
// width
Z3ASTHandle Z3Builder::bvVarArithRightShift(Z3ASTHandle expr,
                                            Z3ASTHandle shift) {
  unsigned width = getBVLength(expr);

  // get the sign bit to fill with
  Z3ASTHandle signedBool = bvBoolExtract(expr, width - 1);

  Z3ASTHandle res = constructAShrByConstant(expr, width - 1, signedBool);

  // amount
  // XXX more efficient to move the ite on the sign outside all exprs?
  // XXX more efficient to sign extend, right shift, then extract lower bits?
  for (int i = width - 2; i >= 0; i--) {
    res = iteExpr(eqExpr(shift, bvConst32(width, i)),
                  constructAShrByConstant(expr, i, signedBool), res);
  }

  Z3ASTHandle ex = bvLtExpr(shift, bvConst32(getBVLength(shift), width));
  res = iteExpr(ex, res, bvZero(width));
  return res;
}

Z3ASTHandle Z3Builder::notExpr(Z3ASTHandle expr) {
  return Z3ASTHandle(Z3_mk_not(ctx, expr), ctx);
}

Z3ASTHandle Z3Builder::bvNotExpr(Z3ASTHandle expr) {
  return Z3ASTHandle(Z3_mk_bvnot(ctx, expr), ctx);
}

Z3ASTHandle Z3Builder::andExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  ::Z3_ast args[2] = {lhs, rhs};
  return Z3ASTHandle(Z3_mk_and(ctx, 2, args), ctx);
}

Z3ASTHandle Z3Builder::bvAndExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvand(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::orExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  ::Z3_ast args[2] = {lhs, rhs};
  return Z3ASTHandle(Z3_mk_or(ctx, 2, args), ctx);
}

Z3ASTHandle Z3Builder::bvOrExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvor(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::iffExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  Z3SortHandle lhsSort = Z3SortHandle(Z3_get_sort(ctx, lhs), ctx);
  Z3SortHandle rhsSort = Z3SortHandle(Z3_get_sort(ctx, rhs), ctx);
  assert(Z3_get_sort_kind(ctx, lhsSort) == Z3_get_sort_kind(ctx, rhsSort) &&
         "lhs and rhs sorts must match");
  assert(Z3_get_sort_kind(ctx, lhsSort) == Z3_BOOL_SORT && "args must have BOOL sort");
  return Z3ASTHandle(Z3_mk_iff(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::bvXorExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvxor(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::bvSignExtend(Z3ASTHandle src, unsigned width) {
  unsigned src_width =
      Z3_get_bv_sort_size(ctx, Z3SortHandle(Z3_get_sort(ctx, src), ctx));
  assert(src_width <= width && "attempted to extend longer data");

  return Z3ASTHandle(Z3_mk_sign_ext(ctx, width - src_width, src), ctx);
}

Z3ASTHandle Z3Builder::writeExpr(Z3ASTHandle array, Z3ASTHandle index,
                                 Z3ASTHandle value) {
  return Z3ASTHandle(Z3_mk_store(ctx, array, index, value), ctx);
}

Z3ASTHandle Z3Builder::readExpr(Z3ASTHandle array, Z3ASTHandle index) {
  return Z3ASTHandle(Z3_mk_select(ctx, array, index), ctx);
}

Z3ASTHandle Z3Builder::iteExpr(Z3ASTHandle condition, Z3ASTHandle whenTrue,
                               Z3ASTHandle whenFalse) {
  return Z3ASTHandle(Z3_mk_ite(ctx, condition, whenTrue, whenFalse), ctx);
}

unsigned Z3Builder::getBVLength(Z3ASTHandle expr) {
  return Z3_get_bv_sort_size(ctx, Z3SortHandle(Z3_get_sort(ctx, expr), ctx));
}

Z3ASTHandle Z3Builder::bvLtExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvult(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::bvLeExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvule(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::sbvLtExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvslt(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::sbvLeExpr(Z3ASTHandle lhs, Z3ASTHandle rhs) {
  return Z3ASTHandle(Z3_mk_bvsle(ctx, lhs, rhs), ctx);
}

Z3ASTHandle Z3Builder::constructAShrByConstant(Z3ASTHandle expr, unsigned shift,
                                               Z3ASTHandle isSigned) {
  unsigned width = getBVLength(expr);

  if (shift == 0) {
    return expr;
  } else if (shift >= width) {
    return bvZero(width); // Overshift to zero
  } else {
    // FIXME: Is this really the best way to interact with Z3?
    return iteExpr(isSigned,
                   Z3ASTHandle(Z3_mk_concat(ctx, bvMinusOne(shift),
                                            bvExtract(expr, width - 1, shift)),
                               ctx),
                   bvRightShift(expr, shift));
  }
}

Z3ASTHandle Z3Builder::getInitialArray(const Array *root) {

  assert(root);
  Z3ASTHandle array_expr;
  bool hashed = _arr_hash.lookupArrayExpr(root, array_expr);

  if (!hashed) {
    // Unique arrays by name, so we make sure the name is unique by
    // using the size of the array hash as a counter.
    std::string unique_id = llvm::utostr(_arr_hash._array_hash.size());
    // number
    std::string unique_name = root->name + "_" + unique_id;

    array_expr = buildArray(unique_name.c_str(), root->getDomain(),
                            root->getRange());

    if (root->isConstantArray() && constant_array_assertions.count(root) == 0) {
      std::vector<Z3ASTHandle> array_assertions;
      for (unsigned i = 0, e = root->size; i != e; ++i) {
        // Z3Solver.cpp
        int width_out;
        Z3ASTHandle array_value =
            construct(root->constantValues[i], &width_out);
        assert(width_out == (int)root->getRange() &&
               "Value doesn't match root range");
        array_assertions.push_back(
            eqExpr(readExpr(array_expr, bvConst32(root->getDomain(), i)),
                   array_value));
      }
      constant_array_assertions[root] = std::move(array_assertions);
    }

    _arr_hash.hashArrayExpr(root, array_expr);
  }

  return (array_expr);
}

Z3ASTHandle Z3Builder::getInitialIntArray(const Array *root, int elementWidth) {
  assert(root);
  Z3ASTHandle array_expr;
  bool hashed = _int_arr_hash.lookupArrayExpr(root, array_expr);

  if (!hashed && elementWidth) {
    // Unique arrays by name, so we make sure the name is unique by
    // using the size of the array hash as a counter.
    std::string unique_id = llvm::utostr(_int_arr_hash._array_hash.size());
    // number
    std::string unique_name = root->name + "_" + unique_id;

    array_expr = buildIntArray(unique_name.c_str());
    unsigned byteWidth = elementWidth / 8;

    if (root->isConstantArray() && constant_array_assertions.count(root) == 0) {
      std::vector<Z3ASTHandle> array_assertions;
      for (unsigned i = 0, e = root->size / byteWidth; i != e; ++i) {
        // Z3Solver.cpp
        ref<ConstantExpr> full_value = ConstantExpr::create(0, elementWidth);
        for (unsigned j = 0; j < byteWidth; ++j) {
          ref<ConstantExpr> byte_value = root->constantValues[i * byteWidth + j];
          full_value = full_value->Or(byte_value->ZExt(elementWidth)->Shl(ConstantExpr::create(j * 8, elementWidth)));
        }

        int width_out;
        Z3ASTHandle array_value = constructForInt(full_value, &width_out);
    
        array_assertions.push_back(
            eqExpr(readExpr(array_expr, intConst32(i)), array_value));
      }
      constant_array_assertions[root] = std::move(array_assertions);
    }

    _int_arr_hash.hashArrayExpr(root, array_expr);
  }

  return (array_expr);
}

Z3ASTHandle Z3Builder::getInitialRead(const Array *root, unsigned index) {
  return readExpr(getInitialArray(root), bvConst32(32, index));
}

Z3ASTHandle Z3Builder::getIntArrayInitialRead(const Array *root, unsigned index) {
  Z3ASTHandle arrayAST = getInitialIntArray(root, 0);
  if (!arrayAST || arrayAST == Z3ASTHandle())
    return Z3ASTHandle();
  return readExpr(arrayAST, intConst32(index));
}

Z3ASTHandle Z3Builder::getArrayForUpdate(const Array *root,
                                         const UpdateNode *un, bool forInt) {
  // Iterate over the update nodes, until we find a cached version of the node,
  // or no more update nodes remain
  Z3ASTHandle un_expr;
  std::vector<const UpdateNode *> update_nodes;
  for (; un && !_arr_hash.lookupUpdateNodeExpr(un, un_expr);
       un = un->next.get()) {
    update_nodes.push_back(un);
  }
  if (!un) {
    un_expr = getInitialArray(root);
  }
  // virtue of being the initial array expression

  // Create and cache solver expressions based on the update nodes starting from
  // the oldest
  for (const auto &un :
       llvm::make_range(update_nodes.crbegin(), update_nodes.crend())) {
    Z3ASTHandle indexAST;
    Z3ASTHandle valueAST;
    if (forInt) {
      indexAST = constructForInt(un->index, 0, true);
      valueAST = constructForInt(un->value, 0, true);
    } else {
      indexAST = construct(un->index, 0);
      valueAST = construct(un->value, 0);
    }
    
    un_expr =
        writeExpr(un_expr, indexAST, valueAST);

    _arr_hash.hashUpdateNodeExpr(un, un_expr);
  }

  return un_expr;
}

//   // Iterate over the update nodes, until we find a cached version of the node,
//   // or no more update nodes remain
//   // virtue of being the initial array expression

//   // Create and cache solver expressions based on the update nodes starting from
//   // the oldest



// bool: isWholeInt
std::pair<Z3ASTHandle, bool> Z3Builder::readIntExprInitial(const Array *array) {

  if (int_ast_map.find(array->name) != int_ast_map.end()) 
    return std::make_pair(int_ast_map[array->name], true);
  
  return std::make_pair(Z3ASTHandle(), false);
}

Z3ASTHandle Z3Builder::readIntExpr(const Array *array) {  
  assert(array);
  std::string symName = array->name;

  if (int_ast_map.find(symName) != int_ast_map.end()) 
    return int_ast_map[symName];
  
  Z3SortHandle t = getIntSort();
  Z3ASTHandle res = Z3ASTHandle(Z3_mk_const(ctx, Z3_mk_string_symbol(ctx, symName.c_str()), t), ctx);
  int_ast_map[symName] = res;
  return res;
}

/** if *width_out!=1 then result is a bitvector,
    otherwise it is a bool */
Z3ASTHandle Z3Builder::construct(ref<Expr> e, int *width_out) {
  // to store simpler expressions.
  if (!UseConstructHashZ3 || isa<ConstantExpr>(e)) {
    return constructActual(e, width_out);
  } else {
    ExprHashMap<std::pair<Z3ASTHandle, unsigned> >::iterator it =
        constructed.find(e);
    if (it != constructed.end()) {
      if (width_out)
        *width_out = it->second.second;
      return it->second.first;
    } else {
      int width;
      if (!width_out)
        width_out = &width;
      Z3ASTHandle res = constructActual(e, width_out);
      constructed.insert(std::make_pair(e, std::make_pair(res, *width_out)));
      return res;
    }
  }
}

Z3ASTHandle Z3Builder::intCStyleDivExpr(Z3ASTHandle left, Z3ASTHandle right) {
  Z3ASTHandle zeroAST = uintConst32(0);
  Z3ASTHandle isNegativeA = Z3ASTHandle(Z3_mk_lt(ctx, left, zeroAST), ctx);
  Z3ASTHandle isNegativeB = Z3ASTHandle(Z3_mk_lt(ctx, right, zeroAST), ctx);
  Z3_ast args[2] = {isNegativeA, Z3_mk_not(ctx, isNegativeB)};
  Z3ASTHandle shouldAdjust = Z3ASTHandle(Z3_mk_and(ctx, 2, args), ctx);

  Z3ASTHandle absA = Z3ASTHandle(Z3_mk_ite(ctx, isNegativeA, Z3_mk_unary_minus(ctx, left), left), ctx);
  Z3ASTHandle absB = Z3ASTHandle(Z3_mk_ite(ctx, isNegativeB, Z3_mk_unary_minus(ctx, right), right), ctx);

  Z3ASTHandle divResult = Z3ASTHandle(Z3_mk_div(ctx, absA, absB), ctx);
  Z3ASTHandle finalResult = Z3ASTHandle(Z3_mk_ite(ctx, shouldAdjust, Z3_mk_unary_minus(ctx, divResult), divResult), ctx);

  return finalResult;
}

Z3ASTHandle Z3Builder::intCStyleModExpr(Z3ASTHandle left, Z3ASTHandle right) {
  Z3ASTHandle divResult = intCStyleDivExpr(left, right);
  Z3_ast mulArgs[2] = {divResult, right};
  Z3_ast subArgs[2] = {left, Z3_mk_mul(ctx, 2, mulArgs)};
  Z3ASTHandle modResult = Z3ASTHandle(Z3_mk_sub(ctx, 2, subArgs), ctx);

  return modResult;
}

Z3ASTHandle Z3Builder::constructForInt(ref<Expr> e, int *width_out, bool isBitVec) {
  // to store simpler expressions.
  if (!UseConstructHashZ3 || isa<ConstantExpr>(e)) {
    return constructActualForInt(e, width_out, isBitVec);
  } else {
    ExprHashMap<std::pair<Z3ASTHandle, unsigned> >::iterator it =
        constructed.find(e);
    if (it != constructed.end()) {
      if (width_out)
        *width_out = it->second.second;
      Z3ASTHandle res = it->second.first;
      Z3_sort res_sort = Z3_get_sort(ctx, res);
      Z3_sort_kind res_kind = Z3_get_sort_kind(ctx, res_sort);
      if (isBitVec) {
        if (res_kind == Z3_REAL_SORT) {
          useInt2BV = true;
          if (width_out)
            *width_out = e->getWidth();
          res = Z3ASTHandle(Z3_mk_real2int(ctx, res), ctx);
          res = Z3ASTHandle(Z3_mk_int2bv(ctx, e->getWidth(), res), ctx);
        } 
        if (res_kind == Z3_INT_SORT) {
          useInt2BV = true;
          if (width_out)
            *width_out = e->getWidth();
          res = Z3ASTHandle(Z3_mk_int2bv(ctx, e->getWidth(), res), ctx);
        }
      }
      // else 
      return res;
    } else {
      int width;
      if (!width_out)
        width_out = &width;
      Z3ASTHandle res = constructActualForInt(e, width_out, isBitVec);
      Z3_sort res_sort = Z3_get_sort(ctx, res);
      Z3_sort_kind res_kind = Z3_get_sort_kind(ctx, res_sort);
      if (isBitVec) {
        if (res_kind == Z3_REAL_SORT) {
          useInt2BV = true;
          *width_out = e->getWidth();
          res = Z3ASTHandle(Z3_mk_real2int(ctx, res), ctx);
          res = Z3ASTHandle(Z3_mk_int2bv(ctx, e->getWidth(), res), ctx);
        } 
        if (res_kind == Z3_INT_SORT) {
          useInt2BV = true;
          *width_out = e->getWidth();
          res = Z3ASTHandle(Z3_mk_int2bv(ctx, e->getWidth(), res), ctx);
        }
      }
      // else 
      constructed.insert(std::make_pair(e, std::make_pair(res, *width_out)));
      return res;
    }
  }
}

Z3ASTHandle Z3Builder::constructActualForInt(ref<Expr> e, int *width_out, bool isBitVec) {
  int width;
  if (!width_out)
    width_out = &width;

  ++stats::queryConstructs;

  switch (e->getKind()) {
  case Expr::Constant: {
    ConstantExpr *CE = cast<ConstantExpr>(e);
    *width_out = CE->getWidth();

    if (*width_out == 1)
      return CE->isTrue() ? getTrue() : getFalse();

    // Fast path.
    if (!isBitVec) {
      if (CE->isFloatValue()) {
        if (*width_out == 32) {
          useReal = true;
          float value = ConstantExpr::getFloatFromConstantExpr(CE);
          if (std::trunc(value) == value) {
            return intConst32(static_cast<int32_t>(value));
          }
          return realConst(std::to_string(value));
        }
        if (*width_out == 64) {
          useReal = true;
          double value = ConstantExpr::getDoubleFromConstantExpr(CE);
          if (std::trunc(value) == value) {
            return intConst64(static_cast<int64_t>(value));
          }
          return realConst(std::to_string(value));
        }
      }
      if (*width_out < 32) {
        uint64_t rawValue = CE->getZExtValue();
        int32_t value;
        if (CE->isValueSigned()) {
          value = static_cast<int32_t>(rawValue | (~0U << *width_out));
        } else {
          value = static_cast<int32_t>(rawValue);
        }
        return intConst32(value);
      } else if (*width_out == 32) {
        if (CE->isValueSigned()) {
            return intConst32(CE->getZExtValue());
        } else {
          return uintConst32(CE->getZExtValue());
        }
        // else
      } else if (*width_out <= 64) {
        if (CE->isValueSigned())
          return intConst64(CE->getZExtValue());
        else {
          return uintConst64(CE->getZExtValue());
        }
        // else
      }
    }
    
    if (*width_out <= 32)
      return bvConst32(*width_out, CE->getZExtValue(32));
    if (*width_out <= 64)
      return bvConst64(*width_out, CE->getZExtValue());

    ref<ConstantExpr> Tmp = CE;
    Z3ASTHandle Res = bvConst64(64, Tmp->Extract(0, 64)->getZExtValue());
    while (Tmp->getWidth() > 64) {
      Tmp = Tmp->Extract(64, Tmp->getWidth() - 64);
      unsigned Width = std::min(64U, Tmp->getWidth());
      Res = Z3ASTHandle(
          Z3_mk_concat(ctx,
                       bvConst64(Width, Tmp->Extract(0, Width)->getZExtValue()),
                       Res),
          ctx);
    }
    return Res;
  }

  // Special
  case Expr::NotOptimized: {
    NotOptimizedExpr *noe = cast<NotOptimizedExpr>(e);
    return constructForInt(noe->src, width_out, isBitVec);
  }

  case Expr::Read: { 
    ReadExpr *re = cast<ReadExpr>(e);
    assert(re && re->updates.root);
    *width_out = re->updates.root->getRange();
    int index = 0;
    if (auto CE = dyn_cast<ConstantExpr>(re->index)) {
      index = CE->getZExtValue();
    } 
    if (!isBitVec && index == 0 && intArrNames.find(re->updates.root->name)!=intArrNames.end()) {
      if (intArrNames[re->updates.root->name] * 8 == e->getWidth()) {
        Z3ASTHandle indexAST = uintConst32(0);  
        Z3ASTHandle readAST = readExpr(getInitialIntArray(re->updates.root, e->getWidth()), indexAST);
        return readAST;
      }
    }
    if (isBitVec || !re->updates.root->isIntVar || index > 0) {
      Z3ASTHandle indexAST = constructForInt(re->index, 0, true);
      return readExpr(getArrayForUpdate(re->updates.root, re->updates.head.get(), true), indexAST);
    }
    return readIntExpr(re->updates.root);
  }

  case Expr::Select: {
    SelectExpr *se = cast<SelectExpr>(e);
    Z3ASTHandle cond = constructForInt(se->cond, 0, isBitVec);
    Z3ASTHandle tExpr = constructForInt(se->trueExpr, width_out, isBitVec);
    Z3ASTHandle fExpr = constructForInt(se->falseExpr, width_out, isBitVec);

    Z3_sort tsort = Z3_get_sort(ctx, tExpr);
    Z3_sort_kind tkind = Z3_get_sort_kind(ctx, tsort);
    Z3_sort fsort = Z3_get_sort(ctx, fExpr);
    Z3_sort_kind fkind = Z3_get_sort_kind(ctx, fsort);
    
    if (tkind == fkind) {
      return iteExpr(cond, tExpr, fExpr);
    }
    if (tkind == Z3_REAL_SORT) {
      if (fkind == Z3_INT_SORT) {
        fExpr = Z3ASTHandle(Z3_mk_int2real(ctx, fExpr), ctx);
        return iteExpr(cond, tExpr, fExpr);
      }
      fExpr = Z3ASTHandle(Z3_mk_bv2int(ctx, fExpr, true), ctx);
      fExpr = Z3ASTHandle(Z3_mk_int2real(ctx, fExpr), ctx);
      return iteExpr(cond, tExpr, fExpr);
    }
    if (fkind == Z3_REAL_SORT) {
      if (tkind == Z3_INT_SORT) {
        tExpr = Z3ASTHandle(Z3_mk_int2real(ctx, tExpr), ctx);
        return iteExpr(cond, tExpr, fExpr);
      }
      tExpr = Z3ASTHandle(Z3_mk_bv2int(ctx, tExpr, true), ctx);
      tExpr = Z3ASTHandle(Z3_mk_int2real(ctx, tExpr), ctx);
      return iteExpr(cond, tExpr, fExpr);
    }

    cond = constructForInt(se->cond, 0, true);
    tExpr = constructForInt(se->trueExpr, width_out, true);
    fExpr = constructForInt(se->falseExpr, width_out, true);
    return iteExpr(cond, tExpr, fExpr);
  }

  case Expr::Concat: {
    ConcatExpr *ce = cast<ConcatExpr>(e);
    unsigned numKids = ce->getNumKids();
    const Array *array = nullptr;
    *width_out = ce->getWidth();

    bool isReadInt = false;
    if (!isBitVec) {
      isReadInt = ConcatExpr::checkIsReadInt(e, &array);
    }

    if (!isReadInt) {
      ref<ConstantExpr> lastConstExpr = ConcatExpr::getLastConstantInConcat(e, &array);
      if (lastConstExpr && !array->isConstantArray()) {
        return readIntExpr(array);
      }

      ref<Expr> indexExpr = ConcatExpr::getArrayIndex(e, &array);
      if (indexExpr) {
        Z3ASTHandle tmpAST = constructForInt(indexExpr, 0);
        Z3_sort tmp_sort = Z3_get_sort(ctx, tmpAST);
        Z3_sort_kind tmp_kind = Z3_get_sort_kind(ctx, tmp_sort);
        
        if (tmp_kind == Z3_INT_SORT) {
          int elementWidth = e->getWidth();
          if (intArrNames.find(array->name)!=intArrNames.end()) {
            int tmpWidth = intArrNames[array->name] * 8;
            if (tmpWidth > 8 && tmpWidth < elementWidth) {
            }
          }
          Z3ASTHandle indexAST = Z3ASTHandle(Z3_mk_div(ctx, tmpAST, uintConst32(elementWidth/8)), ctx);  
          Z3ASTHandle readAST = readExpr(getInitialIntArray(array, ce->getWidth()), indexAST);


          
          if (elementWidth <= 64) {
            ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (elementWidth-1)) - 1, elementWidth);
            Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
            ref<ConstantExpr> minValueExpr = ConstantExpr::alloc(1ULL << (elementWidth-1), elementWidth, true);   
            Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, readAST, constructForInt(minValueExpr, 0)), ctx);
            Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, readAST, maxValueAST), ctx);

            int_array_bounds[array->name].push_back(lowerBounds);
            int_array_bounds[array->name].push_back(upperBounds);
          }
          return readAST;
        }
      }
    }
    
    if (isBitVec || !isReadInt) {
      Z3ASTHandle res = constructForInt(ce->getKid(numKids - 1), 0, true);
      for (int i = numKids - 2; i >= 0; i--) {
        res =
            Z3ASTHandle(Z3_mk_concat(ctx, constructForInt(ce->getKid(i), 0, true), res), ctx);
      }
      *width_out = ce->getWidth();
      return res;
    }
    return readIntExpr(array);
  }

  case Expr::Extract: {
    ExtractExpr *ee = cast<ExtractExpr>(e);
    if (ee->offset == 0) {
      Z3ASTHandle src_int = constructForInt(ee->expr, width_out, isBitVec);
    
      Z3_sort src_sort = Z3_get_sort(ctx, src_int);
      Z3_sort_kind src_kind = Z3_get_sort_kind(ctx, src_sort);
      if (src_kind == Z3_INT_SORT || src_kind == Z3_REAL_SORT)
        return src_int;
    }
    
    Z3ASTHandle src = constructForInt(ee->expr, width_out, true);
    *width_out = ee->getWidth();
    if (*width_out == 1) {
      return bvBoolExtract(src, ee->offset);
    } else {
      return bvExtract(src, ee->offset + *width_out - 1, ee->offset);
    }
  }

  // Casting

  case Expr::ZExt: {
    int srcWidth;
    CastExpr *ce = cast<CastExpr>(e);
    Z3ASTHandle src = constructForInt(ce->src, &srcWidth, isBitVec);
    
    Z3_sort src_sort = Z3_get_sort(ctx, src);
    Z3_sort_kind src_kind = Z3_get_sort_kind(ctx, src_sort);
    if (src_kind == Z3_INT_SORT || src_kind == Z3_REAL_SORT){
      *width_out = srcWidth;
      return src;
    }

    src = constructForInt(ce->src, &srcWidth, true);
    *width_out = ce->getWidth();
    if (srcWidth == 1) {
      return iteExpr(src, bvOne(*width_out), bvZero(*width_out));
    } else {
      assert(*width_out > srcWidth && "Invalid width_out");
      return Z3ASTHandle(Z3_mk_concat(ctx, bvZero(*width_out - srcWidth), src),
                          ctx);
    }
  }

  case Expr::SExt: {
    int srcWidth;
    CastExpr *ce = cast<CastExpr>(e);
    Z3ASTHandle src = constructForInt(ce->src, &srcWidth, isBitVec);
    
    Z3_sort src_sort = Z3_get_sort(ctx, src);
    Z3_sort_kind src_kind = Z3_get_sort_kind(ctx, src_sort);
    if (src_kind == Z3_INT_SORT || src_kind == Z3_REAL_SORT){
      *width_out = srcWidth;
      return src;
    }

    src = constructForInt(ce->src, &srcWidth, true);
    *width_out = ce->getWidth();
    if (srcWidth == 1) {
      return iteExpr(src, bvMinusOne(*width_out), bvZero(*width_out));
    } else {
      return bvSignExtend(src, *width_out);
    }
  }

  // Arithmetic
  case Expr::Add: {
    AddExpr *ae = cast<AddExpr>(e);
    Z3ASTHandle left = constructForInt(ae->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(ae->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized add");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    
    if (left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) {
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT) {
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(ae->right)) {
      right = constructForInt(ae->right, width_out, false);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(ae->left)) {
      left = constructForInt(ae->left, width_out, false);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_add(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_add"].push_back(upperBounds);
      }
      return result;
    }
    
    left = constructForInt(ae->left, width_out, true);
    right = constructForInt(ae->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized add");

    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvadd(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::Sub: {
    SubExpr *se = cast<SubExpr>(e);
    Z3ASTHandle left = constructForInt(se->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(se->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized sub");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_sub(ctx, 2, args), ctx);
      return result;
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(se->right)) {
      right = constructForInt(se->right, width_out, false);
      Z3_ast args[2] = {left, right};
      return Z3ASTHandle(Z3_mk_sub(ctx, 2, args), ctx);
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(se->left)) {
      left = constructForInt(se->left, width_out, false);
      Z3_ast args[2] = {left, right};
      return Z3ASTHandle(Z3_mk_sub(ctx, 2, args), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_sub(ctx, 2, args), ctx);
      return result;
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_sub(ctx, 2, args), ctx);
      return result;
    }

    left = constructForInt(se->left, width_out, true);
    right = constructForInt(se->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized sub");
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsub(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::Mul: {
    MulExpr *me = cast<MulExpr>(e);
    Z3ASTHandle right = constructForInt(me->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized mul");
    Z3ASTHandle left = constructForInt(me->left, width_out, isBitVec);

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    if (left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) {
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> minValueExpr = ConstantExpr::alloc(1ULL << (e->getWidth()-1), e->getWidth(), true);   
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, constructForInt(minValueExpr, 0)), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT) {
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        int64_t minVal = -(1ULL << (e->getWidth()-1));
        Z3ASTHandle minValueAST  = Z3ASTHandle(realConst(std::to_string(minVal)));
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, minValueAST), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        int64_t minVal = -(1ULL << (e->getWidth()-1));
        Z3ASTHandle minValueAST  = Z3ASTHandle(realConst(std::to_string(minVal)));
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, minValueAST), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        int64_t minVal = -(1ULL << (e->getWidth()-1));
        Z3ASTHandle minValueAST  = Z3ASTHandle(realConst(std::to_string(minVal)));
        Z3ASTHandle maxValueAST = Z3ASTHandle(realConst(std::to_string((1ULL << (e->getWidth()-1)) - 1)));
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, minValueAST), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(me->right)) {
      right = constructForInt(me->right, width_out, false);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> minValueExpr = ConstantExpr::alloc(1ULL << (e->getWidth()-1), e->getWidth(), true);   
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, constructForInt(minValueExpr, 0)), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(me->left)) {
      left = constructForInt(me->left, width_out, false);
      Z3_ast args[2] = {left, right};
      Z3ASTHandle result = Z3ASTHandle(Z3_mk_mul(ctx, 2, args), ctx);
      if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
        ref<ConstantExpr> minValueExpr = ConstantExpr::alloc(1ULL << (e->getWidth()-1), e->getWidth(), true);   
        ref<ConstantExpr> maxValueExpr = ConstantExpr::create((1ULL << (e->getWidth()-1)) - 1, e->getWidth());
        Z3ASTHandle maxValueAST = constructForInt(maxValueExpr, 0);
        Z3ASTHandle lowerBounds = Z3ASTHandle(Z3_mk_ge(ctx, result, constructForInt(minValueExpr, 0)), ctx);
        Z3ASTHandle upperBounds = Z3ASTHandle(Z3_mk_le(ctx, result, maxValueAST), ctx);
        int_array_bounds["int_mul"].push_back(lowerBounds);
        int_array_bounds["int_mul"].push_back(upperBounds);
      }
      return result;
    }

    left = constructForInt(me->left, width_out, true);
    right = constructForInt(me->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized mul");

    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvmul(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::UDiv: {
    UDivExpr *de = cast<UDivExpr>(e);
    Z3ASTHandle left = constructForInt(de->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized udiv");
    Z3ASTHandle right = constructForInt(de->right, width_out, isBitVec);

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(de->right)) {
      right = constructForInt(de->right, width_out, false);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(de->left)) {
      left = constructForInt(de->left, width_out, false);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    
    left = constructForInt(de->left, width_out, true);
    assert(*width_out != 1 && "uncanonicalized udiv");
    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(de->right)) {
      if (CE->getWidth() <= 64) {
        uint64_t divisor = CE->getZExtValue();
        if (bits64::isPowerOfTwo(divisor))
          return bvRightShift(left, bits64::indexOfSingleBit(divisor));
      }
    }
    right = constructForInt(de->right, width_out, true);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvudiv(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::SDiv: {
    SDivExpr *de = cast<SDivExpr>(e);
    Z3ASTHandle left = constructForInt(de->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized sdiv");
    Z3ASTHandle right = constructForInt(de->right, width_out, isBitVec);

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    if (left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT)
      return intCStyleDivExpr(left, right);
    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(de->right)) {
      right = constructForInt(de->right, width_out, false);
      return intCStyleDivExpr(left, right);
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(de->left)) {
      left = constructForInt(de->left, width_out, false);
      return intCStyleDivExpr(left, right);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_div(ctx, left, right), ctx);
    }
    
    left = constructForInt(de->left, width_out, true);
    assert(*width_out != 1 && "uncanonicalized sdiv");
    right = constructForInt(de->right, width_out, true);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsdiv(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::URem: {
    URemExpr *de = cast<URemExpr>(e);
    Z3ASTHandle left = constructForInt(de->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized urem");
    Z3ASTHandle right = constructForInt(de->right, width_out, isBitVec);

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(de->right)) {
      right = constructForInt(de->right, width_out, false);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(de->left)) {
      left = constructForInt(de->left, width_out, false);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    
    left = constructForInt(de->left, width_out, true);
    assert(*width_out != 1 && "uncanonicalized urem");
    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(de->right)) {
      if (CE->getWidth() <= 64) {
        uint64_t divisor = CE->getZExtValue();

        if (bits64::isPowerOfTwo(divisor)) {
          // FIXME: This should be unsigned but currently needs to be signed to
          int bits = bits64::indexOfSingleBit(divisor);

          if (bits == 0) {
            return bvZero(*width_out);
          } else {
            assert(*width_out > bits && "invalid width_out");
            return Z3ASTHandle(Z3_mk_concat(ctx, bvZero(*width_out - bits),
                                            bvExtract(left, bits - 1, 0)),
                               ctx);
          }
        }
      }
    }
    right = constructForInt(de->right, width_out, true);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvurem(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::SRem: {
    SRemExpr *de = cast<SRemExpr>(e);
    Z3ASTHandle left = constructForInt(de->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(de->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized srem");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(de->right)) {
      right = constructForInt(de->right, width_out, false);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (right_kind == Z3_INT_SORT && isa<ConstantExpr>(de->left)) {
      left = constructForInt(de->left, width_out, false);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      return Z3ASTHandle(Z3_mk_rem(ctx, left, right), ctx);
    }
    
    left = constructForInt(de->left, width_out, true);
    right = constructForInt(de->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized srem");
    // LLVM's srem instruction says that the sign follows the dividend
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsrem(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  // Bitwise
  case Expr::Not: {
    NotExpr *ne = cast<NotExpr>(e);
    Z3ASTHandle expr = constructForInt(ne->expr, width_out, isBitVec);
    if (*width_out == 1) {
      return notExpr(expr);
    } else {
      expr = constructForInt(ne->expr, width_out, true);
      return bvNotExpr(expr);
    }
  }

  case Expr::And: {
    AndExpr *ae = cast<AndExpr>(e);
    Z3ASTHandle left = constructForInt(ae->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(ae->right, width_out, isBitVec);
    if (*width_out == 1) {
      return andExpr(left, right);
    } else {
      Z3_sort left_sort = Z3_get_sort(ctx, left);
      Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
      Z3_sort right_sort = Z3_get_sort(ctx, right);
      Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
      if (left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) {
        if (isa<ConstantExpr>(ae->left) || isa<ConstantExpr>(ae->right))
          return constructForInt(Expr::andExprUsingArithmetic(ae->left, ae->right), width_out);
      }
      left = constructForInt(ae->left, width_out, true);
      right = constructForInt(ae->right, width_out, true);
      return bvAndExpr(left, right);
    }
  }

  case Expr::Or: {
    OrExpr *oe = cast<OrExpr>(e);
    Z3ASTHandle left = constructForInt(oe->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(oe->right, width_out, isBitVec);
    if (*width_out == 1) {
      return orExpr(left, right);
    } else {
      Z3_sort left_sort = Z3_get_sort(ctx, left);
      Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
      Z3_sort right_sort = Z3_get_sort(ctx, right);
      Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
      if (left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) {
        if (isa<ConstantExpr>(oe->left) || isa<ConstantExpr>(oe->right))
          return constructForInt(Expr::orExprUsingArithmetic(oe->left, oe->right), width_out);
      }
      left = constructForInt(oe->left, width_out, true);
      right = constructForInt(oe->right, width_out, true);
      return bvOrExpr(left, right);
    }
  }

  case Expr::Xor: {
    XorExpr *xe = cast<XorExpr>(e);
    Z3ASTHandle left = constructForInt(xe->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(xe->right, width_out, isBitVec);

    if (*width_out == 1) {
      return iteExpr(left, Z3ASTHandle(notExpr(right)), right);
    } else {
      left = constructForInt(xe->left, width_out, true);
      right = constructForInt(xe->right, width_out, true);
      return bvXorExpr(left, right);
    }
  }

  case Expr::Shl: {
    ShlExpr *se = cast<ShlExpr>(e);
    Z3ASTHandle left = constructForInt(se->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized shl");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(se->right)) {
      auto rightCE = dyn_cast<ConstantExpr>(se->right);
      if (rightCE->getZExtValue() < 8) {
        return constructForInt(Expr::leftShiftUsingArithmetic(se->left, se->right), width_out);
      }
    }

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(se->right)) {
      left = constructForInt(se->left, width_out, true);
      return bvLeftShift(left, (unsigned)CE->getLimitedValue());
    } else {
      int shiftWidth;
      Z3ASTHandle amount = constructForInt(se->right, &shiftWidth, true);
      if (left_kind == Z3_INT_SORT) {
        left = constructForInt(se->left, width_out, true);
      }
      return bvVarLeftShift(left, amount);
    }
  }

  case Expr::LShr: {
    LShrExpr *lse = cast<LShrExpr>(e);
    Z3ASTHandle left = constructForInt(lse->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized lshr");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(lse->right)) {
      auto rightCE = dyn_cast<ConstantExpr>(lse->right);
      if (rightCE->getZExtValue() < 8) {
        return constructForInt(Expr::rightShiftUsingArithmetic(lse->left, lse->right), width_out);
      }  
    }

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(lse->right)) {
      left = constructForInt(lse->left, width_out, true);
      return bvRightShift(left, (unsigned)CE->getLimitedValue());
    } else {
      int shiftWidth;
      Z3ASTHandle amount = constructForInt(lse->right, &shiftWidth, true);
      if (left_kind == Z3_INT_SORT) {
        left = constructForInt(lse->left, width_out, true);
      }
      return bvVarRightShift(left, amount);
    }
  }

  case Expr::AShr: {
    AShrExpr *ase = cast<AShrExpr>(e);
    Z3ASTHandle left = constructForInt(ase->left, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized ashr");

    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    if (left_kind == Z3_INT_SORT && isa<ConstantExpr>(ase->right)) {
      auto rightCE = dyn_cast<ConstantExpr>(ase->right);
      if (rightCE->getZExtValue() < 8) {
        return constructForInt(Expr::rightShiftUsingArithmetic(ase->left, ase->right), width_out);
      }
    }

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(ase->right)) {
      left = constructForInt(ase->left, width_out, true);
      unsigned shift = (unsigned)CE->getLimitedValue();
      Z3ASTHandle signedBool = bvBoolExtract(left, *width_out - 1);
      return constructAShrByConstant(left, shift, signedBool);
    } else {
      int shiftWidth;
      Z3ASTHandle amount = constructForInt(ase->right, &shiftWidth, true);
      if (left_kind == Z3_INT_SORT) {
        left = constructForInt(ase->left, width_out, true);
      }
      return bvVarArithRightShift(left, amount);
    }
  }

  // Comparison

  case Expr::Eq: {
    EqExpr *ee = cast<EqExpr>(e);
    Z3ASTHandle left = constructForInt(ee->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(ee->right, width_out, isBitVec);
      if (isa<ConstantExpr>(ee->left) && ee->left->getWidth()==Expr::Bool) {
        ConstantExpr *CE = dyn_cast<ConstantExpr>(ee->left);
        Z3_sort right_sort = Z3_get_sort(ctx, right);
        Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);
        if (CE->isFalse() && right_kind == Z3_INT_SORT) {
          left = intConst32(0);
          *width_out = 1;
          return eqExpr(left, right);
        } else if (CE->isTrue() && right_kind == Z3_INT_SORT) {
          left = intConst32(1);
          *width_out = 1;
          return eqExpr(left, right);
        } 
      }
      Z3_sort left_sort = Z3_get_sort(ctx, left);
      Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
      Z3_sort right_sort = Z3_get_sort(ctx, right);
      Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

      if (left_kind != right_kind) {
        if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
          left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
        } else if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
          right = Z3ASTHandle(Z3_mk_int2real(ctx, right), ctx);
        } else {
          left = constructForInt(ee->left, width_out, true);
          right = constructForInt(ee->right, width_out, true);
        }
      }
      *width_out = 1;
      return eqExpr(left, right);
  }

  case Expr::Ult: {
    UltExpr *ue = cast<UltExpr>(e);
    Z3ASTHandle left = constructForInt(ue->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(ue->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized ult");
    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, right), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }

    left = constructForInt(ue->left, width_out, true);
    right = constructForInt(ue->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized ult");
    *width_out = 1;
    return bvLtExpr(left, right);
  }

  case Expr::Ule: {
    UleExpr *ue = cast<UleExpr>(e);
    Z3ASTHandle left = constructForInt(ue->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(ue->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized ule");
    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, right), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }

    left = constructForInt(ue->left, width_out, true);
    right = constructForInt(ue->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized ule");
    *width_out = 1;
    return bvLeExpr(left, right);
  }

  case Expr::Slt: {
    SltExpr *se = cast<SltExpr>(e);
    Z3ASTHandle left = constructForInt(se->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(se->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized slt");
    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, right), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_lt(ctx, left, right), ctx);
    }

    left = constructForInt(se->left, width_out, true);
    right = constructForInt(se->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized slt");
    *width_out = 1;
    return sbvLtExpr(left, right);
  }

  case Expr::Sle: {
    SleExpr *se = cast<SleExpr>(e);
    Z3ASTHandle left = constructForInt(se->left, width_out, isBitVec);
    Z3ASTHandle right = constructForInt(se->right, width_out, isBitVec);
    assert(*width_out != 1 && "uncanonicalized sle");
    Z3_sort left_sort = Z3_get_sort(ctx, left);
    Z3_sort_kind left_kind = Z3_get_sort_kind(ctx, left_sort);
    Z3_sort right_sort = Z3_get_sort(ctx, right);
    Z3_sort_kind right_kind = Z3_get_sort_kind(ctx, right_sort);

    if ((left_kind == Z3_INT_SORT && right_kind == Z3_INT_SORT) || (left_kind == Z3_REAL_SORT && right_kind == Z3_REAL_SORT)) {
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }
    if (left_kind == Z3_INT_SORT && right_kind == Z3_REAL_SORT) {
      left = Z3ASTHandle(Z3_mk_int2real(ctx, left), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }
    if (left_kind == Z3_REAL_SORT && right_kind == Z3_INT_SORT) {
      right = Z3ASTHandle(Z3_mk_int2real(ctx, right), ctx);
      *width_out = 1;
      return Z3ASTHandle(Z3_mk_le(ctx, left, right), ctx);
    }

    left = constructForInt(se->left, width_out, true);
    right = constructForInt(se->right, width_out, true);
    assert(*width_out != 1 && "uncanonicalized sle");
    *width_out = 1;
    return sbvLeExpr(left, right);
  }

// unused due to canonicalization
#if 0
  case Expr::Ne:
  case Expr::Ugt:
  case Expr::Uge:
  case Expr::Sgt:
  case Expr::Sge:
#endif

  default:
    assert(0 && "unhandled Expr type");
    return getTrue();
  }
}

/** if *width_out!=1 then result is a bitvector,
    otherwise it is a bool */
Z3ASTHandle Z3Builder::constructActual(ref<Expr> e, int *width_out) {
  int width;
  if (!width_out)
    width_out = &width;

  ++stats::queryConstructs;

  switch (e->getKind()) {
  case Expr::Constant: {
    ConstantExpr *CE = cast<ConstantExpr>(e);
    *width_out = CE->getWidth();

    if (*width_out == 1)
      return CE->isTrue() ? getTrue() : getFalse();

    // Fast path.
    if (*width_out <= 32)
      return bvConst32(*width_out, CE->getZExtValue(32));
    if (*width_out <= 64)
      return bvConst64(*width_out, CE->getZExtValue());

    ref<ConstantExpr> Tmp = CE;
    Z3ASTHandle Res = bvConst64(64, Tmp->Extract(0, 64)->getZExtValue());
    while (Tmp->getWidth() > 64) {
      Tmp = Tmp->Extract(64, Tmp->getWidth() - 64);
      unsigned Width = std::min(64U, Tmp->getWidth());
      Res = Z3ASTHandle(
          Z3_mk_concat(ctx,
                       bvConst64(Width, Tmp->Extract(0, Width)->getZExtValue()),
                       Res),
          ctx);
    }
    return Res;
  }

  // Special
  case Expr::NotOptimized: {
    NotOptimizedExpr *noe = cast<NotOptimizedExpr>(e);
    return construct(noe->src, width_out);
  }

  case Expr::Read: {
    ReadExpr *re = cast<ReadExpr>(e);
    assert(re && re->updates.root);
    *width_out = re->updates.root->getRange();
    return readExpr(getArrayForUpdate(re->updates.root, re->updates.head.get()),
                    construct(re->index, 0));
  }

  case Expr::Select: {
    SelectExpr *se = cast<SelectExpr>(e);
    Z3ASTHandle cond = construct(se->cond, 0);
    Z3ASTHandle tExpr = construct(se->trueExpr, width_out);
    Z3ASTHandle fExpr = construct(se->falseExpr, width_out);
    return iteExpr(cond, tExpr, fExpr);
  }

  case Expr::Concat: {
    ConcatExpr *ce = cast<ConcatExpr>(e);
    unsigned numKids = ce->getNumKids();
    Z3ASTHandle res = construct(ce->getKid(numKids - 1), 0);
    for (int i = numKids - 2; i >= 0; i--) {
      res =
          Z3ASTHandle(Z3_mk_concat(ctx, construct(ce->getKid(i), 0), res), ctx);
    }
    *width_out = ce->getWidth();
    return res;
  }

  case Expr::Extract: {
    ExtractExpr *ee = cast<ExtractExpr>(e);
    Z3ASTHandle src = construct(ee->expr, width_out);
    *width_out = ee->getWidth();
    if (*width_out == 1) {
      return bvBoolExtract(src, ee->offset);
    } else {
      return bvExtract(src, ee->offset + *width_out - 1, ee->offset);
    }
  }

  // Casting

  case Expr::ZExt: {
    int srcWidth;
    CastExpr *ce = cast<CastExpr>(e);
    Z3ASTHandle src = construct(ce->src, &srcWidth);
    *width_out = ce->getWidth();
    if (srcWidth == 1) {
      return iteExpr(src, bvOne(*width_out), bvZero(*width_out));
    } else {
      assert(*width_out > srcWidth && "Invalid width_out");
      return Z3ASTHandle(Z3_mk_concat(ctx, bvZero(*width_out - srcWidth), src),
                         ctx);
    }
  }

  case Expr::SExt: {
    int srcWidth;
    CastExpr *ce = cast<CastExpr>(e);
    Z3ASTHandle src = construct(ce->src, &srcWidth);
    *width_out = ce->getWidth();
    if (srcWidth == 1) {
      return iteExpr(src, bvMinusOne(*width_out), bvZero(*width_out));
    } else {
      return bvSignExtend(src, *width_out);
    }
  }

  // Arithmetic
  case Expr::Add: {
    AddExpr *ae = cast<AddExpr>(e);
    Z3ASTHandle left = construct(ae->left, width_out);
    Z3ASTHandle right = construct(ae->right, width_out);
    assert(*width_out != 1 && "uncanonicalized add");
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvadd(ctx, left, right), ctx);
    if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
      bool isSigned = ae->isValueSigned();
      Z3ASTHandle no_overflow_check = Z3ASTHandle(Z3_mk_bvadd_no_overflow(ctx, left, right, isSigned), ctx);
      if (std::find(int_array_bounds["bv"].begin(), int_array_bounds["bv"].end(), no_overflow_check) == int_array_bounds["bv"].end()){
          int_array_bounds["bv"].push_back(no_overflow_check);
      }
    }
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::Sub: {
    SubExpr *se = cast<SubExpr>(e);
    Z3ASTHandle left = construct(se->left, width_out);
    Z3ASTHandle right = construct(se->right, width_out);
    assert(*width_out != 1 && "uncanonicalized sub");
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsub(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::Mul: {
    MulExpr *me = cast<MulExpr>(e);
    Z3ASTHandle right = construct(me->right, width_out);
    assert(*width_out != 1 && "uncanonicalized mul");
    Z3ASTHandle left = construct(me->left, width_out);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvmul(ctx, left, right), ctx);
    if (e->getWidth()>32 && !isHandlingQuery && std::find(noCheckExprs.begin(), noCheckExprs.end(), e) == noCheckExprs.end()) {
      bool isSigned = me->isValueSigned();
      Z3ASTHandle no_overflow_check = Z3ASTHandle(Z3_mk_bvmul_no_overflow(ctx, left, right, isSigned), ctx);
      if (std::find(int_array_bounds["bv"].begin(), int_array_bounds["bv"].end(), no_overflow_check) == int_array_bounds["bv"].end()) {
          int_array_bounds["bv"].push_back(no_overflow_check);
      }
    }
    // check overflow

    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::UDiv: {
    UDivExpr *de = cast<UDivExpr>(e);
    Z3ASTHandle left = construct(de->left, width_out);
    assert(*width_out != 1 && "uncanonicalized udiv");

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(de->right)) {
      if (CE->getWidth() <= 64) {
        uint64_t divisor = CE->getZExtValue();
        if (bits64::isPowerOfTwo(divisor))
          return bvRightShift(left, bits64::indexOfSingleBit(divisor));
      }
    }

    Z3ASTHandle right = construct(de->right, width_out);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvudiv(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::SDiv: {
    SDivExpr *de = cast<SDivExpr>(e);
    Z3ASTHandle left = construct(de->left, width_out);
    assert(*width_out != 1 && "uncanonicalized sdiv");
    Z3ASTHandle right = construct(de->right, width_out);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsdiv(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::URem: {
    URemExpr *de = cast<URemExpr>(e);
    Z3ASTHandle left = construct(de->left, width_out);
    assert(*width_out != 1 && "uncanonicalized urem");

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(de->right)) {
      if (CE->getWidth() <= 64) {
        uint64_t divisor = CE->getZExtValue();

        if (bits64::isPowerOfTwo(divisor)) {
          // FIXME: This should be unsigned but currently needs to be signed to
          int bits = bits64::indexOfSingleBit(divisor);

          if (bits == 0) {
            return bvZero(*width_out);
          } else {
            assert(*width_out > bits && "invalid width_out");
            return Z3ASTHandle(Z3_mk_concat(ctx, bvZero(*width_out - bits),
                                            bvExtract(left, bits - 1, 0)),
                               ctx);
          }
        }
      }
    }

    Z3ASTHandle right = construct(de->right, width_out);
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvurem(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  case Expr::SRem: {
    SRemExpr *de = cast<SRemExpr>(e);
    Z3ASTHandle left = construct(de->left, width_out);
    Z3ASTHandle right = construct(de->right, width_out);
    assert(*width_out != 1 && "uncanonicalized srem");
    // LLVM's srem instruction says that the sign follows the dividend
    Z3ASTHandle result = Z3ASTHandle(Z3_mk_bvsrem(ctx, left, right), ctx);
    assert(getBVLength(result) == static_cast<unsigned>(*width_out) &&
           "width mismatch");
    return result;
  }

  // Bitwise
  case Expr::Not: {
    NotExpr *ne = cast<NotExpr>(e);
    Z3ASTHandle expr = construct(ne->expr, width_out);
    if (*width_out == 1) {
      return notExpr(expr);
    } else {
      return bvNotExpr(expr);
    }
  }

  case Expr::And: {
    AndExpr *ae = cast<AndExpr>(e);
    Z3ASTHandle left = construct(ae->left, width_out);
    Z3ASTHandle right = construct(ae->right, width_out);
    if (*width_out == 1) {
      return andExpr(left, right);
    } else {
      return bvAndExpr(left, right);
    }
  }

  case Expr::Or: {
    OrExpr *oe = cast<OrExpr>(e);
    Z3ASTHandle left = construct(oe->left, width_out);
    Z3ASTHandle right = construct(oe->right, width_out);
    if (*width_out == 1) {
      return orExpr(left, right);
    } else {
      return bvOrExpr(left, right);
    }
  }

  case Expr::Xor: {
    XorExpr *xe = cast<XorExpr>(e);
    Z3ASTHandle left = construct(xe->left, width_out);
    Z3ASTHandle right = construct(xe->right, width_out);

    if (*width_out == 1) {
      return iteExpr(left, Z3ASTHandle(notExpr(right)), right);
    } else {
      return bvXorExpr(left, right);
    }
  }

  case Expr::Shl: {
    ShlExpr *se = cast<ShlExpr>(e);
    Z3ASTHandle left = construct(se->left, width_out);
    assert(*width_out != 1 && "uncanonicalized shl");

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(se->right)) {
      return bvLeftShift(left, (unsigned)CE->getLimitedValue());
    } else {
      int shiftWidth;
      Z3ASTHandle amount = construct(se->right, &shiftWidth);
      return bvVarLeftShift(left, amount);
    }
  }

  case Expr::LShr: {
    LShrExpr *lse = cast<LShrExpr>(e);
    Z3ASTHandle left = construct(lse->left, width_out);
    assert(*width_out != 1 && "uncanonicalized lshr");

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(lse->right)) {
      return bvRightShift(left, (unsigned)CE->getLimitedValue());
    } else {
      int shiftWidth;
      Z3ASTHandle amount = construct(lse->right, &shiftWidth);
      return bvVarRightShift(left, amount);
    }
  }

  case Expr::AShr: {
    AShrExpr *ase = cast<AShrExpr>(e);
    Z3ASTHandle left = construct(ase->left, width_out);
    assert(*width_out != 1 && "uncanonicalized ashr");

    if (ConstantExpr *CE = dyn_cast<ConstantExpr>(ase->right)) {
      unsigned shift = (unsigned)CE->getLimitedValue();
      Z3ASTHandle signedBool = bvBoolExtract(left, *width_out - 1);
      return constructAShrByConstant(left, shift, signedBool);
    } else {
      int shiftWidth;
      Z3ASTHandle amount = construct(ase->right, &shiftWidth);
      return bvVarArithRightShift(left, amount);
    }
  }

  // Comparison

  case Expr::Eq: {
    EqExpr *ee = cast<EqExpr>(e);
    Z3ASTHandle left = construct(ee->left, width_out);
    Z3ASTHandle right = construct(ee->right, width_out);
    if (*width_out == 1) {
      if (ConstantExpr *CE = dyn_cast<ConstantExpr>(ee->left)) {
        if (CE->isTrue())
          return right;
        return notExpr(right);
      } else {
        return iffExpr(left, right);
      }
    } else {
      *width_out = 1;
      return eqExpr(left, right);
    }
  }

  case Expr::Ult: {
    UltExpr *ue = cast<UltExpr>(e);
    Z3ASTHandle left = construct(ue->left, width_out);
    Z3ASTHandle right = construct(ue->right, width_out);
    assert(*width_out != 1 && "uncanonicalized ult");
    *width_out = 1;
    return bvLtExpr(left, right);
  }

  case Expr::Ule: {
    UleExpr *ue = cast<UleExpr>(e);
    Z3ASTHandle left = construct(ue->left, width_out);
    Z3ASTHandle right = construct(ue->right, width_out);
    assert(*width_out != 1 && "uncanonicalized ule");
    *width_out = 1;
    return bvLeExpr(left, right);
  }

  case Expr::Slt: {
    SltExpr *se = cast<SltExpr>(e);
    Z3ASTHandle left = construct(se->left, width_out);
    Z3ASTHandle right = construct(se->right, width_out);
    assert(*width_out != 1 && "uncanonicalized slt");
    *width_out = 1;
    return sbvLtExpr(left, right);
  }

  case Expr::Sle: {
    SleExpr *se = cast<SleExpr>(e);
    Z3ASTHandle left = construct(se->left, width_out);
    Z3ASTHandle right = construct(se->right, width_out);
    assert(*width_out != 1 && "uncanonicalized sle");
    *width_out = 1;
    return sbvLeExpr(left, right);
  }

// unused due to canonicalization
#if 0
  case Expr::Ne:
  case Expr::Ugt:
  case Expr::Uge:
  case Expr::Sgt:
  case Expr::Sge:
#endif

  default:
    assert(0 && "unhandled Expr type");
    return getTrue();
  }
}
}
#endif // ENABLE_Z3
