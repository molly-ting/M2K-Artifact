import ast
import os
from sxia.analysis_types import PyCppBinding, TorchCall
from sxia.ast_ext.cfg import CachedCFGBuilder
from sxia.cfgrunner.runner import FuncRunner
from sxia.value import (
    ModuleInstanceValue,
    Value,
)
from sxia.utils.ast import (
    get_cls_from_mod,
    get_func_from_cls,
)

import logging


logger = logging.getLogger(__name__)


class TorchCallVisitor:
    def __init__(
        self,
        init_mod: ast.Module,
        init_cls: ast.ClassDef,
        init_func: str,
        config: Value,
        bindings: list[PyCppBinding],
    ):
        self.calls = []
        self._init_mod = init_mod
        self._init_cls = init_cls
        self._init_func = init_func
        self._bindings = bindings
        self._config = config
        self._env: ModuleInstanceValue = None

    def start(self):
        # workflow is:
        # 1. init module
        self._env = ModuleInstanceValue.from_ast_module(self._init_mod)

        paths = FuncRunner(CachedCFGBuilder()).run(
            self._init_cls,
            kwargs={"config": self._config},
            env=self._env,
        )

        func = get_func_from_cls(self._init_cls, self._init_func)

        possible_selfs = [p.return_value for p in paths]
        logger.debug(f"possible_selfs: {len(possible_selfs)}")
        for self_value in possible_selfs:
            if "config" not in self_value.value:
                self_value.value["config"] = self._config

            forward_paths = FuncRunner(CachedCFGBuilder()).run(
                func, self_value=self_value, env=self._env
            )
            for path in forward_paths:
                self.calls.extend(path.calls)

    @staticmethod
    def starts_from(
        py_file: str,
        cls: str,
        config: Value,
        func: str = "forward",
        bindings: list[PyCppBinding] = None,
    ):
        assert isinstance(config, Value)
        print(f"starts_from {py_file} {cls} {func} {config}")
        if not os.path.exists(py_file):
            raise FileNotFoundError(py_file)
        with open(py_file, "r") as f:
            mod = ast.parse(f.read())
        cls_def = get_cls_from_mod(mod, cls)
        return TorchCallVisitor.starts_from_ast(mod, cls_def, func, config, bindings)

    @staticmethod
    def starts_from_ast(
        init_mod: ast.Module,
        init_cls: ast.ClassDef,
        init_func: str,
        config: Value,
        bindings: list[PyCppBinding],
    ) -> list[TorchCall]:
        visitor = TorchCallVisitor(init_mod, init_cls, init_func, config, bindings)
        visitor.start()
        return visitor.calls
