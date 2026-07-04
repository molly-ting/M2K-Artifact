"""
use the following command format to run the script:
BOS_HIGHLEVEL=null BOS_BIN_HOOK=1 BOS_CE_MODE=bypass LOCAL_ONLY=1 python run_graph.py
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
from utils import computeSymbolicArgsWithMap
from collections import defaultdict

tensor_calls = []
CPP_SEARCH_DIRS = []
_CPP_LOAD_SEEN = False
# pytree: 优先用 torch 自带实现，失败则降级为简易递归
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

# === 防重入（线程本地） ===
import threading
_BOS_TLS = threading.local()

def _enter_guard() -> bool:
    """进入包装器前的重入门槛；已在包装器内则返回 False。"""
    if getattr(_BOS_TLS, "busy", False):
        return False
    _BOS_TLS.busy = True
    return True

def _exit_guard():
    """包装器退出时务必调用（建议放 try/finally 里）。"""
    _BOS_TLS.busy = False

# === 通用工具 ===
def _collect_args_meta(*args, **kwargs):
    """
    收集 *args/**kwargs 的轻量元信息（shape/dtype/device/基础类型）。
    返回: (has_tensor: bool, meta: dict)
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
            # 其他对象：只记录类型名
            return {"type": type(x).__name__, "value": None}
        except Exception:
            return {"type": "Exception", "value": None}

    args_meta = pytree.tree_map(_brief, args)
    kwargs_meta = pytree.tree_map(_brief, kwargs)
    return has_tensor, {"args": args_meta, "kwargs": kwargs_meta}

# FILL_ZERO = True

def collect_tensor_args(*args, method = None):
    argCons = []
    hasTensor = False
    for i, arg in enumerate(args):
        if isinstance(arg, torch.Tensor):
            hasTensor = True
            tmp = {"shape": list(arg.shape), "dtype": str(arg.dtype), "type": "torch.Tensor"}
            # print(method, i, str(arg.dtype), arg.dtype in (torch.int32, torch.int64), not torch.all(arg == 0))
            if arg.dtype in (torch.int32, torch.int64, torch.int16, torch.int8):  # check integer type
                # print(arg)
                # if (arg.numel() == 1 and arg.item() == 0) or not torch.all(arg == 0):  # check not all zero
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
                        # if (item.numel() == 1 and item.item() == 0) or not torch.all(item == 0):  # check not all zero
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
                    # if (len(arg) == 1 and arg[0] == 0) or not all(x == 0 for x in arg):
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
    进入: 伪造 CUDA_HOME 与 nvcc -V 输出（Transformers/JIT 常会探测）
    退出: 完整还原环境
    """
    def __enter__(self):
        import torch.utils.cpp_extension as ce
        self._old_env_cuda_home = os.environ.get("CUDA_HOME")
        self._old_ce_cuda_home = getattr(ce, "CUDA_HOME", None)
        self._old_check_output = subprocess.check_output

        # 伪造 CUDA_HOME
        os.environ["CUDA_HOME"] = "/usr/local/cuda"
        ce.CUDA_HOME = "/usr/local/cuda"

        # 伪造 nvcc -V 输出（兼容 text=True / universal_newlines=True）
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
        # 还原 check_output
        subprocess.check_output = self._old_check_output
        # 还原 CUDA_HOME
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
from cpp_load import mock_torch_utils_cpp_extension, LoadedCppExtensionMock

def _on_called(method, *args, **kwargs):
    global tensor_calls
    global calls_map
    global argChanged

    call_stack = retrieve_stack(inspect.stack())
    
    hasTensor, argCons = collect_tensor_args(*args[0], method=method) 
    to_add = {"name": method, "args": argCons, "stack": call_stack}
    if to_add not in tensor_calls:
        tensor_calls.append(to_add)

    # if method not in calls_map:
    #     calls_map[method] = {}
    # if call_stack not in calls_map[method]:
    #     calls_map[method][call_stack] = []
    # if argCons not in calls_map[method][call_stack]:
    #     calls_map[method][call_stack].append(argCons)
    #     argChanged = True
        # print(method, argCons)
    
cpp_mock = LoadedCppExtensionMock(_on_called)
mock_torch_utils_cpp_extension(cpp_mock)

# --- 导入并应用补丁 ---
import cuda_patches 
def patch_torch_cpp_extension():
    """拦截 JIT 扩展加载，返回带日志的包装器；不执行真实 CUDA。"""
    print("[INFO] Patching torch.utils.cpp_extension for custom kernel capture...")
    import torch.utils.cpp_extension as ce

    CPP_EXEC_ENABLED = (os.getenv("CPP_EXEC_ENABLED", "0") == "1")
    _orig_load = ce.load
    _orig_inline = getattr(ce, "load_inline", None)

    def _get_ce_mode():
        # "bypass" 默认不编译；想试编译再 export BOS_CE_MODE=attempt
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
        
        # 1) 优先返回 out/output/result/dst
        for key in ("out", "output", "result", "dst"):
            t = kkwargs.get(key, None)
            if isinstance(t, torch.Tensor):
                return t
        # 2) 简单 matmul 形状推断
        tins = [x for x in kargs if isinstance(x, torch.Tensor)]
        tins += [v for v in kkwargs.values() if isinstance(v, torch.Tensor)]
        twos = [t for t in tins if t.dim() == 2]
        if len(twos) >= 2 and twos[0].shape[1] == twos[1].shape[0]:
            A, B = twos[0], twos[1]
            return torch.zeros((A.shape[0], B.shape[1]), dtype=A.dtype, device="cpu")
        # 3) 回退：zeros_like 第一个张量
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
                    # has_t, params_meta = _collect_args_meta(*kernel_args, **kernel_kwargs)
                    # tensor_calls.append({
                    #     "name": full,
                    #     "params": params_meta,
                    #     "executed": bool(CPP_EXEC_ENABLED),
                    #     "ns": "custom_cpp",
                    # })

                    call_stack = retrieve_stack(inspect.stack())
                    
                    hasTensor, argCons = collect_tensor_args(*kernel_args, method=full)
                    if hasTensor:
                        to_add = {"name": full, "args": argCons, "stack": call_stack}
                        print(full)

                        if to_add not in tensor_calls:
                            tensor_calls.append(to_add)
                    
                    # 如需真执行（会失败），放开下面逻辑
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
        # 真要尝试编译才走原逻辑
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
                        # 占位返回也可以；这里选择调用原函数以减少破坏性
                        return fn(*args, **kwargs)
                    try:
                         # has_t, meta = _collect_args_meta(*args, **kwargs)
                        # tensor_calls.append({
                        #     "name": f"custom_bin::{qname}",
                        #     "params": meta,
                        #     "executed": False,
                        #     "ns": "custom_bin",
                        # })

                        call_stack = retrieve_stack(inspect.stack())
                        
                        hasTensor, argCons = collect_tensor_args(*args, method=qname)
                        if hasTensor:
                            to_add = {"name": f"custom_bin::{qname}", "args": argCons, "stack": call_stack}

                            if to_add not in tensor_calls:
                                tensor_calls.append(to_add)

                        # 占位返回：优先 out→zeros_like→None
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
        # 名称命中白名单 + 必须是二进制扩展（.so/.pyd）
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
    # id = os.path.basename(cache_dir)
    # dir = os.path.expanduser("~/.cache/huggingface/modules/transformers_modules")
    # module_dir = "."
    module_dir = os.path.expanduser("~/.cache/huggingface/modules/transformers_modules")
    hash_number = cache_dir.split("/")[-1]
    module_dir = os.path.join(module_dir, hash_number)
    for root, dirs, files in os.walk(cache_dir):
        for file in files:
            # if file.endswith(".json") or file.endswith(".yaml"):
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
            # else:
            #     print(f"Config already exists at {dst}, skipping copy.")
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
        # allow_patterns=allow_patterns,
        ignore_patterns=ignore_patterns
    )

    createEmptyModelBin(model_id, local_dir)
    copy_config_to_modules_if_needed(local_dir)
    return local_dir

    # srcs = []
    # for ext in ("*.cpp", "*.cu", "*.h", "*.cuh"):
    #     srcs += glob.glob(os.path.join(local_dir, "**", ext), recursive=True)

    # hash_str = Path(local_dir).name  # snapshots/<hash>
    # mods_root = Path.home() / ".cache" / "huggingface" / "modules" / "transformers_modules"
    # mods_dir1 = mods_root / hash_str
    # mods_dir2 = mods_root / model_id / hash_str

    # staged_dirs = []
    # for target in (mods_dir1, mods_dir2):
    #     target.mkdir(parents=True, exist_ok=True)
    #     for s in srcs:
    #         shutil.copy(s, target / Path(s).name)
    #     staged_dirs.append(str(target))

    # CPP_SEARCH_DIRS[:] = list(dict.fromkeys([str(mods_dir1), str(mods_dir2), str(local_dir)]))

    # print(f"[STAGE] model={model_id}")
    # print(f"        snapshot : {local_dir}")
    # print(f"        sources  : {len(srcs)} files (cpp/cu/h/cuh)")
    # if srcs[:3]: print(f"        e.g.    : {srcs[:3]}")
    # print(f"        staged → : {staged_dirs}")
    # print(f"        search   : {CPP_SEARCH_DIRS}")

    # return local_dir, srcs, staged_dirs

if os.getenv("BOS_FAKE_CUDA", "1") == "1":
    import cuda_patches

# patch_torch_cpp_extension()
from torchmock.torchmocks import *
mock()
if os.getenv("BOS_BIN_HOOK", "1") == "1":
    patch_binary_imports()

# import transformers
# _real_load_pretrained_model = transformers.modeling_utils.PreTrainedModel._load_pretrained_model.__func__

# @classmethod
# def _dummy_load_pretrained_model(
#     cls,
#     model,
#     state_dict=None,
#     checkpoint_files=None,
#     pretrained_model_name_or_path=None,
#     ignore_mismatched_sizes=False,
#     sharded_metadata=None,
#     device_map=None,
#     disk_offload_folder=None,
#     offload_state_dict=None,
#     dtype=None,
#     hf_quantizer=None,
#     keep_in_fp32_regex=None,
#     device_mesh=None,
#     key_mapping=None,
#     weights_only=True,
# ):
#     if state_dict is None:
#         print("Generating dummy weights for", cls.__name__)
#         dummy_dict = {
#             name: torch.zeros_like(param, device="cpu")
#             for name, param in model.named_parameters()
#         }
#         # dummy_dict = {
#         #     key: torch.zeros_like(value, device="cpu")
#         #     for key, value in model.state_dict().items()
#         # }
#         state_dict = dummy_dict
#         checkpoint_files = []

#     return _real_load_pretrained_model(
#         cls,
#         model=model,
#         state_dict=state_dict,
#         checkpoint_files=checkpoint_files,
#         pretrained_model_name_or_path=pretrained_model_name_or_path,
#         ignore_mismatched_sizes=ignore_mismatched_sizes,
#         sharded_metadata=sharded_metadata,
#         device_map=device_map,
#         disk_offload_folder=disk_offload_folder,
#         offload_state_dict=offload_state_dict,
#         dtype=dtype,
#         hf_quantizer=hf_quantizer,
#         keep_in_fp32_regex=keep_in_fp32_regex,
#         device_mesh=device_mesh,
#         key_mapping=key_mapping,
#         weights_only=weights_only,
#     )

# transformers.modeling_utils.PreTrainedModel._load_pretrained_model = _dummy_load_pretrained_model

# === 在补丁启用完成后，再 import transformers ===
from transformers import (
    AutoTokenizer, AutoConfig,
    AutoModelForCausalLM, AutoModelForSeq2SeqLM, AutoModel
)

# === 构建 config ===
def build_config(local_dir: str):
    cfg = AutoConfig.from_pretrained(local_dir, trust_remote_code=True)
    # 只在字段存在时才打开，避免不同仓库报错
    for k in ("use_cache_kernel", "use_cache_quantization", "use_flash_attn", "rope_backend"):
        if hasattr(cfg, k):
            try:
                # 一般是 bool 开关；非 bool（如 rope_backend）保持原值
                if isinstance(getattr(cfg, k), bool):
                    setattr(cfg, k, True)
            except Exception:
                pass
    return cfg

# === 加载 tokenizer + 模型（自动判别 Seq2Seq / CausalLM；失败回退 AutoModel） ===
def load_model_and_tokenizer(local_dir: str, cfg):
    # tok = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True)
    tok = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
    is_s2s = bool(getattr(cfg, "is_encoder_decoder", False))
    ModelCls = AutoModelForSeq2SeqLM if is_s2s else AutoModelForCausalLM
    model = ModelCls.from_pretrained(
            local_dir,
            config=cfg,
            trust_remote_code=True,
            low_cpu_mem_usage=True,
            device_map="cpu",
            # torch_dtype=torch.float32,
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

# === 主流程 ===
# MODEL_ID       = os.getenv("MODEL_ID", "Qwen/Qwen-7B")
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
    output_dir = "./hfout"
    os.makedirs(output_dir, exist_ok=True)

    filename = model_id.replace('/', '_')+".json"
    agg_path = os.path.join(output_dir, filename)
    if os.path.exists(agg_path):
        return
    
    local_dir = "models_hf/"+model_id.replace('/', '_')
    
    # local_dir = prepare_snapshot_and_stage_sources(
    #     model_id=model_id,
    #     hf_token=HF_TOKEN or None,
    #     local_only=False,
    #     include_weights=True
    # )

    module_dir = copy_config_to_modules_if_needed(local_dir)
    sys.path.append(module_dir)
    # sys.path.append(local_dir)

    total_calls_map = defaultdict(dict)
    data = []

    # 伪造 nvcc/CUDA 环境 → 加载 → 触发 → 落盘
    with NvccPatch():
        cfg = build_config(module_dir)
        message_funcs = ["transe", "distmult"]
        aggregate_funcs = ["sum", "mean", "max", "pna"] 
        # aggregate_funcs = ["pna"] 
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
                            # low_cpu_mem_usage=True,
                            # device_map="cpu",
                        ).eval()
                except Exception as e:
                    traceback.print_exc()
                    continue
                # from models_hf.mgalkin_ultra_3g.modeling import UltraForKnowledgeGraphReasoning
                # model = UltraForKnowledgeGraphReasoning.from_pretrained(
                #         model_id
                #         # local_dir,
                #         # config=cfg,
                #         # trust_remote_code=True,
                #         # low_cpu_mem_usage=True,
                #         # device_map="cpu",
                #     ).eval()

                from models_hf.mgalkin_ultra_3g.ultra import datasets
                for dName in TRANSDUCTIVE:
                    if dName == "WordNet18RR":
                        try:
                            dataset = datasets.WN18RR("./models_hf/datasets/")
                        except Exception as e:
                            print(f"❌ Failed to instantiate WordNet18RR: {e}")
                            continue
                    elif dName == "RelLinkPredDataset":
                        try:
                            dataset = datasets.FB15k237("./models_hf/datasets/")
                        except Exception as e:
                            print(f"❌ Failed to instantiate RelLinkPredDataset: {e}")
                            continue
                    else:
                        cls = getattr(datasets, dName, None)
                        if cls is None:
                            print(f"⚠️  Class {dName} not found in datasets.py")
                            continue

                        try:
                            dataset = cls(root="./models_hf/datasets/")
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

                        # for call in tensor_calls:
                        #     func_name = call.get('name', 'unknown_function')
                        #     argCons = call.get('args', [])
                        #     call_stack = call.get('stack', ())
                        #     params = call.get('params', {})
                        #     argCons = _params_to_argCons(params)            
                        #     run_key = (batch_size, "CoDExSmall")
                            
                        #     if func_name not in total_calls_map:
                        #         total_calls_map[func_name] = {}
                        #     if run_key not in total_calls_map[func_name]:
                        #         total_calls_map[func_name][run_key] = []
                        #     if argCons not in total_calls_map[func_name][run_key]:
                        #         total_calls_map[func_name][run_key].append(argCons)

                            # total_calls_map.setdefault(func_name, {}).setdefault(run_key, []).append(argCons)
                        data.append({"batch_size": batch_size, "dataset": dName, "calls": tensor_calls.copy()})
                        tensor_calls.clear()
                        break

    print("\n--- 所有推理运行完毕。开始符号化分析... ---")
    
    with open("./hfdata/"+filename, "w") as wf:
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
        output_dir = "./hfout"
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
    
    local_dir = "models_hf/"+model_id.replace('/', '_')
    
    # local_dir = prepare_snapshot_and_stage_sources(
    #     model_id=model_id,
    #     hf_token=HF_TOKEN or None,
    #     local_only=False,
    #     include_weights=True
    # )

    module_dir = copy_config_to_modules_if_needed(local_dir)
    sys.path.append(module_dir)
    # sys.path.append(local_dir)

    total_calls_map = defaultdict(dict)
    data = []

    # 伪造 nvcc/CUDA 环境 → 加载 → 触发 → 落盘
    with NvccPatch():
        cfg = build_config(module_dir)
        setConfig(cfg, override_configs)
        try:
            model = AutoModel.from_pretrained(
                    module_dir,
                    config=cfg,
                    trust_remote_code=True,
                    # low_cpu_mem_usage=True,
                    device_map="cpu",
                ).eval()
        except Exception as e:
            traceback.print_exc()
            return

        from models_hf.mgalkin_ultra_3g.ultra import datasets
        for dName in TRANSDUCTIVE:
            if dName == "WordNet18RR":
                try:
                    dataset = datasets.WN18RR("./models_hf/datasets/")
                except Exception as e:
                    print(f"❌ Failed to instantiate WordNet18RR: {e}")
                    continue
            elif dName == "RelLinkPredDataset":
                try:
                    dataset = datasets.FB15k237("./models_hf/datasets/")
                except Exception as e:
                    print(f"❌ Failed to instantiate RelLinkPredDataset: {e}")
                    continue
            else:
                cls = getattr(datasets, dName, None)
                if cls is None:
                    print(f"⚠️  Class {dName} not found in datasets.py")
                    continue

                try:
                    dataset = cls(root="./models_hf/datasets/")
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
                    traceback.print_exc()
                    continue

                # for call in tensor_calls:
                #     func_name = call.get('name', 'unknown_function')
                #     argCons = call.get('args', [])
                #     call_stack = call.get('stack', ())
                #     params = call.get('params', {})
                #     argCons = _params_to_argCons(params)            
                #     run_key = (batch_size, "CoDExSmall")
                    
                #     if func_name not in total_calls_map:
                #         total_calls_map[func_name] = {}
                #     if run_key not in total_calls_map[func_name]:
                #         total_calls_map[func_name][run_key] = []
                #     if argCons not in total_calls_map[func_name][run_key]:
                #         total_calls_map[func_name][run_key].append(argCons)

                    # total_calls_map.setdefault(func_name, {}).setdefault(run_key, []).append(argCons)
                data.append({"batch_size": batch_size, "dataset": dName, "calls": tensor_calls.copy()})
                tensor_calls.clear()
                break

    print("\n--- 所有推理运行完毕。开始符号化分析... ---")
    
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
    output_dir = "./hfout"
    os.makedirs(output_dir, exist_ok=True)

    filename = model_id.replace('/', '_')+".json"
    agg_path = os.path.join(output_dir, filename)
    if os.path.exists(agg_path):
        return
    
    local_dir = "models_hf/"+model_id.replace('/', '_')
    
    # local_dir = prepare_snapshot_and_stage_sources(
    #     model_id=model_id,
    #     hf_token=HF_TOKEN or None,
    #     local_only=False,
    #     include_weights=True
    # )

    # sys.path.append(local_dir)

    total_calls_map = defaultdict(dict)
    data = []

    # 伪造 nvcc/CUDA 环境 → 加载 → 触发 → 落盘
    with NvccPatch():
        # cfg = build_config(local_dir)
        # model = AutoModel.from_pretrained(
        #         local_dir,
        #         config=cfg,
        #         trust_remote_code=True,
        #         low_cpu_mem_usage=True,
        #         # device_map="cpu",
        #     ).eval()
        model = load_model_from_local_path(local_dir)
        
        # input is a rgb image normalized.
        from torchvision.transforms import Compose, ToTensor, Normalize
        from PIL import Image
        img_path = ""
        img = Image.open('images/1.jpg')
        trans = Compose([ToTensor(), Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])])
        input = trans(img).unsqueeze(0)  # torch.randn(1, 3, 112, 112)
        
        # KPRPE also takes keypoints locations as input
        aligner = load_model_from_local_path('models_hf/minchul_cvlface_DFA_mobilenet')
        aligned_x, orig_ldmks, aligned_ldmks, score, thetas, bbox = aligner(input)
        keypoints = orig_ldmks  # torch.randn(1, 5, 2)
        out = model(input, keypoints)

        # for call in tensor_calls:
        #     func_name = call.get('name', 'unknown_function')
        #     argCons = call.get('args', [])
        #     call_stack = call.get('stack', ())
        #     # params = call.get('params', {})
        #     # argCons = _params_to_argCons(params)            
        #     run_key = img_path
            
            # if func_name not in total_calls_map:
            #     total_calls_map[func_name] = {}
            # if run_key not in total_calls_map[func_name]:
            #     total_calls_map[func_name][run_key] = []
            # if argCons not in total_calls_map[func_name][run_key]:
            #     total_calls_map[func_name][run_key].append(argCons)

            # total_calls_map.setdefault(func_name, {}).setdefault(run_key, []).append(argCons)
        data.append({"image": img_path, "calls": tensor_calls.copy()})

    print("\n--- 所有推理运行完毕。开始符号化分析... ---")
    
    with open("./hfdata/"+filename, "w") as wf:
        json.dump(data, wf)

# shutil.rmtree("/home/mvh6224/.cache/huggingface/hub/models--mgalkin--ultra_3g")
# run_ultra("mgalkin/ultra_3g")
# run_ultra("mgalkin/ultra_4g")
# run_ultra("mgalkin/ultra_50g")
# run_minchul("minchul/cvlface_adaface_vit_base_kprpe_webface4m")