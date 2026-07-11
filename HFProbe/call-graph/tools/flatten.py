#!/usr/bin/env python3
import ast
import astor  # fallback if you're using Python <3.9 and no ast.unparse
import shutil
import argparse
import os


class NestedFlattener(ast.NodeTransformer):
    def __init__(self):
        self.temp_counter = 0

    def flatten_block(self, stmts, stmt_flattener):
        new_block = []
        for stmt in stmts:
            if stmt is None:
                continue
            if isinstance(stmt, ast.For):
                if stmt.iter is not None:
                    stmt.iter, new_assigns = stmt_flattener(stmt.iter)
                new_block.extend(new_assigns)
                # Flatten the body of the for loop
                stmt.body = self.flatten_block(
                    stmt.body, stmt_flattener
                )  # Pass the custom flattener for nested calls

                new_block.append(stmt)
            elif isinstance(stmt, ast.While):
                # Flatten the body of the while loop
                stmt.body = self.flatten_block(stmt.body, stmt_flattener)
                new_block.append(stmt)
            elif isinstance(stmt, ast.If):
                stmt.body = self.flatten_block(stmt.body, stmt_flattener)
                stmt.orelse = self.flatten_block(stmt.orelse, stmt_flattener)
                new_block.append(stmt)
            elif isinstance(stmt, ast.With):
                stmt.body = self.flatten_block(stmt.body, stmt_flattener)
                new_block.append(stmt)
            elif isinstance(stmt, ast.Try):
                stmt.body = self.flatten_block(stmt.body, stmt_flattener)
                stmt.orelse = self.flatten_block(stmt.orelse, stmt_flattener)
                stmt.finalbody = self.flatten_block(stmt.finalbody, stmt_flattener)
                new_block.append(stmt)
            elif isinstance(stmt, ast.FunctionDef) or isinstance(
                stmt, ast.AsyncFunctionDef
            ):
                new_block.append(self.visit(stmt))

            else:
                new_stmt, new_assigns = stmt_flattener(stmt)
                new_block.extend(new_assigns)
                new_block.append(new_stmt)
        return new_block

    def _flat_nested_calls(self, stmt):
        call_flattener = _SingleStatementNestedCallFlattener(self.temp_counter)
        new_stmt = call_flattener.visit(stmt)
        self.temp_counter = call_flattener.temp_counter
        return (new_stmt, call_flattener.new_assignments)

    def _flat_nested_if(self, stmt):
        if_flattener = _SingleStatementNestedIfFlattener(self.temp_counter)
        new_stmt = if_flattener.visit(stmt)
        self.temp_counter = (
            if_flattener.temp_counter
        )  # Update temp counter from the if flattener
        return (new_stmt, if_flattener.new_assignments)

    def _flat_continued_calls(self, stmt):
        call_flattener = _SingleStmtContinuedCallFlattener(self.temp_counter)
        new_stmt = call_flattener.visit(stmt)
        self.temp_counter = call_flattener.temp_counter
        return (new_stmt, call_flattener.new_assignments)

    def visit_FunctionDef(self, node):
        node.body = self.flatten_block(node.body, self._flat_nested_calls)
        node.body = self.flatten_block(node.body, self._flat_nested_if)
        node.body = self.flatten_block(node.body, self._flat_continued_calls)
        return node

    def visit_AsyncFunctionDef(self, node):
        node.body = self.flatten_block(node.body, self._flat_nested_calls)
        node.body = self.flatten_block(node.body, self._flat_nested_if)
        node.body = self.flatten_block(node.body, self._flat_continued_calls)
        return node


class _SingleStmtContinuedCallFlattener(ast.NodeTransformer):
    """aaa().bbb().ccc() -> a1 = aaa(); a2 = a1.bbb(); a3 = a2.ccc()"""

    def __init__(self, temp_counter):
        self.temp_counter = temp_counter
        self.new_assignments = []

    def visit_Call(self, node):
        if isinstance(node.func, ast.Attribute):
            if isinstance(node.func.value, ast.Call):
                new_temp_var = f"_temp{self.temp_counter}"
                new_temp_name = ast.Name(id=new_temp_var, ctx=ast.Store())
                new_assign = ast.Assign(
                    targets=[new_temp_name],
                    value=node.func.value,
                )
                self.temp_counter += 1
                self.new_assignments.append(new_assign)
                node.func.value = new_temp_name
        super().generic_visit(node)

        return node


class _SingleStatementNestedCallFlattener(ast.NodeTransformer):
    """aaa(bbb()) ->
    temp1 = bbb()
    aaa(temp1)
    """

    def __init__(self, temp_counter):
        self.temp_counter = temp_counter
        self.new_assignments = []

    def handle_arg_expr(self, node: ast.expr):
        if (
            isinstance(node, ast.Name)
            or isinstance(node, ast.Constant)
            or isinstance(node, ast.Attribute)
            or isinstance(node, ast.Starred)
        ):
            return node
        temp_var = f"_temp{self.temp_counter}"
        self.temp_counter += 1

        assign = ast.Assign(
            targets=[ast.Name(id=temp_var, ctx=ast.Store())], value=node
        )
        self.new_assignments.append(assign)

        temp_node = ast.Name(id=temp_var, ctx=ast.Load())
        return temp_node

    def visit_Call(self, node):
        for i, arg in enumerate(node.args):
            node.args[i] = self.handle_arg_expr(arg)
        super().generic_visit(
            node
        )  # Ensure we visit other parts of the node (like keywords)
        return node


class _SingleStatementNestedIfFlattener(ast.NodeTransformer):
    """aaa(b if xxx else c)
    -> if xxx:
           arg0 = b
        else
            arg0 = c

    Args:
        ast (_type_): _description_
    """

    def __init__(self, temp_counter):
        self.temp_counter = temp_counter
        self.new_assignments = []

    def _handle_expr(self, node: ast.expr):
        if isinstance(node, ast.Assign):
            if not isinstance(node.value, ast.IfExp):
                return node

            # temp_var = f"_temp_if{self.temp_counter}"
            # self.temp_counter += 1
            new_if = ast.If(
                node.value.test,
                body=[ast.Assign(targets=node.targets, value=node.value.body)],
                orelse=[ast.Assign(targets=node.targets, value=node.value.orelse)],
            )

            self.new_assignments.append(new_if)

            return None

        return node

    def visit_Assign(self, node):
        super().generic_visit(node)
        return self._handle_expr(node)


def flatten_file(filename, in_place=False):
    with open(filename, "r") as f:
        source = f.read()

    tree = ast.parse(source)
    new_body = []

    for stmt in tree.body:
        flattener = NestedFlattener()
        result = flattener.visit(stmt)
        if isinstance(result, list):
            new_body.extend(result)
        else:
            new_body.append(result)

    tree.body = new_body
    try:
        new_source = ast.unparse(tree)
    except AttributeError:
        new_source = astor.to_source(tree)

    if in_place:
        shutil.copyfile(filename, filename + ".bak")
        with open(filename, "w") as f:
            f.write(new_source)
    else:
        output_file = filename.replace(".py", "_flattened.py")
        with open(output_file, "w") as f:
            f.write(new_source)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Flatten nested statements in Python code."
    )
    parser.add_argument(
        "filename", type=str, help="Path/Directory to the Python file(s) to flatten."
    )
    parser.add_argument(
        "--in-place",
        action="store_true",
        help="If set, overwrite the original file with the flattened code.",
    )
    args = parser.parse_args()
    if args.filename.endswith(".py"):
        flatten_file(args.filename, in_place=args.in_place)
    else:
        for root, _, files in os.walk(args.filename):
            for file in files:
                if file.endswith(".py"):
                    flatten_file(os.path.join(root, file), in_place=args.in_place)
