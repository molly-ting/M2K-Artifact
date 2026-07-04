from copy import deepcopy
from sxia.analysis_types import TorchCall
from sxia.ast_ext.cfg import BasicBlock
from sxia.cfgrunner.frame import CallStackFrame


class FuncPath:
    def __init__(
        self,
        id: int,
        block: BasicBlock,
        frames: list[CallStackFrame],
        calls: list[
            TorchCall
        ],  # FIXME: this should not be collected here, better to be in FuncRunner
    ):
        self.id = id
        self.block = block
        self.frames = frames
        self.calls: list[TorchCall] = calls
        self.return_value = None

    def fork(self, id: int, block: BasicBlock):
        new_path = FuncPath(
            id, block, [deepcopy(f) for f in self.frames], self.calls.copy()
        )
        return new_path
