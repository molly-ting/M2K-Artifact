"""
use the following command format to run the script:
BOS_HIGHLEVEL=null BOS_BIN_HOOK=1 BOS_CE_MODE=bypass LOCAL_ONLY=1 python -m HFProbe.backend.run_transformers
"""
import os, glob, torch, sys, inspect
from pathlib import Path
import shutil, subprocess, json
from datetime import datetime
from collections import Counter
import types
import torch.nn.functional as F
from huggingface_hub import snapshot_download, list_repo_files
import io, contextlib
from .utils import computeSymbolicArgsWithMap
from collections import defaultdict

tensor_calls = []
CPP_SEARCH_DIRS = []
_CPP_LOAD_SEEN = False
current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(current_path_string))
# pytree: prefer Torch's implementation and fall back to a simple recursive version.
try:
    from torch.utils import _pytree as pytree
except Exception:
    class _MiniPytree:
        @staticmethod
        def tree_map(fn, x):
            if isinstance(x, dict):
                return {k: _MiniPytree.tree_map(fn, v) for k, v in x.items()}
            if isinstance(x, (list, tuple)):
                t = [ _MiniPytree.tree_map(fn, v) for v in x ]
                return type(x)(t) if isinstance(x, list) else tuple(t)
            return fn(x)
    pytree = _MiniPytree

# === Reentrancy guard (thread-local) ===
import threading
_BOS_TLS = threading.local()

def _enter_guard() -> bool:
    """Enter the wrapper guard; return False if already inside a wrapper."""
    if getattr(_BOS_TLS, "busy", False):
        return False
    _BOS_TLS.busy = True
    return True

def _exit_guard():
    """Must be called when leaving a wrapper, preferably in try/finally."""
    _BOS_TLS.busy = False

# === Common utilities ===
def _collect_args_meta(*args, **kwargs):
    """
    Collect lightweight metadata for *args/**kwargs, such as shape, dtype,
    device, and primitive values.
    Return: (has_tensor: bool, meta: dict)
    """
    has_tensor = False

    def _brief(x):
        nonlocal has_tensor
        try:
            if torch.is_tensor(x):
                has_tensor = True
                return {
                    "type": "torch.Tensor",
                    "shape": tuple(x.shape),
                    "dtype": str(x.dtype),
                }
            if isinstance(x, (int, float, bool, str)):
                return {"type": type(x).__name__, "value": x}
            if isinstance(x, (torch.dtype, torch.device)):
                return {"type": type(x).__name__, "value": str(x)}
            if x is None:
                return {"type": "NoneType", "value": None}
            # Other objects: record only the type name.
            return {"type": type(x).__name__, "value": None}
        except Exception:
            return {"type": "Exception", "value": None}

    args_meta = pytree.tree_map(_brief, args)
    kwargs_meta = pytree.tree_map(_brief, kwargs)
    return has_tensor, {"args": args_meta, "kwargs": kwargs_meta}

def collect_tensor_args(*args, method = None):
    argCons = []
    hasTensor = False
    for i, arg in enumerate(args):
        if isinstance(arg, torch.Tensor):
            hasTensor = True
            tmp = {"shape": list(arg.shape), "dtype": str(arg.dtype), "type": "torch.Tensor"}
            if arg.dtype in (torch.int32, torch.int64, torch.int16, torch.int8):  # check integer type
                if (arg.numel() == 1 and arg.item() == 0) or not torch.all(arg == 0):  # check not all zero
                    max_val = torch.max(arg).item()
                    tmp["maxV"] = max_val
                    min_val = torch.min(arg).item()
                    tmp["minV"] = min_val
                    unique_vals, counts = torch.unique(arg, return_counts=True)
                    has_duplicates = torch.any(counts > 1).item()
                    tmp["dupV"] = has_duplicates
            argCons.append(tmp)
        elif isinstance(arg, list):
            if len(arg) == 0:
                argCons.append({"shape": [0], "type": type(arg).__name__})
            elif isinstance(arg[0], torch.Tensor):
                hasTensor = True
                values = []
                for item in arg:
                    tmp = {"shape": list(item.shape), "dtype": str(item.dtype), "type": "torch.Tensor"}
                    if item.dtype in (torch.int32, torch.int64, torch.int16, torch.int8):  # check integer type
                        if (item.numel() == 1 and item.item() == 0) or not torch.all(item == 0):  # check not all zero
                            max_val = torch.max(item).item()
                            tmp["maxV"] = max_val
                            min_val = torch.min(item).item()
                            tmp["minV"] = min_val
                            unique_vals, counts = torch.unique(item, return_counts=True)
                            has_duplicates = torch.any(counts > 1).item()
                            tmp["dupV"] = has_duplicates
                    values.append(tmp)
                argCons.append({"value": values, "shape": [len(arg)], "dtype": "torch.Tensor", "type": "list"})
            else:
                tmp = {"shape": [len(arg)], "dtype": type(arg[0]).__name__, "type": "list"}
                if type(arg[0]).__name__ == "int":
                    if (len(arg) == 1 and arg[0] == 0) or not all(x == 0 for x in arg):
                        max_val = max(arg)
                        tmp["maxV"] = max_val
                        min_val = min(arg)
                        tmp["minV"] = min_val
                        has_duplicates = len(set(arg)) != len(arg)
                        tmp["dupV"] = has_duplicates
                argCons.append(tmp)
        else:
            value = arg
            if not isinstance(arg, (int, float)):
                value = str(arg)
            argCons.append({"value": value, "type": type(arg).__name__})
    return hasTensor, argCons

class NvccPatch:
    """
    On enter: fake CUDA_HOME and nvcc -V output, which Transformers/JIT often probes.
    On exit: fully restore the environment.
    """
    def __enter__(self):
        import torch.utils.cpp_extension as ce
        self._old_env_cuda_home = os.environ.get("CUDA_HOME")
        self._old_ce_cuda_home = getattr(ce, "CUDA_HOME", None)
        self._old_check_output = subprocess.check_output

        # Fake CUDA_HOME.
        os.environ["CUDA_HOME"] = "/usr/local/cuda"
        ce.CUDA_HOME = "/usr/local/cuda"

        # Fake nvcc -V output, compatible with text=True / universal_newlines=True.
        def _fake_check_output(cmd, *a, **k):
            seq = cmd if isinstance(cmd, (list, tuple)) else [cmd]
            try:
                if any("nvcc" in str(x) for x in seq):
                    s = "Cuda compilation tools, release 11.8, V11.8.89\n"
                    return s if (k.get("text") or k.get("universal_newlines")) else s.encode("utf-8")
            except Exception:
                pass
            return self._old_check_output(cmd, *a, **k)

        subprocess.check_output = _fake_check_output
        return self

    def __exit__(self, exc_type, exc, tb):
        import torch.utils.cpp_extension as ce
        # Restore check_output.
        subprocess.check_output = self._old_check_output
        # Restore CUDA_HOME.
        if self._old_env_cuda_home is None:
            os.environ.pop("CUDA_HOME", None)
        else:
            os.environ["CUDA_HOME"] = self._old_env_cuda_home
        ce.CUDA_HOME = self._old_ce_cuda_home

from collections import Counter, defaultdict

def retrieve_stack(stack):
    call_stack = []
    i = 0
    for frame in stack:
        if i >= 5:
            break
        if "/transformers" in frame.filename and "/torch/nn/" not in frame.filename:
            call_stack.append((frame.filename.split("/transformers")[1],frame.lineno,frame.function))
            i+=1
    return tuple(call_stack)

# mock cpp extension load
from .cpp_load import mock_torch_utils_cpp_extension, LoadedCppExtensionMock

def _on_called(method, *args, **kwargs):
    global tensor_calls
    global calls_map
    global argChanged

    call_stack = retrieve_stack(inspect.stack())

    hasTensor, argCons = collect_tensor_args(*args[0], method=method) 
    to_add = {"name": method, "args": argCons, "stack": call_stack}
    if to_add not in tensor_calls:
        tensor_calls.append(to_add)

cpp_mock = LoadedCppExtensionMock(_on_called)
mock_torch_utils_cpp_extension(cpp_mock)

# --- Import and apply patches ---
from . import cuda_patches
def patch_torch_cpp_extension():
    """Intercept JIT extension loading and return a logging wrapper without running real CUDA."""
    print("[INFO] Patching torch.utils.cpp_extension for custom kernel capture...")
    import torch.utils.cpp_extension as ce

    CPP_EXEC_ENABLED = (os.getenv("CPP_EXEC_ENABLED", "0") == "1")
    _orig_load = ce.load
    _orig_inline = getattr(ce, "load_inline", None)

    def _get_ce_mode():
        # "bypass" skips compilation by default. Set BOS_CE_MODE=attempt to try compiling.
        return os.getenv("BOS_CE_MODE", "bypass").lower()

    def _fake_return(kernel_name, *kargs, **kkwargs):
        # 1) Prefer out/output/result/dst.
        for key in ("out", "output", "result", "dst"):
            t = kkwargs.get(key, None)
            if isinstance(t, torch.Tensor):
                return t
        # 2) Simple matmul shape inference.
        tins = [x for x in kargs if isinstance(x, torch.Tensor)]
        tins += [v for v in kkwargs.values() if isinstance(v, torch.Tensor)]
        twos = [t for t in tins if t.dim() == 2]
        if len(twos) >= 2 and twos[0].shape[1] == twos[1].shape[0]:
            A, B = twos[0], twos[1]
            return torch.zeros((A.shape[0], B.shape[1]), dtype=A.dtype, device="cpu")
        # 3) Fallback: zeros_like for the first tensor.
        if tins:
            return torch.zeros_like(tins[0], device="cpu")
        return None

    class CppKernelWrapper:
        def __init__(self, module_name, real_mod=None):
            self.__name__ = module_name
            self.__real_mod = real_mod
            self._method_cache = {}

        def __getattr__(self, kernel_name):
            if kernel_name in self._method_cache:
                return self._method_cache[kernel_name]

            def proxy(*kernel_args, **kernel_kwargs):
                if not _enter_guard():
                    return _fake_return(kernel_name, *kernel_args, **kernel_kwargs)
                try:
                    full = f"custom_cpp::{self.__name__}::{kernel_name}"

                    call_stack = retrieve_stack(inspect.stack())
                    
                    hasTensor, argCons = collect_tensor_args(*kernel_args, method=full)
                    if hasTensor:
                        to_add = {"name": full, "args": argCons, "stack": call_stack}

                        if to_add not in tensor_calls:
                            tensor_calls.append(to_add)

                    # Enable the logic below if real execution is needed; it may fail.
                    if CPP_EXEC_ENABLED and self.__real_mod is not None:
                        try:
                            real_fn = getattr(self.__real_mod, kernel_name)
                            return real_fn(*kernel_args, **kernel_kwargs)
                        except Exception:
                            pass
                    return _fake_return(kernel_name, *kernel_args, **kernel_kwargs)
                finally:
                    _exit_guard()

            proxy.__name__ = kernel_name
            proxy.__qualname__ = f"{self.__name__}.{kernel_name}"
            self._method_cache[kernel_name] = proxy
            return proxy

        def __dir__(self):
            base = set(super().__dir__())
            try:
                base |= set(dir(self.__real_mod)) if self.__real_mod is not None else set()
            except Exception:
                pass
            base |= set(self._method_cache.keys())
            return sorted(base)

    def _fix_sources(sources):
        srcs = sources if isinstance(sources, (list, tuple)) else [sources]
        fixed = []
        for s in srcs:
            if isinstance(s, str) and not os.path.isabs(s):
                base = os.path.basename(s)
                hit = None
                for d in CPP_SEARCH_DIRS:
                    cand = os.path.join(d, base)
                    if os.path.exists(cand):
                        hit = cand
                        break
                fixed.append(hit or s)
            else:
                fixed.append(s)
        return fixed

    def _wrap_load(fn, name, *args, **kwargs):
        try:
            real_mod = fn(name, *args, **kwargs)
            print(f"[PATCH] Loaded real C++ extension '{name}', returning logging wrapper.")
            return CppKernelWrapper(name, real_mod=real_mod)
        except Exception as e:
            print(f"[PATCH] Compile/load failed for '{name}'. Return stub wrapper. Err={e}")
            return CppKernelWrapper(name, real_mod=None)

    def patched_load(name, sources, *args, **kwargs):
        global _CPP_LOAD_SEEN; _CPP_LOAD_SEEN = True
        if _get_ce_mode() != "attempt":
            print(f"[PATCH] Bypass compilation for '{name}'. Returning stub wrapper.")
            return CppKernelWrapper(name, real_mod=None)
        # Use the original logic only when compilation is explicitly attempted.
        return _wrap_load(_orig_load, name, _fix_sources(sources), *args, **kwargs)

    ce.load = patched_load

    if _orig_inline is not None:
        def patched_inline(name, cpp_sources=None, cuda_sources=None, functions=None, *args, **kwargs):
            global _CPP_LOAD_SEEN; _CPP_LOAD_SEEN = True
            if _get_ce_mode() != "attempt":
                print(f"[PATCH] Bypass compilation for inline '{name}'. Returning stub wrapper.")
                return CppKernelWrapper(name, real_mod=None)
            if cpp_sources is not None:  cpp_sources = _fix_sources(cpp_sources)
            if cuda_sources is not None: cuda_sources = _fix_sources(cuda_sources)
            return _wrap_load(_orig_inline, name, cpp_sources, cuda_sources, functions, *args, **kwargs)
        ce.load_inline = patched_inline

import sys, importlib, importlib.abc, importlib.machinery, types

def _wrap_module_functions(mod: types.ModuleType, modname: str):
    for attr_name in dir(mod):
        if attr_name.startswith("__"):
            continue
        try:
            obj = getattr(mod, attr_name)
        except Exception:
            continue
        if callable(obj) and not isinstance(obj, types.ModuleType) and not getattr(obj, "__bos_wrapped__", False):
            def make_wrapper(fn, qname):
                def wrapper(*args, **kwargs):
                    if not _enter_guard():
                        # A placeholder return is possible; call the original function to reduce disruption.
                        return fn(*args, **kwargs)
                    try:

                        call_stack = retrieve_stack(inspect.stack())
                        
                        hasTensor, argCons = collect_tensor_args(*args, method=qname)
                        if hasTensor:
                            to_add = {"name": f"custom_bin::{qname}", "args": argCons, "stack": call_stack}

                            if to_add not in tensor_calls:
                                tensor_calls.append(to_add)

                        # Placeholder return: prefer out, then zeros_like, then None.
                        for k in ("out","output","result","dst"):
                            t = kwargs.get(k)
                            if isinstance(t, torch.Tensor): return t
                        for a in args:
                            if isinstance(a, torch.Tensor): return torch.zeros_like(a)
                        return None
                    finally:
                        _exit_guard()
                wrapper.__bos_wrapped__ = True
                wrapper.__name__ = getattr(fn, "__name__", attr_name)
                return wrapper
            try:
                setattr(mod, attr_name, make_wrapper(obj, f"{modname}.{attr_name}"))
            except Exception:
                pass

class _WrappingLoader(importlib.abc.Loader):
    def __init__(self, spec, real_loader, name, wrap_pred):
        self.spec = spec
        self.real_loader = real_loader
        self.name = name
        self.wrap_pred = wrap_pred
    def create_module(self, spec):  # noqa
        if hasattr(self.real_loader, "create_module"):
            return self.real_loader.create_module(spec)
        return None
    def exec_module(self, module):  # noqa
        self.real_loader.exec_module(module)
        try:
            if self.wrap_pred(self.name):
                _wrap_module_functions(module, self.name)
                print(f"[BIN-HOOK] wrapped module: {self.name}")
        except Exception as e:
            print(f"[BIN-HOOK] wrap failed for {self.name}: {e}")

class _WrappingFinder(importlib.abc.MetaPathFinder):
    def __init__(self, wrap_pred):
        self.wrap_pred = wrap_pred

    def find_spec(self, fullname, path, target=None):
        spec = importlib.machinery.PathFinder.find_spec(fullname, path)
        if spec is None or spec.loader is None:
            return None
        # Name must match the allowlist and the loader must be for a binary extension (.so/.pyd).
        if not self.wrap_pred(fullname):
            return None
        if not isinstance(spec.loader, importlib.machinery.ExtensionFileLoader):
            return None

        return importlib.machinery.ModuleSpec(
            name=fullname,
            loader=_WrappingLoader(spec, spec.loader, fullname, self.wrap_pred),
            origin=spec.origin,
            is_package=spec.submodule_search_locations is not None,
        )

bnb_dummy = types.ModuleType("bitsandbytes")
bnb_dummy.nn = types.ModuleType("bitsandbytes.nn")
sys.modules["bitsandbytes"] = bnb_dummy
bnb_dummy.__spec__ = importlib.machinery.ModuleSpec(name="bitsandbytes", loader=None)
bnb_dummy.nn.__spec__ = importlib.machinery.ModuleSpec(name="bitsandbytes.nn", loader=None)

def patch_binary_imports(name_patterns=(
    "bitsandbytes", "flash_attn", "xformers", "exllama", "awq", "gptq", "marlin"
)):
    pats = tuple(name_patterns)
    def _pred(name: str) -> bool:
        return name.startswith(pats) or any(p in name for p in pats)
    if any(isinstance(f, _WrappingFinder) for f in sys.meta_path):
        return
    sys.meta_path.insert(0, _WrappingFinder(_pred))
    print("[INFO] Binary import hook installed for:", pats)

import torch as _torch
import torch.nn.functional as _F

# ---- helpers for "null" mode ----
def _zeros_like_linear_out(x, w, b=None):
    out_features = w.shape[0]; *prefix, _ = x.shape
    return _torch.zeros(*prefix, out_features, dtype=x.dtype, device="cpu")

def _zeros_like_matmul(a, b):
    if a.dim()==2 and b.dim()==2:
        return _torch.zeros(a.shape[0], b.shape[1], dtype=a.dtype, device="cpu")
    if a.dim()==3 and b.dim()==3:
        return _torch.zeros(a.shape[0], a.shape[1], b.shape[2], dtype=a.dtype, device="cpu")
    return _torch.zeros((), device="cpu")

def _reduce_shape(shape, dim, keepdim=False):
    if dim is None:
        return () if not keepdim else tuple(1 for _ in shape)
    if isinstance(dim, int): dims = [dim]
    else: dims = list(dim)
    rank = len(shape)
    dims = [d if d >= 0 else d + rank for d in dims]
    out = list(shape)
    for d in sorted(set(dims)):
        out[d] = 1 if keepdim else None
    return tuple(s for s in out if s is not None)

def _zeros_like_where(args, kwargs):
    # where(cond, x, y): use x as the reference tensor.
    if len(args) >= 3 and isinstance(args[1], _torch.Tensor):
        return _torch.zeros_like(args[1])
    x = kwargs.get("input") or kwargs.get("x")
    return _torch.zeros_like(x) if isinstance(x, _torch.Tensor) else None

def _zeros_like_sort(inp):
    vals = _torch.zeros_like(inp)
    idxs = _torch.zeros_like(inp, dtype=_torch.long)
    return vals, idxs

def _zeros_like_topk(inp, k, dim=None):
    dim = (-1 if dim is None else dim)
    dim = dim if dim >= 0 else (inp.dim()+dim)
    shape = list(inp.shape); shape[dim] = int(k)
    vals = _torch.zeros(shape, dtype=inp.dtype, device="cpu")
    idxs = _torch.zeros(shape, dtype=_torch.long, device="cpu")
    return vals, idxs

def _zeros_like_multinomial(inp, num_samples):
    shape = tuple(list(inp.shape[:-1]) + [int(num_samples)])
    return _torch.zeros(shape, dtype=_torch.long, device="cpu")

def _zeros_like_addmm(mat1, mat2):
    if mat1.dim()==2 and mat2.dim()==2 and mat1.shape[1]==mat2.shape[0]:
        return _torch.zeros((mat1.shape[0], mat2.shape[1]), dtype=mat1.dtype, device="cpu")
    return _torch.zeros((), device="cpu")

# ---- generic wrapper ----
def _wrap_highlevel(ns_obj, ns_name: str, fn_name: str, mode: str):
    if not hasattr(ns_obj, fn_name): return
    orig = getattr(ns_obj, fn_name)
    if not callable(orig) or getattr(orig, "__bos_wrapped__", False): return

    def wrapper(*args, **kwargs):
        if not _enter_guard():
            return orig(*args, **kwargs)
        try:
            if mode == "null":
                if ns_name == "torch":
                    if fn_name in ("matmul","mm","bmm"):   return _zeros_like_matmul(args[0], args[1])
                    if fn_name == "einsum":                return _torch.zeros_like(args[0])
                    if fn_name in ("tril","triu","rsqrt","clamp","zeros_like","softmax"):
                        base = args[0] if len(args)>0 else kwargs.get("input"); return _torch.zeros_like(base)
                    if fn_name == "where":                return _zeros_like_where(args, kwargs)
                    if fn_name in ("amax","amin"):
                        x = args[0]; dim = kwargs.get("dim", None)
                        if len(args)>1: dim = args[1]
                        keepdim = bool(kwargs.get("keepdim", False))
                        out_shape = _reduce_shape(tuple(x.shape), dim, keepdim)
                        return _torch.zeros(out_shape, dtype=x.dtype, device="cpu")
                    if fn_name == "sort":                 return _zeros_like_sort(args[0])
                    if fn_name == "topk":
                        x = args[0]; k = kwargs.get("k", None); 
                        if k is None and len(args)>1: k = args[1]
                        return _zeros_like_topk(x, k, kwargs.get("dim", None))
                    if fn_name == "multinomial":
                        x = args[0]; n = kwargs.get("num_samples", None)
                        if n is None and len(args)>1: n = args[1]
                        return _zeros_like_multinomial(x, n)
                    if fn_name == "addmm":
                        if len(args) >= 3:
                            return _zeros_like_addmm(args[1], args[2])
                        return _torch.zeros_like(args[0]) if len(args)>0 and isinstance(args[0], _torch.Tensor) else None
                    if fn_name == "isin":
                        base = args[0] if len(args)>0 else kwargs.get("elements")
                        return _torch.zeros_like(base, dtype=_torch.bool) if _torch.is_tensor(base) else None
                    if fn_name == "is_floating_point":
                        x = args[0] if len(args)>0 else kwargs.get("input")
                        # Return a scalar bool; only arguments are recorded, so output shape is irrelevant.
                        return bool(getattr(x, "dtype", _torch.float32).is_floating_point) if hasattr(x, "dtype") else True
                    if fn_name == "flatten":
                        x = args[0] if len(args) > 0 else kwargs.get("input")
                        if not _torch.is_tensor(x):
                            return None
                        start = kwargs.get("start_dim", 0)
                        end   = kwargs.get("end_dim", -1)
                        if len(args) > 1: start = args[1]
                        if len(args) > 2: end   = args[2]
                        rank = x.dim()
                        # Normalize indices.
                        if start < 0: start += rank
                        if end   < 0: end   += rank
                        start = max(0, min(start, rank - 1))
                        end   = max(start, min(end, rank - 1))
                        # Compute the new shape: pre + [product(mid)] + post.
                        pre  = list(x.shape[:start])
                        mid  = 1
                        for d in x.shape[start:end + 1]:
                            mid *= int(d)
                        post = list(x.shape[end + 1:])
                        new_shape = pre + [mid] + post
                        return _torch.zeros(new_shape, dtype=x.dtype, device="cpu")
                    if fn_name == "cat":
                        tensors = args[0] if len(args) > 0 else kwargs.get("tensors")
                        dim = kwargs.get("dim", 0)
                        if len(args) > 1: dim = args[1]
                        if isinstance(tensors, (list, tuple)) and tensors and _torch.is_tensor(tensors[0]):
                            ref = tensors[0]
                            shape = list(ref.shape)
                            D = dim if dim >= 0 else dim + ref.dim()
                            shape[D] = sum(int(t.shape[D]) for t in tensors)
                            return _torch.zeros(shape, dtype=ref.dtype, device="cpu")
                        return None
                    if fn_name == "sum":
                        x = args[0] if len(args) > 0 else kwargs.get("input")
                        if not _torch.is_tensor(x):
                            return 0
                        dim = kwargs.get("dim", None)
                        if len(args) > 1:
                            dim = args[1]
                        keepdim = kwargs.get("keepdim", False)
                        if len(args) > 2:
                            keepdim = args[2]
                        out_dtype = kwargs.get("dtype", getattr(x, "dtype", _torch.float32))
                        out_shape = _reduce_shape(tuple(x.shape), dim, bool(keepdim))
                        return _torch.zeros(out_shape, dtype=out_dtype, device="cpu")
                else:  # torch.nn.functional
                    if fn_name == "linear":
                        return _zeros_like_linear_out(args[0], args[1], args[2] if len(args)>2 else kwargs.get("bias"))
                    if fn_name in ("layer_norm","softmax","gelu","silu","dropout"):
                        return _torch.zeros_like(args[0])
                    if fn_name == "scaled_dot_product_attention":
                        q = args[0]; return _torch.zeros_like(q)
            # log: real execution; off: does not reach here; null: fallback to real execution if no branch matches.
            return orig(*args, **kwargs)
        finally:
            _exit_guard()

    wrapper.__bos_wrapped__ = True
    setattr(ns_obj, fn_name, wrapper)

def patch_highlevel_apis(mode: str = "off"):
    assert mode in ("off","log","null")
    if mode == "off":
        print("[INFO] High-level API patch: off"); return
    print(f"[INFO] High-level API patch: mode={mode}")

    # Patch torch.*.
    TORCH_FNS = [
        "matmul","mm","bmm","einsum","addmm",
        "tril","triu","where","clamp","amax","amin","rsqrt","zeros_like",
        "softmax","sort","topk","multinomial",
        "isin","is_floating_point","flatten","cat","sum",
    ]
    for fn in TORCH_FNS:
        _wrap_highlevel(_torch, "torch", fn, mode)

    # Patch high-level F.* APIs.
    F_FNS = [
        "linear","layer_norm","softmax","gelu","silu","dropout",
        "scaled_dot_product_attention",
    ]
    for fn in F_FNS:
        _wrap_highlevel(_F, "torch.nn.functional", fn, mode)

def createEmptyModelBin(modelId, cache_dir):
    files = list_repo_files(modelId)
    
    hasModelBin = False
    for f in files:
        if f == "pytorch_model.bin":
            hasModelBin = True
            break
        
    if not hasModelBin:
        return
    
    dst_path = os.path.join(cache_dir, "pytorch_model.bin")
    print(f"Creating dummy file: {dst_path}")
    with open(dst_path, "wb") as f:
        f.write(b"")

def copy_config_to_modules_if_needed(cache_dir, model_id):
    module_dir = os.path.expanduser("~/.cache/huggingface/modules/transformers_modules")
    hash_number = cache_dir.split("/")[-1]
    module_dir = os.path.join(module_dir, hash_number)
    for root, dirs, files in os.walk(cache_dir):
        for file in files:
            if not os.path.exists(module_dir):
                os.makedirs(module_dir)
            src = os.path.join(root, file)
            relative_path = os.path.relpath(src, cache_dir)
            dst = os.path.join(module_dir, relative_path)
            dst_dir = os.path.dirname(dst)
            if not os.path.exists(dst):
                print(f"Copying {src} to {dst}")
                if not os.path.exists(dst_dir):
                    os.makedirs(dst_dir)
                shutil.copy(src, dst)

    if "Qwen--Qwen-1_8B" in cache_dir:
        module_dir_2 = os.path.expanduser("~/.cache/huggingface/modules/transformers_modules/Qwen/Qwen-1_8B")
        module_dir_2 = os.path.join(module_dir_2, hash_number)
        if not os.path.exists(module_dir_2):
            os.makedirs(module_dir_2)
        for root, dirs, files in os.walk(cache_dir):
            for file in files:
                src = os.path.join(root, file)
                relative_path = os.path.relpath(src, cache_dir)
                dst = os.path.join(module_dir_2, relative_path)
                dst_dir = os.path.dirname(dst)
                if not os.path.exists(dst):
                    print(f"Copying {src} to {dst}")
                    if not os.path.exists(dst_dir):
                        os.makedirs(dst_dir)
                    shutil.copy(src, dst)
        return

    if model_id:
        module_dir_2 = os.path.expanduser(f"~/.cache/huggingface/modules/transformers_modules/{model_id}")
        module_dir_2 = os.path.join(module_dir_2, hash_number)
        if not os.path.exists(module_dir_2):
            return 
        for root, dirs, files in os.walk(cache_dir):
            for file in files:
                src = os.path.join(root, file)
                relative_path = os.path.relpath(src, cache_dir)
                dst = os.path.join(module_dir_2, relative_path)
                dst_dir = os.path.dirname(dst)
                if not os.path.exists(dst):
                    print(f"Copying {src} to {dst}")
                    if not os.path.exists(dst_dir):
                        os.makedirs(dst_dir)
                    shutil.copy(src, dst)

def prepare_snapshot_and_stage_sources(model_id: str,
                                       hf_token: str | None = None,
                                       local_only: bool = False,
                                       include_weights: bool = True):
    allow_patterns = [
        "*.py", "*.json", "tokenizer.*", "vocab.*", "merges.txt", "*.model",
        "*.cpp", "*.cu", "*.h", "*.cuh",
    ]
    ignore_patterns = []
    if not include_weights and model_id not in ["Qwen/Qwen-1_8B-Chat-Int4", "Qwen/Qwen-1_8B-Chat-Int8", "openerotica/Qwen-7b-GPTQ-ERP", 
                                                "yyjjtt/test-model2", "ycchen/qwen-14b-4bit", "kevinz23/Qwen-7B-light-int4"]:
        ignore_patterns=["*.bin", "**/*.bin", "*.safetensors", "**/*.safetensors"]
    else:
        allow_patterns += ["*.safetensors", "pytorch_model*.bin", "pytorch_model-*.bin"]

    local_dir = snapshot_download(
        repo_id=model_id,
        token=hf_token or None,
        local_files_only=local_only,
        ignore_patterns=ignore_patterns
    )

    createEmptyModelBin(model_id, local_dir)
    copy_config_to_modules_if_needed(local_dir, model_id)
    return local_dir

if os.getenv("BOS_FAKE_CUDA", "1") == "1":
    from . import cuda_patches

from .torchmock.torchmocks import *
mock()
if os.getenv("BOS_BIN_HOOK", "1") == "1":
    patch_binary_imports()

import transformers
_real_load_pretrained_model = transformers.modeling_utils.PreTrainedModel._load_pretrained_model.__func__

@classmethod
def _dummy_load_pretrained_model(
    cls,
    model,
    state_dict=None,
    checkpoint_files=None,
    pretrained_model_name_or_path=None,
    ignore_mismatched_sizes=False,
    sharded_metadata=None,
    device_map=None,
    disk_offload_folder=None,
    offload_state_dict=None,
    dtype=None,
    hf_quantizer=None,
    keep_in_fp32_regex=None,
    device_mesh=None,
    key_mapping=None,
    weights_only=True,
):
    if state_dict is None:
        print("Generating dummy weights for", cls.__name__)
        dummy_dict = {
            name: torch.zeros_like(param, device="cpu")
            for name, param in model.named_parameters()
        }
        state_dict = dummy_dict
        checkpoint_files = []

    return _real_load_pretrained_model(
        cls,
        model=model,
        state_dict=state_dict,
        checkpoint_files=checkpoint_files,
        pretrained_model_name_or_path=pretrained_model_name_or_path,
        ignore_mismatched_sizes=ignore_mismatched_sizes,
        sharded_metadata=sharded_metadata,
        device_map=device_map,
        disk_offload_folder=disk_offload_folder,
        offload_state_dict=offload_state_dict,
        dtype=dtype,
        hf_quantizer=hf_quantizer,
        keep_in_fp32_regex=keep_in_fp32_regex,
        device_mesh=device_mesh,
        key_mapping=key_mapping,
        weights_only=weights_only,
    )

transformers.modeling_utils.PreTrainedModel._load_pretrained_model = _dummy_load_pretrained_model

# === Import transformers after enabling patches ===
from transformers import (
    AutoTokenizer, AutoConfig,
    AutoModelForCausalLM, AutoModelForSeq2SeqLM, AutoModel
)

# === Build config ===
def build_config(local_dir: str, override_configs):
    cfg = AutoConfig.from_pretrained(local_dir, trust_remote_code=True)
    if override_configs:
        if "architectures" in override_configs:
            override_configs.pop("architectures")
        if "_name_or_path" in override_configs:
            override_configs.pop("_name_or_path")
        if "auto_map" in override_configs:
            override_configs.pop("auto_map")
        
        for k in override_configs:
            if hasattr(cfg, k):
                try:
                    setattr(cfg, k, override_configs[k])
                except Exception:
                    pass
    return cfg

# === Load tokenizer and model; infer Seq2Seq/CausalLM and fall back to AutoModel on failure ===
def load_model_and_tokenizer(local_dir: str, cfg):
    try:
        tok = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
    except:
        local_dir = prepare_snapshot_and_stage_sources(
            model_id="Qwen/Qwen-1_8B",
            hf_token=HF_TOKEN or None,
            local_only=False,
            include_weights=False
        )
        tok = AutoTokenizer.from_pretrained("Qwen/Qwen-1_8B", trust_remote_code=True, use_fast=True)
    is_s2s = bool(getattr(cfg, "is_encoder_decoder", False))
    ModelCls = AutoModelForSeq2SeqLM if is_s2s else AutoModelForCausalLM
    model = ModelCls.from_pretrained(
            local_dir,
            config=cfg,
            trust_remote_code=True,
            low_cpu_mem_usage=True,
            device_map="cpu",
        ).eval()
    return model, tok

# === Trigger one computation; prefer generate, otherwise use a minimal forward pass ===
def run_once(model, tok, cfg, prompts: list[str], new_tokens: int = 2):
    tensor_calls.clear()
    with torch.no_grad():
        if hasattr(model, "generate"):
            inputs = tok(prompts, return_tensors="pt") 
            _ = model.generate(**inputs, max_new_tokens=new_tokens, use_cache=True)
        else:
            inputs = tok(prompts[0], return_tensors="pt")
            if "input_ids" not in inputs:
                vocab = int(getattr(cfg, "vocab_size", 32000))
                inputs["input_ids"] = torch.randint(0, vocab, (1, len(prompts[0].split())))
            _ = model(**inputs)

def _infer_list_dtype(lst):
    if all(isinstance(v, (int, bool)) for v in lst): return "int"
    if all(isinstance(v, float)      for v in lst): return "float"
    if all(isinstance(v, str)        for v in lst): return "str"
    return "unknown"

def _to_arg_item(x):
    if isinstance(x, dict) and x.get("type") == "torch.Tensor":
        return x
    if isinstance(x, bool):  return {"type":"bool",  "value": bool(x)}
    if isinstance(x, int):   return {"type":"int",   "value": int(x)}
    if isinstance(x, float): return {"type":"float", "value": float(x)}
    if isinstance(x, str):   return {"type":"str",   "value": x}
    if isinstance(x, (list, tuple)):
        if x and all(isinstance(v, dict) and v.get("type") == "torch.Tensor" for v in x):
            return {"type":"list","dtype":"torch.Tensor","shape":[len(x)],"value": list(x)}
        return {"type":"list","dtype": _infer_list_dtype(list(x)),"shape":[len(x)]}
    return {"type": type(x).__name__, "value": None}

def _params_to_argCons(params_meta: dict):
    args_meta   = list(params_meta.get("args", []))
    kwargs_meta = dict(params_meta.get("kwargs", {}))
    out = []
    for a in args_meta: out.append(_to_arg_item(a))
    for k in sorted(kwargs_meta.keys()): out.append(_to_arg_item(kwargs_meta[k]))
    return out

# === Main flow ===
HF_TOKEN       = os.getenv("HF_TOKEN")
LOCAL_ONLY     = os.getenv("LOCAL_ONLY", "1") == "1"
INCLUDE_WEIGHTS= os.getenv("INCLUDE_WEIGHTS", "1") == "1"
NEW_TOKENS     = int(os.getenv("NEW_TOKENS", "2"))
BATCH_SIZE_CONFIGS = [1, 3, 5]
SEQ_LENS_CONFIGS = [1, 7, 17]

def run(model_id, override_configs=None, suffix=None, output_dir=None, data_dir=None, is_op_suffix=False):
    if not output_dir:
        output_dir = os.path.join(root_dir, "results", "huggingface", "out")
    os.makedirs(output_dir, exist_ok=True)

    if not is_op_suffix:
        filename = model_id.replace('/', '_')+".json"
        if suffix:
            filename = model_id.replace('/', '_')+f"_{suffix}.json"
        agg_path = os.path.join(output_dir, filename)
    else:
        data_dir = os.path.join(data_dir, model_id.replace('/', '_'))
        output_dir = os.path.join(output_dir, model_id.replace('/', '_'))
        os.makedirs(output_dir, exist_ok=True)
        filename = suffix+".json"
        agg_path = os.path.join(output_dir, filename)
        
    local_dir = prepare_snapshot_and_stage_sources(
        model_id=model_id,
        hf_token=HF_TOKEN or None,
        local_only=False,
        include_weights=False
    )

    total_calls_map = defaultdict(dict)
    data = []

    # Fake the nvcc/CUDA environment, then load, trigger, and write results.
    with NvccPatch():
        cfg = build_config(local_dir, override_configs)
        if hasattr(cfg, "auto_map"):
            if hasattr(cfg.auto_map, "AutoModelForCausalLM"):
                if "--" in cfg.auto_map.AutoModelForCausalLM:
                    use_model_id = cfg.auto_map.AutoModelForCausalLM.split("--")[0]
                    if use_model_id != model_id:
                        local_dir_2 = prepare_snapshot_and_stage_sources(
                            model_id=use_model_id,
                            hf_token=HF_TOKEN or None,
                            local_only=False,
                            include_weights=False
                        )
        model, tok = load_model_and_tokenizer(local_dir, cfg)
        
        for batch_size in BATCH_SIZE_CONFIGS:
            for seq_len in SEQ_LENS_CONFIGS:
                # 1. Prepare batched inputs.
                prompt_text = ("hi " * seq_len).strip()
                prompts = [prompt_text] * batch_size
            
                # 2. Get the real token length.
                real_seq_len = len(tok(prompt_text, return_tensors="pt")["input_ids"][0])
                print(f"\n--- Running: batch_size={batch_size}, seq_len={real_seq_len} ---")

                # 3. Call the modified run_once.
                run_once(model, tok, cfg, prompts, new_tokens=NEW_TOKENS)

                # 4. Collect and organize logs.
                for call in tensor_calls:
                    func_name = call.get('name', 'unknown_function')
                    argCons = call.get('args', [])
                    call_stack = call.get('stack', ())
                    run_key = (batch_size, real_seq_len)

                    total_calls_map.setdefault(func_name, {}).setdefault(call_stack, {}).setdefault(run_key, []).append(argCons)
                data.append({"batch_size": batch_size, "seq_len": real_seq_len, "calls": tensor_calls.copy()})
    
    if not data_dir:
        data_dir = os.path.join(root_dir, "results", "huggingface", "data")
    os.makedirs(data_dir, exist_ok=True)
           
    with open(os.path.join(data_dir, filename), "w") as wf:
        json.dump(data, wf)

    buf = io.StringIO()  # Collect all prints from computeSymbolicArgsWithMap.

    try:
        # Silence console output from computeSymbolicArgsWithMap.
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            computeSymbolicArgsWithMap(total_calls_map, agg_path)
    except Exception as e:
        pass
