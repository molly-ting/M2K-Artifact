//===-- Z3Builder.h --------------------------------------------*- C++ -*-====//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef KLEE_Z3BUILDER_H
#define KLEE_Z3BUILDER_H

#include "klee/Config/config.h"
#include "klee/Expr/ArrayExprHash.h"
#include "klee/Expr/ExprHashMap.h"

#include <unordered_map>
#include <z3.h>

namespace klee {

template <typename T> class Z3NodeHandle {
  // Internally these Z3 types are pointers
  // so storing these should be cheap.
  // It would be nice if we could infer the Z3_context from the node
  // but I can't see a way to do this from Z3's API.
protected:
  T node;
  ::Z3_context context;

private:
  // To be specialised
  inline ::Z3_ast as_ast();

public:
  Z3NodeHandle() : node(NULL), context(NULL) {}
  Z3NodeHandle(const T _node, const ::Z3_context _context)
      : node(_node), context(_context) {
    if (node && context) {
      ::Z3_inc_ref(context, as_ast());
    }
  };
  ~Z3NodeHandle() {
    if (node && context) {
      ::Z3_dec_ref(context, as_ast());
    }
  }
  Z3NodeHandle(const Z3NodeHandle &b) : node(b.node), context(b.context) {
    if (node && context) {
      ::Z3_inc_ref(context, as_ast());
    }
  }
  Z3NodeHandle &operator=(const Z3NodeHandle &b) {
    if (node == NULL && context == NULL) {
      // Special case for when this object was constructed
      // using the default constructor. Try to inherit a non null
      // context.
      context = b.context;
    }
    assert(context == b.context && "Mismatched Z3 contexts!");
    // node != nullptr ==> context != NULL
    assert((node == NULL || context) &&
           "Can't have non nullptr node with nullptr context");

    if (node && context) {
      ::Z3_dec_ref(context, as_ast());
    }
    node = b.node;
    if (node && context) {
      ::Z3_inc_ref(context, as_ast());
    }
    return *this;
  }
  // To be specialised
  void dump();

  operator T() const { return node; }
};

// Specialise for Z3_sort
template <> inline ::Z3_ast Z3NodeHandle<Z3_sort>::as_ast() {
  // In Z3 internally this call is just a cast. We could just do that
  // instead to simplify our implementation but this seems cleaner.
  return ::Z3_sort_to_ast(context, node);
}
typedef Z3NodeHandle<Z3_sort> Z3SortHandle;
template <> void Z3NodeHandle<Z3_sort>::dump() __attribute__((used));

// Specialise for Z3_ast
template <> inline ::Z3_ast Z3NodeHandle<Z3_ast>::as_ast() { return node; }
typedef Z3NodeHandle<Z3_ast> Z3ASTHandle;
template <> void Z3NodeHandle<Z3_ast>::dump() __attribute__((used));

class Z3ArrayExprHash : public ArrayExprHash<Z3ASTHandle> {

  friend class Z3Builder;

public:
  Z3ArrayExprHash(){};
  virtual ~Z3ArrayExprHash();
  void clear();
};

class Z3Builder {
  ExprHashMap<std::pair<Z3ASTHandle, unsigned> > constructed;
  Z3ArrayExprHash _arr_hash;
  Z3ArrayExprHash _int_arr_hash;
  std::map<std::string, Z3ASTHandle> int_ast_map;
  std::map<std::string, unsigned> intArrNames;
  std::vector<ref<Expr>> noCheckExprs;

private:
  Z3ASTHandle uintConst32(uint32_t value);
  Z3ASTHandle intConst32(int32_t value);
  Z3ASTHandle uintConst64(uint64_t value);
  Z3ASTHandle intConst64(int64_t value);
  Z3ASTHandle realConst(std::string value);
  Z3ASTHandle bvOne(unsigned width);
  Z3ASTHandle bvZero(unsigned width);
  Z3ASTHandle bvMinusOne(unsigned width);
  Z3ASTHandle bvConst32(unsigned width, uint32_t value);
  Z3ASTHandle bvConst64(unsigned width, uint64_t value);
  Z3ASTHandle bvZExtConst(unsigned width, uint64_t value);
  Z3ASTHandle bvSExtConst(unsigned width, uint64_t value);
  Z3ASTHandle bvBoolExtract(Z3ASTHandle expr, int bit);
  Z3ASTHandle bvExtract(Z3ASTHandle expr, unsigned top, unsigned bottom);
  Z3ASTHandle eqExpr(Z3ASTHandle a, Z3ASTHandle b);

  // logical left and right shift (not arithmetic)
  Z3ASTHandle bvLeftShift(Z3ASTHandle expr, unsigned shift);
  Z3ASTHandle bvRightShift(Z3ASTHandle expr, unsigned shift);
  Z3ASTHandle bvVarLeftShift(Z3ASTHandle expr, Z3ASTHandle shift);
  Z3ASTHandle bvVarRightShift(Z3ASTHandle expr, Z3ASTHandle shift);
  Z3ASTHandle bvVarArithRightShift(Z3ASTHandle expr, Z3ASTHandle shift);

  Z3ASTHandle notExpr(Z3ASTHandle expr);
  Z3ASTHandle bvNotExpr(Z3ASTHandle expr);
  Z3ASTHandle andExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle bvAndExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle orExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle bvOrExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle iffExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle bvXorExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle bvSignExtend(Z3ASTHandle src, unsigned width);

  // Array operations
  Z3ASTHandle writeExpr(Z3ASTHandle array, Z3ASTHandle index,
                        Z3ASTHandle value);
  Z3ASTHandle readExpr(Z3ASTHandle array, Z3ASTHandle index);

  // ITE-expression constructor
  Z3ASTHandle iteExpr(Z3ASTHandle condition, Z3ASTHandle whenTrue,
                      Z3ASTHandle whenFalse);

  // Bitvector length
  unsigned getBVLength(Z3ASTHandle expr);

  // Bitvector comparison
  Z3ASTHandle bvLtExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle bvLeExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle sbvLtExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);
  Z3ASTHandle sbvLeExpr(Z3ASTHandle lhs, Z3ASTHandle rhs);

  Z3ASTHandle constructAShrByConstant(Z3ASTHandle expr, unsigned shift,
                                      Z3ASTHandle isSigned);

  Z3ASTHandle intCStyleDivExpr(Z3ASTHandle left, Z3ASTHandle right);
  Z3ASTHandle intCStyleModExpr(Z3ASTHandle left, Z3ASTHandle right);

  Z3ASTHandle getInitialArray(const Array *os);
  Z3ASTHandle getInitialIntArray(const Array *root, int elementWidth);
  Z3ASTHandle getArrayForUpdate(const Array *root, const UpdateNode *un, bool forInt=false);
  // Z3ASTHandle getIntArrayForUpdate(const Array *root, const UpdateNode *un, int elementWidth);

  Z3ASTHandle readIntExpr(const Array *array);
  Z3ASTHandle constructActualForInt(ref<Expr> e, int *width_out, bool isBitVec=false);
  Z3ASTHandle constructActual(ref<Expr> e, int *width_out);
  Z3ASTHandle construct(ref<Expr> e, int *width_out);
  Z3ASTHandle constructForInt(ref<Expr> e, int *width_out, bool isBitVec=false);

  Z3ASTHandle buildArray(const char *name, unsigned indexWidth,
                         unsigned valueWidth);
  Z3ASTHandle buildIntArray(const char *name);

  Z3SortHandle getIntSort();
  Z3SortHandle getBvSort(unsigned width);
  Z3SortHandle getArraySort(Z3SortHandle domainSort, Z3SortHandle rangeSort);
  bool autoClearConstructCache;
  std::string z3LogInteractionFile;

public:
  Z3_context ctx;
  std::unordered_map<const Array *, std::vector<Z3ASTHandle> >
      constant_array_assertions;
  std::map<std::string, std::vector<Z3ASTHandle>> int_array_bounds;
  bool useInt2BV = false;
  bool useReal = false;
  bool isHandlingQuery = false;
  Z3Builder(bool autoClearConstructCache, const char *z3LogInteractionFile);
  ~Z3Builder();

  Z3ASTHandle getTrue();
  Z3ASTHandle getFalse();
  Z3ASTHandle getInitialRead(const Array *os, unsigned index);
  Z3ASTHandle getIntArrayInitialRead(const Array *root, unsigned index);
  std::pair<Z3ASTHandle, bool> readIntExprInitial(const Array *array);

  Z3ASTHandle constructForBV(ref<Expr> e, std::vector<ref<Expr>> _noCheckExprs, bool isQuery = false) {
    isHandlingQuery = isQuery;
    noCheckExprs = _noCheckExprs;
    Z3ASTHandle res = construct(e, 0);
    if (autoClearConstructCache)
      clearConstructCache();
    isHandlingQuery = false;
    return res;
  }

  Z3ASTHandle constructForInt(ref<Expr> e, std::map<std::string, unsigned> _intArrNames, std::vector<ref<Expr>> _noCheckExprs, bool isQuery = false) {
    isHandlingQuery = isQuery;
    intArrNames = _intArrNames;
    noCheckExprs = _noCheckExprs;
    Z3ASTHandle res = constructForInt(e, 0);
    if (isa<ExtractExpr>(e)) {
      Z3_sort res_sort = Z3_get_sort(ctx, res);
      Z3_sort_kind res_kind = Z3_get_sort_kind(ctx, res_sort);
      if (res_kind == Z3_INT_SORT) {
        res = Z3ASTHandle(Z3_mk_eq(ctx, res, intConst32(1)), ctx);
      } else if (res_kind == Z3_REAL_SORT) {
        res = Z3ASTHandle(Z3_mk_eq(ctx, res, realConst("1")), ctx);
      }
    }
    if (autoClearConstructCache)
      clearConstructCache();
    isHandlingQuery = false;
    return res;
  }

  void clearConstructCache() { 
    constructed.clear(); 
    int_array_bounds.clear();
  }
};
}

#endif /* KLEE_Z3BUILDER_H */
