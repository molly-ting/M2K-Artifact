import unittest
from sxia.runner.path import FuncPath
from sxia.analysis_types import TorchCall
from sxia.ast_ext.cfg import BasicBlock
from sxia.runner.frame import CallStackFrame
from sxia.value import ClassInstanceValue, ModuleInstanceValue


class TestFuncPath(unittest.TestCase):
    def test_fork_creates_independent_paths(self):
        block1 = BasicBlock(1)
        block2 = BasicBlock(2)
        block3 = BasicBlock(3)
        frame1 = CallStackFrame(
            ClassInstanceValue(None, None),
            block2,
            local_env={"test": 1},
            env=ModuleInstanceValue(None),
            args=[],
            kwargs={},
        )
        call1 = TorchCall("call1", [], [], 123)
        call2 = TorchCall("call2", [], [], 456)
        path = FuncPath(id=1, block=block1, frames=[frame1], calls=[call1])

        forked = path.fork(id=2, block=block3)

        # Changing forked should not affect original
        forked.frames[0].local_env["test"] = 99
        forked.calls.append(call2)
        forked.frames[0].self_value.value["tokens"] = 100

        self.assertNotEqual(
            path.frames[0].local_env["test"], forked.frames[0].local_env["test"]
        )
        self.assertIn("tokens", forked.frames[0].self_value.value)
        self.assertNotIn("tokens", path.frames[0].self_value.value)
        self.assertNotIn(call2, path.calls)
        self.assertIn(call2, forked.calls)
        self.assertEqual(path.block, block1)
        self.assertEqual(forked.block, block3)
