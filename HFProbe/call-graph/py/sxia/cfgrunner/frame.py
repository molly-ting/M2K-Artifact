from typing import Optional
from sxia.ast_ext.cfg import BasicBlock
from sxia.value import ClassInstanceValue, ModuleInstanceValue


class CallStackFrame:
    """
    A frame in the FuncPath's call stack.
    """

    def __init__(
        self,
        self_value: Optional[ClassInstanceValue],
        ret_blocks: list[BasicBlock],
        local_env: dict,
        env: ModuleInstanceValue,
        args: list,
        kwargs: dict,
        ret_val_obj=None,
        ret_val_obj_key=None,
        name: str = None,
    ):
        self.name = name
        self.self_value = self_value
        self.ret_blocks = ret_blocks
        self.local_env = local_env
        self.env = env
        self.args = args
        self.kwargs = kwargs
        self.ret_val_obj = ret_val_obj
        self.ret_val_obj_key = ret_val_obj_key
