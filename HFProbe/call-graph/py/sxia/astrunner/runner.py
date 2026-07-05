import ast
import copy
import json
import os
import traceback
from typing import List, Optional, Union
from sxia.analysis_types import PyCppBinding, TorchCall
from sxia.type_info import resolve_ann
from sxia.utils.cpp_binding_helper import CppBindingHelper
from sxia.value import (
    ClassInstanceValue,
    ClassValue,
    CppBindingChildValue,
    CppBindingValue,
    FuncValue,
    ImportValue,
    LambdaValue,
    ModuleInstanceValue,
    SuperValue,
    Value,
    new_symbol,
    serialize_value,
)
from sxia.utils.ast import (
    env_resolve,
    get_cls_from_mod,
    get_func_from_cls,
    get_inherited_classes,
    name_or_full_attr,
    resolve_import_value,
    getImport
)

from sxia.torch_api import torch_apis
from sxia.native_api import global_func_map
import logging

logger = logging.getLogger(__name__)


def resolve_with_import(name: str, env: ModuleInstanceValue):
    fullname = None

    parts = name.split(".")

    if parts[0] in env.value:
        imp_val = env.value[parts[0]]
        if isinstance(imp_val, ImportValue):
            fullname = "." * imp_val.level + ".".join(
                [env.value[parts[0]].value] + parts[1:]
            )
        else:
            fullname = name

    else:
        fullname = name
    return fullname


def to_primitive(val):
    if isinstance(val, Value):
        if isinstance(val.value, ast.Constant):
            return val.value.value
        if isinstance(val.value, Value) and not val.ty:
            return to_primitive(val.value)
        return val.value
    else:
        return val


def _find_module(val) -> ModuleInstanceValue:
    if isinstance(val, ModuleInstanceValue):
        return val
    elif isinstance(val, ClassValue) or isinstance(val, FuncValue):
        return _find_module(val.parent)

    raise ValueError(f"Unsupported value type: {type(val)}")


def _handle_tensor_selection(tensor: Value, slice: list[tuple]) -> Value:
    if isinstance(tensor, ClassInstanceValue) and tensor.ty == "torch.Tensor":
        if not slice:
            return tensor

        new_tensor = ClassInstanceValue(None)
        new_tensor.ty = "torch.Tensor"
        new_tensor.value = {}
        new_shape = []
        old_shape = tensor.value.get("shape")
        if old_shape is None:
            old_shape = []
        for i, s in enumerate(slice):
            if isinstance(s, tuple):
                start, end, step = s
                if start is None:
                    start = 0

                if len(old_shape) > i:
                    old_dim = old_shape[i]
                    # FIXME: miss many other cases for now
                    if end is None:
                        new_shape.append(old_dim)
                    else:
                        new_shape.append(end - start)
                else:
                    new_shape.append(new_symbol())

        new_tensor.value["shape"] = tuple(new_shape)
        return new_tensor

    return new_symbol(def_at=tensor.def_at)


class AbortByReturn(Exception):
    pass


def _handle_message_passing_collect(args, kwargs):
    ret = {
        "edge_index": args[1],
        "size": args[2] if len(args) > 2 else None,
    }

    _kwargs = args[3] if len(args) > 3 else None
    if _kwargs is not None:
        if isinstance(_kwargs, dict):
            ret.update(_kwargs)

    return ret


def _handle_message_passing_inspector_distribute(args, kwargs):
    return args[1]

def get_inherited_classes_by_value(cls: ClassInstanceValue) -> list[str]:
    inherited_classes = set(get_inherited_classes(cls.def_at))
    if cls.inheritance:
        for cls_name in cls.inheritance:
            if isinstance(cls_name, str):
                inherited_classes.add(cls_name)
            elif isinstance(cls_name, ClassValue):
                inherited_classes.add(cls_name.ty)
    return list(inherited_classes)

def _torch_ops_name(name: str) -> Optional[str]:
    if not name.startswith("torch.ops._"):
        return None
    # Need at least torch.ops.<namespace>.<op>.
    if len(name.split(".")) < 4:
        return None
    if name.endswith(".default"):
        return name[: -len(".default")]
    return name

def _find_torch_ops_calls(node: ast.AST) -> list[tuple[str, int]]:
    calls = []
    for child in ast.walk(node):
        if isinstance(child, ast.Call):
            name = _torch_ops_name(name_or_full_attr(child.func))
            if name:
                item = (name, getattr(child, "lineno", getattr(node, "lineno", 0)))
                if item not in calls:
                    calls.append(item)
        elif isinstance(child, ast.Attribute):
            attr_name = name_or_full_attr(child)
            name = _torch_ops_name(attr_name)
            if name:
                item = (name, getattr(child, "lineno", getattr(node, "lineno", 0)))
                if item not in calls:
                    calls.append(item)
    return calls

def getTypeOfReturnValue(funcDef: ast.FunctionDef) -> Optional[str]:
    if not hasattr(funcDef, "returns"):
        return None
    
    if isinstance(funcDef.returns, ast.Name):
        if hasattr(funcDef.returns, "id"):
            return funcDef.returns.id
        if hasattr(funcDef.returns, "slice") and hasattr(funcDef.returns.slice, "id"):
            return funcDef.returns.slice.id
    if isinstance(funcDef.returns, ast.Subscript):
        if hasattr(funcDef.returns, "id"):
            return funcDef.returns.id
        if hasattr(funcDef.returns, "slice"):
            if hasattr(funcDef.returns.slice, "id"):
                return funcDef.returns.slice.id
            if hasattr(funcDef.returns.slice, "value"):
                return funcDef.returns.slice.value
    return None
class FuncRunner(ast.NodeVisitor):
    def __init__(
        self,
        start_node: Union[ast.FunctionDef, ast.ClassDef, ast.Lambda],
        args: list[Value] = None,
        kwargs: dict[str, Value] = None,
        self_value: ClassInstanceValue = None,
        env: ModuleInstanceValue = None,
        calls: list[TorchCall] = None,
        auto_symbol_input_tensor=False,
        resolve_import_dirs: list[str] = None,
        local_env=None,
        call_graph=None,
    ):
        self.start_node = start_node
        self.local_env = {}
        if local_env:
            for lkey in local_env:
                if isinstance(local_env[lkey], list) and len(local_env[lkey]) > 20:
                    self.local_env[lkey] = new_symbol(def_at=start_node)
                else:
                    self.local_env[lkey] = copy.deepcopy(local_env[lkey])

        self.torch_calls = calls
        self._init_args = args or []
        self._init_kwargs = kwargs or {}
        self._self_value = self_value
        self._env = env
        self.return_value = None
        self._auto_symbol_input_tensor = auto_symbol_input_tensor
        self._resolve_import_dirs = resolve_import_dirs
        self._started_args = None
        self.call_graph = call_graph
        self.cg_key = None

        name = (
            start_node.name
            if hasattr(start_node, "name")
            else type(start_node).__name__
        )
        self_ty = None
        if isinstance(self_value, list):
            for candidate in self_value:
                if getattr(candidate, "ty", None):
                    self_ty = candidate.ty
                    break
        elif self_value is not None:
            self_ty = getattr(self_value, "ty", None)
        logger.debug(
            f"[FuncRunner] self:{self_ty} {name} at file {self._env.file_path}"
        )
        
        self._visit_level = 0
        self._shape2tensor = {}
        self.cg_key = None
        if self.call_graph is None:
            self.call_graph = {}
        
        if isinstance(self.start_node, ast.FunctionDef):
            className = None
            if self_value is not None:
                if isinstance(self_value, list):
                    for candidate in self_value:
                        if getattr(candidate, "def_at", None):
                            className = candidate.def_at.name
                            break
                        if getattr(candidate, "ty", None):
                            className = candidate.ty
                            break
                elif getattr(self_value, "def_at", None):
                    className = self_value.def_at.name
                elif getattr(self_value, "ty", None):
                    className = self_value.ty
            file_name = self._env.file_path.split("/")[-1].split(".")[0]
            if className:
                self.cg_key = file_name+"-"+className+"-"+start_node.name
            else:
                self.cg_key = file_name+"-"+start_node.name
            if self.cg_key not in self.call_graph:
                self.call_graph[self.cg_key] = {"class": className, "function": start_node.name, "filepath": self._env.file_path, "loc": (start_node.lineno, start_node.end_lineno), "callees": [], "unknown": []}
            

    def _record_callee(self, function_name: str, filepath: str = None, line: int = None, class_name: str = None):
        if self.cg_key and self.cg_key in self.call_graph:
            item = {
                "class": class_name,
                "function": function_name,
                "filepath": filepath or self._env.file_path,
                "line": line,
            }
            if item not in self.call_graph[self.cg_key]["callees"]:
                self.call_graph[self.cg_key]["callees"].append(item)

    def run(self):
        if isinstance(self.start_node, ast.ClassDef):
            assert self._self_value is None
            return self._run_cls(self.start_node)
        elif isinstance(self.start_node, ast.FunctionDef):
            # find nested functions
            for stmt in self.start_node.body:
                if isinstance(stmt, ast.FunctionDef):
                    logger.debug(
                        f"Found nested function: {stmt.name} at line {stmt.lineno}"
                    )
                    func_value = FuncValue(
                        def_at=stmt,
                        parent=self._self_value,
                        nested=True,
                    )
                    self.local_env[stmt.name] = func_value
                    
            self.visit(self.start_node)
            if self.start_node.name == "__init__":
                helper = CppBindingHelper(
                    ["cpp_kernels.cache_autogptq_cuda_256"], self._self_value
                )
                helper.visit(self.start_node)
        elif isinstance(self.start_node, ast.Lambda):
            assert self._self_value is None
            return self._run_lambda(self.start_node)

        return self.return_value

    def _run_lambda(self, node: ast.Lambda):
        self.visit(node.args)
        result = self._eval(node.body)
        return result

    def _run_cls(self, node: ast.ClassDef):
        self_value = ClassInstanceValue(node, parent=self._env)
        self._self_value = self_value
        base_classes = get_inherited_classes_by_value(self._self_value)
        for base_cls in base_classes:
            self._self_value.inheritance.append(base_cls)

        # handle outmost assignment
        for stmt in node.body:
            if isinstance(stmt, ast.Pass):
                for base_cls in base_classes:
                    if base_cls.endswith("nn.Module") or base_cls.endswith(
                        "PreTrainedModel"
                    ) or base_cls.startswith("torch.nn"):
                        continue
                    base_cls_value = env_resolve(
                        self._env, base_cls, self._resolve_import_dirs
                    )
                    return FuncRunner(
                        base_cls_value.def_at,
                        args=self._init_args,
                        kwargs=self._init_kwargs,
                        self_value=None,
                        env=self._env,
                        resolve_import_dirs=self._resolve_import_dirs,
                        call_graph=self.call_graph,
                    ).run()
            if isinstance(stmt, ast.AnnAssign):
                if isinstance(stmt.target, ast.Name):
                    if isinstance(stmt.value, ast.Constant) or isinstance(
                        stmt.value, ast.Call
                    ):
                        self_value.value[stmt.target.id] = self._eval(stmt.value)
                    else:
                        tmp_name = ""
                        if hasattr(stmt.annotation, "id"):
                            tmp_name = stmt.annotation.id
                        elif hasattr(stmt.annotation, "value"):
                            tmp_name = stmt.annotation.value.id
                        if tmp_name:
                            self_value.value[stmt.target.id] = new_symbol(
                                name=tmp_name, def_at=node
                            )
                        else:
                            self_value.value[stmt.target.id] = new_symbol(
                                def_at=node
                            )
                else:
                    logger.warning(
                        f"AnnAssign Unsupported target: {ast.dump(node.target)}"
                    )
            elif isinstance(stmt, ast.Assign):
                stmt_value = self._eval(stmt.value)
                if len(stmt.targets) == 1:
                    target = stmt.targets[0]
                    if isinstance(target, ast.Name):
                        self_value.value[target.id] = stmt_value
                    else:
                        logger.warning(
                            f"visit_Assign Unsupported target: {ast.dump(target)}"
                        )
                else:
                    assert isinstance(stmt_value, list)
                    assert len(stmt_value) == len(stmt.targets)
                    for target, value in zip(stmt.targets, stmt_value):
                        self._eval(target).value = value
            elif isinstance(stmt, ast.FunctionDef):
                if stmt.name in self._env.value:
                    continue
                fn_value = FuncValue(stmt, self._env)
                self._env.value[stmt.name] = fn_value

                for decorator_item in stmt.decorator_list:
                    if isinstance(decorator_item, ast.Name):
                        if decorator_item.id == "classmethod":
                            fn_value.classmethod = True
                        elif decorator_item.id == "staticmethod":
                            fn_value.staticmethod = True

        fn = None
        try:
            fn = get_func_from_cls(node, "__init__")
        except ValueError:
            pass
        if fn is not None:
            runner = FuncRunner(
                fn,
                args=self._init_args,
                kwargs=self._init_kwargs,
                self_value=self_value,
                env=self._env,
                calls=self.torch_calls,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            )
            runner.run()
        elif not any(base.endswith("CustomOp") for base in get_inherited_classes(node)):
            base_val, init_value = self._resolve_super_method("__init__")
            if init_value is not None:
                old_def_at = self_value.def_at
                if base_val is not None:
                    existing_names = set(self_value.value)
                    self_value.add_functions_from(base_val.def_at)
                    for name, value in base_val.value.items():
                        if name not in existing_names and isinstance(value, FuncValue):
                            self_value.value[name] = value
                    self_value.def_at = base_val.def_at
                FuncRunner(
                    init_value.def_at,
                    args=self._init_args,
                    kwargs=self._init_kwargs,
                    self_value=self_value,
                    env=_find_module(init_value),
                    calls=self.torch_calls,
                    resolve_import_dirs=self._resolve_import_dirs,
                    call_graph=self.call_graph,
                ).run()
                self_value.def_at = old_def_at
        return self_value

    def _eval(self, node: ast.AST, update_to=None) -> Union[Value, List[Value]]:
        if not node:
            return None
        try:
            if isinstance(node, ast.List):
                val = []
                for item in node.elts:
                    val.append(self._eval(item))
                return val
            elif isinstance(node, ast.Name):
                if update_to is not None:
                    if node.id in self.local_env:
                        if isinstance(self.local_env[node.id], list):
                            if isinstance(update_to, list):
                                self.local_env[node.id].extend(update_to)
                            else:
                                self.local_env[node.id].append(update_to)
                        else:  
                            old_val = self.local_env[node.id]
                            if isinstance(update_to, list):
                                self.local_env[node.id] = [old_val] + update_to
                            else:
                                self.local_env[node.id] = [old_val, update_to]
                    else:
                        self.local_env[node.id] = update_to
                    return
                if node.id == "self":
                    return self._self_value
                elif node.id in self.local_env:
                    return self.local_env[node.id]
                elif node.id in self._env.value:
                    if update_to is not None:
                        self._env[node.id] = update_to
                        return
                    return self._env.value[node.id]
                else:
                    return new_symbol(node.id, def_at=node)
            elif isinstance(node, ast.Constant):
                return node.value
            elif isinstance(node, ast.Attribute):
                torch_op_name = _torch_ops_name(name_or_full_attr(node))
                if torch_op_name:
                    return new_symbol(
                        name=f"[op: {torch_op_name}]",
                        def_at=node,
                        ty=torch_op_name,
                    )
                if isinstance(node.value, ast.Name):
                    if node.value.id == "self":
                        if node.attr == "__class__":
                            return self._self_value.def_at
                        if update_to is not None:
                            if node.attr in self._self_value.value:
                                old_val = self._self_value.value[node.attr]
                                self._self_value.value[node.attr] = [old_val, update_to]
                            else:
                                self._self_value.value[node.attr] = update_to
                            return
                        if node.attr not in self._self_value.value:
                            return new_symbol(def_at=node)
                        return self._self_value.value[node.attr]
                    elif node.value.id == "torch":
                        return Value(None, ty=f"torch.{node.attr}", def_at=node)
                    elif node.value.id in self.local_env:
                        base_val = self.local_env[node.value.id]
                        if isinstance(base_val, dict):
                            if update_to is not None:
                                base_val[node.attr] = update_to
                                return
                            return base_val.get(node.attr, new_symbol(def_at=node))
                        
                        is_symbol = False
                        if isinstance(base_val, list):
                            for bv in base_val:
                                if bv.is_symbol():
                                    is_symbol = True
                                    break
                        else:
                            is_symbol = base_val.is_symbol()
                            
                        if is_symbol:
                            # try some aggressive guess:
                            # if attr is .shape, we guess it is a tensor
                            if node.attr == "shape":
                                guessed_tensor = ClassInstanceValue(None)
                                guessed_tensor.ty = "torch.Tensor"
                                guessed_tensor.value = {
                                    "shape": new_symbol(
                                        def_at=node, ty="torch.Tensor.shape"
                                    )
                                }
                                self.local_env[node.value.id] = guessed_tensor
                                guessed_tensor.value["shape"].metadata = guessed_tensor
                                return guessed_tensor.value["shape"]

                            return new_symbol(f"{base_val}.{node.attr}", def_at=node)
                        else:
                            if isinstance(base_val, ClassInstanceValue):
                                if base_val.ty == "torch.Tensor":
                                    if node.attr == "shape":
                                        shape_arr = base_val.value.get("shape")
                                        while isinstance(shape_arr, list):
                                            shape_arr = shape_arr[0]
                                        self._shape2tensor[shape_arr] = base_val

                                        return shape_arr
                                    
                                    if node.attr == "device":
                                        return base_val.value.get("device")
                                    if node.attr == "type":
                                        return base_val.value.get("type")
                                
                            if isinstance(base_val, list):
                                return_values = []
                                for bv in base_val:
                                    if node.attr not in bv.value:
                                        return_values.append(new_symbol(def_at=node))
                                    else:
                                        return_values.append(bv.value[node.attr])
                                return return_values
                            if node.attr not in base_val.value:
                                return new_symbol(def_at=node)
                            return base_val.value[node.attr]
                    elif node.value.id in self._env.value:
                        base_val = self._env.value[node.value.id]
                        if isinstance(base_val, ImportValue):
                            # mock the torch.nn.*
                            fullname = base_val.value + "." + node.attr
                            if fullname.startswith("torch.nn."):
                                mock_cls = ClassValue(None)
                                mock_cls.ty = fullname
                                return mock_cls

                            resolved = env_resolve(
                                self._env, base_val.value, self._resolve_import_dirs
                            )
                            if not resolved and "vllm.env" not in fullname:
                                resolved = env_resolve(
                                    self._env, node.value.id, self._resolve_import_dirs
                                )
                            if isinstance(resolved, CppBindingValue):
                                return CppBindingChildValue(node, name=f"{node.attr}")
                            if resolved:
                                return resolved.get(node.attr)
                            else:
                                return new_symbol(f"{base_val.value}.{node.attr}", def_at=node)
                        elif isinstance(base_val, ClassValue):
                            return base_val.value[node.attr]
                        elif isinstance(base_val, ModuleInstanceValue):
                            return base_val.value[node.attr]
                        elif isinstance(base_val, CppBindingValue):
                            return CppBindingChildValue(node, name=f"{node.attr}")
                        else:
                            return new_symbol(f"{base_val}.{node.attr}", def_at=node)
                    else:
                        return new_symbol(f"{node.value.id}.{node.attr}", def_at=node)
                elif isinstance(node.value, ast.Attribute):
                    if hasattr(node, "attr") and hasattr(node.value, "attr") and node.value.attr=="vllm" \
                        and isinstance(node.value.value, ast.Attribute) and hasattr(node.value.value, "attr") \
                            and node.value.value.attr == "ops" and isinstance(node.value.value.value, ast.Name) \
                                and hasattr(node.value.value.value, "id") and node.value.value.value.id == "torch":
                        function_name = node.attr
                        if function_name == "moe_forward":
                            function_name = "_moe_forward"
                        if function_name == "moe_forward_shared":
                            function_name = "_moe_forward_shared"
                        if function_name in self._env.value:
                            return self._env.value[function_name]
                        else:
                            resolved_result = env_resolve(
                                self._env, function_name, self._resolve_import_dirs
                            )
                            if resolved_result is not None:
                                return resolved_result
                    value = self._eval(node.value)
                    if value is None:
                        return new_symbol(def_at=node)
                    if isinstance(value, dict):
                        return value.get(node.attr, new_symbol(def_at=node))
                    if isinstance(value, ast.ClassDef) and node.attr == "name":
                        return value.name
                    if isinstance(value, list):
                        return_values = []
                        for val in value:
                            if not val:
                                continue
                            if isinstance(val, dict):
                                return_values.append(val[node.attr])
                            if isinstance(val, ast.ClassDef) and node.attr == "name":
                                return_values.append(val.name)
                            elif isinstance(val, Value) and hasattr(val.value, node.attr):
                                return_values.append(getattr(val.value, node.attr))
                        if return_values:
                            return return_values
                        else:
                            return new_symbol(def_at=node)
                    if isinstance(value, Value):
                        if not isinstance(value.value, dict) or node.attr not in value.value:
                            return new_symbol(def_at=node)
                    return value.value[node.attr]
                elif isinstance(node.value, ast.Subscript):
                    value = self._eval(node.value)
                    if isinstance(value, dict):
                        return value.get(node.attr, new_symbol(def_at=node))
                    if isinstance(value, list):
                        return_values = []
                        for val in value:
                            if not val:
                                continue
                            if isinstance(val, dict) and node.attr in val:
                                return_values.append(val[node.attr])
                            elif isinstance(val, Value) and node.attr in val.value:
                                return_values.append(val.value[node.attr])
                        if return_values:
                            return return_values
                        return new_symbol(def_at=node)
                    if isinstance(value, Value):
                        if value.is_symbol():
                            return new_symbol(f"{value}.{node.attr}", def_at=node)
                        if isinstance(value.value, dict) and node.attr in value.value:
                            return value.value[node.attr]
                    return new_symbol(def_at=node)
                elif isinstance(node.value, ast.Call):
                    ret_val = self._eval(node.value)
                    if isinstance(ret_val, list):
                        return_values = []
                        for rv in ret_val:
                            if rv.is_symbol():
                                return_values.append(new_symbol(f"{rv}.{node.attr}", def_at=node))
                            else:
                                return_values.append(rv.value[node.attr])
                        return return_values
                    else:
                        if ret_val is None:
                            return new_symbol(def_at=node)
                        if ret_val.is_symbol():
                            return new_symbol(
                                f"ret_val.{node.attr}",
                                def_at=node,
                            )
                        else:
                            if isinstance(ret_val, ast.Constant):
                                if ret_val.value:
                                    return ret_val.value
                                else:
                                    return new_symbol(def_at=node)
                            if isinstance(ret_val, Value) and isinstance(ret_val.value, ast.Constant):
                                if ret_val.value.value:
                                    return ret_val.value.value
                                else:
                                    return new_symbol(def_at=node)
                            if isinstance(ret_val, Value):
                                if not isinstance(ret_val.value, dict) or node.attr not in ret_val.value:
                                    return new_symbol(def_at=node)
                            return ret_val.value[node.attr]
                else:
                    print(f"_eval Unsupported node: {ast.dump(node)}")
            elif isinstance(node, ast.Tuple):
                val = []
                for item in node.elts:
                    val.append(self._eval(item))
                return val
            elif isinstance(node, ast.Subscript):
                base_val = self._eval(node.value)
                slice_val = self._eval(node.slice)
                
                if isinstance(base_val, ast.Dict):
                    base_val = self._handle_dict(base_val)
                
                if hasattr(base_val, "ty") and base_val.ty == "torch.nn.ModuleList":
                    if isinstance(slice_val, Value) and slice_val.is_symbol():
                        slice_val = 0
                    if isinstance(slice_val, int):
                        return list(base_val.get("_list").values())[slice_val]

                if isinstance(base_val, Value) and base_val.is_symbol():
                    # aggressive guess:
                    # if base_val is a tensor's shape, and slice_val is a constant integer,
                    # it means that in order to proceed this program, the base_val has to be that long
                    if base_val.ty == "torch.Tensor.shape":
                        if isinstance(slice_val, int):
                            if slice_val < 0:
                                return new_symbol(def_at=node)
                            base_val.metadata.value["shape"] = tuple(
                                [new_symbol() for _ in range(slice_val + 1)]
                            )
                            return base_val.metadata.value["shape"][slice_val]

                if isinstance(slice_val, tuple):
                    if any(isinstance(i, Value) and i.is_symbol() for i in slice_val):
                        return new_symbol(def_at=node)
                    if isinstance(base_val, Value):
                        if base_val.ty == "torch.Tensor":
                            new_tensor = ClassInstanceValue(None)
                            new_tensor.ty = "torch.Tensor"
                            new_tensor.value = {}
                            return new_tensor
                        elif base_val.ty == "torch.nn.ModuleList":
                            mod_list = list(base_val.get("_list").values())

                            return mod_list[slice_val[0] : slice_val[1] : slice_val[2]]
                    return base_val[slice_val[0] : slice_val[1] : slice_val[2]]
                elif isinstance(slice_val, int):
                    if update_to is not None:
                        base_val[slice_val] = update_to
                        return
                    return base_val[slice_val]
                elif isinstance(base_val, dict):
                    is_slice_symbol = False
                    if isinstance(slice_val, Value) and slice_val.is_symbol():
                        is_slice_symbol = True
                    elif isinstance(slice_val, list):
                        for sv in slice_val:
                            if isinstance(sv, Value) and sv.is_symbol():
                                is_slice_symbol = True
                                break
                    if is_slice_symbol:
                        return list(base_val.values())
                    return base_val.get(slice_val, new_symbol(def_at=node))
                elif isinstance(base_val, Value) and base_val.ty == "torch.Tensor":
                    new_tensor = _handle_tensor_selection(base_val, slice_val)
                    return new_tensor
                elif isinstance(base_val, Value):
                    if isinstance(base_val.value, (list, tuple)) and isinstance(slice_val, int):
                        try:
                            return base_val.value[slice_val]
                        except Exception:
                            return new_symbol(def_at=node)
                    if isinstance(base_val.value, dict):
                        return base_val.value.get(slice_val, new_symbol(def_at=node))
                    return new_symbol(def_at=node)
                else:
                    return new_symbol(def_at=node)
            elif isinstance(node, ast.Slice):
                return (
                    self._eval(node.lower) if node.lower else None,
                    self._eval(node.upper) if node.upper else None,
                    self._eval(node.step) if node.step else None,
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
            elif isinstance(node, ast.GeneratorExp):
                return self._handle_list_comp(node)
            elif isinstance(node, ast.Dict):
                return self._handle_dict(node)
            elif isinstance(node, ast.IfExp):
                return self._handle_ifesp(node)
            elif isinstance(node, ast.JoinedStr):
                return ""
            elif isinstance(node, ast.Lambda):
                return self._handle_lambda(node)
            else:
                logger.warning(
                    f"_eval Unsupported node: {ast.dump(node)} at line {node.lineno}"
                )
                return new_symbol(def_at=node)
        except Exception:
            logger.exception(f"failed to eval {ast.dump(node)} at line {node.lineno}")
            return new_symbol(def_at=node)

    def _handle_dict(self, node: ast.Dict):
        ret = {}
        for key, value in zip(node.keys, node.values):
            resolved_value = self._eval(key)
            if type(resolved_value) is not str:
                logger.warning(
                    f"Unsupported dict key type: {type(resolved_value)} for {ast.dump(node)}"
                )
            else:
                ret[resolved_value] = self._eval(value)

        return ret

    def _handle_lambda(self, node: ast.Lambda):
        lambda_value = LambdaValue(def_at=node, local_env=self.local_env, env=self._env)
        return lambda_value

    def _handle_ifesp(self, node: ast.IfExp):
        test = self._eval(node.test)
        if isinstance(test, Value) and test.is_symbol():
            return [self._eval(node.body), self._eval(node.orelse)]
        if to_primitive(test):
            return self._eval(node.body)
        else:
            return self._eval(node.orelse)

    def _expand_starred(self, node: ast.Starred):
        value = self._eval(node.value)
        if isinstance(value, list):
            return value
        elif isinstance(value, Value) and value.is_symbol():
            return new_symbol(def_at=node)
        else:
            logger.warning(f"Unsupported starred value: {ast.dump(node)}")
            return new_symbol(def_at=node)

    def visit_ImportFrom(self, node):
        self._env.add_import_from(node)

    def visit_FunctionDef(self, node):
        logger.debug(f"visit_FunctionDef: {node.name} at line {node.lineno}")
        self._visit_level += 1
        if self._visit_level == 1:
            return self.generic_visit(node)
        else:
            logger.debug("skipping nested function visit")

    def visit_For(self, node):
        logger.debug(f"visit_For: {ast.dump(node.iter)} at line {node.lineno}")
        skip_generic_visit = False
        if isinstance(node.iter, ast.Call):
            if isinstance(node.iter.func, ast.Name):
                if node.iter.func.id == "range":
                    skip_generic_visit = True
                    args = node.iter.args
                    start = 0
                    end = None
                    step = 1
                    if len(args) == 1:
                        end = to_primitive(self._eval(args[0]))
                    elif len(args) == 2:
                        start = to_primitive(self._eval(args[0]))
                        end = to_primitive(self._eval(args[1]))
                    elif len(args) >= 3:
                        start = to_primitive(self._eval(args[0]))
                        end = to_primitive(self._eval(args[1]))
                        step = to_primitive(self._eval(args[2]))

                    if not isinstance(start, int) or not isinstance(end, int) or not isinstance(step, int):
                        # Fallback to a single iteration when bounds are symbolic.
                        start = 0
                        end = 1
                        step = 1

                    if isinstance(node.target, ast.Name):
                        for i in range(start, end, step):
                            self._eval(node.target, i)
                            for stmt in node.body:
                                self.visit(stmt)
                    return
                if node.iter.func.id == "enumerate":
                    arg0 = node.iter.args[0]
                    arg0_val = self._eval(arg0)
                    if (
                        isinstance(arg0_val, Value)
                        and arg0_val.ty == "torch.nn.ModuleList"
                    ):
                        arg0_val = list(arg0_val.get("_list").values())
                    if isinstance(node.target, ast.Tuple):
                        skip_generic_visit = True
                        iter_items = arg0_val if isinstance(arg0_val, list) else [arg0_val]
                        for idx, item in enumerate(iter_items):
                            # enumerate's index
                            self._eval(node.target.elts[0], idx)
                            if isinstance(node.target.elts[1], ast.Tuple):
                                for i, el in enumerate(node.target.elts[1].elts):
                                    if isinstance(el, ast.Name):
                                        self._eval(el, item[i])
                            elif isinstance(node.target.elts[1], ast.Name):
                                self._eval(node.target.elts[1], item)
                            for stmt in node.body:
                                self.visit(stmt)
                elif node.iter.func.id == "dir":
                    skip_generic_visit = True
                    arg0_val = self._eval(node.iter)
                    if not arg0_val:
                        return
                    if isinstance(arg0_val, Value):
                        return
                    # simulate dir for loop
                    for item in arg0_val:
                        if isinstance(node.target, ast.Name):
                            self._eval(node.target, item)

                        for stmt in node.body:
                            self.visit(stmt)

                elif node.iter.func.id == "islice":
                    arg0 = node.iter.args[0]
                    arg0_val = self._eval(arg0)
                    if (
                        isinstance(arg0_val, Value)
                        and arg0_val.ty == "torch.nn.ModuleList"
                    ):
                        arg0_val = list(arg0_val.get("_list").values())
                    skip_generic_visit = True
                    iter_items = arg0_val if isinstance(arg0_val, list) else [arg0_val]
                    for idx, item in enumerate(iter_items):
                        self._eval(node.target, item)
                        for stmt in node.body:
                            self.visit(stmt)
                else:
                    logger.warning(
                        f"Unsupported for loop iterator: {ast.dump(node.iter)} at line {node.lineno}"
                    )
            elif isinstance(node.iter.func, ast.Attribute):
                base_val = self._eval(node.iter.func.value)

                if node.iter.func.attr == "named_children":
                    skip_generic_visit = True
                    if not isinstance(base_val, Value) and not isinstance(
                        base_val, dict
                    ):
                        return
                    logger.debug(
                        f"{base_val} at line {node.lineno} is calling named_children"
                    )
                    ncs = base_val.named_children()
                    for name, child in ncs:
                        logger.debug(
                            f"visit_For named_children: {name} at line {node.lineno}"
                        )
                        if isinstance(node.target, ast.Tuple):
                            if len(node.target.elts) == 2:
                                self._eval(node.target.elts[0], name)
                                self._eval(node.target.elts[1], child)
                                for stmt in node.body:
                                    self.visit(stmt)
                            else:
                                logger.warning(
                                    f"Unsupported target in for loop: {ast.dump(node.target)}"
                                )
                        else:
                            logger.warning(
                                f"Unsupported target in for loop: {ast.dump(node.target)}"
                            )
        else:
            try:
                iter_value = self._eval(node.iter)
                if (
                    isinstance(iter_value, Value)
                    and iter_value.ty == "torch.nn.ModuleList"
                ):
                    iter_value = list(iter_value.get("_list").values())
                if isinstance(iter_value, list):
                    skip_generic_visit = True
                    if isinstance(node.target, ast.Name):
                        for item in iter_value:
                            self._eval(node.target, item)
                            for stmt in node.body:
                                self.visit(stmt)

            except Exception:
                pass

        if not skip_generic_visit:
            for stmt in node.body:
                self.visit(stmt)
    
    def visit_Return(self, node):
        if node.value is not None:
            tmp_value = self._eval(node.value)
            if isinstance(tmp_value, Value):
                if tmp_value.is_symbol() or (isinstance(tmp_value.value, Value) and tmp_value.value.is_symbol()):
                    return_type = getTypeOfReturnValue(self.start_node)
                    if return_type and not _torch_ops_name(tmp_value.ty or ""):
                        import_val = getImport(self._env, return_type, self._resolve_import_dirs)
                        tmp_value.ty = return_type
                        if import_val:
                            tmp_value.metadata = import_val
            elif isinstance(tmp_value, list):
                return_type = getTypeOfReturnValue(self.start_node)
                if return_type:
                    import_val = getImport(self._env, return_type, self._resolve_import_dirs)
                    for v in tmp_value:
                        if (
                            isinstance(v, Value)
                            and v.is_symbol()
                            and not _torch_ops_name(v.ty or "")
                        ):
                            v.ty = return_type
                            if import_val:
                                v.metadata = import_val
            if self.return_value:
                if isinstance(self.return_value, list):
                    if isinstance(tmp_value, list):
                        for v in tmp_value:
                            if v not in self.return_value:
                                self.return_value.append(v)
                    elif tmp_value not in self.return_value:
                        self.return_value.append(tmp_value)
                else:
                    old_value = self.return_value
                    if isinstance(tmp_value, list):
                        if old_value not in tmp_value:
                            tmp_value.insert(0, old_value)
                        self.return_value = tmp_value
                    else:
                        self.return_value = [old_value, tmp_value]
            else:
                self.return_value = tmp_value
            logger.debug(f"visit_Return return value: {self.return_value} at line {node.lineno}")

    def _handle_list_comp(self, node: Union[ast.ListComp, ast.GeneratorExp]):
        if len(node.generators) > 1:
            logger.warning("Do not support more than 1 generater")
            return new_symbol(def_at=node)

        iterator = node.generators[0].iter
        if isinstance(iterator, ast.Name):
            iterator = self.local_env.get(iterator.id, None)
            if isinstance(iterator, list):
                val = []
                for item in iterator:
                    target = node.generators[0].target
                    self._eval(target, item)
                    val.append(self._eval(node.elt))
                return val
        if not isinstance(iterator, ast.Call):
            logger.warning("Do not support iterator is not call")
            return new_symbol(def_at=node)

        if iterator.func.id == "range":
            if len(iterator.args) == 1:
                arr_len = to_primitive(self._eval(iterator.args[0]))
                if not isinstance(arr_len, int) and isinstance(iterator.args[0], ast.Attribute):
                    if "_layer" in iterator.args[0].attr:
                        arr_len = 1
                        
                if not isinstance(arr_len, int):
                    logger.warning("Do not support iterator range with non int arg")
                    return new_symbol(def_at=node)

                val = []
                target = node.generators[0].target
                for i in range(arr_len):
                    if isinstance(target, ast.Name):
                        self._eval(target, i)
                    val.append(self._eval(node.elt))
                return val
            elif len(iterator.args) == 2:
                start = to_primitive(self._eval(iterator.args[0]))
                end = to_primitive(self._eval(iterator.args[1]))
                if not isinstance(start, int) or not isinstance(end, int):
                    start = 0
                    end = 1
                val = []
                target = node.generators[0].target
                for i in range(start, end):
                    if isinstance(target, ast.Name):
                        self._eval(target, i)
                    val.append(self._eval(node.elt))
                return val
            else:
                logger.warning(
                    f"Unsupported range args: {len(iterator.args)} at line {node.lineno}"
                )
                return new_symbol(def_at=node)
        elif iterator.func.id == "zip":
            in_items = self._eval(iterator)
            val = []
            for in_item in in_items:
                target = node.generators[0].target
                if isinstance(target, ast.Tuple):
                    if len(target.elts) != len(in_item):
                        logger.warning(
                            f"Unsupported target in list comprehension: {ast.dump(target)}"
                        )
                        return new_symbol(def_at=node)
                    for i, el in enumerate(target.elts):
                        if isinstance(el, ast.Name):
                            self._eval(el, in_item[i])

                    elm = self._eval(node.elt)
                    val.append(elm)
            return val
        else:
            logger.warning(
                f"Unsupported iterator: {ast.dump(iterator)} at line {node.lineno}"
            )
            return new_symbol(def_at=node)

    def _handle_unary_op(self, node: ast.UnaryOp):
        super().generic_visit(node)
        op = node.op
        operand = self._eval(node.operand)
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
            print(f"visit_UnaryOp Unsupported op: {ast.dump(node)}")

    def _handle_bool_op(self, node: ast.BoolOp):
        super().generic_visit(node)
        op = node.op
        if isinstance(op, ast.And):
            values = [self._eval(v) for v in node.values]
            for v in values:
                if isinstance(v, Value) and v.is_symbol():
                    return new_symbol(def_at=node)
            return all([to_primitive(v) for v in values])
        elif isinstance(op, ast.Or):
            values = [self._eval(v) for v in node.values]
            for v in values:
                if isinstance(v, Value) and v.is_symbol():
                    return new_symbol(def_at=node)
            return any([to_primitive(v) for v in values])
        else:
            print(f"visit_BoolOp Unsupported op: {ast.dump(node)}")
            return new_symbol(def_at=node)

    def _is_super_init(self, node: ast.Attribute):
        if (
            isinstance(node.value, ast.Call)
            and isinstance(node.value.func, ast.Name)
            and node.value.func.id == "super"
            and node.attr == "__init__"
        ):
            return True
        if isinstance(node.value, ast.Name):
            base = self._eval(node.value)
            if isinstance(base, SuperValue) and node.attr == "__init__":
                return True
        return False

    def _is_super_method(self, node: ast.Attribute):
        if (
            isinstance(node.value, ast.Call)
            and isinstance(node.value.func, ast.Name)
            and node.value.func.id == "super"
        ):
            return True
        if isinstance(node.value, ast.Name):
            base = self._eval(node.value)
            if isinstance(base, SuperValue):
                return True
        return False

    def _resolve_super_method(self, method_name: str):
        if not self._self_value or not getattr(self._self_value, "def_at", None):
            return None, None

        if isinstance(self._self_value, ClassInstanceValue):
            base_classes = get_inherited_classes_by_value(self._self_value)
        else:
            base_classes = get_inherited_classes(self._self_value.def_at)
        for base_cls in base_classes:
            if (
                base_cls.endswith("nn.Module")
                or base_cls.endswith("PreTrainedModel")
                or base_cls.startswith("torch.nn")
            ):
                continue

            base_val = None
            try:
                base_val = self._env.get(base_cls)
            except Exception:
                pass

            if isinstance(base_val, ImportValue):
                base_val = resolve_import_value(
                    self._env, base_val, self._resolve_import_dirs
                )
            if base_val is None:
                base_val = env_resolve(self._env, base_cls, self._resolve_import_dirs)

            if not isinstance(base_val, ClassValue):
                continue

            func = base_val.get(method_name) if method_name in base_val.value else None
            if isinstance(func, FuncValue):
                return base_val, func

            if method_name == "forward":
                if isinstance(base_val, ClassInstanceValue):
                    base_inheritance = get_inherited_classes_by_value(base_val)
                else:
                    base_inheritance = get_inherited_classes(base_val.def_at)
                if any("CustomOp" in base for base in base_inheritance):
                    if "forward_cuda" in base_val.value:
                        return base_val, base_val.value["forward_cuda"]
                    if "forward_native" in base_val.value:
                        return base_val, base_val.value["forward_native"]

        return None, None
    
    def _handle_one_self_call(self, node, func: Value, args, kwargs, parts):
        self_value = None
        if isinstance(func, LambdaValue):
            func = FuncRunner(
                func.def_at,
                args=None,
                kwargs=None,
                self_value=None,
                env=func.env,
                calls=self.torch_calls,
                local_env=func.local_env,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()

        if isinstance(func, list):
            return_values = []
            for candidate in func:
                if not candidate:
                    continue
                tmp_res = self._handle_one_self_call(node, candidate, args, kwargs, parts)
                if tmp_res is None:
                    continue
                if isinstance(tmp_res, list):
                    return_values.extend(tmp_res)
                else:
                    return_values.append(tmp_res)
            if return_values:
                if len(return_values) == 1:
                    return return_values[0]
                return return_values
            return new_symbol(def_at=node)

        if isinstance(func, ClassValue) and not isinstance(func, ClassInstanceValue):
            new_env = _find_module(func)
            if self.cg_key and self.cg_key in self.call_graph:
                item = {
                    "class": func.def_at.name,
                    "function": "__init__",
                    "filepath": new_env.file_path,
                    "line": node.lineno,
                }
                if item not in self.call_graph[self.cg_key]["callees"]:
                    self.call_graph[self.cg_key]["callees"].append(item)
            return FuncRunner(
                func.def_at,
                args=args,
                kwargs=kwargs,
                self_value=None,
                env=new_env,
                calls=self.torch_calls,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()
            
        if isinstance(func, ClassInstanceValue):
            func_ty = (func.ty or "").lower()
            if func.ty != "torch.nn.LayerNorm" and func_ty.find("norm") != -1:
                if len(args) == 1:
                    # if calling normalizing layer, like BatchNorm, LayerNorm
                    # we don't need to actually call it,
                    # since it does not change the shape of the tensor
                    return args[0]

            self_value = func

            if any("CustomOp" in base for base in func.inheritance):
                # vllm CustomOp
                if "forward_cuda" in func.value:
                    func = func.value["forward_cuda"]
                elif "forward" in func.value:
                    func = func.value["forward"]
            elif "forward" in func.value:
                func = func.value["forward"]
            else:
                typed_method_sig = f"{func.ty}.__call__"
                if typed_method_sig in torch_apis:
                    return torch_apis[typed_method_sig](
                        args, kwargs=kwargs, self_value=self_value
                    )
                logger.warning(
                    f"visit_Call Unsupported callee: {ast.dump(node)} at line {node.lineno}"
                )
                return new_symbol(def_at=node)
        elif isinstance(func, ImportValue):
            resolved_result = resolve_import_value(self._env, func, self._resolve_import_dirs)
            if resolved_result is not None:
                if isinstance(resolved_result, list):
                    return_values = []
                    for res in resolved_result:
                        new_env=_find_module(res)
                        if self.cg_key and self.cg_key in self.call_graph:
                            item = {"class": None, "function": res.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                            if item not in self.call_graph[self.cg_key]["callees"]:
                                self.call_graph[self.cg_key]["callees"].append(item)
                        tmp_res = FuncRunner(
                                    res.def_at,
                                    args=args,
                                    kwargs=kwargs,
                                    self_value=None,
                                    env=new_env,
                                    calls=self.torch_calls,
                                    resolve_import_dirs=self._resolve_import_dirs,
                                    call_graph=self.call_graph,
                                ).run()
                        if isinstance(tmp_res, list):
                            return_values.extend(tmp_res)
                        else:
                            return_values.append(tmp_res)
                    return return_values
                
                new_env=_find_module(resolved_result)
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": None, "function": resolved_result.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)
                return FuncRunner(
                    resolved_result.def_at,
                    args=args,
                    kwargs=kwargs,
                    self_value=None,
                    env=new_env,
                    calls=self.torch_calls,
                    resolve_import_dirs=self._resolve_import_dirs,
                    call_graph=self.call_graph,
                ).run()

            logger.warning(
                f"visit_Call Unsupported callee: {func.value} at line {node.lineno}"
            )
            return new_symbol(def_at=node)
        elif func.is_symbol():
            if func.ty:
                torch_op_name = _torch_ops_name(func.ty)
                if torch_op_name:
                    self._record_callee(torch_op_name, line=node.lineno)
                    if torch_op_name in {
                        "torch.ops.vllm.moe_forward",
                        "torch.ops.vllm.moe_forward_shared",
                    } and self._self_value and "forward_impl" in self._self_value.value:
                        forward_impl = self._self_value.value["forward_impl"]
                        if isinstance(forward_impl, FuncValue):
                            impl_args = [
                                new_symbol(name="layer", def_at=node),
                                args[0] if len(args) > 0 else new_symbol(def_at=node),
                                args[1] if len(args) > 1 else new_symbol(def_at=node),
                                args[2] if len(args) > 2 else new_symbol(def_at=node),
                            ]
                            new_env = _find_module(forward_impl)
                            self._record_callee(
                                forward_impl.def_at.name,
                                filepath=new_env.file_path,
                                line=node.lineno,
                                class_name=getattr(self._self_value.def_at, "name", None),
                            )
                            return FuncRunner(
                                forward_impl.def_at,
                                args=impl_args,
                                kwargs={},
                                self_value=self._self_value,
                                env=new_env,
                                calls=self.torch_calls,
                                resolve_import_dirs=self._resolve_import_dirs,
                                call_graph=self.call_graph,
                            ).run()
                    return new_symbol(def_at=node)
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": None, "function": func.ty, "filepath": self._env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)    
                
            return new_symbol(def_at=node)
        else:
            if len(parts) == 2:
                self_value = self._self_value
            else:
                self_value = self._self_value.get(".".join(parts[1:-1]))
        assert isinstance(func, FuncValue)
        
        new_env=_find_module(func)
        if self.cg_key and self.cg_key in self.call_graph:
            class_name = None
            if isinstance(self_value, list):
                for candidate in self_value:
                    if getattr(candidate, "def_at", None):
                        class_name = candidate.def_at.name
                        break
                    if getattr(candidate, "ty", None):
                        class_name = candidate.ty
                        break
            else:
                if getattr(self_value, "def_at", None):
                    class_name = self_value.def_at.name
                elif getattr(self_value, "ty", None):
                    class_name = self_value.ty

            item = {"class": class_name, "function": func.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
            if item not in self.call_graph[self.cg_key]["callees"]:
                self.call_graph[self.cg_key]["callees"].append(item)
        runner = FuncRunner(
            func.def_at,
            args=args,
            kwargs=kwargs,
            self_value=self_value,
            env=new_env,
            calls=self.torch_calls,
            resolve_import_dirs=self._resolve_import_dirs,
            call_graph=self.call_graph,
        )
        return runner.run()
    
    def _handle_one_name_call(self, node, base_val, args, kwargs):
        if base_val and isinstance(base_val, Value) and base_val.is_symbol():
            if base_val.ty:
                torch_op_name = _torch_ops_name(base_val.ty)
                if torch_op_name:
                    self._record_callee(torch_op_name, line=node.lineno)
                    return new_symbol(def_at=node)
                new_env = self._env
                resolved_result = env_resolve(
                    self._env, base_val.ty, self._resolve_import_dirs
                )
                if resolved_result is not None:
                    new_env = _find_module(resolved_result)
                else:
                    if isinstance(base_val.metadata, ImportValue):
                        resolved_result = resolve_import_value(self._env, base_val.metadata, self._resolve_import_dirs)
                        if resolved_result is not None:
                            new_env = _find_module(resolved_result)
                    elif isinstance(base_val.metadata, ClassValue):
                        new_env = _find_module(base_val.metadata)
                
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": base_val.ty, "function": node.func.id, "type": base_val.ty, "filepath": new_env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["unknown"]:
                        self.call_graph[self.cg_key]["unknown"].append(item)
            return_val = new_symbol(def_at=node, ty=base_val.ty)
            if base_val.metadata:
                return_val.metadata = base_val.metadata
            return return_val
        elif isinstance(base_val, ClassInstanceValue):
            self_value = None
            func = None

            # check whether it is our mocked torch class
            if base_val.ty.startswith("torch.nn."):
                typed_method_sig = f"{base_val.ty}.__call__"
                if typed_method_sig in torch_apis:
                    return torch_apis[typed_method_sig](
                        args, kwargs=kwargs, self_value=base_val
                    )

            if "forward" in base_val.value:
                self_value = base_val
                func = base_val.value["forward"]

            else:
                logger.warning(
                    f"Not supported call class {ast.dump(node)} at line {node.lineno}"
                )
                return new_symbol(def_at=node)
            
            new_env = _find_module(func)
            if self.cg_key and self.cg_key in self.call_graph:
                item = {"class": self_value.def_at.name, "function": func.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                if item not in self.call_graph[self.cg_key]["callees"]:
                    self.call_graph[self.cg_key]["callees"].append(item)
            return FuncRunner(
                func.def_at,
                args=args,
                kwargs=kwargs,
                self_value=self_value,
                env=new_env,
                calls=self.torch_calls,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()
        elif isinstance(base_val, ClassValue):
            new_env = _find_module(base_val)
            if self.cg_key and self.cg_key in self.call_graph:
                item = {"class": base_val.def_at.name, "function": "__init__", "filepath": new_env.file_path, "line": node.lineno}
                if item not in self.call_graph[self.cg_key]["callees"]:
                    self.call_graph[self.cg_key]["callees"].append(item)
            return FuncRunner(
                base_val.def_at,
                args=args,
                kwargs=kwargs,
                self_value=None,
                env=new_env,
                calls=self.torch_calls,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()
        elif isinstance(base_val, CppBindingChildValue):
            self.torch_calls.append(
                TorchCall(
                    name=base_val.value,
                    args=[serialize_value(arg) for arg in args],
                    kwargs={k: serialize_value(v) for k, v in kwargs.items()},
                    lineno=node.lineno,
                )
            )
            if self.cg_key and self.cg_key in self.call_graph:
                item = {"class": None, "function": base_val.value, "filepath": self._env.file_path, "line": node.lineno}
                if item not in self.call_graph[self.cg_key]["callees"]:
                    self.call_graph[self.cg_key]["callees"].append(item)
        elif isinstance(base_val, FuncValue):
            # nested function call
            if self.cg_key and self.cg_key in self.call_graph:
                item = {"class": None, "function": base_val.def_at.name, "filepath": self._env.file_path, "line": node.lineno}
                if item not in self.call_graph[self.cg_key]["callees"]:
                    self.call_graph[self.cg_key]["callees"].append(item)
            return FuncRunner(
                base_val.def_at,
                args=args,
                kwargs=kwargs,
                self_value=None,
                env=self._env,
                calls=self.torch_calls,
                local_env=self.local_env,  # nested function call will inherit the local env
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()
        elif isinstance(base_val, LambdaValue):
            return FuncRunner(
                base_val.def_at,
                args=args,
                kwargs=kwargs,
                self_value=None,
                env=base_val.env,
                calls=self.torch_calls,
                local_env=base_val.local_env,
                resolve_import_dirs=self._resolve_import_dirs,
                call_graph=self.call_graph,
            ).run()
        return None
    
    def handleLocalEnvCall(self, node, callee_self, callee_method, args, kwargs):
        if isinstance(callee_self, ImportValue):
            res_class = resolve_import_value(self._env, callee_self, self._resolve_import_dirs)
            if res_class and isinstance(res_class, ClassValue):
                resolved_result = res_class.get(callee_method)
                if resolved_result:
                    new_env = _find_module(res_class)
                    if self.cg_key and self.cg_key in self.call_graph:
                        item = {"class": res_class.def_at.name, "function": resolved_result.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                        if item not in self.call_graph[self.cg_key]["callees"]:
                            self.call_graph[self.cg_key]["callees"].append(item)
                    return FuncRunner(
                        resolved_result.def_at,
                        args=args,
                        kwargs=kwargs,
                        self_value=None,
                        env=new_env,
                        calls=self.torch_calls,
                        resolve_import_dirs=self._resolve_import_dirs,
                        call_graph=self.call_graph,
                    ).run()
        elif isinstance(callee_self, Value) and callee_self.is_symbol():
            if callee_self.ty:
                import_val = callee_self.metadata
                resolved_class = env_resolve(
                    self._env, callee_self.ty, self._resolve_import_dirs
                )
                if not resolved_class and import_val:
                    resolved_class = resolve_import_value(self._env, import_val, self._resolve_import_dirs)
                if resolved_class and isinstance(resolved_class, ClassValue):
                    resolved_result = resolved_class.get(callee_method)
                    new_ty = ""
                    new_import_val = None
                    if resolved_result and hasattr(resolved_result.def_at, "returns"):
                        new_env = _find_module(resolved_class)
                        new_ty = getTypeOfReturnValue(resolved_result.def_at)
                        if new_ty:
                            new_import_val = getImport(new_env, new_ty, self._resolve_import_dirs)
                    if new_ty:
                        return_val = new_symbol(def_at=node, ty=new_ty)
                        if new_import_val:
                            return_val.metadata = new_import_val
                        return return_val
            return new_symbol(def_at=node)

    def _handle_call(self, node: ast.Call):
        args = []
        kwargs = {}
        for arg in node.args:
            if isinstance(arg, ast.Starred):
                args.extend(self._started_args or [])
            else:
                args.append(self._eval(arg))
        for kw in node.keywords:
            if kw.arg is None:
                karg = self._eval(kw.value)
                if isinstance(karg, dict):
                    kwargs.update(karg)
            else:
                kwargs[kw.arg] = self._eval(kw.value)
        global torch_apis

        if isinstance(node.func, ast.Attribute):
            if self._is_super_init(node.func):
                if "config" in self.local_env:
                    self._self_value.value["config"] = self.local_env["config"]

                base_classes = get_inherited_classes(self._self_value.def_at)
                for base_cls in base_classes:
                    if base_cls not in self._self_value.inheritance:
                        self._self_value.inheritance.append(base_cls)
                    if base_cls.endswith("nn.Module") or base_cls.endswith(
                        "PreTrainedModel"
                    ) or base_cls.startswith("torch.nn"):
                        continue

                    try:
                        item = self._env.get(base_cls)
                    except Exception:
                        continue
                    init_fn = None
                    resolved = None
                    if isinstance(item, ClassValue):
                        existing_names = set(self._self_value.value)
                        self._self_value.add_functions_from(item.def_at)
                        for name, value in item.value.items():
                            if name not in existing_names and isinstance(value, FuncValue):
                                self._self_value.value[name] = value

                        try:
                            init_fn = get_func_from_cls(item.def_at, "__init__")
                        except ValueError:
                            pass
                    elif isinstance(item, ImportValue):
                        # this is imported class
                        # find whether we need to resolve the import
                        if self._resolve_import_dirs is not None:
                            resolved = resolve_import_value(
                                self._env,
                                item,
                                self._resolve_import_dirs,
                            )
                            if resolved is not None and isinstance(
                                resolved, ClassValue
                            ):
                                existing_names = set(self._self_value.value)
                                self._self_value.add_functions_from(resolved.def_at)
                                for name, value in resolved.value.items():
                                    if name not in existing_names and isinstance(value, FuncValue):
                                        self._self_value.value[name] = value

                                try:
                                    init_fn = get_func_from_cls(
                                        resolved.def_at, "__init__"
                                    )
                                except ValueError:
                                    pass

                    else:
                        logger.warning(
                            f"Unsupported init: {ast.dump(node)} at line {node.lineno}"
                        )

                    if init_fn:
                        old_def_at = self._self_value.def_at
                        if resolved is not None:
                            self._self_value.def_at = resolved.def_at
                        elif isinstance(item, ClassValue):
                            self._self_value.def_at = item.def_at
                        
                        runner = FuncRunner(
                            init_fn,
                            args=args,
                            kwargs=kwargs,
                            self_value=self._self_value,
                            env=_find_module(resolved) if resolved else self._env,
                            calls=self.torch_calls,
                            resolve_import_dirs=self._resolve_import_dirs,
                            call_graph=self.call_graph,
                        )

                        runner.run()
                        self._self_value.def_at = old_def_at

                return None
            if self._is_super_method(node.func):
                base_val, func = self._resolve_super_method(node.func.attr)
                if func is not None:
                    new_env = _find_module(func)
                    self._record_callee(
                        func.def_at.name,
                        filepath=new_env.file_path,
                        line=node.lineno,
                        class_name=base_val.def_at.name if base_val else None,
                    )

                    old_def_at = self._self_value.def_at
                    if base_val is not None:
                        existing_names = set(self._self_value.value)
                        self._self_value.add_functions_from(base_val.def_at)
                        for name, value in base_val.value.items():
                            if name not in existing_names and isinstance(value, FuncValue):
                                self._self_value.value[name] = value
                        self._self_value.def_at = base_val.def_at
                    try:
                        return FuncRunner(
                            func.def_at,
                            args=args,
                            kwargs=kwargs,
                            self_value=self._self_value,
                            env=new_env,
                            calls=self.torch_calls,
                            resolve_import_dirs=self._resolve_import_dirs,
                            call_graph=self.call_graph,
                        ).run()
                    finally:
                        self._self_value.def_at = old_def_at

            callee_name = name_or_full_attr(node.func)
            full_callee_name = resolve_with_import(callee_name, self._env)
            logger.debug(f"handling callee: {full_callee_name} at line {node.lineno}")
            if (isinstance(self.start_node, ast.ClassDef) or isinstance(self.start_node, ast.FunctionDef)) and callee_name == self.start_node.name:
                return new_symbol(def_at=node)

            torch_op_name = _torch_ops_name(full_callee_name)
            if torch_op_name:
                self._record_callee(torch_op_name, line=node.lineno)
                return new_symbol(name=f"[return: {torch_op_name}]", def_at=node)

            if full_callee_name.startswith("logger."):
                return None
            elif full_callee_name.startswith("self.register_buffer") or full_callee_name.startswith("self.register_parameter"):
                self._self_value.value[args[0]] = args[1]
                return None
            elif full_callee_name.startswith("self.post_init"):
                return None
            self_inheritance = []
            if isinstance(self._self_value, list):
                for candidate in self._self_value:
                    self_inheritance.extend(getattr(candidate, "inheritance", []))
            elif self._self_value:
                self_inheritance = getattr(self._self_value, "inheritance", [])

            if self_inheritance and "MessagePassing" in self_inheritance:
                if full_callee_name.startswith("self._collect"):
                    return _handle_message_passing_collect(args, kwargs)
                elif full_callee_name.startswith("self.inspector.distribute"):
                    return _handle_message_passing_inspector_distribute(args, kwargs)

            need_redirect = False
            if full_callee_name.startswith("vllm.platforms.current_platform.is"):
                if "cuda" in full_callee_name:
                    if self.cg_key and "-Attention" in self.cg_key:
                        return new_symbol(def_at=node, ty="bool")
                    return True
                else:    
                    if self.cg_key and "-Attention" in self.cg_key:
                        return new_symbol(def_at=node, ty="bool")                
                    return False
                
            if self.torch_calls is not None and (
                # or 
                full_callee_name.find("cache_kernels") != -1
                or full_callee_name.find("_cuda") != -1
            ):
                self.torch_calls.append(
                    TorchCall(
                        name=full_callee_name,
                        args=[serialize_value(arg) for arg in args],
                        kwargs={k: serialize_value(v) for k, v in kwargs.items()},
                        lineno=node.lineno,
                    )
                )
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": None, "function": full_callee_name, "filepath": self._env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)

            if full_callee_name in torch_apis:
                try:
                    return torch_apis[full_callee_name](args, kwargs=kwargs)
                except Exception:
                    logger.exception("failed to run torch api")
                    return new_symbol(def_at=node)

            parts = full_callee_name.split(".")
            if (full_callee_name=="self.impl.forward" or "attn_layer.impl" in full_callee_name) and self.cg_key and "attention" in self.cg_key:
                ty = "AttentionImplBase"
                resolved_result = env_resolve(
                    self._env, "AttentionBackend", self._resolve_import_dirs
                )
                if resolved_result is not None:
                    new_env = _find_module(resolved_result)
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": None, "function": full_callee_name, "type": ty, "filepath": new_env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["unknown"]:
                        self.call_graph[self.cg_key]["unknown"].append(item)
                return new_symbol(def_at=node)
            
            elif full_callee_name.startswith("self"):
                func = None
                try:
                    if len(parts) > 2:
                        selector = ".".join(parts[1:-1])
                        inst = self._self_value.get(selector)
                        if isinstance(inst, list):
                            return_values = []
                            for candidate in inst:
                                if not candidate or not candidate.ty:
                                    continue
                                typed_method_sig = ".".join([candidate.ty] + parts[-1:])
                                if typed_method_sig in torch_apis:
                                    return_values.append(torch_apis[typed_method_sig](
                                        args, kwargs=kwargs, self_value=candidate
                                    ))
                            if return_values:
                                if len(return_values) == 1:
                                    return return_values[0]
                                return return_values
                        else:    
                            if inst.ty is None:
                                typed_method_sig = None
                            else:
                                typed_method_sig = ".".join([inst.ty] + parts[-1:])
                            if typed_method_sig in torch_apis:
                                return torch_apis[typed_method_sig](
                                    args, kwargs=kwargs, self_value=inst
                                )
                    if self._self_value is None:
                        func = self._env.value.get(".".join(parts[1:]))
                    else:
                        func = self._self_value.get(".".join(parts[1:]))
                except Exception:
                    logger.exception(
                        f"visit_Call Unsupported callee: {ast.dump(node)} at line {node.lineno}"
                    )
                    try:
                        ty = None
                        targets = None
                        metadata = None
                        
                        if len(parts) == 3 and parts[1] == "kernel" and parts[2] == "apply_weights":
                            if self._env.file_path and "scheme" in self._env.file_path:
                                ty = "Int8ScaledMMLinearKernel"
                                metadata = ImportValue(def_at=None, value="vllm.model_executor.kernels.linear.scaled_mm.ScaledMMLinearKernel.Int8ScaledMMLinearKernel")
                            else:
                                ty = "MPLinearKernel"
                                metadata = ImportValue(def_at=None, value="vllm.model_executor.kernels.linear.mixed_precision.MPLinearKernel.MPLinearKernel")
                        else:
                            targets = self._self_value.get(parts[1])
                        
                        t_bases = []
                        if isinstance(targets, list):
                            for target in targets:
                                if not target:
                                    continue
                                if isinstance(target, Value) and target.is_symbol() and target.ty:
                                    ty = target.ty
                                    metadata = target.metadata
                                    break
                                elif isinstance(target.def_at, ast.ClassDef):
                                    if isinstance(target, ClassInstanceValue):
                                        t_bases.extend(get_inherited_classes_by_value(target))
                                    else:
                                        t_bases.extend(get_inherited_classes(target.def_at))
                                    t_bases = list(set(t_bases))
                        elif isinstance(targets, Value) and targets.is_symbol() and targets.ty:
                            ty = targets.ty
                            metadata = target.metadata
                        elif isinstance(targets, ClassValue) and targets.def_at:
                            t_bases = get_inherited_classes(targets.def_at)
                        elif isinstance(targets, ClassInstanceValue):
                            t_bases = get_inherited_classes_by_value(targets)
                        
                        new_env = self._env
                        if ty is not None:
                            resolved_result = env_resolve(
                                self._env, ty, self._resolve_import_dirs
                            )
                            if resolved_result is not None:
                                new_env = _find_module(resolved_result)
                            elif metadata:
                                if isinstance(metadata, ImportValue):
                                    resolved_result = resolve_import_value(self._env, metadata, self._resolve_import_dirs)
                                    if resolved_result is not None:
                                        new_env = _find_module(resolved_result)
                                elif isinstance(metadata, ClassValue):
                                    new_env = _find_module(metadata)
                        elif t_bases:
                            for base_cls in t_bases:
                                if not base_cls:
                                    continue   
                                if base_cls.endswith("nn.Module") or base_cls.endswith(
                                    "PreTrainedModel"
                                ) or base_cls.startswith("torch.nn") or base_cls.endswith("CustomOp"):
                                    continue
                                
                                ty = base_cls
                                resolved_result = env_resolve(
                                    self._env, base_cls, self._resolve_import_dirs
                                )
                                if resolved_result is not None:
                                    new_env = _find_module(resolved_result)
                                    break
                                
                        if self.cg_key and self.cg_key in self.call_graph:
                            item = {"class": None, "function": full_callee_name, "type": ty, "filepath": new_env.file_path, "line": node.lineno}
                            if item not in self.call_graph[self.cg_key]["unknown"]:
                                self.call_graph[self.cg_key]["unknown"].append(item)
                    except Exception:
                        traceback.print_exc()
                        pass
                    return new_symbol(def_at=node)
                
                if isinstance(func, list):
                    return_values = []
                    for f in func:
                        if f:
                            if isinstance(f, list):
                                for ff in f:
                                    if ff:
                                        return_values.append(self._handle_one_self_call(node, ff, args, kwargs, parts))
                            else:
                                return_values.append(self._handle_one_self_call(node, f, args, kwargs, parts))
                    if return_values:
                        if len(return_values) == 1:
                            return return_values[0]
                        return return_values
                    else:
                        return new_symbol(
                            def_at=node,
                            name=f"[return: {full_callee_name}]",
                        )
                return self._handle_one_self_call(node, func, args, kwargs, parts)
                
            elif len(parts) > 1 and parts[-1].startswith("forward"):
                func = None
                if parts[-1] in self._env.value:
                    func = self._env.value[parts[-1]]
                elif parts[-1] in self._self_value.value:
                    func = self._self_value.value[parts[-1]]
                if func and isinstance(func, FuncValue):
                    new_env = _find_module(func)
                    if self.cg_key and self.cg_key in self.call_graph:
                        item = {"class": None, "function": func.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                        if item not in self.call_graph[self.cg_key]["callees"]:
                            self.call_graph[self.cg_key]["callees"].append(item)
                    return FuncRunner(
                        func.def_at,
                        args=args,
                        kwargs=kwargs,
                        self_value=self._self_value,
                        env=new_env,
                        calls=self.torch_calls,
                        resolve_import_dirs=self._resolve_import_dirs,
                        call_graph=self.call_graph,
                    ).run()
            elif parts[0] in self.local_env:
                callee_self = self.local_env[parts[0]]
                i = 1
                while isinstance(callee_self, Value) and callee_self.value and i < len(parts) - 1:
                    key = parts[i]
                    if isinstance(callee_self, bool):
                        return new_symbol(
                            def_at=node,
                            name=f"[return: {full_callee_name}]",
                        )
                    if key not in callee_self.value:
                        return new_symbol(
                            def_at=node,
                            name=f"[return: {full_callee_name}]",
                        )
                    callee_self = callee_self.value[key]
                    i += 1
                callee_method = parts[-1]
                logger.debug(f"callee_self: {callee_self}, {type(callee_self)}")
                logger.debug(f"callee: {parts[-1]}")
                
                if isinstance(callee_self, list):
                    return_values = []
                    for candidate in callee_self:
                        tmp_value = self.handleLocalEnvCall(node, candidate, callee_method, args, kwargs)
                        if tmp_value:
                            return_values.append(tmp_value)
                    if return_values:
                        if len(return_values) == 1:
                            return return_values[0]
                        return return_values
                    
                typed_method_sig = None
                if isinstance(callee_self, ClassInstanceValue):
                    typed_method_sig = f"{callee_self.ty}.{callee_method}"
                    logger.debug(
                        f"typed_method_sig: {typed_method_sig} at line {node.lineno}"
                    )

                if typed_method_sig in torch_apis:
                    try:
                        return torch_apis[typed_method_sig](
                            args, kwargs=kwargs, self_value=callee_self
                        )
                    except Exception:
                        logger.warning(
                            f"visit_Call Unsupported callee: {typed_method_sig} at line {node.lineno}"
                        )
                        return new_symbol(name=f"[return: {typed_method_sig}]", def_at=node)

                if isinstance(callee_self, dict):
                    return self._handle_obj_call(
                        callee_self, callee_method, args, kwargs, node
                    )
                elif isinstance(callee_self, str):
                    if callee_method == "capitalize":
                        return callee_self.capitalize()
                    else:
                        logger.warning(
                            f"visit_Call Unsupported callee for string: {ast.dump(node)} at line {node.lineno}"
                        )
                        return new_symbol(def_at=node)
                elif isinstance(callee_self, Value):
                    if isinstance(callee_self, ClassValue):
                        if callee_method == "apply":
                            forward_fn = callee_self.get("forward")
                            
                            new_env = _find_module(callee_self)
                            if self.cg_key and self.cg_key in self.call_graph:
                                item = {"class": self.callee_self.def_at.name, "function": forward_fn.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                                if item not in self.call_graph[self.cg_key]["callees"]:
                                    self.call_graph[self.cg_key]["callees"].append(item)
                            return FuncRunner(
                                forward_fn.def_at,
                                args=args,
                                kwargs=kwargs,
                                self_value=None,
                                env=new_env,
                                calls=self.torch_calls,
                                resolve_import_dirs=self._resolve_import_dirs,
                                call_graph=self.call_graph,
                            ).run()
                        else:
                            logger.warning(
                                f"visit_Call Unsupported callee: {ast.dump(node)} at line {node.lineno}"
                            )
                            return new_symbol(def_at=node)

                    if callee_self.is_symbol():
                        if callee_self.ty:
                            if self.cg_key and self.cg_key in self.call_graph:
                                new_env = self._env
                                resolved_result = env_resolve(
                                    self._env, callee_self.ty, self._resolve_import_dirs
                                )
                                if resolved_result is not None:
                                    new_env = _find_module(resolved_result)
                                    
                                item = {"class": None, "function": full_callee_name, "type": callee_self.ty, "filepath": new_env.file_path, "line": node.lineno}
                                if item not in self.call_graph[self.cg_key]["unknown"]:
                                    self.call_graph[self.cg_key]["unknown"].append(item)
                                    
                        return new_symbol(
                            def_at=node,
                            name=f"[return: {full_callee_name}]",
                        )
                    if callee_self.ty == "dict":
                        return self._handle_obj_call(
                            callee_self.value, callee_method, args, kwargs, node
                        )

                    elif callee_self.ty == "torch.Tensor":
                        if callee_method == "size":
                            return callee_self.value["size"]
                        elif callee_method == "shape":
                            return callee_self.value["shape"]
                        elif callee_method == "stride":
                            return new_symbol(def_at=node)
                        else:
                            logger.warning(
                                f"visit_Call Unsupported callee: {callee_self.ty}.{callee_method} at line {node.lineno}"
                            )
                            return new_symbol(def_at=node)
                    else:
                        logger.warning(
                                    f"visit_Call Unsupported callee: {callee_self.ty}.{callee_method} at line {node.lineno}"
                                )
                        return new_symbol(def_at=node)
                elif isinstance(callee_self, list):
                    if callee_method == "append":
                        return callee_self.append(args[0])
                    else:
                        logger.warning(
                                    f"visit_Call Unsupported callee: list.{callee_method} at line {node.lineno}"
                                )
                        return new_symbol(def_at=node)
                else:
                    if typed_method_sig:
                        if self.cg_key and self.cg_key in self.call_graph:
                            new_env = self._env
                            resolved_result = env_resolve(
                                self._env, callee_self.ty, self._resolve_import_dirs
                            )
                            if resolved_result is not None:
                                new_env = _find_module(resolved_result)
                                
                            item = {"class": None, "function": full_callee_name, "type": callee_self.ty, "filepath": new_env.file_path, "line": node.lineno}
                            if item not in self.call_graph[self.cg_key]["unknown"]:
                                self.call_graph[self.cg_key]["unknown"].append(item)
                    logger.warning(
                                f"visit_Call Unsupported callee: list.{callee_method} at line {node.lineno}"
                            )
                    return new_symbol(def_at=node)

            if full_callee_name.startswith("torch.ops._"):
                if self.cg_key and self.cg_key in self.call_graph:
                    item = {"class": None, "function": full_callee_name, "filepath": self._env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)
                return new_symbol(name=f"[return: {full_callee_name}]", def_at=node)
            else:
                vllm_dispatch = False
                if full_callee_name.startswith("torch.ops.vllm."):
                    vllm_dispatch = True
                    full_callee_name = full_callee_name.replace("torch.ops.vllm.", "")
                if full_callee_name == "to" and isinstance(node.func.value, ast.Call):
                    return self._handle_call(node.func.value)
                if full_callee_name in {"wrap_modules", "get_offloader.wrap_modules"}:
                    return args[0] if args else []
                if full_callee_name in {"islice", "itertools.islice"} and args:
                    iter_value = args[0]
                    if isinstance(iter_value, Value) and iter_value.ty == "torch.nn.ModuleList":
                        iter_value = list(iter_value.get("_list").values())
                    return iter_value if isinstance(iter_value, list) else [iter_value]
                if full_callee_name in global_func_map:
                    return global_func_map[full_callee_name](args, kwargs)
                
                if need_redirect:
                    resolved_result = resolve_import_value(self._env, ImportValue(def_at=None, value="vllm.model_executor.layers.fused_moe.fused_marlin_moe.fused_marlin_moe"), self._resolve_import_dirs)
                else:
                    resolved_result = env_resolve(
                        self._env, full_callee_name, self._resolve_import_dirs
                    )
                if not resolved_result:
                    resolved_result = env_resolve(
                        self._env, callee_name, self._resolve_import_dirs
                    )
                if isinstance(resolved_result, FuncValue) and (
                    resolved_result.classmethod or resolved_result.staticmethod
                ):
                    args.insert(0, resolved_result.parent)

                if resolved_result is not None:
                    if isinstance(resolved_result, list):
                        return_values = []
                        for res in resolved_result:
                            new_env=_find_module(res)
                            if self.cg_key and self.cg_key in self.call_graph:
                                item = {"class": None, "function": res.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                                if item not in self.call_graph[self.cg_key]["callees"]:
                                    self.call_graph[self.cg_key]["callees"].append(item)
                            tmp_res = FuncRunner(
                                        res.def_at,
                                        args=args,
                                        kwargs=kwargs,
                                        self_value=self._self_value if vllm_dispatch else None,
                                        env=new_env,
                                        calls=self.torch_calls,
                                        resolve_import_dirs=self._resolve_import_dirs,
                                        call_graph=self.call_graph,
                                    ).run()
                            if isinstance(tmp_res, list):
                                return_values.extend(tmp_res)
                            else:
                                return_values.append(tmp_res)
                        return return_values
                    
                    new_env=_find_module(resolved_result)
                    if self.cg_key and self.cg_key in self.call_graph:
                        item = {"class": None, "function": resolved_result.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                        if item not in self.call_graph[self.cg_key]["callees"]:
                            self.call_graph[self.cg_key]["callees"].append(item)
                    return FuncRunner(
                        resolved_result.def_at,
                        args=args,
                        kwargs=kwargs,
                        self_value=self._self_value if vllm_dispatch else None,
                        env=new_env,
                        calls=self.torch_calls,
                        resolve_import_dirs=self._resolve_import_dirs,
                        call_graph=self.call_graph,
                    ).run()

                logger.warning(
                    f"visit_Call Unsupported callee: {full_callee_name} at line {node.lineno}"
                )
                return new_symbol(def_at=node, name=f"[return: {full_callee_name}]")
        elif isinstance(node.func, ast.Name):
            if (isinstance(self.start_node, ast.ClassDef) or isinstance(self.start_node, ast.FunctionDef)) and node.func.id == self.start_node.name:
                is_recursive = True
                if node.func.id in self._env.value and isinstance(self._env.value[node.func.id], list):
                    for item in self._env.value[node.func.id]:
                        if isinstance(item.def_at, ast.ImportFrom):
                            is_recursive = False
                if is_recursive:
                    return new_symbol(def_at=node)
            # check if it is a local variable first
            if node.func.id in self.local_env:
                base_val = self.local_env[node.func.id]
                return_values = []
                if isinstance(base_val, list):
                    for bv in base_val:
                        tmp_res = self._handle_one_name_call(node, bv, args, kwargs)
                        if tmp_res:
                            return_values.append(tmp_res)
                else:
                    tmp_res = self._handle_one_name_call(node, base_val, args, kwargs)
                    if tmp_res:
                        return tmp_res
                if return_values:
                    if len(return_values) == 1:
                        return return_values[0]
                    else:
                        return return_values

            if node.func.id == "super":
                return SuperValue(def_at=node, parent=self._self_value)
            elif node.func.id == "print":
                return None
            elif node.func.id == "RuntimeError":
                return None
            elif node.func.id == "NotImplementedError":
                return None
            elif node.func.id == "ValueError":
                return None

            if node.func.id in global_func_map:
                extra = {}
                if node.func.id == "open":
                    # decouple this dependency

                    extra["base_dir"] = self._resolve_import_dirs[0]
                return global_func_map[node.func.id](args, kwargs, **extra)
            if node.func.id == "hasattr":
                if isinstance(node.args[0], ast.Name):
                    if "config" in node.args[0].id:
                        return new_symbol(def_at=node)
                if isinstance(args[0], Value):
                    if args[0].is_symbol() or (isinstance(args[0].value, Value) and args[0].value.is_symbol()):
                        return new_symbol(def_at=node)
                    return args[0].value and args[1] in args[0].value
                if isinstance(args[1], Value):
                    if args[1].is_symbol() or (isinstance(args[1].value, Value) and args[1].value.is_symbol()):
                        return new_symbol(def_at=node)
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
            elif node.func.id == "range":
                return [args[0]]

            full_callee_name = resolve_with_import(node.func.id, self._env)
            if full_callee_name in {"islice", "itertools.islice"} and args:
                iter_value = args[0]
                if isinstance(iter_value, Value) and iter_value.ty == "torch.nn.ModuleList":
                    iter_value = list(iter_value.get("_list").values())
                return iter_value if isinstance(iter_value, list) else [iter_value]
            if full_callee_name in global_func_map:
                return global_func_map[full_callee_name](args, kwargs)
            if full_callee_name in torch_apis:
                return torch_apis[full_callee_name](args, kwargs)

            # could be something import by 'import *'
            resolved_result = env_resolve(
                self._env, node.func.id, self._resolve_import_dirs
            )

            # could be class instantiation

            if resolved_result is not None and (
                isinstance(resolved_result, ClassValue)
                or isinstance(resolved_result, FuncValue)
            ):
                new_env = _find_module(resolved_result)
                if self.cg_key and self.cg_key in self.call_graph:
                    if isinstance(resolved_result, ClassValue):
                        item = {"class": resolved_result.def_at.name, "function": "__init__", "filepath": new_env.file_path, "line": node.lineno}
                    else:
                        item = {"class": None, "function": resolved_result.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)
                return FuncRunner(
                    resolved_result.def_at,
                    args=args,
                    kwargs=kwargs,
                    self_value=None,
                    env=new_env,
                    calls=self.torch_calls,
                    resolve_import_dirs=self._resolve_import_dirs,
                    call_graph=self.call_graph,
                ).run()
            elif resolved_result is not None and isinstance(resolved_result, list):
                return_values = []
                for res in resolved_result:
                    if isinstance(res, ClassValue) or isinstance(res, FuncValue):
                        new_env = _find_module(res)
                        if self.cg_key and self.cg_key in self.call_graph:
                            if isinstance(resolved_result, ClassValue):
                                item = {"class": res.def_at.name, "function": "__init__", "filepath": new_env.file_path, "line": node.lineno}
                            else:
                                item = {"class": None, "function": res.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                            if item not in self.call_graph[self.cg_key]["callees"]:
                                self.call_graph[self.cg_key]["callees"].append(item)
                                
                        tmp_res = FuncRunner(
                                res.def_at,
                                args=args,
                                kwargs=kwargs,
                                self_value=None,
                                env=new_env,
                                calls=self.torch_calls,
                                resolve_import_dirs=self._resolve_import_dirs,
                                call_graph=self.call_graph,
                            ).run()
                        if isinstance(tmp_res, list):
                            return_values.extend(tmp_res)
                        else:
                            return_values.append(tmp_res)
                            
                if return_values:
                    if len(return_values) == 1:
                        return return_values[0]
                    return return_values
                else:
                    logger.warning(
                        f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                    )
                    return new_symbol(name=f"[return: {node.func.id}]", def_at=node)

            else:
                logger.warning(
                    f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                )
                return new_symbol(name=f"[return: {node.func.id}]", def_at=node)

        elif isinstance(node.func, ast.Call):
            resolved_result = env_resolve(
                self._env, node.func.func.id, self._resolve_import_dirs
            )
            
            target_func = None
            if resolved_result is not None and (
                isinstance(resolved_result, ClassValue)
                or isinstance(resolved_result, FuncValue)
            ):
                target_func = FuncRunner(
                    resolved_result.def_at,
                    args=node.func.args,
                    kwargs={},
                    self_value=None,
                    env=_find_module(resolved_result),
                    calls=self.torch_calls,
                    resolve_import_dirs=self._resolve_import_dirs,
                    call_graph=self.call_graph,
                ).run()
            elif resolved_result is not None and isinstance(resolved_result, list):
                return_values = []
                for res in resolved_result:
                    if isinstance(res, ClassValue) or isinstance(res, FuncValue):
                        tmp_res = FuncRunner(
                                res.def_at,
                                args=node.func.args,
                                kwargs={},
                                self_value=None,
                                env=_find_module(res),
                                calls=self.torch_calls,
                                resolve_import_dirs=self._resolve_import_dirs,
                                call_graph=self.call_graph,
                            ).run()
                        if isinstance(tmp_res, list):
                            return_values.extend(tmp_res)
                        else:
                            return_values.append(tmp_res)
                if return_values:
                    if len(return_values) == 1:
                        target_func = return_values[0]
                    else:
                        target_func = return_values
                else:
                    logger.warning(
                        f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                    )
                    return new_symbol(name=f"[return: {node.func.id}]", def_at=node)
            else:
                logger.warning(
                    f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                )
                return new_symbol(name=f"[return: {node.func.id}]", def_at=node)
            
            if target_func is not None and (
                isinstance(target_func, ClassValue)
                or isinstance(target_func, FuncValue)
            ):
                new_env = _find_module(target_func)
                if self.cg_key and self.cg_key in self.call_graph:
                    if isinstance(resolved_result, ClassValue):
                        item = {"class": target_func.def_at.name, "function": "__init__", "filepath": new_env.file_path, "line": node.lineno}
                    else:
                        item = {"class": None, "function": target_func.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                    if item not in self.call_graph[self.cg_key]["callees"]:
                        self.call_graph[self.cg_key]["callees"].append(item)
                return FuncRunner(
                    target_func.def_at,
                    args=args,
                    kwargs=kwargs,
                    self_value=None,
                    env=new_env,
                    calls=self.torch_calls,
                    resolve_import_dirs=self._resolve_import_dirs,
                    call_graph=self.call_graph,
                ).run()
            elif target_func is not None and isinstance(target_func, list):
                return_values = []
                for res in target_func:
                    if isinstance(res, ClassValue) or isinstance(res, FuncValue):
                        new_env = _find_module(res)
                        if self.cg_key and self.cg_key in self.call_graph:
                            if isinstance(resolved_result, ClassValue):
                                item = {"class": res.def_at.name, "function": "__init__", "filepath": new_env.file_path, "line": node.lineno}
                            else:
                                item = {"class": None, "function": res.def_at.name, "filepath": new_env.file_path, "line": node.lineno}
                            if item not in self.call_graph[self.cg_key]["callees"]:
                                self.call_graph[self.cg_key]["callees"].append(item)
                        
                        tmp_res = FuncRunner(
                                res.def_at,
                                args=args,
                                kwargs=kwargs,
                                self_value=None,
                                env=new_env,
                                calls=self.torch_calls,
                                resolve_import_dirs=self._resolve_import_dirs,
                                call_graph=self.call_graph,
                            ).run()
                        if isinstance(tmp_res, list):
                            return_values.extend(tmp_res)
                        else:
                            return_values.append(tmp_res)
                if return_values:
                    if len(return_values) == 1:
                        return return_values[0]
                    return return_values
                else:
                    logger.warning(
                        f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                    )
                    return new_symbol(name=f"[return: {node.func.id}]", def_at=node)
            else:
                logger.warning(
                    f"visit_Call Unsupported callee: {node.func.id} at line {node.lineno}"
                )
                return new_symbol(name=f"[return: {node.func.id}]", def_at=node)
        else:
            logger.warning(f"visit_Call Unsupported callee: {ast.dump(node)}")
            return new_symbol(name=f"[return: {ast.dump(node)}]", def_at=node)

    def _handle_obj_call(self, base, method, args, kwargs, node):
        try:
            if isinstance(base, dict):
                if method == "get":
                    return base.get(args[0], args[1] if len(args) > 1 else None)
                elif method == "set":
                    base[args[0]] = args[1]
                    return None
                elif method == "update":
                    base.update(args[0])
                    return None
                elif method == "pop":
                    base.pop(args[0], args[1] if len(args) > 1 else None)
                else:
                    logger.warning(
                                f"visit_Call Unsupported callee: dict.method at {node.lineno}"
                            )
                    return new_symbol(def_at=node)
                
            else:
                    logger.warning(
                                f"visit_Call Unsupported callee: dict.method at {node.lineno}"
                            )
                    return new_symbol(def_at=node)
        except Exception as ex:
            logger.warning(
                f"visit_Call Unsupported callee: dict.method at {node.lineno}"
            )
            return new_symbol(def_at=node)

    def visit_Call(self, node: ast.Call):
        super().generic_visit(node)
        self._handle_call(node)

    def visit_arguments(self, node):
        args_len = len(node.args)
        default_args_len = len(node.defaults)
        arg_offset = 0
        super().generic_visit(node)
        used_init_kwargs = set()

        has_started_args = False
        started_args = None

        # first loop handle default args
        for idx, arg in enumerate(node.args):
            if isinstance(arg, ast.Starred):
                # handle starred args, like *args
                if not has_started_args:
                    has_started_args = True
                continue
            if self._self_value is not None and idx == 0:
                arg_offset = 1
                continue
            if idx >= args_len - default_args_len:
                if arg.arg not in self.local_env:
                    default_val = node.defaults[idx - args_len + default_args_len]
                    self.local_env[arg.arg] = self._eval(default_val)

        # second loop handle passed arguments and kwargs
        used_init_args_idx = 0
        for idx, arg in enumerate(node.args):
            if self._self_value is not None and idx == 0:
                arg_offset = 1
                continue
            init_arg_idx = idx - arg_offset
            # passed arguments assign first
            if init_arg_idx < len(self._init_args):
                self.local_env[arg.arg] = self._init_args[idx - arg_offset]
                used_init_args_idx += 1
            else:
                # if passed arguments done, try to assign from passed kwargs
                if arg.arg in self._init_kwargs:
                    self.local_env[arg.arg] = self._init_kwargs[arg.arg]
                    used_init_kwargs.add(arg.arg)

        if has_started_args:
            started_args = self._init_args[used_init_args_idx:]
            self._started_args = started_args

        if node.kwarg is not None:
            self.local_env[node.kwarg.arg] = {}
            for key, value in self._init_kwargs.items():
                if key not in used_init_kwargs:
                    self.local_env[node.kwarg.arg][key] = value


        if node.kwonlyargs is not None:
            for (arg_index, arg) in enumerate(node.kwonlyargs):
                if arg.arg not in self.local_env:
                    if arg.arg in self._init_kwargs:
                        self.local_env[arg.arg] = self._init_kwargs[arg.arg]
                        used_init_kwargs.add(arg.arg)
                    else:
                        default_val = node.kw_defaults[arg_index]
                        if isinstance(default_val, ast.Constant):
                            self.local_env[arg.arg] = new_symbol(def_at=node, ty=type(default_val.value), name=arg.arg)
                            logger.debug(f"symbolize kwonlyarg {arg.arg} to local_env")
                        elif default_val:
                            self.local_env[arg.arg] = self._eval(default_val)

        # add types if there are any None
        found = False
        for arg in node.args:
            if arg.arg == "self":
                continue
            if self._auto_symbol_input_tensor:
                if arg.arg not in used_init_kwargs:
                    if arg.arg.startswith("input") or arg.arg.startswith("inputs"):
                        self.local_env[arg.arg] = new_symbol(
                            def_at=node, name=f"[arg: {arg.arg}]"
                        )
                        logger.debug(f"symbolize input tensor {arg.arg} to local_env")
                        found = True

            if arg.annotation:
                if arg.arg in self.local_env:
                    arg_val = self.local_env[arg.arg]

                    if isinstance(arg_val, Value) and arg_val.is_symbol():
                        ty = resolve_ann(arg.annotation)

                        if ty.ty == "torch.Tensor":
                            self.local_env[arg.arg] = ClassInstanceValue(None)
                            self.local_env[arg.arg].ty = "torch.Tensor"
                            self.local_env[arg.arg].value = new_symbol(def_at=node)
                        elif ty.ty == "torch.FloatTensor":
                            self.local_env[arg.arg] = ClassInstanceValue(None)
                            self.local_env[arg.arg].ty = "torch.Tensor"
                            self.local_env[arg.arg].value = {"dtype": "float"}
                        elif ty.ty == "torch.LongTensor":
                            self.local_env[arg.arg] = ClassInstanceValue(None)
                            self.local_env[arg.arg].ty = "torch.Tensor"
                            self.local_env[arg.arg].value = {"dtype": "long"}
                        else:
                            arg_val.ty = ty.ty

                        logger.debug(f"update symbolic arg {arg.arg} to {ty.ty}")

            if found:
                break

    def _handle_compare(self, node: ast.Compare):
        assert len(node.ops) == 1
        assert len(node.comparators) == 1
        left_val = self._eval(node.left)
        right_val = self._eval(node.comparators[0])
        op = node.ops[0]
        
        if type(left_val) != type(right_val):
            return new_symbol(def_at=node)
    
        if (isinstance(left_val, Value) and left_val.is_symbol()) or (isinstance(right_val, Value) and right_val.is_symbol()):
            return new_symbol(def_at=node)
        left_tmp = to_primitive(left_val)
        right_tmp = to_primitive(right_val)
        if (isinstance(left_tmp, Value) and left_tmp.is_symbol()) or (isinstance(right_tmp, Value) and right_tmp.is_symbol()):
            return new_symbol(def_at=node)
        if isinstance(left_tmp, list):
            for li in left_tmp:
                if isinstance(li, Value) and li.is_symbol():
                    return new_symbol(def_at=node)
        if isinstance(right_tmp, list):
            for ri in right_tmp:
                if isinstance(ri, Value) and ri.is_symbol():
                    return new_symbol(def_at=node)
        
        if isinstance(op, ast.Eq):
            return to_primitive(left_val) == to_primitive(right_val)
        elif isinstance(op, ast.NotEq):
            if (isinstance(left_val, Value) and left_val.is_symbol()) or (isinstance(right_val, Value) and right_val.is_symbol()):
                return new_symbol(def_at=node)
            return to_primitive(left_val) != to_primitive(right_val)
        elif isinstance(op, ast.Lt):
            return to_primitive(left_val) < to_primitive(right_val)
        elif isinstance(op, ast.LtE):
            return to_primitive(left_val) <= to_primitive(right_val)
        elif isinstance(op, ast.Gt):
            return to_primitive(left_val) > to_primitive(right_val)
        elif isinstance(op, ast.GtE):
            return to_primitive(left_val) >= to_primitive(right_val)
        elif isinstance(op, ast.Is):
            return to_primitive(left_val) is to_primitive(right_val)
        elif isinstance(op, ast.IsNot):
            return to_primitive(left_val) is not to_primitive(right_val)
        elif isinstance(op, ast.In):
            left_val = to_primitive(left_val)
            right_val = to_primitive(right_val)
            if (
                isinstance(right_val, list)
                and len(right_val) > 0
                and isinstance(right_val[0], ClassValue)
            ):
                right_val = [v.ty for v in right_val]
                return left_val in right_val
            return (
                left_val in right_val
                if isinstance(right_val, (list, tuple, dict, str))
                else False
            )
        else:
            print(f"visit_Compare Unsupported op: {ast.dump(node)}")
            return new_symbol(def_at=node)

    def _handle_bin_op(self, node: ast.BinOp):
        left_val = self._eval(node.left)
        right_val = self._eval(node.right)
        op = node.op
        
        if isinstance(op, ast.Add):
            if isinstance(left_val, list) and isinstance(right_val, tuple):
                return left_val + list(right_val)
            elif isinstance(left_val, tuple) and isinstance(right_val, list):
                return list(left_val) + right_val
            elif isinstance(left_val, list) and not right_val:
                return left_val
            elif not left_val and isinstance(right_val, list):
                return right_val
            elif isinstance(left_val, tuple) and not right_val:
                return list(left_val)
            elif not left_val and isinstance(right_val, tuple):
                return list(right_val)
            elif isinstance(left_val, list):
                return left_val
            elif isinstance(right_val, list):
                return right_val

        if isinstance(left_val, Value):
            if left_val.ty == "torch.Tensor":
                if left_val.value and not left_val.value.get("shape"):
                    if isinstance(right_val, Value) and right_val.ty == "torch.Tensor":
                        return right_val

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
        
        if isinstance(left_val, (list, tuple, dict)) or isinstance(right_val, (list, tuple, dict)):
            return new_symbol(def_at=node)

        if isinstance(op, ast.Add):
            return to_primitive(left_val) + to_primitive(right_val)
        elif isinstance(op, ast.Sub):
            return to_primitive(left_val) - to_primitive(right_val)
        elif isinstance(op, ast.Mult):
            return to_primitive(left_val) * to_primitive(right_val)
        elif isinstance(op, ast.Div):
            return to_primitive(left_val) / to_primitive(right_val)
        elif isinstance(op, ast.Mod):
            l = to_primitive(left_val)
            r = to_primitive(right_val)
            if isinstance(l, str) and isinstance(r, list):
                return l % tuple(r)
            return l % r
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
        elif isinstance(op, ast.Is):
            return to_primitive(left_val) is to_primitive(right_val)
        elif isinstance(op, ast.IsNot):
            return to_primitive(left_val) is not to_primitive(right_val)
        else:
            print(f"visit_BinOp Unsupported op: {ast.dump(node)}")

    def visit_AnnAssign(self, node):
        logger.debug(f"visit_annassign {ast.dump(node)} at line {node.lineno}")
        try:
            if not node.value:
                return
            value = self._eval(node.value)
            if hasattr(node.annotation, "id"):
                if isinstance(value, Value) and value.is_symbol():
                    value.ty = node.annotation.id
                elif isinstance(value, list):
                    for v in value:
                        if isinstance(v, Value) and v.is_symbol():
                            v.ty = node.annotation.id
                            
            self._eval(node.target, value)
        except Exception:
            logger.exception(f"failed to execute {ast.dump(node)}")
            
    def visit_Assign(self, node):
        logger.debug(f"visit_assign {ast.dump(node)} at line {node.lineno}")
        try:
            value = self._eval(node.value)
            if isinstance(value, Value) and value.is_symbol():
                tmp_val = node.value
                ty = ""
                while isinstance(tmp_val, ast.Attribute):
                    ty = f"{tmp_val.attr}.{ty}" if ty else tmp_val.attr
                    tmp_val = tmp_val.value
                if isinstance(tmp_val, ast.Name) and ty:
                    ty = f"{tmp_val.id}.{ty}"
                if ty:
                    value.ty = ty        
            

            if isinstance(value, tuple) and value in self._shape2tensor:
                tgt = node.targets[0]
                if isinstance(tgt, ast.Tuple):
                    if len(value) != len(tgt.elts):
                        tensor = self._shape2tensor[value]
                        old_shape = tensor.value["shape"]
                        old_shape_len = len(old_shape)  # [x]
                        new_shape_len = len(tgt.elts)  # [a, b, c]
                        diff = new_shape_len - old_shape_len
                        tensor.value["shape"] = tuple(
                            [
                                new_symbol(def_at=node)
                                if i < diff
                                else old_shape[i - diff]
                                for i in range(len(tgt.elts))
                            ]
                        )
                        value = tensor.value["shape"]

            for target in node.targets:
                if isinstance(target, ast.Tuple):
                    if isinstance(value, list) or isinstance(value, tuple):
                        for elt, val in zip(target.elts, value):
                            self._eval(elt, val)
                    else:
                        for elt in target.elts:
                            self._eval(elt, new_symbol(def_at=node))
                else:
                    self._eval(target, value)
        except Exception:
            logger.exception(f"failed to execute {ast.dump(node)}")

    def visit_If(self, node):
        test_value = self._eval(node.test)
        logger.debug(
            f"eval if {ast.dump(node.test)} at line {node.lineno} = {test_value}"
        )

        if test_value and ((
            (isinstance(test_value, Value) and not test_value.is_symbol())
        ) or isinstance(test_value, bool)):
            # run true branch
            for stmt in node.body:
                self.visit(stmt)
        elif not test_value and ((
            (isinstance(test_value, Value) and not test_value.is_symbol())
        ) or isinstance(test_value, bool)):
            if node.orelse:
                # run false branch
                for stmt in node.orelse:
                    self.visit(stmt)
        else:
            if node.body:
                # run true branch
                for stmt in node.body:
                    self.visit(stmt)
            if node.orelse:
                # run false branch
                for stmt in node.orelse:
                    self.visit(stmt)


class TorchCallVisitor:
    def __init__(
        self,
        init_mod: ast.Module,
        init_cls: ast.ClassDef,
        init_func: str,
        config: Value,
        bindings: list[PyCppBinding],
        resolve_import_dirs: list[str] = None,
        init_mod_filepath: str = None,
    ):
        self.torch_calls = []
        self._init_mod = init_mod
        self._init_cls = init_cls
        self._init_func = init_func
        self._bindings = bindings
        self._config = config
        self._env: ModuleInstanceValue = None
        self._main_self = None
        self._resolve_import_dirs = resolve_import_dirs
        self._init_mod_filepath = init_mod_filepath
        self.call_graph = {}

    def start(self):
        # workflow is:
        # 1. init module
        self._env = ModuleInstanceValue.from_ast_module(self._init_mod)
        self._env.file_path = self._init_mod_filepath

        self._main_self = FuncRunner(
            self._init_cls,
            kwargs={
                "config": self._config,
                "cfg": self._config,
                "vllm_config": self._config,
            },  # hard code for now, we can change it to automatically find possible config later
            env=self._env,
            resolve_import_dirs=self._resolve_import_dirs,
            call_graph=self.call_graph,
        ).run()
        if "config" not in self._main_self.value:
            self._main_self.value["config"] = self._config

        def _find_func_in_bases(cls_def, env, visited):
            key = (env.file_path if env else None, cls_def.name)
            if key in visited:
                return None
            visited.add(key)

            try:
                return get_func_from_cls(cls_def, self._init_func)
            except ValueError:
                pass

            for base_cls in get_inherited_classes(cls_def):
                if not base_cls:
                    continue
                resolved = env_resolve(env, base_cls, self._resolve_import_dirs)
                if isinstance(resolved, ClassValue):
                    new_env = _find_module(resolved)
                    func_def = _find_func_in_bases(resolved.def_at, new_env, visited)
                    if func_def is not None:
                        return func_def
            return None

        try:
            func = get_func_from_cls(self._init_cls, self._init_func)
        except ValueError:
            func = None
            # if not found in ast tree, maybe it is from base class or resolved from env
            try:
                func_value = self._main_self.get(self._init_func)
                if isinstance(func_value, FuncValue):
                    func = func_value.def_at
            except Exception:
                func = None

            if func is None:
                func = _find_func_in_bases(self._init_cls, self._env, set())

            if func is None:
                logger.warning(
                    "Function %s not found in class %s",
                    self._init_func,
                    self._init_cls.name,
                )
                return
                
        FuncRunner(
            func,
            self_value=self._main_self,
            env=self._env,
            calls=self.torch_calls,
            auto_symbol_input_tensor=True,
            resolve_import_dirs=self._resolve_import_dirs,
            call_graph=self.call_graph,
        ).run()

    @staticmethod
    def starts_from(
        py_file: str,
        cls: str,
        config: Value,
        func: str = "forward",
        bindings: list[PyCppBinding] = None,
        resolve_import_dirs: list[str] = None,
        out_path: str = None
    ):
        assert isinstance(config, Value)
        
        if not os.path.exists(py_file):
            raise FileNotFoundError(py_file)
        with open(py_file, "r", encoding="utf-8") as f:
            mod = ast.parse(f.read())
        cls_def = get_cls_from_mod(mod, cls)
        return TorchCallVisitor.starts_from_ast(
            mod,
            cls_def,
            func,
            config,
            bindings,
            resolve_import_dirs=resolve_import_dirs,
            init_mod_filepath=py_file,
            out_path = out_path
        )

    @staticmethod
    def starts_from_ast(
        init_mod: ast.Module,
        init_cls: ast.ClassDef,
        init_func: str,
        config: Value,
        bindings: list[PyCppBinding],
        resolve_import_dirs: list[str] = None,
        init_mod_filepath: str = None,
        out_path: str = None
    ):
        visitor = TorchCallVisitor(
            init_mod,
            init_cls,
            init_func,
            config,
            bindings,
            resolve_import_dirs=resolve_import_dirs,
            init_mod_filepath=init_mod_filepath,
        )
        visitor.start()
        if not out_path:
            current_path_string = os.path.abspath(__file__)
            root_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(current_path_string))))
            out_path = os.path.join(root_dir, "cgout", init_cls.name+"_"+init_func+".json")
        with open(out_path, "w") as f:
            json.dump(visitor.call_graph, f, indent=4)
        return visitor.torch_calls
