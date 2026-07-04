import ast

from sxia.value import ClassInstanceValue, CppBindingValue


class CppBindingHelper(ast.NodeVisitor):
    """
    Function-level visitor to find C++ binding module assignment in a function
    """

    def __init__(self, target_modules: list[str], self_value: ClassInstanceValue):
        self._target_modules = target_modules
        self._self_value = self_value
        self._ns = {}

    def visit_ImportFrom(self, node):
        for alias in node.names:
            full_name = f"{node.module}.{alias.name}"
            self._ns[alias.asname or alias.name] = full_name

    def visit_Import(self, node):
        for alias in node.names:
            self._ns[alias.asname or alias.name] = alias.name

    def visit_Assign(self, node):
        if isinstance(node.value, ast.Name):
            if node.value.id in self._ns:
                full_name = self._ns[node.value.id]
                if full_name in self._target_modules:
                    if isinstance(node.targets[0], ast.Attribute):
                        if isinstance(node.targets[0].value, ast.Name):
                            if node.targets[0].value.id == "self":
                                self._self_value.value[node.targets[0].attr] = (
                                    CppBindingValue(node, full_name)
                                )
