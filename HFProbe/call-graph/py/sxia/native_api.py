from sxia.value import ClassInstanceValue, FuncValue, Value, new_symbol


def _handle_zip(args, kwargs):
    if len(args) != 2:
        raise ValueError("zip only support 2 args")

    actual_args = []
    for i in range(2):
        curr_arg = args[i]
        if isinstance(curr_arg, Value):
            if curr_arg.is_symbol():
                actual_args.append([new_symbol() for _ in actual_args[(i + 1) % 2]])
            elif curr_arg.ty == "torch.nn.ModuleList":
                actual_args.append(curr_arg.get("_list").values())
            else:
                raise ValueError(f"zip {i} arg must be list or symbol")
        elif isinstance(curr_arg, list):
            actual_args.append(curr_arg)
        else:
            raise ValueError(f"zip {i} arg must be list or symbol")

    if len(actual_args[0]) != len(actual_args[1]):
        raise ValueError("zip args length not equal")
    return list(zip(actual_args[0], actual_args[1]))


def _dict(args, kwargs):
    if len(args) == 1:
        return dict(args[0])
    return dict(**kwargs)


def _enumerate(args, kwargs):
    if len(args) != 1:
        raise ValueError("enumerate only support 1 arg")
    if not isinstance(args[0], list):
        raise ValueError("enumerate first arg must be list")

    return list(enumerate(args[0]))


def _dir(args, kwargs):
    if len(args) != 1:
        raise ValueError("dir only support 1 arg")

    obj = args[0]
    if isinstance(obj, FuncValue):
        return []
    if isinstance(obj, Value):
        if obj.ty == "torch.nn.ModuleList":
            return obj.get("_list").keys()
        return obj.value.keys()
    else:
        dir(obj)


def _type(args, kwargs):
    if len(args) != 1:
        raise ValueError("type only support 1 arg")

    obj = args[0]
    if not isinstance(obj, Value):
        return type(obj)
    elif isinstance(obj, ClassInstanceValue):
        return obj.ty

    return new_symbol("type return")


def _isinstance(args, kwargs):
    if len(args) != 2:
        raise ValueError("isinstance only support 2 args")

    obj = args[0]
    cls = args[1]

    if isinstance(obj, Value):
        left = obj.ty
        right = cls.ty if isinstance(cls, Value) else cls.id
        return left == right

    return new_symbol("isinstance return")


def _getattr(args, kwargs):
    if len(args) < 2 or len(args) > 3:
        raise ValueError("getattr only support 2 args")

    obj = args[0]
    attr_name = args[1]

    try:
        if isinstance(obj, Value):
            if obj.ty == "torch.nn.ModuleList":
                return obj.get("_list").get(attr_name)

            return obj.get(attr_name)
        else:
            return getattr(obj, attr_name)
    except Exception:
        return new_symbol(f"{obj}.{attr_name}")


def _setattr(args, kwargs):
    if len(args) != 3:
        raise ValueError("setattr only support 3 args")

    obj = args[0]
    attr_name = args[1]
    value = args[2]

    if isinstance(obj, Value):
        if obj.ty == "torch.nn.ModuleList":
            return obj.get("_list").set(attr_name, value)
        obj.set(attr_name, value)
    else:
        if isinstance(attr_name, Value):
            return
        setattr(obj, attr_name, value)


def _len(args, kwargs):
    if len(args) != 1:
        raise ValueError("len only support 1 arg")

    obj = args[0]
    if isinstance(obj, Value):
        return new_symbol("len return")
    else:
        return len(obj)


def _math_ceil(args, kwargs):
    if len(args) != 1:
        raise ValueError("math.ceil only support 1 arg")

    obj = args[0]
    if not isinstance(obj, (int, float)):
        if not isinstance(obj, Value):
            raise ValueError("math.ceil arg must be int, float or Value")
        if hasattr(obj, "name"):
            return new_symbol(f"math.ceil({obj.name})")
        else:
            return new_symbol(f"math.ceil({obj.sym_name})")
    import math

    return math.ceil(obj)


def _yaml_safe_load(args, kwargs):
    if len(args) != 1:
        raise ValueError("yaml.safe_load only support 1 arg")

    import yaml

    obj = args[0]
    if isinstance(obj, Value):
        return new_symbol(f"yaml.safe_load({obj.name})")

    return yaml.safe_load(obj)


def _open(args, _kwargs, **kwargs):
    if len(args) != 1:
        raise ValueError("open only support 1 arg")

    import os

    file_path = args[0]
    if kwargs.get("base_dir") is not None:
        file_path = os.path.join(kwargs["base_dir"], file_path)
    if isinstance(file_path, Value):
        return new_symbol(f"open({file_path.name})")
    elif isinstance(file_path, str):
        return open(file_path, **_kwargs)
    else:
        raise ValueError("open arg must be str or Value")


def _set(args, kwargs):
    if len(args) != 2:
        raise ValueError("set only support 2 args")

    obj = args[0]
    if isinstance(obj, Value) and obj.is_symbol():
        return new_symbol(f"set({obj.name})")

    return set(obj)


def _list(args, kwargs):
    if len(args) != 1:
        raise ValueError("list only support 1 arg")

    obj = args[0]
    if obj is None:
        return [None]
    return list(obj)


def _vllm_distributed_utils_get_pp_indices(args, kwargs):
    return (0, 1)


def _maybe_offload_to_cpu(args, kwargs):
    if len(args) != 1:
        raise ValueError("maybe_offload_to_cpu only support 1 arg")
    obj = args[0]
    return obj


global_func_map = {
    "zip": _handle_zip,
    "dict": _dict,
    "enumerate": _enumerate,
    "dir": _dir,
    "type": _type,
    "isinstance": _isinstance,
    "getattr": _getattr,
    "setattr": _setattr,
    "len": _len,
    "math.ceil": _math_ceil,
    "yaml.safe_load": _yaml_safe_load,
    "open": _open,
    "omegaconf.OmegaConf.create": lambda args, kwargs: args[0],
    "set": _set,
    "edict": _dict,
    "list": _list,
    # vllm specific functions
    "vllm.distributed.utils.get_pp_indices": _vllm_distributed_utils_get_pp_indices,
    "maybe_offload_to_cpu": _maybe_offload_to_cpu,
}
