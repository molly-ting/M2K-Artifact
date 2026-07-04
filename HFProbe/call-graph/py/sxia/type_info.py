import ast
from dataclasses import dataclass
from enum import Enum
from typing import Optional
from ast import (
    NodeVisitor,
    Name,
    Attribute,
    Call,
    FunctionDef,
    ClassDef,
)
import logging

logger = logging.getLogger(__name__)
from sxia.utils.ast import name_or_full_attr


class TypeInfoCategory(str, Enum):
    MODULE = "module"
    CLASS = "class"
    FUNCTION = "function"
    PRIMITIVE = "primitive"


@dataclass
class TensorInfo:
    def __init__(self, shape: tuple, dtype: str):
        self.shape = shape
        self.dtype = dtype

    def size(self, idx):
        if idx >= len(self.shape):
            raise IndexError("Index out of range for shape dimensions.")
        return self.shape[idx]

    def __repr__(self):
        return f"Tensor(shape={self.shape}, dtype={self.dtype})"


@dataclass
class TypeInfo:
    # str, int, torch.Tensor, etc..
    ty: str

    # category: TypeInfoCategory

    optional: bool = False
    callable: bool = False

    # Required if name is list
    item: Optional["TypeInfo"] = None

    # Required if name is tuple
    items: Optional[list["TypeInfo"]] = None

    # Required if name is Callable
    args: Optional[list] = None

    # Required if name is Callable
    return_ty: Optional["TypeInfo"] = None

    # Only available if name is `Tensor` and import_path is `torch``
    tensor_info: Optional[TensorInfo] = None


def resolve_ann(expr: ast.expr) -> TypeInfo:
    """Resolve the type annotation to a string."""

    if isinstance(expr, ast.BinOp) and isinstance(expr.op, ast.BitOr):
        left = resolve_ann(expr.left)
        right = resolve_ann(expr.right)
        if not left.ty:
            right.optional = True
            return right
        if not right.ty:
            left.optional = True
            return left
        return TypeInfo(ty=f"{left.ty} | {right.ty}")

    base_info = TypeInfo(None)
    queue = [expr]

    while queue:
        current = queue.pop(0)
        current_text = None
        if isinstance(current, ast.Name):
            current_text = current.id
        elif isinstance(current, ast.Constant):
            current_text = current.value
        elif isinstance(current, ast.Subscript):
            queue.append(current.value)
            queue.append(current.slice)
        elif isinstance(current, ast.Attribute):
            current_text = name_or_full_attr(current)
        elif isinstance(current, ast.Tuple):
            base_info.ty = "tuple"
            if base_info.callable:
                assert len(current.elts) == 2
                assert isinstance(current.elts[0], ast.List)
                base_info.args = [[resolve_ann(el) for el in current.elts[0].elts]]
                base_info.return_ty = (
                    resolve_ann(current.elts[1]) if len(current.elts) > 1 else None
                )
            else:
                base_info.items = []
                for el in current.elts:
                    queue.append(el)
        elif isinstance(current, ast.List):
            base_info.ty = "list"
            base_info.items = []
            for el in current.elts:
                queue.append(el)
        else:
            raise ValueError(f"Unsupported annotation type: {type(expr)}")

        if current_text is not None:
            if current_text == "Optional":
                base_info.optional = True
            elif current_text == "Callable":
                base_info.callable = True
            else:
                if base_info.ty is None:
                    base_info.ty = current_text
                else:
                    if base_info.items is not None:
                        base_info.items.append(current_text)
                    else:
                        base_info.item = current_text
            current_text = None
    return base_info


class TypeInfoCollector(NodeVisitor):
    """Extract type information from a Python AST.
    <class name>: {
        Keys are:
        <function name>: {
            <arg name>: <type>
        }
        // class's properties (self.yyy = zzz in __init__)
        <property name>: <type>
    }
    """

    def __init__(self, ns):
        super().__init__()
        self._ns_stack: list = []
        self.tys = {
            # keys are the fully qualified names
        }
        self.ns = ns

    # NodeVisitor
    def visit_ClassDef(self, node: ClassDef):
        self.tys[node.name] = {}
        self._ns_stack.append(node)
        self.generic_visit(node)
        self._ns_stack.pop()

    def visit_FunctionDef(self, node: FunctionDef):
        if len(self._ns_stack) != 1:
            return
        cls_name = self._ns_stack[-1].name
        self.tys[cls_name][node.name] = {}
        self._ns_stack.append(node)
        self.generic_visit(node)
        self._ns_stack.pop()

    # def visit_arguments(self, node):
    #     if len(self._ns_stack) < 2:
    #         return
    #     print("current context is", self._ns_stack[-1].name, type(self._ns_stack[-1]))
    #     print("visit_arguments", dump(node, indent=4))
    #     func_name = self._ns_stack[-1].name
    #     cls_name = self._ns_stack[-2].name

    def visit_arg(self, node):
        if len(self._ns_stack) != 2:
            return
        func_name = self._ns_stack[-1].name
        cls_name = self._ns_stack[-2].name
        if node.arg == "self":
            return
        if node.annotation is not None:
            self.tys[cls_name][func_name][node.arg] = resolve_ann(node.annotation)

    def visit_AnnAssign(self, node):
        if len(self._ns_stack) != 2:
            return
        func_name = self._ns_stack[-1].name
        cls_name = self._ns_stack[-2].name
        self.tys[cls_name][func_name][node.target.id] = resolve_ann(node.annotation)

    def visit_Assign(self, node):
        if len(self._ns_stack) != 2:
            return
        func_name = self._ns_stack[-1].name
        cls_name = self._ns_stack[-2].name
        cls_ty = self.tys[cls_name]
        fn_ty = cls_ty[func_name]

        for target in node.targets:
            base_ty = None
            key = None
            if (
                isinstance(target, Attribute)
                and isinstance(target.value, Name)
                and target.value.id == "self"
            ):
                base_ty = cls_ty
                key = target.attr
            elif isinstance(target, Name):
                base_ty = fn_ty
                key = target.id
            else:
                continue

            if isinstance(node.value, Call):
                callee_name = None
                if isinstance(node.value.func, Name):
                    callee_name = node.value.func.id
                elif isinstance(node.value.func, Attribute):
                    callee_name = name_or_full_attr(node.value.func, self.ns)
                else:
                    raise ValueError("Unsupported function call")

                if callee_name == "torch.nn.ModuleList":
                    base_ty[key] = self._resolve_nn_module_list_type(node.value.args)
                else:
                    if callee_name == "zip":
                        print("!")
                    base_ty[key] = TypeInfo(
                        callee_name,
                        args=self._resolve_call_arg_types(node.value),
                    )

            elif isinstance(node.value, Name):
                base_ty[key] = fn_ty.get(node.value.id, TypeInfo("Any"))
            elif isinstance(node.value, ast.ListComp):
                base_ty[key] = TypeInfo("list")
                if isinstance(node.value.elt, ast.Call):
                    base_ty[key].item = TypeInfo(name_or_full_attr(node.value.elt.func))

    def _resolve_call_arg_types(self, node: ast.Call):
        arg_types = []

        for arg in node.args:
            arg_types.append(self._resolve_expr_type(arg))

        return arg_types

    def _resolve_expr_type(self, node: ast.expr) -> TypeInfo:
        if len(self._ns_stack) != 2:
            return TypeInfo("Any")
        func_name = self._ns_stack[-1].name
        cls_name = self._ns_stack[-2].name
        cls_ty = self.tys[cls_name]
        fn_ty = cls_ty[func_name]
        if isinstance(node, ast.Name):
            return fn_ty.get(node.id, TypeInfo("Any"))
        elif isinstance(node, ast.Attribute):
            if isinstance(node.value, Name):
                if node.value.id == "self":
                    return cls_ty.get(node.attr, TypeInfo("Any"))
            else:
                return fn_ty.get(node.attr, TypeInfo("Any"))
        elif isinstance(node, ast.Constant):
            return TypeError(node.value.__class__.__name__)

        return TypeError("Any")

    def _resolve_nn_module_list_type(self, args: list[ast.expr]) -> TypeInfo:
        base = TypeInfo("Any")
        if len(args) != 1:
            logger.warning("ModuleList other than 1 argument is not supported")
            return base
        if isinstance(args[0], ast.ListComp) and isinstance(args[0].elt, ast.Call):
            base = TypeInfo(name_or_full_attr(args[0].elt.func))
        elif isinstance(args[0], ast.Name):
            if len(self._ns_stack) != 2:
                return base
            func_name = self._ns_stack[-1].name
            cls_name = self._ns_stack[-2].name
            fn_ty = self.tys[cls_name][func_name]
            base = fn_ty.get(args[0].id, TypeInfo("Any"))

        return base

    def visit_For(self, node):
        if len(self._ns_stack) != 2:
            return
        func_name = self._ns_stack[-1].name
        cls_name = self._ns_stack[-2].name

        cls_ty = self.tys[cls_name]
        fn_ty = cls_ty[func_name]
        if isinstance(node.iter, Call):
            if isinstance(node.iter.func, Name):
                if node.iter.func.id == "enumerate":
                    arg0 = node.iter.args[0]
                    arg0_ty = self._resolve_expr_type(arg0)
                    if isinstance(node.target, ast.Tuple):
                        # for i, (x, y) in enumerate(...)
                        fn_ty[node.target.elts[0].id] = TypeInfo("int")
                        if isinstance(node.target.elts[1], ast.Tuple):
                            for i, el in enumerate(node.target.elts[1].elts):
                                if isinstance(el, ast.Name):
                                    if arg0_ty.ty == "zip":
                                        fn_ty[el.id] = arg0_ty.args[i].item


@dataclass
class AnalysisContext:
    ty_ctx: dict
