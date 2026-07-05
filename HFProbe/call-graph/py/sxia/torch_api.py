from functools import reduce
from sxia.value import ClassInstanceValue, Value, new_symbol
import logging

logger = logging.getLogger(__name__)


def _empty_like(x: Value):
    empty = Value(ty=x.ty, def_at=None)
    empty.set_attribute("size", x.get_attribute("size"))
    empty.set_attribute("shape", x.get_attribute("shape"))
    empty.set_attribute("dtype", x.get_attribute("dtype"))
    empty.set_attribute("device", x.get_attribute("device"))
    return empty


API_SYM_ID = 0


def sym_name():
    global API_SYM_ID
    API_SYM_ID += 1
    return f"API_{API_SYM_ID}"


def _arange(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.arange requires at least one argument")
    logger.debug(f"torch.arange: args: {args}")
    for arg in args:
        if isinstance(arg, Value) and arg.is_symbol():
            logger.warning(
                f"torch.arange: argument {arg} is a symbol, return symbol"
            )
            return new_symbol(ty="torch.Tensor")

    def get_int(val, name: str) -> int:
        if isinstance(val, Value):
            return val.value
        elif isinstance(val, list):
            return val[0]
        else:
            return val


    # Parse start, end, step
    if len(args) == 1:
        start = 0
        end = get_int(args[0], "end")
        step = 1
    elif len(args) == 2:
        start = get_int(args[0], "start")
        end = get_int(args[1], "end")
        step = 1
    elif len(args) >= 3:
        start = get_int(args[0], "start")
        end = get_int(args[1], "end")
        step = get_int(args[2], "step")
    else:
        raise ValueError("torch.arange requires 1 to 3 positional arguments")

    if step == 0:
        raise ValueError("torch.arange step cannot be 0")

    if isinstance(start, int) and isinstance(end, int) and isinstance(step, int):
        size = max(0, (end - start + (step - 1 if step > 0 else step + 1)) // step)
    else:
        size = new_symbol(ty="int")

    cls_ins = ClassInstanceValue(None)
    cls_ins.ty = "torch.Tensor"
    cls_ins.value = {
        "shape": (size,),
        "size": size,
        "range": (start, end, step),
        "data": None,  # could be list(range(start, end, step)) if needed
    }
    return cls_ins


def _cat(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.cat requires at least one argument")

    list_val = args[0]
    if not isinstance(list_val, list):
        raise TypeError("torch.cat expects a list of tensors as first argument")

    tensors = list_val
    if not tensors:
        raise ValueError("Empty list passed to torch.cat")

    # Validate types
    for t in tensors:
        if not isinstance(t, Value) or t.ty != "torch.Tensor":
            #     "torch.cat only supports Value objects with type 'torch.Tensor'"
            return new_symbol(ty="torch.Tensor")

    dim_val = kwargs.get("dim", Value(ty="int", def_at=list_val.def_at, value=0))
    dim = dim_val.value

    # Use the shape of the first tensor as reference
    ref_shape = tensors[0].value["shape"]
    new_shape = list(ref_shape)
    concat_dim_size = 0

    for t in tensors:
        shape = t.value["shape"]
        if len(shape) != len(ref_shape):
            raise ValueError(
                "All tensors must have the same number of dimensions for torch.cat"
            )

        for i, (a, b) in enumerate(zip(shape, ref_shape)):
            if i != dim and a != b:
                raise ValueError(
                    f"All dimensions except dim={dim} must match: got {shape} vs {ref_shape}"
                )

        concat_dim_size += shape[dim]

    new_shape[dim] = concat_dim_size
    size = 1
    for d in new_shape:
        size *= d

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": size,
        "cat_dim": dim,
        "data": None,  # optional: simulate or leave empty
    }
    return cls_inst


def _zeros(args: list[Value], kwargs: dict[str, Value]) -> Value:
    """
    Create a tensor of zeros with the same shape as the input.
    """
    if not args:
        raise ValueError("torch.zeros requires at least one argument")

    data_val = args[0] if len(args) == 1 else args
    device = kwargs.get("device", None)
    dtype = kwargs.get("dtype", None)

    out = ClassInstanceValue(None)
    out.ty = "torch.Tensor"
    out.value = {
        "shape": tuple(data_val),
        # FIXME: here just wait for Value's constraint implementation
        "size": None,
        "dtype": dtype,
        "device": device,
    }
    return out


def _clamp(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.clamp requires at least one argument")

    data_val = args[0]
    if not isinstance(data_val, Value):
        raise TypeError("torch.clamp expects Value objects as arguments")

    out = ClassInstanceValue(None)
    out.ty = data_val.ty
    out.value = {
        "shape": data_val.get("shape"),
        "dtype": data_val.value.get("dtype", None),
        "device": data_val.value.get("device", None),
    }
    return out


def _ones(args: list[Value], kwargs: dict[str, Value]) -> Value:
    """
    Create a tensor of ones with the same shape as the input.
    """
    if not args:
        raise ValueError("torch.ones requires at least one argument")

    data_val = args[0] if len(args) == 1 else args
    device = kwargs.get("device", None)
    dtype = kwargs.get("dtype", None)

    out = ClassInstanceValue(None)
    out.ty = "torch.Tensor"
    out.value = {
        "shape": tuple(data_val),
        "device": device,
        "dtype": dtype,
    }
    return out


def _iinfo(dtype: Value):
    """
    Mimics torch.iinfo to return information about integer types.
    For simplicity, we return a fixed range for integer types.
    """
    out = Value(ty=dtype.ty, def_at=None)

    if dtype.get_attribute("dtype") == "int":
        # Example fixed range for integer types; this can be expanded based on actual dtype.
        out.set_attribute("min", -2147483648)
        out.set_attribute("max", 2147483647)
    else:
        out.set_attribute("min", None)
        out.set_attribute("max", None)

    return out


def _torch_tensor(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError(
            "torch.tensor() requires at least one positional argument (data)"
        )

    data_val = args[0]
    raw_data = data_val

    if isinstance(data_val, int) or isinstance(data_val, float):
        tensor_metadata = {
            "data": data_val,
            "shape": (),
            "size": 0,
            "dtype": kwargs.get("dtype", None),
            "device": kwargs.get("device", None),
        }
        cls_inst = ClassInstanceValue(None)
        cls_inst.ty = "torch.Tensor"
        cls_inst.value = tensor_metadata
        return cls_inst

    if isinstance(raw_data, Value) and raw_data.is_symbol():
        logger.warning("torch.tensor: data is a symbol, return symbol")
        return new_symbol(ty="torch.Tensor")
    
    if not isinstance(raw_data, (list)):
        raise TypeError(f"Expected list, got: {data_val}")

    def get_shape(data):
        shape = []
        while isinstance(data, list) or isinstance(data, Value):
            if isinstance(data, Value):
                shape.extend(data.value["shape"])
                return tuple(shape)
            else:
                shape.append(len(data))
                if data:
                    data = data[0]
                else:
                    break
        return tuple(shape)

    def get_size(shape):
        size = 1
        for dim in shape:
            size *= dim
        return size

    if isinstance(raw_data, list):
        shape = get_shape(raw_data)
        size = get_size(shape)
    else:
        shape = ()
        size = 1

    # Compose tensor metadata into value dict
    tensor_metadata = {
        "data": raw_data,
        "shape": shape,
        "size": size,
        "dtype": kwargs.get("dtype", None),
        "device": kwargs.get("device", None),
    }
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = tensor_metadata
    return cls_inst


def _iinfo(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.iinfo requires a dtype as the first argument")

    dtype_val = args[0]
    dtype = dtype_val.ty if isinstance(dtype_val, Value) else dtype_val
    if dtype.startswith("torch."):
        dtype = dtype[6:]
    int_info = {
        "int8": (-128, 127),
        "uint8": (0, 255),
        "int16": (-(2**15), 2**15 - 1),
        "int32": (-(2**31), 2**31 - 1),
        "int64": (-(2**63), 2**63 - 1),
    }

    if dtype not in int_info:
        raise ValueError(f"Unsupported dtype '{dtype}' in torch.iinfo")

    min_val, max_val = int_info[dtype]

    return Value(
        ty="return[torch.iinfo]",
        def_at=dtype_val.def_at,
        value={"dtype": dtype, "min": min_val, "max": max_val},
    )


def _torch_amax(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.amax requires at least one argument")

    input_tensor = args[0]
    dim = args[1] if len(args) > 1 else kwargs.get("dim", None)
    keepdim = args[2] if len(args) > 2 else kwargs.get("keepdim", False)

    if isinstance(input_tensor, Value):
        tensor_shape = input_tensor.value["shape"]
        if dim is not None:
            if isinstance(dim, int):
                new_shape = list(tensor_shape)
                new_shape[dim] = 1
                if not keepdim:
                    new_shape.pop(dim)
            else:
                raise TypeError("Invalid dimension type for torch.amax")
        else:
            new_shape = ()
    else:
        raise TypeError("torch.amax expects a tensor as the first argument")

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,
    }
    return cls_inst


def _torch_flatten(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.flatten requires at least one argument")

    input_tensor = args[0]
    start_dim = args[1] if len(args) > 1 else kwargs.get("start_dim", 0)
    end_dim = args[2] if len(args) > 2 else kwargs.get("end_dim", -1)

    if isinstance(input_tensor, Value):
        tensor_shape = input_tensor.value["shape"]
        if end_dim == -1:
            end_dim = len(tensor_shape) - 1
        flatten_dims = list(tensor_shape[start_dim : end_dim + 1])
        flattened = reduce(
            lambda x, y: x * y if isinstance(x, Value) else y * x, flatten_dims, 1
        )
        new_shape = (
            list(tensor_shape[:start_dim])
            + [flattened]
            + list(tensor_shape[end_dim + 1 :])
        )
    else:
        raise TypeError("torch.flatten expects a tensor as the first argument")

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,
    }
    return cls_inst


def _torch_amin(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.amin requires at least one argument")

    input_tensor = args[0]
    dim = kwargs.get("dim", None)
    keepdim = kwargs.get("keepdim", False)

    if isinstance(input_tensor, Value):
        tensor_shape = input_tensor.value["shape"]
        if dim is not None:
            if isinstance(dim, int):
                new_shape = list(tensor_shape)
                new_shape[dim] = 1
                if not keepdim:
                    new_shape.pop(dim)
            else:
                raise TypeError("Invalid dimension type for torch.amin")
        else:
            new_shape = ()
    else:
        raise TypeError("torch.amin expects a tensor as the first argument")

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,
    }
    return cls_inst


def _nn_module_list(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.ModuleList"
    items = args[0] if args else []
    cls_inst.value = {"_list": {f"{idx}": item for idx, item in enumerate(items)}}
    return cls_inst


def _nn_module_list_append(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.nn.ModuleList.append requires at least one argument")

    item = args[0]

    # Append the item to the ModuleList
    self_value.value["_list"][str(len(self_value.value["_list"]))] = item
    return self_value


def _nn_linear(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.Linear"
    cls_inst.value = {
        "in_features": args[0],
        "out_features": args[1],
        "bias": kwargs.get("bias", True),
    }
    return cls_inst


def _nn_linear_call(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    input_tensor = args[0]
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    new_shape = list(input_tensor.value["shape"])
    new_shape[-1] = self_value.value["out_features"]
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,
    }

    return cls_inst


def _nn_embedding(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.Embedding"
    cls_inst.value = {
        "num_embeddings": args[0],
        "embedding_dim": args[1],
        "padding_idx": kwargs.get("padding_idx", None),
        "max_norm": kwargs.get("max_norm", None),
        "norm_type": kwargs.get("norm_type", None),
        "scale_grad_by_freq": kwargs.get("scale_grad_by_freq", False),
        "sparse": kwargs.get("sparse", False),
    }

    # create a weight tensor for the embedding
    weight_shape = (cls_inst.value["num_embeddings"], cls_inst.value["embedding_dim"])
    cls_inst.value["weight"] = ClassInstanceValue(None)
    cls_inst.value["weight"].ty = "torch.Tensor"
    cls_inst.value["weight"].value = {
        "shape": weight_shape,
        "size": None,  # can be filled if total elements are known
        "data": None,  # remains symbolic / unknown
    }
    return cls_inst


def _nn_embedding_call(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    input_tensor = args[0]

    input_shape = input_tensor.value.get("shape")
    embedding_dim = self_value.value.get("embedding_dim")

    if input_shape is None or embedding_dim is None:
        # If shape or embedding_dim is unknown, propagate unknown
        output_shape = None
    else:
        output_shape = tuple(input_shape) + (embedding_dim,)

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": output_shape,
        "size": None,  # can be filled if total elements are known
        "data": None,  # remains symbolic / unknown
    }
    return cls_inst


def _torch_tensor_to(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    self_value.value["device"] = args[0]
    return self_value


def _torch_tensor_reshape(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.reshape requires at least one argument")

    # All args are shape dimensions, handle -1, and if any value is symbol, simply replace the shape with args
    new_shape = []
    has_symbol = False
    for dim in args:
        if isinstance(dim, Value) and dim.is_symbol():
            has_symbol = True
            break
    if has_symbol:
        new_shape = tuple(args)
    else:
        for dim in args:
            if dim == -1:
                orig_has_symbol = any(
                    isinstance(d, Value) and d.is_symbol()
                    for d in self_value.value.get("shape", [])
                )
                if orig_has_symbol:
                    new_shape.append(dim)
                else:
                    # Calculate the size of -1 based on the original shape
                    total_size = reduce(
                        lambda x, y: x * y, self_value.value.get("shape", []), 1
                    )
                    new_shape.append(
                        total_size // reduce(lambda x, y: x * y, args[1:], 1)
                    )
            else:
                new_shape.append(dim)
        new_shape = tuple(new_shape)

    neg_one_idx = new_shape.index(-1) if -1 in new_shape else -1
    if neg_one_idx != -1:
        new_shape = list(new_shape)
        new_shape[neg_one_idx] = new_symbol(
            ty="int(-1)",
        )
        new_shape = tuple(new_shape)

    self_value.value["shape"] = new_shape
    return self_value


def _torch_tensor_scatter_add_(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    return self_value  # No-op for symbolic tensors, just return self


def _torch_tensor_unsqueeze(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.unsqueeze requires at least one argument")
    if len(args) > 1:
        raise ValueError("torch.unsqueeze only supports one argument")

    dim = args[0]
    if not isinstance(dim, int):
        raise TypeError("torch.unsqueeze expects an integer as the first argument")

    new_shape = list(self_value.value["shape"])
    new_shape.insert(dim, 1)
    self_value.value["shape"] = tuple(new_shape)
    return self_value


def _torch_tensor_repeat(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.repeat requires at least one argument")

    repeats = args[0]
    # Accept both tuple/list of ints or multiple int arguments
    if isinstance(repeats, (list, tuple)):
        repeat_factors = list(repeats)
    elif len(args) > 1:
        repeat_factors = list(args)
    else:
        repeat_factors = [repeats]

    orig_shape = list(self_value.value["shape"])
    # If repeat_factors is longer than orig_shape, pad orig_shape with 1s
    if len(repeat_factors) > len(orig_shape):
        orig_shape = [1] * (len(repeat_factors) - len(orig_shape)) + orig_shape
    elif len(repeat_factors) < len(orig_shape):
        repeat_factors = [1] * (len(orig_shape) - len(repeat_factors)) + repeat_factors

    new_shape = []
    for s, r in zip(orig_shape, repeat_factors):
        if isinstance(s, Value):
            new_shape.append(s * r)
        else:
            new_shape.append(r * s)

    self_value.value["shape"] = tuple(new_shape)
    return self_value


def _torch_tensor_transpose(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.transpose requires at least one argument")
    if len(args) > 2:
        raise ValueError("torch.transpose only supports two arguments")

    dim0 = args[0]
    dim1 = args[1] if len(args) > 1 else None

    if not isinstance(dim0, int):
        raise TypeError("torch.transpose expects integers as the first two arguments")

    new_shape = list(self_value.value["shape"])
    if dim1 is not None:
        new_shape[dim0], new_shape[dim1] = new_shape[dim1], new_shape[dim0]
    else:
        new_shape[dim0] = new_shape[dim0]

    self_value.value["shape"] = tuple(new_shape)
    return self_value


def _torch_contiguous(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    return self_value


def _torch_view(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    self_value.value["shape"] = []
    if args and isinstance(args[0], tuple) or isinstance(args[0], list):
        args = args[0]
    for arg in args:
        if arg == -1:
            old_shapes = self_value.value["shape"]
            # TODO: shuold calculate a concrete number for -1
            self_value.value["shape"].append(new_symbol(ty="int"))
        else:
            self_value.value["shape"].append(arg)
    return self_value


def _nn_dropout(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.Dropout"
    cls_inst.value = {
        "p": args[0] if args else kwargs.get("p", 0.5),
        "inplace": kwargs.get("inplace", False),
    }
    return cls_inst


def _nn_layer_norm(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.LayerNorm"
    cls_inst.value = {
        "normalized_shape": args[0],
        "eps": kwargs.get("eps", 1e-5),
        "elementwise_affine": kwargs.get("elementwise_affine", True),
    }
    return cls_inst


def _nn_layer_norm_call(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    input_tensor = args[0]
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": None,
        "size": None,
        "data": None,
    }
    normalized_shape = self_value.value["normalized_shape"]
    if (
        not isinstance(input_tensor, ClassInstanceValue)
        or input_tensor.ty != "torch.Tensor"
    ):
        cls_inst.value["shape"] = (normalized_shape,)
        return cls_inst

    new_shape = input_tensor.value["shape"]
    if new_shape is None:
        cls_inst.value["shape"] = (normalized_shape,)
    else:
        new_shape = list(new_shape)
        new_shape[-1] = normalized_shape
        cls_inst.value["shape"] = tuple(new_shape)

    return cls_inst


def _nn_dropout_call(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    return args[0]


def _torch_split(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> list[Value]:
    dim = kwargs.get("dim", 0)
    split_size = args[0]
    tensor_shape = self_value.value["shape"]
    if not isinstance(split_size, int) or tensor_shape is None:
        return []  # cannot split if unknown

    dim_len = tensor_shape[dim]
    split_tensors = []

    for start in range(0, dim_len, split_size):
        current_split_size = min(split_size, dim_len - start)
        split_shape = list(tensor_shape)
        split_shape[dim] = current_split_size
        new_tensor = ClassInstanceValue(None)
        new_tensor.ty = "torch.Tensor"
        new_tensor.value = {
            "shape": tuple(split_shape),
            "size": None,
            "data": None,
        }
        split_tensors.append(new_tensor)

    return split_tensors


def _torch_tensor_exapend(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if not args:
        raise ValueError("torch.expand requires at least one argument")

    shape = args[0]
    new_shape = None
    if isinstance(shape, (list, tuple)):
        new_shape = shape
    else:
        new_shape = args

    old_shape = self_value.value["shape"]
    diff = len(new_shape) - len(old_shape)
    for i, dim in enumerate(new_shape):
        if dim == -1:
            new_shape[i] = old_shape[i - diff]

    self_value.value["shape"] = tuple(new_shape)
    return self_value


def _torch_tensor_flatten(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    return _torch_flatten([self_value] + args, kwargs)


def _torch_size(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    if self_value.is_symbol():
        if args:
            ty = "int"
        else:
            ty = "tuple"
        return new_symbol(name=f"{self_value.sym_name}.size", ty=ty)
    if args:
        assert isinstance(args[0], int)
        return self_value.value["shape"][args[0]]

    return self_value.value["shape"]


def _torch_permute(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    shape = self_value.value["shape"]
    for arg in args:
        if not isinstance(arg, int):
            logger.warning("torch.permute requires integer arguments")
            return new_symbol(name=f"{self_value.sym_name}.permute", ty="torch.Tensor")
    new_shape = [shape[i] for i in args]
    self_value.value["shape"] = tuple(new_shape)
    return self_value


def _nn_conv2d(args: list[Value], kwargs: dict[str, Value]) -> Value:
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.nn.Conv2d"
    cls_inst.value = {
        "in_channels": args[0],
        "out_channels": args[1],
        "kernel_size": args[2] if len(args) > 2 else kwargs.get("kernel_size", None),
        "stride": kwargs.get("stride", 1),
        "padding": kwargs.get("padding", 0),
        "dilation": kwargs.get("dilation", 1),
        "groups": kwargs.get("groups", 1),
        "bias": kwargs.get("bias", True),
    }
    return cls_inst


def _nn_conv2d_call(
    args: list[Value], kwargs: dict[str, Value], self_value: ClassInstanceValue
) -> Value:
    input_tensor = args[0]
    if (
        not isinstance(input_tensor, ClassInstanceValue)
        or input_tensor.ty != "torch.Tensor"
    ):
        raise TypeError("torch.nn.Conv2d expects a torch.Tensor as the first argument")

    new_shape = list(input_tensor.value["shape"])
    new_shape[-3] = self_value.value["out_channels"]  # Update channel dimension
    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,
    }
    return cls_inst


def _torch_stack(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.stack requires at least one argument")

    tensors = args[0] if len(args) == 1 else args
    if not isinstance(tensors, list):
        raise TypeError("torch.stack expects a list of tensors as the first argument")

    if not tensors:
        raise ValueError("Empty list passed to torch.stack")

    # Use the shape of the first tensor as reference
    ref_shape = tensors[0].value["shape"]
    new_shape = [len(tensors)] + list(ref_shape)

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": tuple(new_shape),
        "size": None,
        "data": None,  # optional: simulate or leave empty
    }
    return cls_inst


def _torch_meshgrid(args: list[Value], kwargs: dict[str, Value]) -> list[Value]:
    if not args:
        raise ValueError("torch.meshgrid requires at least one argument")

    tensors = args[0] if len(args) == 1 else args
    if not isinstance(tensors, list):
        raise TypeError(
            "torch.meshgrid expects a list of tensors as the first argument"
        )

    if not tensors:
        raise ValueError("Empty list passed to torch.meshgrid")

    # Validate types
    for t in tensors:
        if not isinstance(t, Value) or t.ty != "torch.Tensor":
            raise TypeError(
                "torch.meshgrid only supports Value objects with type 'torch.Tensor'"
            )

    # Create meshgrid output
    output = []
    for t in tensors:
        new_tensor = ClassInstanceValue(None)
        new_tensor.ty = "torch.Tensor"
        new_tensor.value = {
            "shape": t.value.get("shape", tuple()),
            "size": None,
            "data": None,
        }
        output.append(new_tensor)

    return output


def _torch_linespace(args: list[Value], kwargs: dict[str, Value]) -> Value:
    if not args:
        raise ValueError("torch.linspace requires at least two arguments")

    start = args[0]
    end = args[1]
    steps = args[2] if len(args) > 2 else kwargs.get("steps", None)

    cls_inst = ClassInstanceValue(None)
    cls_inst.ty = "torch.Tensor"
    cls_inst.value = {
        "shape": (steps,),
        "size": steps,
        "data": None,  # could be list of values from start to end
        "device": kwargs.get("device", None),
        "dtype": kwargs.get("dtype", None),
    }
    return cls_inst


def _torch_chunk(args: list[Value], kwargs: dict[str, Value]) -> list[Value]:
    if not args:
        raise ValueError("torch.chunk requires at least one argument")

    self_value = args[0]
    chunks = args[1]
    dim = kwargs.get("dim", 0)

    if not isinstance(chunks, int):
        raise TypeError("torch.chunk expects an integer as the first argument")

    tensor_shape = self_value.value["shape"]
    if dim >= len(tensor_shape):
        raise ValueError(
            f"Dimension {dim} out of range for tensor with shape {tensor_shape}"
        )

    chunk_size = tensor_shape[dim] // chunks
    remainder = tensor_shape[dim] % chunks

    split_tensors = []
    for i in range(chunks):
        start = i * chunk_size + min(i, remainder)
        end = start + chunk_size + (1 if i < remainder else 0)
        new_shape = list(tensor_shape)
        new_shape[dim] = end - start
        new_tensor = ClassInstanceValue(None)
        new_tensor.ty = "torch.Tensor"
        new_tensor.value = {
            "shape": tuple(new_shape),
            "size": None,
            "data": None,
        }
        split_tensors.append(new_tensor)

    return split_tensors


torch_apis = {
    # Torch
    "torch.arange": _arange,
    "torch.cat": _cat,
    "torch.Tensor": _torch_tensor,
    "torch.tensor": _torch_tensor,
    "torch.zeros": _zeros,
    "torch.iinfo": _iinfo,
    "torch.amax": _torch_amax,
    "torch.amin": _torch_amin,
    "torch.flatten": _torch_flatten,
    "torch.clamp": _clamp,
    "torch.ones": _ones,
    "torch.stack": _torch_stack,
    "torch.meshgrid": _torch_meshgrid,
    "torch.linspace": _torch_linespace,
    "torch.chunk": _torch_chunk,
    # Torch NN
    "torch.nn.ModuleList": _nn_module_list,
    "torch.nn.ModuleList.append": _nn_module_list_append,
    "torch.nn.Conv2d": _nn_conv2d,
    "torch.nn.Conv2d.__call__": _nn_conv2d_call,
    "torch.nn.Linear": _nn_linear,
    "torch.nn.Embedding": _nn_embedding,
    "torch.nn.Embedding.__call__": _nn_embedding_call,
    "torch.nn.Linear.__call__": _nn_linear_call,
    "torch.nn.Dropout": _nn_dropout,
    "torch.nn.LayerNorm": _nn_layer_norm,
    "torch.nn.LayerNorm.__call__": _nn_layer_norm_call,
    "torch.nn.Dropout.__call__": _nn_dropout_call,
    # Tensor
    "torch.Tensor.to": _torch_tensor_to,
    "torch.Tensor.contiguous": _torch_contiguous,
    "torch.Tensor.view": _torch_view,
    "torch.Tensor.split": _torch_split,
    "torch.Tensor.size": _torch_size,
    "torch.Tensor.permute": _torch_permute,
    "torch.Tensor.unsqueeze": _torch_tensor_unsqueeze,
    "torch.Tensor.repeat": _torch_tensor_repeat,
    "torch.Tensor.transpose": _torch_tensor_transpose,
    "torch.Tensor.reshape": _torch_tensor_reshape,
    "torch.Tensor.scatter_add_": _torch_tensor_scatter_add_,
    "torch.Tensor.expand": _torch_tensor_exapend,
    "torch.Tensor.flatten": _torch_tensor_flatten,
}
