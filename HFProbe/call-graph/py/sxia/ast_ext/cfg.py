import ast


class BasicBlock:
    def __init__(self, id: int, statement: ast.stmt = None):
        self.id = id
        self.statements: list[ast.stmt] = [statement] if statement is not None else None
        self.successors: "list[BasicBlock]" = None
        self.predecessors: "list[BasicBlock]" = None

    def add_statement(self, statement: ast.stmt):
        """
        Add a statement to the current block.
        """
        if self.statements is None:
            self.statements = []
        self.statements.append(statement)

    def add_successor(self, block: "BasicBlock"):
        """
        Add a successor block to the current block.
        """
        if self.successors is None:
            self.successors = []
        self.successors.append(block)

    def add_predecessor(self, block: "BasicBlock"):
        """
        Add a predecessor block to the current block.
        """
        if self.predecessors is None:
            self.predecessors = []
        self.predecessors.append(block)

    def remove_successor(self, block: "BasicBlock"):
        """
        Remove a successor block from the current block.
        """
        if self.successors is not None:
            self.successors.remove(block)

    def remove_predecessor(self, block: "BasicBlock"):
        """
        Remove a predecessor block from the current block.
        """
        if self.predecessors is not None:
            self.predecessors.remove(block)

    def __hash__(self):
        return self.id


class CFG:
    def __init__(self, func_name: str, entry_block: BasicBlock):
        self.func_name = func_name
        self.entry_block = entry_block
        self.blocks = [entry_block]
        self.exit_blocks = []

    def add_block(self, block: BasicBlock):
        """
        Add a block to the CFG.
        """
        self.blocks.append(block)


class CachedCFGBuilder:
    def __init__(self):
        self._cache = {}

    def get_cfg(self, node: ast.FunctionDef) -> CFG:
        """
        Get the CFG for a function node, using a cache to avoid
        redundant computations.
        """
        if node in self._cache:
            return self._cache[node]
        builder = CFGBuilder(node)
        cfg = builder.build()
        self._cache[node] = cfg
        return cfg


class CFGBuilder(ast.NodeVisitor):
    def __init__(self, node: ast.FunctionDef):
        super().__init__()
        self._node = node
        self._id = 0
        self._cfg = None
        self._block = None
        self._nested_after_ifs = []

    def _new_block(self, statement: ast.stmt = None) -> BasicBlock:
        """
        Create a new basic block with a unique ID.
        """
        block = BasicBlock(id=self._id, statement=statement)
        self._id += 1
        if self._cfg is not None:
            self._cfg.add_block(block)
        return block

    def _add_successor(self, block: BasicBlock, successor: BasicBlock):
        """
        Add a successor block to the current block.
        """
        block.add_successor(successor)
        successor.add_predecessor(block)

    def build(self) -> CFG:
        """
        Build the control flow graph (CFG) for the function.
        """
        entry_block = self._new_block()
        self._cfg = CFG(func_name=self._node.name, entry_block=entry_block)
        self._block = entry_block
        self.visit(self._node)
        self._clean_cfg()
        return self._cfg

    def _clean_cfg(self):
        """
        Clean the CFG by removing empty blocks
        """
        for block in self._cfg.blocks:
            if (
                (block.statements is None or len(block.statements) == 0)
                and (block.successors is None or len(block.successors) == 0)
            ) and block != self._cfg.entry_block:
                self._cfg.blocks.remove(block)
                for pre in block.predecessors:
                    pre.remove_successor(block)

    # AST Node Visitor Methods

    def visit_Assign(self, node: ast.Assign):
        self.generic_visit(node)
        self._block.add_statement(node)
        # if the assignment rhs is a function call, we should create a new block after it
        if isinstance(node.value, ast.Call):
            call_block = self._new_block()
            self._add_successor(self._block, call_block)
            self._block = call_block

    def visit_Return(self, node):
        self.generic_visit(node)
        self._block.add_statement(node)

    def visit_Expr(self, node: ast.Expr):
        self.generic_visit(node)
        self._block.add_statement(node)

    def visit_If(self, node: ast.If):
        self.visit(node.test)
        self._block.add_statement(node)
        if_block = self._block

        true_block = self._new_block()
        afterif_block = self._new_block()
        self._nested_after_ifs.append(afterif_block)

        self._add_successor(if_block, true_block)
        self._block = true_block
        for child in node.body:
            self.visit(child)
        self._add_successor(self._block, afterif_block)

        if node.orelse:
            false_block = self._new_block()
            self._add_successor(if_block, false_block)
            self._block = false_block
            for child in node.orelse:
                self.visit(child)
            self._add_successor(self._block, afterif_block)
        else:
            self._add_successor(if_block, afterif_block)

        self._nested_after_ifs.pop()
        self._block = afterif_block

    def visit_While(self, node: ast.While):
        self.visit(node.test)
        self._block.add_statement(node)
        beforewhile_block = self._block

        body_block = self._new_block()
        afterwhile_block = self._new_block()

        self._add_successor(beforewhile_block, body_block)
        self._block = body_block
        for child in node.body:
            self.visit(child)
        self._add_successor(self._block, afterwhile_block)

        if node.orelse:
            else_block = self._new_block()
            self._add_successor(beforewhile_block, else_block)
            self._block = else_block
            for child in node.orelse:
                self.visit(child)
            self._add_successor(self._block, afterwhile_block)

        self._block = afterwhile_block

    def visit_For(self, node: ast.For):
        self.visit(node.target)
        self.visit(node.iter)
        self._block.add_statement(node)
        beforefor_block = self._block

        body_block = self._new_block()
        afterfor_block = self._new_block()

        self._add_successor(beforefor_block, body_block)
        self._block = body_block
        for child in node.body:
            self.visit(child)
        self._add_successor(self._block, afterfor_block)

        if node.orelse:
            else_block = self._new_block()
            self._add_successor(beforefor_block, else_block)
            self._block = else_block
            for child in node.orelse:
                self.visit(child)
            self._add_successor(self._block, afterfor_block)

        self._block = afterfor_block
