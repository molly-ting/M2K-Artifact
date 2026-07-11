import ast
from typing import Optional, Union

from sxia.analysis_types import TorchCall
from sxia.ast_ext.cfg import BasicBlock, CachedCFGBuilder
from sxia.cfgrunner.frame import CallStackFrame
from sxia.cfgrunner.path import FuncPath
from sxia.type_info import resolve_ann
from sxia.utils.ast import get_func_from_cls, name_or_full_attr
from sxia.value import (
    ClassInstanceValue,
    ClassValue,
    FuncValue,
    ImportValue,
    ModuleInstanceValue,
    Value,
    new_symbol,
    serialize_value,
)
from sxia.torch_api import torch_apis





def _handle_zip(args, kwargs):
    if len(args) != 2:
        raise ValueError("zip only support 2 args")
    if not isinstance(args[0], list):
        raise ValueError("zip first arg must be list")

    right_value = None
    if isinstance(args[1], Value):
        if args[1].is_symbol():
            right_value = [new_symbol() for _ in args[0]]
        else:
            assert isinstance(args[1], list)
            right_value = args[1]
    elif isinstance(args[1], list):
        right_value = args[1]
    else:
        raise ValueError("zip second arg must be list or symbol")

    if len(args[0]) != len(right_value):
        raise ValueError("zip args length not equal")
    return list(zip(args[0], right_value))


global_func_map = {"zip": _handle_zip}


def resolve_with_import(name: str, env: ModuleInstanceValue):
    fullname = None
    parts = name.split(".")
    if parts[0] in env.value and isinstance(env.value[parts[0]], ImportValue):
        fullname = env.value[parts[0]].value + "." + ".".join(parts[1:])
    else:
        fullname = name
    return fullname


def to_primitive(val):
    if isinstance(val, Value):
        return val.value
    else:
        return val


class FuncReturnPlaceHolder:
    pass


class FuncRunner(ast.NodeVisitor):
    def __init__(
        self,
        cfg_builder: CachedCFGBuilder,
    ):
        self._cfg_builder = cfg_builder

        ## Execution Context Related
        self._cfg = None
        self._frame: CallStackFrame = None
        self._path: FuncPath = None
        self._path_id = 0
        self._bb: BasicBlock = None
        self._next_bbs: list[BasicBlock] = None

        ## All Execution Paths
        self.paths: list[FuncPath] = None

    def run(
        self,
        node: Union[ast.FunctionDef, ast.ClassDef],
        self_value: ClassInstanceValue = None,
        env: ModuleInstanceValue = None,
        args: list[Value] = None,
        kwargs: dict[str, Value] = None,
    ) -> list[FuncPath]:
        if isinstance(node, ast.ClassDef):
            return self._run_cls(node, env=env, args=args, kwargs=kwargs)
        elif isinstance(node, ast.FunctionDef):
            return self._run_fn(
                node, self_value=self_value, env=env, args=args, kwargs=kwargs
            )
        else:
            raise ValueError("node must be either ClassDef or FunctionDef")

    def _run_cls(
        self,
        node: ast.ClassDef,
        env: ModuleInstanceValue = None,
        args: list[Value] = None,
        kwargs: dict[str, Value] = None,
    ):
        """
        Create a class instance and run __init__ function (if any)
        """
        self_value = self._get_instance_value(node)

        fn = None
        try:
            fn = get_func_from_cls(node, "__init__")
        except ValueError:
            # if class does not have __init__, do nothing
            pass
        if fn is not None:
            return self._run_fn(
                fn, self_value=self_value, env=env, args=args, kwargs=kwargs
            )
        else:
            path = self._new_path(
                None,
                base_frame=CallStackFrame(
                    self_value=self_value,
                    ret_blocks=None,
                    local_env=None,
                    env=env,
                    args=args if args else [],
                    kwargs=kwargs if kwargs else {},
                ),
                base_path=None,
            )
            path.return_value = self_value
            # simply return one path with the class instance
            return [path]

    def _new_path(
        self,
        block: BasicBlock,
        base_path: Optional[FuncPath] = None,
        base_frame: Optional[CallStackFrame] = None,
    ):
        if base_path is None:
            new_path = FuncPath(self._path_id, block, [base_frame], [])
        else:
            new_path = base_path.fork(self._path_id, block)

        self._path_id += 1
        return new_path

    def _run_fn(
        self,
        func_node: ast.FunctionDef,
        self_value: ClassInstanceValue = None,
        env: ModuleInstanceValue = None,
        args: list[Value] = None,
        kwargs: dict[str, Value] = None,
    ) -> list[FuncPath]:
        assert isinstance(func_node, ast.FunctionDef)
        self._cfg = self._cfg_builder.get_cfg(func_node)
        if self._cfg is None:
            raise ValueError("CFG not built yet")
        entry_block = self._cfg.entry_block
        if entry_block is None:
            raise ValueError("No entry block found in CFG")

        # create base frame
        init_frame = CallStackFrame(
            self_value=self_value,
            ret_blocks=None,
            local_env={},
            env=env,
            args=args if args else [],
            kwargs=kwargs if kwargs else {},
            name=func_node.name,
        )
        init_path = self._new_path(entry_block, base_path=None, base_frame=init_frame)
        self._set_current_frame(init_frame)
        self._set_current_path(init_path)

        # initialize the arguments to local env first
        self.visit_arguments(func_node.args)

        explore = [init_path]
        self.paths = []
        while explore:
            path = explore.pop(0)
            self._run_path(path, explore)
            self.paths.append(path)

        return self.paths

    def _set_current_frame(self, frame: CallStackFrame):
        self._frame = frame

    def _set_current_path(self, path: FuncPath):
        self._path = path

    def _get_current_frame(self) -> CallStackFrame:
        return self._frame

    def _get_current_local_env(self) -> dict:
        return self._get_current_frame().local_env

    def _get_current_self_value(self) -> ClassInstanceValue:
        return self._get_current_frame().self_value

    def _get_current_env(self) -> ModuleInstanceValue:
        return self._get_current_frame().env

    def _add_torch_call(self, call: TorchCall):
        self._path.calls.append(call)

    def _push_frame(self, frame: CallStackFrame):
        self._set_current_frame(frame)
        self._path.frames.append(frame)

    def _pop_frame(self):
        # base frame should not be popped
        if len(self._path.frames) > 1:
            frame = self._path.frames.pop()
            self._set_current_frame(self._path.frames[-1])
            self._next_bbs = frame.ret_blocks
            if self._next_bbs:
                bb = self._next_bbs[0]
                if bb.statements:
                    pass
            if frame.name == "__init__":
                # if __init__ is called, we need to set the return value to self
                # since __init__ does not return anything
                if frame.ret_val_obj:
                    frame.ret_val_obj[frame.ret_val_obj_key] = frame.self_value
        else:
            base_frame = self._path.frames[0]
            if base_frame.name == "__init__":
                self._path.return_value = base_frame.self_value

    def _run_path(self, path: FuncPath, paths: list[FuncPath]):
        self._set_current_frame(path.frames[-1])
        self._set_current_path(path)
        bb = path.block
        visited = set()

        while bb is not None:
            # if bb in visited:
            #     break
            visited.add(bb)
            self._bb = bb
            if bb.statements:
                for stmt in bb.statements:
                    # entrypoint of executing statement
                    self.visit(stmt)

            if self._next_bbs is None:
                # self._next_bbs can be updated by _handle_call
                self._next_bbs = bb.successors

            if self._next_bbs:
                for i, successor in enumerate(self._next_bbs):
                    if i == 0:
                        bb = successor
                    else:
                        new_path = self._new_path(successor, base_path=path)
                        paths.append(new_path)
                self._next_bbs = None
            else:
                # no successors, end of path
                if len(path.frames) > 1:
                    # pop the frame if not the base frame
                    self._pop_frame()
                else:
                    base_frame = self._path.frames[0]
                    if base_frame.name == "__init__":
                        self._path.return_value = base_frame.self_value
                    break

    def _get_instance_value(self, node: ast.ClassDef) -> ClassInstanceValue:
        self_value = ClassInstanceValue(node)
        frame = self._get_current_frame()
        # handle outmost assignment
        for stmt in node.body:
            if isinstance(stmt, ast.AnnAssign):
                if isinstance(stmt.target, ast.Name):
                    if isinstance(stmt.value, ast.Constant) or isinstance(
                        stmt.value, ast.Call
                    ):
                        self_value.value[stmt.target.id] = self._eval(frame, stmt.value)
                    else:
                        self_value.value[stmt.target.id] = new_symbol(
                            name=stmt.annotation.id, def_at=node
                        )
                else:
                    pass
            elif isinstance(stmt, ast.Assign):
                stmt_value = self._eval(frame, stmt.value)
                if len(stmt.targets) == 1:
                    target = stmt.targets[0]
                    if isinstance(target, ast.Name):
                        self_value.value[target.id] = stmt_value
                    else:
                        pass
                else:
                    assert isinstance(stmt_value, list)
                    assert len(stmt_value) == len(stmt.targets)
                    for target, value in zip(stmt.targets, stmt_value):
                        self._eval(target).value = value
        return self_value

    def _eval(self, frame: CallStackFrame, node: ast.AST, update_to=None) -> Value:
        try:
            if isinstance(node, ast.List):
                val = []
                for item in node.elts:
                    val.append(self._eval(frame, item))
                return val
            elif isinstance(node, ast.Name):
                local_env = frame.local_env
                if update_to is not None:
                    if isinstance(update_to, FuncReturnPlaceHolder):
                        new_frame = self._get_current_frame()
                        new_frame.ret_val_obj = local_env
                        new_frame.ret_val_obj_key = node.id
                    else:
                        local_env[node.id] = update_to
                    return
                if node.id in local_env:
                    return local_env[node.id]
                elif node.id in frame.env.value:
                    if update_to is not None:
                        if isinstance(update_to, FuncReturnPlaceHolder):
                            new_frame = self._get_current_frame()
                            new_frame.ret_val_obj = frame.env.value
                            new_frame.ret_val_obj_key = node.id
                        else:
                            frame.env.value[node.id] = update_to

                        return
                    return frame.env.value[node.id]
                else:
                    return new_symbol(node.id, def_at=node)
            elif isinstance(node, ast.Constant):
                return node.value
            elif isinstance(node, ast.Attribute):
                if isinstance(node.value, ast.Name):
                    if node.value.id == "self":
                        if update_to is not None:
                            if isinstance(update_to, FuncReturnPlaceHolder):
                                new_frame = self._get_current_frame()
                                new_frame.ret_val_obj = frame.self_value.value
                                new_frame.ret_val_obj_key = node.attr
                            else:
                                frame.self_value.value[node.attr] = update_to
                            return
                        return frame.self_value.value[node.attr]
                    elif node.value.id == "torch":
                        return Value(ty=f"torch.{node.attr}", def_at=node)
                    else:
                        base_val = frame.local_env[node.value.id]
                        if base_val.is_symbol():
                            return new_symbol(f"{base_val}.{node.attr}", def_at=node)

                        else:
                            return base_val.value[node.attr]
                elif isinstance(node.value, ast.Attribute):
                    value = self._eval(frame, node.value)
                    if isinstance(value, dict):
                        return value[node.attr]
                    return value.value[node.attr]
                elif isinstance(node.value, ast.Call):
                    ret_val = self._eval(frame, node.value)
                    if ret_val.is_symbol():
                        return new_symbol(
                            f"ret_val.{node.attr}",
                            def_at=node,
                        )
                    else:
                        return ret_val.value[node.attr]
                else:
                    pass
            elif isinstance(node, ast.Tuple):
                val = []
                for item in node.elts:
                    val.append(self._eval(frame, item))
                return val
            elif isinstance(node, ast.Subscript):
                base_val = self._eval(frame, node.value)
                slice_val = self._eval(frame, node.slice)
                if isinstance(slice_val, tuple):
                    if any(isinstance(i, Value) and i.is_symbol() for i in slice_val):
                        return new_symbol(def_at=node)
                    return base_val[slice_val[0] : slice_val[1] : slice_val[2]]
                elif isinstance(slice_val, int) or isinstance(slice_val, str):
                    return base_val[slice_val]
                else:
                    return new_symbol(def_at=node)
            elif isinstance(node, ast.Slice):
                return (
                    self._eval(frame, node.lower) if node.lower else None,
                    self._eval(frame, node.upper) if node.upper else None,
                    self._eval(frame, node.step) if node.step else None,
                )
            elif isinstance(node, ast.Call):
                return self._handle_call(node)
            elif isinstance(node, ast.BinOp):
                return self._handle_bin_op(node)
            elif isinstance(node, ast.Compare):
                return self._handle_compare(node)
            elif isinstance(node, ast.BoolOp):
                return self._handle_bool_op(node)
            elif isinstance(node, ast.UnaryOp):
                return self._handle_unary_op(node)
            elif isinstance(node, ast.ListComp):
                return self._handle_list_comp(node)
            else:
                raise NotImplementedError()
        except Exception:
            return new_symbol(def_at=node)

    def visit_For(self, node):
        frame = self._get_current_frame()
        if isinstance(node.iter, ast.Call):
            if isinstance(node.iter.func, ast.Name):
                if node.iter.func.id == "enumerate":
                    arg0 = node.iter.args[0]
                    arg0_val = self._eval(frame, arg0)
                    if isinstance(node.target, ast.Tuple):
                        #     # for i, (x, y) in enumerate(...)
                        if isinstance(node.target.elts[1], ast.Tuple):
                            for i, el in enumerate(node.target.elts[1].elts):
                                if isinstance(el, ast.Name):
                                    self._eval(frame, el, arg0_val[0][i])
                                    # if arg0_ty.ty == "zip":
                                    #     fn_ty[el.id] = arg0_ty.args[i].item

        self.generic_visit(node)

    def visit_Return(self, node):
        # super().generic_visit(node)
        frame = self._get_current_frame()
        return_value = self._eval(frame, node.value)

        last_frame = len(self._path.frames) == 1
        if last_frame:
            self._path.return_value = return_value
        else:
            self._pop_frame()
            if frame.ret_val_obj:
                frame.ret_val_obj[frame.ret_val_obj_key] = return_value

    def _handle_list_comp(self, node: ast.ListComp):
        if len(node.generators) > 1:
            return new_symbol(def_at=node)
        frame = self._get_current_frame()
        iterator = node.generators[0].iter
        if not isinstance(iterator, ast.Call):
            return new_symbol(def_at=node)

        if iterator.func.id != "range":
            return new_symbol(def_at=node)

        if len(iterator.args) != 1:
            return new_symbol(def_at=node)

        arr_len = to_primitive(self._eval(frame, iterator.args[0]))
        if not isinstance(arr_len, int):
            return new_symbol(def_at=node)

        val = []
        for _ in range(arr_len):
            val.append(self._eval(frame, node.elt))
        return val

    def _handle_unary_op(self, node: ast.UnaryOp):
        super().generic_visit(node)
        frame = self._get_current_frame()
        op = node.op
        operand = self._eval(frame, node.operand)
        if isinstance(operand, Value) and operand.is_symbol():
            # FIXME: use symbolic expression to represent the value
            return new_symbol(def_at=node)
        if isinstance(op, ast.UAdd):
            return +to_primitive(operand)
        elif isinstance(op, ast.USub):
            return -to_primitive(operand)
        elif isinstance(op, ast.Not):
            return not to_primitive(operand)
        elif isinstance(op, ast.Invert):
            return ~to_primitive(operand)
        else:
            pass

    def _handle_bool_op(self, node: ast.BoolOp):
        super().generic_visit(node)
        op = node.op
        if isinstance(op, ast.And):
            return all([to_primitive(v) for v in node.values])
        elif isinstance(op, ast.Or):
            return any([to_primitive(v) for v in node.values])
        else:
            pass

    def _is_super_init(self, node: ast.Attribute):
        if (
            isinstance(node.value, ast.Call)
            and isinstance(node.value.func, ast.Name)
            and node.value.func.id == "super"
            and node.attr == "__init__"
        ):
            return True
        return False

    def _handle_call(self, node: ast.Call):
        frame = self._get_current_frame()
        local_env = self._get_current_local_env()
        env = self._get_current_env()
        self_value = self._get_current_self_value()
        args = []
        kwargs = {}
        for arg in node.args:
            args.append(self._eval(frame, arg))
        for kw in node.keywords:
            kwargs[kw.arg] = self._eval(frame, kw.value)
        global torch_apis

        if isinstance(node.func, ast.Attribute):
            if self._is_super_init(node.func):

                # Hard code to assign config to self.config
                if "config" in local_env:
                    self_value.value["config"] = local_env["config"]

                return new_symbol()
            callee_name = name_or_full_attr(node.func)
            full_callee_name = resolve_with_import(callee_name, env)

            if full_callee_name.startswith("logger."):
                return None
            elif full_callee_name.startswith("self.register_buffer"):
                return None
            elif full_callee_name.startswith("self.post_init"):
                return None

            if (
                full_callee_name.startswith("torch")
                or full_callee_name.find("cache_kernels") != -1
            ):
                self._add_torch_call(
                    TorchCall(
                        name=full_callee_name,
                        args=[serialize_value(arg) for arg in args],
                        kwargs={k: serialize_value(v) for k, v in kwargs.items()},
                        lineno=node.lineno,
                    )
                )

            if full_callee_name in torch_apis:
                try:
                    return torch_apis[full_callee_name](args, kwargs={})
                except Exception:
                    return new_symbol(def_at=node)

            parts = full_callee_name.split(".")
            if full_callee_name.startswith("self"):
                func = None
                try:
                    func = self_value.get(".".join(parts[1:]))
                except Exception:
                    return new_symbol(def_at=node)

                if isinstance(func, ClassInstanceValue):
                    if func.ty.lower().find("norm") != -1:
                        if len(args) == 1:
                            # if calling normalizing layer, like BatchNorm, LayerNorm
                            # we don't need to actually call it,
                            # since it does not change the shape of the tensor
                            return args[0]

                    self_value = func
                    # if it has forward, call forward, else report error and return symbol
                    if "forward" in func.value:
                        func = func.value["forward"]
                    else:
                        typed_method_sig = f"{func.ty}.__call__"
                        if typed_method_sig in torch_apis:
                            return torch_apis[typed_method_sig](
                                args, kwargs=kwargs, self_value=self_value
                            )
                        return new_symbol(def_at=node)
                elif isinstance(func, ImportValue):
                    return new_symbol(def_at=node)
                elif func.is_symbol():
                    return new_symbol(def_at=node)
                else:
                    if len(parts) != 2:
                        self_value = self_value.get(".".join(parts[1:-1]))
                assert isinstance(func, FuncValue)
                return self._jump_to_fn(
                    func.def_at, self_value=self_value, args=args, kwargs=kwargs
                )
            elif parts[0] in local_env:
                callee_self = local_env[parts[0]]
                i = 1
                while i < len(parts) - 1:
                    callee_self = callee_self.value[parts[i]]
                    i += 1
                callee_method = parts[-1]
                typed_method_sig = None
                if isinstance(callee_self, ClassInstanceValue):
                    typed_method_sig = f"{callee_self.ty}.{callee_method}"
                    if isinstance(callee_self.def_at, ast.ClassDef):
                        fn = None
                        try:
                            fn = get_func_from_cls(callee_self.def_at, callee_method)
                        except ValueError:
                            # if class does not have __init__, do nothing
                            pass

                        if fn is not None:
                            return self._jump_to_fn(
                                fn, self_value=callee_self, args=args, kwargs=kwargs
                            )

                if typed_method_sig in torch_apis:
                    return torch_apis[typed_method_sig](
                        args, kwargs=kwargs, self_value=callee_self
                    )

                if isinstance(callee_self, dict):
                    return self._handle_obj_call(
                        callee_self, callee_method, args, kwargs
                    )
                elif isinstance(callee_self, Value):
                    if callee_self.is_symbol():
                        return new_symbol(
                            def_at=node,
                            name=f"[return: {full_callee_name}]",
                        )
                    if callee_self.ty == "dict":
                        return self._handle_obj_call(
                            callee_self.value, callee_method, args, kwargs
                        )

                    elif callee_self.ty == "torch.Tensor":
                        if callee_method == "size":
                            return callee_self.value["size"]
                        elif callee_method == "shape":
                            return callee_self.value["shape"]
                        else:
                            raise NotImplementedError()
                    else:
                        raise NotImplementedError()
                elif isinstance(callee_self, list):
                    if callee_method == "append":
                        return callee_self.append(args[0])
                    else:
                        raise NotImplementedError()
                else:
                    raise NotImplementedError()

            if full_callee_name.startswith("torch"):
                return new_symbol(name=f"[return: {full_callee_name}]", def_at=node)
            else:
                return new_symbol(def_at=node, name=f"[return: {full_callee_name}]")
        elif isinstance(node.func, ast.Name):
            # check if it is a local variable first
            if node.func.id in local_env:
                base_val = local_env[node.func.id]
                if base_val.is_symbol():
                    return new_symbol(def_at=node)
                if isinstance(base_val, ClassValue):
                    self_value = None
                    func = None
                    if "forward" in base_val.value:
                        self_value = base_val
                        func = base_val.value["forward"]
                    else:
                        return new_symbol(def_at=node)

                    return self._jump_to_fn(
                        func.def_at, self_value=self_value, args=args, kwargs=kwargs
                    )

            # like simply xxx(), node.func.id is xxx
            if node.func.id == "super":
                return new_symbol(def_at=node)
            elif node.func.id == "print":
                return None
            elif node.func.id == "RuntimeError":
                return None

            if node.func.id in global_func_map:
                return global_func_map[node.func.id](args, kwargs)
            if node.func.id == "hasattr":
                return hasattr(to_primitive(args[0]), to_primitive(args[1]))
            if node.func.id == "int":
                if isinstance(args[0], int):
                    return args[0]
                elif isinstance(args[0], float):
                    return int(args[0])
                elif isinstance(args[0], Value) and args[0].is_symbol():
                    # FIXME: use symbolic expression to represent the value
                    return new_symbol(def_at=node)
                else:
                    return int(args[0].value)
            elif node.func.id == "float":
                if isinstance(args[0], int):
                    return float(args[0])
                elif isinstance(args[0], float):
                    return args[0]
                elif isinstance(args[0], Value) and args[0].is_symbol():
                    # FIXME: use symbolic expression to represent the value
                    return new_symbol(def_at=node)
                else:
                    return float(args[0].value)
            # could be class instantiation
            cls_val = None
            try:
                cls_val = env.get(node.func.id)
            except Exception:
                return new_symbol(name=f"[return: {node.func.id}]", def_at=node)
            if cls_val is not None and isinstance(cls_val, ClassValue):
                cls_self = self._get_instance_value(cls_val.def_at)
                fn = None
                try:
                    fn = get_func_from_cls(cls_val.def_at, "__init__")
                except ValueError:
                    # if class does not have __init__, do nothing
                    pass

                if fn is not None:
                    return self._jump_to_fn(
                        fn, self_value=cls_self, args=args, kwargs=kwargs
                    )

                return cls_self
            else:
                return new_symbol(name=f"[return: {node.func.id}]", def_at=node)

        else:
            return new_symbol(name=f"[return: {ast.dump(node)}]", def_at=node)

    def _jump_to_fn(
        self, node: ast.FunctionDef, self_value=None, args=None, kwargs=None
    ):
        cfg = self._cfg_builder.get_cfg(node)
        self._next_bbs = [cfg.entry_block]
        new_frame = CallStackFrame(
            self_value=self_value,
            ret_blocks=self._bb.successors,
            local_env={},
            env=self._get_current_env(),
            args=args,
            kwargs=kwargs,
            name=node.name,
        )
        self._push_frame(new_frame)
        self._set_current_frame(new_frame)
        self.visit_arguments(node.args)
        return FuncReturnPlaceHolder()

    def _handle_obj_call(self, base, method, args, kwargs):
        if isinstance(base, dict):
            if method == "get":
                return base.get(args[0], args[1] if len(args) > 1 else None)
            elif method == "set":
                base[args[0]] = args[1]
                return None
            else:
                raise NotImplementedError()
        else:
            raise NotImplementedError()

    def visit_Call(self, node: ast.Call):
        super().generic_visit(node)
        self._handle_call(node)

    def visit_arguments(self, node):
        args_len = len(node.args)
        default_args_len = len(node.defaults)
        arg_offset = 0
        super().generic_visit(node)
        used_init_kwargs = set()
        self_value = self._get_current_self_value()
        local_env = self._get_current_local_env()
        init_args = self._get_current_frame().args
        init_kwargs = self._get_current_frame().kwargs
        frame = self._get_current_frame()

        # first loop handle default args
        for idx, arg in enumerate(node.args):
            if self_value is not None and idx == 0:
                arg_offset = 1
                continue
            if idx >= args_len - default_args_len:
                if arg.arg not in local_env:
                    local_env[arg.arg] = self._eval(
                        frame, node.defaults[idx - args_len + default_args_len]
                    )

        # second loop handle passed arguments and kwargs
        for idx, arg in enumerate(node.args):
            if self_value is not None and idx == 0:
                arg_offset = 1
                continue
            init_arg_idx = idx - arg_offset
            # passed arguments assign first
            if init_arg_idx < len(init_args):
                local_env[arg.arg] = init_args[idx - arg_offset]
            else:
                # if passed arguments done, try to assign from passed kwargs
                if arg.arg in init_kwargs:
                    local_env[arg.arg] = init_kwargs[arg.arg]
                    used_init_kwargs.add(arg.arg)

        # after known argument assignment, assign rest of passed kwargs to kwargs(if function declared )
        if node.kwarg is not None:
            local_env[node.kwarg.arg] = {}
            for key, value in init_kwargs.items():
                if key not in used_init_kwargs:
                    local_env[node.kwarg.arg][key] = value

        # add types if there are any None
        for arg in node.args:
            if arg.arg == "self":
                continue
            if arg.arg not in local_env:
                local_env[arg.arg] = new_symbol(def_at=node, name=f"[arg: {arg.arg}]")

            if arg.annotation:
                if arg.arg in local_env:
                    arg_val = local_env[arg.arg]

                    if isinstance(arg_val, Value) and arg_val.is_symbol():
                        ty = resolve_ann(arg.annotation)

                        if ty.ty == "torch.Tensor":
                            local_env[arg.arg] = ClassInstanceValue(None)
                            local_env[arg.arg].ty = "torch.Tensor"
                            local_env[arg.arg].value = {}
                        elif ty.ty == "torch.FloatTensor":
                            local_env[arg.arg] = ClassInstanceValue(None)
                            local_env[arg.arg].ty = "torch.Tensor"
                            local_env[arg.arg].value = {"dtype": "float"}
                        elif ty.ty == "torch.LongTensor":
                            local_env[arg.arg] = ClassInstanceValue(None)
                            local_env[arg.arg].ty = "torch.Tensor"
                            local_env[arg.arg].value = {"dtype": "long"}
                        else:
                            arg_val.ty = ty.ty


    def _handle_compare(self, node: ast.Compare):
        # super().generic_visit(node)
        frame = self._get_current_frame()
        assert len(node.ops) == 1
        assert len(node.comparators) == 1
        left_val = self._eval(frame, node.left)
        right_val = self._eval(frame, node.comparators[0])
        op = node.ops[0]
        if isinstance(op, ast.Eq):
            return to_primitive(left_val) == to_primitive(right_val)
        elif isinstance(op, ast.NotEq):
            return to_primitive(left_val) != to_primitive(right_val)
        elif isinstance(op, ast.Lt):
            return to_primitive(left_val) < to_primitive(right_val)
        elif isinstance(op, ast.LtE):
            return to_primitive(left_val) <= to_primitive(right_val)
        elif isinstance(op, ast.Gt):
            return to_primitive(left_val) > to_primitive(right_val)
        elif isinstance(op, ast.GtE):
            return to_primitive(left_val) >= to_primitive(right_val)

    def _handle_bin_op(self, node: ast.BinOp):
        frame = self._get_current_frame()
        left_val = self._eval(frame, node.left)
        right_val = self._eval(frame, node.right)

        if isinstance(left_val, Value):
            if left_val.ty == "torch.Tensor":
                # does not change the shape
                return left_val
            if left_val.is_symbol():
                # FIXME: use symbolic expression to represent the value
                return new_symbol(def_at=node)
        elif isinstance(right_val, Value):
            if right_val.ty == "torch.Tensor":
                # does not change the shape
                return right_val

            if right_val.is_symbol():
                # FIXME: use symbolic expression to represent the value
                return new_symbol(def_at=node)
        op = node.op
        if isinstance(op, ast.Add):
            if isinstance(left_val, list) and isinstance(right_val, tuple):
                return left_val + list(right_val)
            elif isinstance(left_val, tuple) and isinstance(right_val, list):
                return list(left_val) + right_val
            return to_primitive(left_val) + to_primitive(right_val)
        elif isinstance(op, ast.Sub):
            return to_primitive(left_val) - to_primitive(right_val)
        elif isinstance(op, ast.Mult):
            return to_primitive(left_val) * to_primitive(right_val)
        elif isinstance(op, ast.Div):
            return to_primitive(left_val) / to_primitive(right_val)
        elif isinstance(op, ast.Mod):
            return to_primitive(left_val) % to_primitive(right_val)
        elif isinstance(op, ast.Pow):
            return to_primitive(left_val) ** to_primitive(right_val)
        elif isinstance(op, ast.BitOr):
            return to_primitive(left_val) | to_primitive(right_val)
        elif isinstance(op, ast.BitAnd):
            return to_primitive(left_val) & to_primitive(right_val)
        elif isinstance(op, ast.BitXor):
            return to_primitive(left_val) ^ to_primitive(right_val)
        elif isinstance(op, ast.FloorDiv):
            return to_primitive(left_val) // to_primitive(right_val)
        else:
            pass

    def visit_Assign(self, node):
        try:
            frame = self._get_current_frame()
            value = self._eval(frame, node.value)

            for target in node.targets:
                if isinstance(target, ast.Tuple):
                    if isinstance(value, list) or isinstance(value, tuple):
                        for elt, val in zip(target.elts, value):
                            self._eval(frame, elt, val)
                    else:
                        for elt in target.elts:
                            self._eval(frame, elt, new_symbol(def_at=node))
                else:
                    self._eval(frame, target, value)
        except Exception:
            pass

    def visit_If(self, node):
        pass
