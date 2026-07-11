"""
use the following command format to run the script:
BOS_HIGHLEVEL=null BOS_BIN_HOOK=1 BOS_CE_MODE=bypass LOCAL_ONLY=1 python -m HFProbe.backend.run_graph
"""
import os, glob, torch, sys
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
models_hf_dir = os.path.join(root_dir, "data", "models_hf")
models_hf_parent = os.path.dirname(models_hf_dir)
models_hf_datasets_dir = os.path.join(models_hf_dir, "datasets")
# pytree: Prefer PyTorch's built-in implementation; fall back to simple recursion on failure.
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
    """Enter a wrapper unless this thread is already inside one."""
    if getattr(_BOS_TLS, "busy", False):
        return False
    _BOS_TLS.busy = True
    return True

def _exit_guard():
    """Call when leaving a wrapper, preferably from a try/finally block."""
    _BOS_TLS.busy = False

# === General utilities ===
def _collect_args_meta(*args, **kwargs):
    """
    Collect lightweight metadata for *args/**kwargs (shape/dtype/device/basic types).
    Returns: (has_tensor: bool, meta: dict)
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
    Enter: Fake CUDA_HOME and nvcc -V output, which Transformers/JIT often probe.
    Exit: Fully restore the environment.
    """
    def __enter__(self):
        import torch.utils.cpp_extension as ce
        self._old_env_cuda_home = os.environ.get("CUDA_HOME")
        self._old_ce_cuda_home = getattr(ce, "CUDA_HOME", None)
        self._old_check_output = subprocess.check_output

        # Fake CUDA_HOME.
        os.environ["CUDA_HOME"] = "/usr/local/cuda"
        ce.CUDA_HOME = "/usr/local/cuda"

        # Fake nvcc -V output, including text-mode compatibility.
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
import inspect

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
    """Intercept JIT extension loading and return a logging wrapper without running CUDA."""
    print("[INFO] Patching torch.utils.cpp_extension for custom kernel capture...")
    import torch.utils.cpp_extension as ce

    CPP_EXEC_ENABLED = (os.getenv("CPP_EXEC_ENABLED", "0") == "1")
    _orig_load = ce.load
    _orig_inline = getattr(ce, "load_inline", None)

    def _get_ce_mode():
        # "bypass" skips compilation; export BOS_CE_MODE=attempt to try compiling.
        return os.getenv("BOS_CE_MODE", "bypass").lower()

    def _fake_return(kernel_name, *kargs, **kkwargs):
        if kernel_name.startswith("vecquant"):
            return None
        
        if kernel_name.startswith("rspmm") and kernel_name.endswith("forward_cuda"):
            num_row, dim = kargs[-1].shape
            output = torch.zeros((num_row, dim), dtype=kargs[-1].dtype, device=kargs[-1].device)
            return output
        
        if kernel_name.startswith("rspmm") and kernel_name.endswith("backward_cuda"):
            weight_grad = torch.zeros_like(kargs[2])
            relation_grad = torch.zeros_like(kargs[3])
            input_grad = torch.zeros_like(kargs[4])
            return (weight_grad, relation_grad, input_grad)
        
        # 1) Prefer returning out/output/result/dst.
        for key in ("out", "output", "result", "dst"):
            t = kkwargs.get(key, None)
            if isinstance(t, torch.Tensor):
                return t
        # 2) Perform basic matmul shape inference.
        tins = [x for x in kargs if isinstance(x, torch.Tensor)]
        tins += [v for v in kkwargs.values() if isinstance(v, torch.Tensor)]
        twos = [t for t in tins if t.dim() == 2]
        if len(twos) >= 2 and twos[0].shape[1] == twos[1].shape[0]:
            A, B = twos[0], twos[1]
            return torch.zeros((A.shape[0], B.shape[1]), dtype=A.dtype, device="cpu")
        # 3) Fall back to zeros_like on the first tensor.
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
                        print(full)

                        if to_add not in tensor_calls:
                            tensor_calls.append(to_add)
                    
                    # Enable the logic below for real execution, which is expected to fail.
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
        # Use the original path only when compilation is explicitly requested.
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
                        # Call the original function instead of a placeholder to minimize disruption.
                        return fn(*args, **kwargs)
                    try:
                        call_stack = retrieve_stack(inspect.stack())
                        
                        hasTensor, argCons = collect_tensor_args(*args, method=qname)
                        if hasTensor:
                            to_add = {"name": f"custom_bin::{qname}", "args": argCons, "stack": call_stack}

                            if to_add not in tensor_calls:
                                tensor_calls.append(to_add)

                        # Placeholder return order: out, then zeros_like, then None.
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
        # The name must be allowlisted and the module must be a binary extension (.so/.pyd).
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

def copy_config_to_modules_if_needed(cache_dir):
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
    return module_dir

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

def prepare_snapshot_and_stage_sources(model_id: str,
                                       hf_token: str | None = None,
                                       local_only: bool = False,
                                       include_weights: bool = True):
    allow_patterns = [
        "*.py", "*.json", "tokenizer.*", "vocab.*", "merges.txt", "*.model",
        "*.cpp", "*.cu", "*.h", "*.cuh",
    ]
    ignore_patterns= []
    if not include_weights:
        allow_patterns += ["*.safetensors", "pytorch_model*.bin", "pytorch_model-*.bin"]
        ignore_patterns=["*.bin", "*.safetensors"]

    local_dir = snapshot_download(
        repo_id=model_id,
        token=hf_token or None,
        local_files_only=local_only,
        ignore_patterns=ignore_patterns
    )

    createEmptyModelBin(model_id, local_dir)
    copy_config_to_modules_if_needed(local_dir)
    return local_dir

    # CPP_SEARCH_DIRS[:] = list(dict.fromkeys([str(mods_dir1), str(mods_dir2), str(local_dir)]))

if os.getenv("BOS_FAKE_CUDA", "1") == "1":
    from . import cuda_patches

from .torchmock.torchmocks import *
mock()
if os.getenv("BOS_BIN_HOOK", "1") == "1":
    patch_binary_imports()

# === Import transformers only after all patches are enabled ===
from transformers import (
    AutoTokenizer, AutoConfig,
    AutoModelForCausalLM, AutoModelForSeq2SeqLM, AutoModel
)

# === Build the config ===
def build_config(local_dir: str):
    cfg = AutoConfig.from_pretrained(local_dir, trust_remote_code=True)
    # Enable a field only if it exists to avoid errors across repositories.
    for k in ("use_cache_kernel", "use_cache_quantization", "use_flash_attn", "rope_backend"):
        if hasattr(cfg, k):
            try:
                # These are usually bool switches; preserve non-bool values such as rope_backend.
                if isinstance(getattr(cfg, k), bool):
                    setattr(cfg, k, True)
            except Exception:
                pass
    return cfg

# === Load tokenizer and model, selecting Seq2SeqLM or CausalLM from the config ===
def load_model_and_tokenizer(local_dir: str, cfg):
    tok = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
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
BATCH_SIZE_CONFIGS = [1, 3, 7]
SEQ_LENS_CONFIGS = [9, 17, 33]

import math

import torch
from torch import distributed as dist
from torch.utils import data as torch_data
from torch_geometric.data import Data


TRANSDUCTIVE = ("WordNet18RR", "RelLinkPredDataset", "CoDExSmall", "CoDExMedium", "CoDExLarge",
                "YAGO310", "NELL995", "ConceptNet100k", "DBpedia100k", "Hetionet", "AristoV4",
                "WDsinger", "NELL23k", "FB15k237_10", "FB15k237_20", "FB15k237_50")

def all_negative(data, batch):
    pos_h_index, pos_t_index, pos_r_index = batch.t()
    r_index = pos_r_index.unsqueeze(-1).expand(-1, data.num_nodes)
    # generate all negative tails for this batch
    all_index = torch.arange(data.num_nodes, device=batch.device)
    h_index, t_index = torch.meshgrid(pos_h_index, all_index, indexing="ij")  # indexing "xy" would return transposed
    t_batch = torch.stack([h_index, t_index, r_index], dim=-1)
    # generate all negative heads for this batch
    all_index = torch.arange(data.num_nodes, device=batch.device)
    t_index, h_index = torch.meshgrid(pos_t_index, all_index, indexing="ij")
    h_batch = torch.stack([h_index, t_index, r_index], dim=-1)

    return t_batch, h_batch

import traceback

def run_ultra(model_id):
    output_dir = os.path.join(root_dir, "results", "hf-exp", "out")
    os.makedirs(output_dir, exist_ok=True)

    filename = model_id.replace('/', '_')+".json"
    agg_path = os.path.join(output_dir, filename)
    if os.path.exists(agg_path):
        return
    
    local_dir = os.path.join(models_hf_dir, model_id.replace('/', '_'))
    
    module_dir = copy_config_to_modules_if_needed(local_dir)
    if models_hf_parent not in sys.path:
        sys.path.append(models_hf_parent)
    sys.path.append(module_dir)

    total_calls_map = defaultdict(dict)
    data = []

    # Fake the nvcc/CUDA environment, load, trigger, and persist results.
    with NvccPatch():
        cfg = build_config(module_dir)
        message_funcs = ["transe", "distmult"]
        aggregate_funcs = ["sum", "mean", "max", "pna"] 
        for mf in message_funcs:
            for af in aggregate_funcs:
                cfg.relation_model_cfg["message_func"] = mf
                cfg.relation_model_cfg["aggregate_func"] = af
                cfg.entity_model_cfg["message_func"] = mf
                cfg.entity_model_cfg["aggregate_func"] = af
                try:
                    model = AutoModel.from_pretrained(
                            module_dir,
                            config=cfg,
                            trust_remote_code=True,
                        ).eval()
                except Exception as e:
                    continue
                from models_hf.mgalkin_ultra_3g.ultra import datasets
                for dName in TRANSDUCTIVE:
                    if dName == "WordNet18RR":
                        try:
                            dataset = datasets.WN18RR(models_hf_datasets_dir)
                        except Exception as e:
                            print(f"❌ Failed to instantiate WordNet18RR: {e}")
                            continue
                    elif dName == "RelLinkPredDataset":
                        try:
                            dataset = datasets.FB15k237(models_hf_datasets_dir)
                        except Exception as e:
                            print(f"❌ Failed to instantiate RelLinkPredDataset: {e}")
                            continue
                    else:
                        cls = getattr(datasets, dName, None)
                        if cls is None:
                            print(f"⚠️  Class {dName} not found in datasets.py")
                            continue

                        try:
                            dataset = cls(root=models_hf_datasets_dir)
                            print(f"✅ Created instance of {dName}")
                        except Exception as e:
                            print(f"❌ Failed to instantiate {dName}: {e}")
                            continue

                    test_data = dataset[2]
                    world_size = 1
                    rank = 0
                    batch_size = 32

                    test_triplets = torch.cat([test_data.target_edge_index, test_data.target_edge_type.unsqueeze(0)]).t()
                    sampler = torch_data.DistributedSampler(test_triplets, world_size, rank)
                    test_loader = torch_data.DataLoader(test_triplets, batch_size, sampler=sampler)

                    for batch in test_loader:
                        t_batch, h_batch = all_negative(test_data, batch)
                        t_pred = model(test_data, t_batch)
                        h_pred = model(test_data, h_batch)

                        data.append({"batch_size": batch_size, "dataset": dName, "calls": tensor_calls.copy()})
                        tensor_calls.clear()
                        break

    print("\n--- All inference runs completed. Starting symbolic analysis... ---")
    
    data_dir = os.path.join(root_dir, "results", "hf-exp", "data")
    os.makedirs(data_dir, exist_ok=True)
    with open(os.path.join(data_dir, filename), "w") as wf:
        json.dump(data, wf)

def setConfig(cfg, override_configs):
    if not override_configs:
        return
    
    if "architectures" in override_configs:
        override_configs.pop("architectures")
    
    for k in override_configs:
        if hasattr(cfg, k):
            try:
                setattr(cfg, k, override_configs[k])
            except Exception:
                pass

def run_ultra_with_config(model_id, override_configs=None, output_dir=None, op_name=None):
    if not output_dir:
        output_dir = os.path.join(root_dir, "results", "hf-exp", "out")
    os.makedirs(output_dir, exist_ok=True)

    if op_name:
        output_dir = os.path.join(output_dir, model_id.replace('/', '_'))
        os.makedirs(output_dir, exist_ok=True)
        filename = op_name + ".json"
    else:
        filename = model_id.replace('/', '_')+".json"
    agg_path = os.path.join(output_dir, filename)
    if os.path.exists(agg_path):
        return
    
    local_dir = os.path.join(models_hf_dir, model_id.replace('/', '_'))
    
    module_dir = copy_config_to_modules_if_needed(local_dir)
    if models_hf_parent not in sys.path:
        sys.path.append(models_hf_parent)
    sys.path.append(module_dir)

    total_calls_map = defaultdict(dict)
    data = []

    # Fake the nvcc/CUDA environment, load, trigger, and persist results.
    with NvccPatch():
        cfg = build_config(module_dir)
        setConfig(cfg, override_configs)
        try:
            model = AutoModel.from_pretrained(
                    module_dir,
                    config=cfg,
                    trust_remote_code=True,
                    device_map="cpu",
                ).eval()
        except Exception as e:
            return

        from models_hf.mgalkin_ultra_3g.ultra import datasets
        for dName in TRANSDUCTIVE:
            if dName == "WordNet18RR":
                try:
                    dataset = datasets.WN18RR(models_hf_datasets_dir)
                except Exception as e:
                    print(f"❌ Failed to instantiate WordNet18RR: {e}")
                    continue
            elif dName == "RelLinkPredDataset":
                try:
                    dataset = datasets.FB15k237(models_hf_datasets_dir)
                except Exception as e:
                    print(f"❌ Failed to instantiate RelLinkPredDataset: {e}")
                    continue
            else:
                cls = getattr(datasets, dName, None)
                if cls is None:
                    print(f"⚠️  Class {dName} not found in datasets.py")
                    continue

                try:
                    dataset = cls(root=models_hf_datasets_dir)
                    print(f"✅ Created instance of {dName}")
                except Exception as e:
                    print(f"❌ Failed to instantiate {dName}: {e}")
                    continue

            test_data = dataset[2]
            world_size = 1
            rank = 0
            batch_size = 32

            test_triplets = torch.cat([test_data.target_edge_index, test_data.target_edge_type.unsqueeze(0)]).t()
            sampler = torch_data.DistributedSampler(test_triplets, world_size, rank)
            test_loader = torch_data.DataLoader(test_triplets, batch_size, sampler=sampler)

            for batch in test_loader:
                try:
                    t_batch, h_batch = all_negative(test_data, batch)
                    t_pred = model(test_data, t_batch)
                    h_pred = model(test_data, h_batch)
                except:
                    continue

                data.append({"batch_size": batch_size, "dataset": dName, "calls": tensor_calls.copy()})
                tensor_calls.clear()
                break

    print("\n--- All inference runs completed. Starting symbolic analysis... ---")
    
    with open(agg_path, "w") as wf:
        json.dump(data, wf, indent=4)

def load_model_from_local_path(path):
    module_dir = copy_config_to_modules_if_needed(path)
    sys.path.append(module_dir)
    cwd = os.getcwd()
    os.chdir(module_dir)
    model = AutoModel.from_pretrained(module_dir, trust_remote_code=True)
    os.chdir(cwd)
    sys.path.pop(0)
    return model

def run_minchul(model_id):
    output_dir = os.path.join(root_dir, "results", "hf-exp", "out")
    os.makedirs(output_dir, exist_ok=True)

    filename = model_id.replace('/', '_')+".json"
    agg_path = os.path.join(output_dir, filename)
    if os.path.exists(agg_path):
        return
    
    local_dir = os.path.join(models_hf_dir, model_id.replace('/', '_'))
    
    total_calls_map = defaultdict(dict)
    data = []

    # Fake the nvcc/CUDA environment, load, trigger, and persist results.
    with NvccPatch():
        model = load_model_from_local_path(local_dir)
        
        # input is a rgb image normalized.
        from torchvision.transforms import Compose, ToTensor, Normalize
        from PIL import Image
        img_path = ""
        img = Image.open(os.path.join(root_dir, "data", "images", "1.jpg"))
        trans = Compose([ToTensor(), Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])])
        input = trans(img).unsqueeze(0)  # torch.randn(1, 3, 112, 112)
        
        # KPRPE also takes keypoints locations as input
        aligner = load_model_from_local_path(os.path.join(models_hf_dir, "minchul_cvlface_DFA_mobilenet"))
        aligned_x, orig_ldmks, aligned_ldmks, score, thetas, bbox = aligner(input)
        keypoints = orig_ldmks  # torch.randn(1, 5, 2)
        out = model(input, keypoints)

        data.append({"image": img_path, "calls": tensor_calls.copy()})

    print("\n--- All inference runs completed. Starting symbolic analysis... ---")
    
    data_dir = os.path.join(root_dir, "results", "hf-exp", "data")
    os.makedirs(data_dir, exist_ok=True)
    with open(os.path.join(data_dir, filename), "w") as wf:
        json.dump(data, wf)
