import ast
from sxia.ast_ext.cfg import CFGBuilder, CFG, BasicBlock
import unittest


class TestCFGBuilder(unittest.TestCase):
    def test_cfgbuilder_simple_function(self):
        code = """
def foo(x):
    y = x + 1
    return y
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "foo")
        self.assertEqual(len(cfg.blocks), 1)
        self.assertIsInstance(cfg.blocks[0], BasicBlock)
        self.assertEqual(len(cfg.blocks[0].statements), 2)

    def test_cfgbuilder_entry_block(self):
        code = """
def bar():
    pass
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(len(cfg.blocks), 1)
        entry_block = cfg.blocks[0]
        self.assertIsInstance(entry_block, BasicBlock)
        self.assertEqual(entry_block.id, 0)
        self.assertIsNone(entry_block.successors)
        self.assertIsNone(entry_block.predecessors)

    def test_cfgbuilder_if(self):
        code = """
def baz(a):
    if a > 0:
        return 1
    else:
        return -1
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "baz")
        self.assertEqual(len(cfg.blocks), 3)

    def test_cfgbuilder_multiple_ifs(self):
        code = """
def multi_if(x):
    if y > 1:        # block 0
        b = 2        # block 1
        if z > 2:    
            c = 3    # block 2
                     # block 3
    d = 4            # block 4
    return 3
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "multi_if")
        self.assertEqual(len(cfg.blocks), 5)
        block0 = cfg.blocks[0]
        self.assertEqual(len(block0.successors), 2)
        block1 = block0.successors[0]
        block4 = block0.successors[1]
        self.assertEqual(len(block1.successors), 2)
        block2 = block1.successors[0]
        self.assertEqual(len(block2.successors), 1)
        self.assertIsNone(block4.successors)

    def test_cfgbuilder_for_loop(self):
        code = """
def sum_list(lst):
    total = 0
    for x in lst:
        total += x
    return total 
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "sum_list")
        self.assertIsInstance(cfg, CFG)
        self.assertTrue(any(isinstance(block, BasicBlock) for block in cfg.blocks))
        self.assertGreater(len(cfg.blocks), 1)
        self.assertTrue(
            any(
                any(isinstance(stmt, ast.For) for stmt in (block.statements or []))
                for block in cfg.blocks
            )
        )

    def test_cfgbuilder_if_elif_else(self):
        code = """
def cond(x):
    if x == 1:
        return "one"
    elif x == 2:
        return "two"
    else:
        return "other"
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "cond")
        self.assertTrue(any(isinstance(block, BasicBlock) for block in cfg.blocks))
        self.assertGreaterEqual(len(cfg.blocks), 3)
        self.assertTrue(
            any(
                any(isinstance(stmt, ast.If) for stmt in (block.statements or []))
                for block in cfg.blocks
            )
        )

    def test_cfgbuilder_nested_loops(self):
        code = """
def nested(n):
    for i in range(n):
        while i < n:
            i += 1
    return i
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "nested")
        self.assertTrue(any(isinstance(block, BasicBlock) for block in cfg.blocks))
        self.assertGreater(len(cfg.blocks), 2)
        self.assertTrue(
            any(
                any(
                    isinstance(stmt, ast.For) or isinstance(stmt, ast.While)
                    for stmt in (block.statements or [])
                )
                for block in cfg.blocks
            )
        )

    def test_cfgbuilder_empty_function(self):
        code = """
def empty():
    pass
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "empty")
        self.assertEqual(len(cfg.blocks), 1)
        self.assertIsInstance(cfg.blocks[0], BasicBlock)
        self.assertTrue(
            cfg.blocks[0].statements is None or len(cfg.blocks[0].statements) == 1
        )

    def test_cfgbuilder_multiple_returns(self):
        code = """
def multi(x):
    if x > 0:
        return 1
    return 0
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "multi")
        self.assertTrue(any(isinstance(block, BasicBlock) for block in cfg.blocks))
        self.assertTrue(
            any(
                any(isinstance(stmt, ast.Return) for stmt in (block.statements or []))
                for block in cfg.blocks
            )
        )

    def test_cfgbuilder_call(self):
        code = """
def caller():
    a = 1
    b = 2
    c = callee(a, b)
    d = c + 1
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "caller")
        self.assertEqual(len(cfg.blocks), 2)
        self.assertIsInstance(cfg.blocks[0].statements[-1], ast.Assign)
        self.assertIsInstance(cfg.blocks[0].statements[-1].value, ast.Call)
        self.assertIsInstance(cfg.blocks[1].statements[0], ast.Assign)
        self.assertFalse(isinstance(cfg.blocks[1].statements[0], ast.Call))

    def test_cfgbuilder_call1(self):
        code = """
def caller():
    a = 1
    b = 2
    c = callee(a, b)
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "caller")
        self.assertEqual(len(cfg.blocks), 1)
        self.assertIsInstance(cfg.blocks[0].statements[-1], ast.Assign)
        self.assertIsInstance(cfg.blocks[0].statements[-1].value, ast.Call)

    def test_cfgbuilder_method_call(self):
        code = """

def method(self):
    a = 1
    b = 2
    c = a.callee(b)
    d = c + 1
"""
        tree = ast.parse(code)
        func_node = tree.body[0]
        builder = CFGBuilder(func_node)
        cfg = builder.build()
        self.assertEqual(cfg.func_name, "method")
        self.assertEqual(len(cfg.blocks), 2)
        self.assertIsInstance(cfg.blocks[0].statements[-1], ast.Assign)
        self.assertIsInstance(cfg.blocks[0].statements[-1].value, ast.Call)
        self.assertIsInstance(cfg.blocks[1].statements[0], ast.Assign)
        self.assertFalse(isinstance(cfg.blocks[1].statements[0], ast.Call))
