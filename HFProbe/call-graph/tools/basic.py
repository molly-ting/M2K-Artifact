import ast
from dataclasses import asdict, dataclass
import json
from typing import Optional
import graphviz

from sxia.type_info import TypeInfo, TypeInfoCollector


@dataclass
class Callsite:
    name: str
    actual_args: list[str]
    actual_kwargs: dict[str, str]
    lineno: int


@dataclass
class CGFunction:
    # should be the full name of the function
    # e.g. torch.nn.functional.relu
    # e.g  SomeClass.some_method
    name: str
    formal_args: list[str]
    calls: list[Callsite]


class ImportInfoCollector(ast.NodeVisitor):
    def __init__(self):
        self.ns = {}

    def visit_ImportFrom(self, node):
        for alias in node.names:
            self.ns[alias.asname or alias.name] = f"{node.module}.{alias.name}"
        self.generic_visit(node)

    def visit_Import(self, node):
        for alias in node.names:
            self.ns[alias.asname or alias.name] = alias.name
        self.generic_visit(node)


class CallsiteCollector(ast.NodeVisitor):
    """
    Collects function definitions and their call sites within a Python module.
    - self._functions maps fully-qualified function names -> CGFunction
    """

    def __init__(self, ns):
        """
        Args:
            ty_ctx (_type_, optional): _description_. Defaults to None.
        """
        # Holds CGFunctions keyed by their 'full' name (e.g. "ClassName.method")
        self._functions: dict[str, CGFunction] = {}
        self._global_callsites: list[Callsite] = []
        # Stack of class names to build qualified function names (e.g. MyClass.my_method)
        self._ns_stack: list = []
        # name space of the module
        # e.g. import torch.nn.functional.relu, then relu => torch.nn.functional.relu
        # used to resolve the function name to fully qualified name, nn.abc => torch.nn.abc
        self.ns = ns

    def _get_stack_names(self):
        """
        Get the names of the classes in the stack.
        """
        return [node.name for node in self._ns_stack]

    def visit_ClassDef(self, node: ast.ClassDef):
        """
        When we enter a class, push its name onto the class stack,
        collect any methods within, then pop the stack.
        """
        self._ns_stack.append(node)
        self.generic_visit(node)
        self._ns_stack.pop()

    def visit_FunctionDef(self, node: ast.FunctionDef):
        """
        Collect basic information about function definitions.
        Build a fully-qualified name if it's inside a class, e.g. ClassName.function.
        """
        full_name = ".".join(self._get_stack_names() + [node.name])

        # Extract the formal argument names
        # (You could also look at defaults, vararg, kwarg, etc. if you need more detail.)
        formal_args = [arg.arg for arg in node.args.args]

        # Create and store the CGFunction object
        cgf = CGFunction(name=full_name, formal_args=formal_args, calls=[])
        self._functions[full_name] = cgf

        self._ns_stack.append(cgf)

        # Continue visiting children (in case of nested functions, etc.)
        self.generic_visit(node)
        self._ns_stack.pop()

    def visit_Call(self, node: ast.Call):
        """
        Every time we see a call, we try to resolve the function name (naively).
        If the function name is recognized (i.e. matches one of our known definitions),
        record a Callsite in the corresponding CGFunction's calls list.
        """
        func_name = self._get_func_name(node.func)

        # Build actual args (as string)
        actual_args = [ast.unparse(arg) for arg in node.args]

        # Build actual kwargs (as string)
        actual_kwargs = {}
        for kw in node.keywords:
            # kw.arg is the name, but can be None if it's a **kwargs expansion
            if kw.arg is not None:
                actual_kwargs[kw.arg] = ast.unparse(kw.value)

        # Create a Callsite and attach it to the function
        callsite = Callsite(
            name=func_name,
            actual_args=actual_args,
            actual_kwargs=actual_kwargs,
            lineno=node.lineno,
        )
        if self._ns_stack:
            self._ns_stack[-1].calls.append(callsite)
        else:
            # If we are not in a function, add to global callsites
            self._global_callsites.append(callsite)
        # Continue traversing the AST
        self.generic_visit(node)

    def _get_func_name(self, func_node: ast.expr) -> Optional[str]:
        """
        Attempt to build a dotted name for the called function:
          - For a bare name like 'foo', returns 'foo'.
          - For an attribute like 'module.submodule.func', returns 'module.submodule.func'.
        This is naive in that it doesn't do any real type inference, so e.g. 'self.my_method'
        is not automatically turned into 'MyClass.my_method' unless the 'self' is recognized
        as 'MyClass' explicitly.
        """
        if isinstance(func_node, ast.Name):
            return func_node.id
        elif isinstance(func_node, ast.Attribute):
            return self._resolve_attribute_chain(func_node)
        return None

    def _resolve_attribute_chain(self, node: ast.Attribute) -> str:
        """
        Recursively build the dotted name from an Attribute node:
           e.g. something like ast for 'torch.nn.functional.relu' would reconstruct
           'torch.nn.functional.relu'
        """
        parts = []
        current = node
        first_self = True
        while isinstance(current, ast.Attribute):
            parts.append(current.attr)
            current = current.value
        if isinstance(current, ast.Name):
            if current.id == "self" and first_self:
                first_self = False
                # If we see 'self' in the attribute chain, we need to look it up
                # in the current class context.
                if self._ns_stack:
                    # Get the current class name
                    class_name = self._ns_stack[-2].name
                    parts.append(class_name)
                else:
                    # If we are not in a class, just use 'self'
                    parts.append("self")
            else:
                parts.append(current.id)
        parts.reverse()
        return ".".join(parts)


def find_paths(
    collector: CallsiteCollector, start: str, end: str
) -> list[list[Callsite]]:
    """Run a BFS to find all paths from start to end in the call graph."""

    paths = []
    queue = [(start, [start])]
    visited = set()
    while queue:
        current, path = queue.pop(0)
        visited.add(current)

        # Check if we reached the end
        if current == end:
            paths.append(path)
            continue

        if current not in collector._functions:
            continue
        # Explore neighbors (i.e., functions called by the current function)
        for callsite in collector._functions[current].calls:
            callee = callsite.name
            if callee not in visited:
                queue.append((callee, path + [callee]))
                visited.add(callee)
    return paths


def to_graphviz(collector: CallsiteCollector) -> graphviz.Digraph:
    """
    Build and return a graphviz Digraph representing the call graph.
    Each function is a node; each call is an edge from caller to callee.
    """
    dot = graphviz.Digraph(comment="Call Graph")

    # Create a node for each function
    for func_name in collector._functions:
        dot.node(func_name, label=func_name)

    # Create edges from caller to callee
    for func_name, cg_func in collector._functions.items():
        for callsite in cg_func.calls:
            caller_name = func_name
            callee_name = callsite.name
            dot.edge(caller_name, callee_name)

    return dot


def generate_png(dot_graph: graphviz.Digraph, output_filename: str):
    """
    Render the given graphviz Digraph to a PNG file.

    :param dot_graph: graphviz.Digraph to be rendered
    :param output_filename: Output filename without extension (e.g. 'mycallgraph')
                           A '.png' will be appended automatically.
    """
    # 'cleanup=True' removes the intermediate .gv file after rendering
    dot_graph.render(filename=output_filename, format="png", cleanup=True)


def patch_call_graph_with_type_info(
    collector: CallsiteCollector, ty_info: dict[str, dict]
):
    """
    Patch the call graph with type information.
    class A(nn.Module):
        pass

    Class B(nn.Module):
        def __init__(self):
            self.a = A()

        def forward(self, x):
            self.a(x)

    Before:
    B.forward
      B.a (...)

    After:
    B.forward
      A.forward (...)
    """
    for func_name, cg_func in collector._functions.items():
        for callsite in cg_func.calls:
            callee_name = callsite.name
            parts = callee_name.split(".")
            if len(parts) == 2:
                self_cls_name, method_or_attr_name = parts
                # Replace the callsite with the type info
                if self_cls_name not in ty_info:
                    continue
                self_cls_ty = ty_info[self_cls_name]
                if method_or_attr_name not in self_cls_ty:
                    continue
                method_or_attr_ty = self_cls_ty[method_or_attr_name]
                if not isinstance(method_or_attr_ty, TypeInfo):
                    continue
                if method_or_attr_ty.ty in ty_info:
                    # means it is a class instance call
                    new_callee_name = f"{method_or_attr_ty.ty}.forward"
                    callsite.name = new_callee_name
            elif len(parts) == 1:
                # means it is a global function call or a function-level variable call
                caller_parts = func_name.split(".")
                if len(caller_parts) == 2:
                    # means it is called in a class method
                    cls_ty = ty_info[caller_parts[0]]
                    fn_ty = cls_ty.get(caller_parts[1], None)
                    if callee_name in fn_ty:
                        callee_ty = fn_ty[callee_name]
                        if callee_ty.ty in ty_info:
                            new_callee_name = f"{callee_ty.ty}.forward"
                            callsite.name = new_callee_name


if __name__ == "__main__":
    import ast
    import sys

    if len(sys.argv) < 2:
        print("Usage: python basic.py <python_file>")
        sys.exit(1)

    filename = sys.argv[1]
    with open(filename, "r") as f:
        source_code = f.read()

    tree = ast.parse(source_code)
    ns_collector = ImportInfoCollector()
    ns_collector.visit(tree)
    ns = ns_collector.ns
    collector = CallsiteCollector(ns)
    collector.visit(tree)

    ty_info = TypeInfoCollector(ns)
    ty_info.visit(tree)

    for k, v in ty_info.tys.items():
        for k1, v1 in v.items():
            if isinstance(v1, TypeInfo):
                print(f"{k}.{k1}: {v1}")
            else:
                for k2, v2 in v1.items():
                    print(f"{k}.{k1}.{k2}: {v2}")

    patch_call_graph_with_type_info(collector, ty_info.tys)

    dot_graph = to_graphviz(collector)
    generate_png(dot_graph, "call_graph")
    print("Call graph generated as call_graph.png")

    paths = find_paths(
        collector,
        "QWenLMHeadModel.forward",
        "QWenAttention.cache_kernels.vecquant8matmul_batched_column_compression_faster_old",
    )

    for path in paths:
        print("Path found:")
        for callsite in path:
            print(f"  {callsite}")
        print()
