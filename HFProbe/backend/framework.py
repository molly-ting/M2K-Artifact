import os, json
from torchmock.torchmocks import *
import contextlib, torch, torch.nn.init as _init
from typing import Any


os.environ["VLLM_USE_V1"] = "0"
os.environ["VLLM_NO_USAGE_STATS"] = "1"
os.environ["VLLM_USE_TRITON_FLASH_ATTN"] = "0"
os.environ["VLLM_ROCM_USE_AITER_PAGED_ATTN"] = "0"
os.environ["VLLM_ROCM_USE_AITER"] = "0"
os.environ["VLLM_USE_TRITON_AWQ"] = "0"
os.environ["VLLM_ENABLE_MOE_ALIGN_BLOCK_SIZE_TRITON"] = "0"
os.environ["XDG_CONFIG_HOME"] = "./.config"
os.environ["GIT_LFS_SKIP_SMUDGE"] = "1"

import torch
from torch import Tensor
import functools
import inspect, traceback
import sys


tensor_calls = []
calls_map = {}
max_model_len = None
reduce_max_model_len = True

# ===== KV-PROBE: 只记录，不改行为 =====
import sys, time, os, threading
from contextlib import contextmanager

_BOS_PROBE_KV = (os.getenv("BOS_PROBE_KV", "0") == "1")
_BOS_PROBE_MIN_NUMEL = int(os.getenv("BOS_PROBE_KV_MIN_NUMEL", str(1_000_000)))  # 触发记录的最小元素量阈值
_tls = threading.local()

def _is_vllm_kv_file(fn: str) -> bool:
    if not fn: return False
    if "/vllm/" not in fn.replace("\\","/"): return False
    # 常见涉及 KV/缓存/注意力的模块
    keys = ("kv_cache", "kvcache", "cache_engine", "paged_attention",
            "model_executor", "layers", "attention", "cache",
            "engine", "core", "block_manager", "memory_manager")
    return any(k in fn for k in keys)

def _stack_has_vllm_kv():
    f = sys._getframe()
    while f:
        fn = (f.f_code.co_filename or "")
        if _is_vllm_kv_file(fn):
            return True
        f = f.f_back
    return False

def _numel_from_size_tuple(size):
    try:
        n = 1
        for s in size:
            s = int(s)
            if s <= 0: return 0
            n *= s
        return int(n)
    except Exception:
        return 0

class _KVProbeState:
    def __init__(self):
        self.enabled = _BOS_PROBE_KV
        self.phase = "unknown"   # "init" / "gen" 等，由上下文设置
        self.summary = {
            "py_alloc_hits": 0,        # 命中 Python 侧分配（torch.empty/zeros/...）
            "py_alloc_numel": 0,       # 统计命中元素量
            "kv_method_calls": 0,      # 命中 vLLM 的 KV 分配/缓存方法
            "kv_method_names": set(),
        }
        self.saved_funcs = {}
        self.saved_methods = {}

state__kvprobe = _KVProbeState()

def _probe_log(msg):
    ts = time.strftime("%H:%M:%S")
    print(f"[BOS][KV-PROBE][{ts}][{state__kvprobe.phase}] {msg}", flush=True)

def _wrap_alloc(fn_name, orig):
    def _inner(*args, **kwargs):
        # 解析 size，仅做记录，不改行为
        size = None
        if fn_name in ("empty_like","zeros_like"):
            t0 = args[0] if args else None
            if hasattr(t0, "size"):
                size = tuple(int(s) for s in t0.size())
        elif fn_name == "empty_strided":
            if len(args) >= 2 and hasattr(args[0], "__iter__"):
                size = tuple(int(s) for s in args[0])
        else:
            if len(args) == 1 and hasattr(args[0], "__iter__"):
                size = tuple(int(s) for s in args[0])
            elif len(args) > 1:
                size = tuple(int(a) for a in args)

        t0 = time.perf_counter()
        out = orig(*args, **kwargs)     # ← 真正的分配
        t1 = time.perf_counter()

        hit_stack = _stack_has_vllm_kv()
        numel = _numel_from_size_tuple(size) if size is not None else 0
        if hit_stack and numel >= _BOS_PROBE_MIN_NUMEL:
            state__kvprobe.summary["py_alloc_hits"] += 1
            state__kvprobe.summary["py_alloc_numel"] += numel
            if os.getenv("BOS_PROBE_KV_DEBUG","0") == "1":
                _probe_log(f"torch.{fn_name} size={size} numel={numel} kwargs={ {k:str(v) for k,v in kwargs.items() if k in ('dtype','device')} }")

        return out
    return _inner

def _patch_allocators():
    import torch
    targets = [
        ("torch", "empty"), ("torch", "empty_like"),
        ("torch", "empty_strided"),
        ("torch", "zeros"), ("torch", "zeros_like"),
        ("torch", "full"),
    ]
    for mod_name, fn_name in targets:
        mod = globals().get(mod_name)
        if not mod or not hasattr(mod, fn_name): 
            continue
        if (mod_name, fn_name) not in state__kvprobe.saved_funcs:
            state__kvprobe.saved_funcs[(mod_name, fn_name)] = getattr(mod, fn_name)
            setattr(mod, fn_name, _wrap_alloc(fn_name, state__kvprobe.saved_funcs[(mod_name, fn_name)]))

def _unpatch_allocators():
    for (mod_name, fn_name), orig in list(state__kvprobe.saved_funcs.items()):
        mod = globals().get(mod_name)
        if mod and hasattr(mod, fn_name):
            setattr(mod, fn_name, orig)
    state__kvprobe.saved_funcs.clear()

def _wrap_kv_method(obj, meth_name):
    orig = getattr(obj, meth_name)
    def _inner(*a, **k):
        state__kvprobe.summary["kv_method_calls"] += 1
        state__kvprobe.summary["kv_method_names"].add(f"{obj.__name__}.{meth_name}")
        if os.getenv("BOS_PROBE_KV_DEBUG","0") == "1":
            _probe_log(f"call {obj.__name__}.{meth_name}()")
        return orig(*a, **k)
    setattr(obj, meth_name, _inner)
    return orig

def _patch_vllm_methods():
    # 不同版本的两个常见入口：KVCache.allocate / CacheEngine._allocate_kv_cache
    try:
        from vllm.model_executor.layers.attention.kv_cache import KVCache
        if hasattr(KVCache, "allocate") and ("KVCache.allocate" not in state__kvprobe.saved_methods):
            state__kvprobe.saved_methods["KVCache.allocate"] = _wrap_kv_method(KVCache, "allocate")
    except Exception:
        pass
    try:
        from vllm.engine.cache_engine import CacheEngine
        if hasattr(CacheEngine, "_allocate_kv_cache") and ("CacheEngine._allocate_kv_cache" not in state__kvprobe.saved_methods):
            state__kvprobe.saved_methods["CacheEngine._allocate_kv_cache"] = _wrap_kv_method(CacheEngine, "_allocate_kv_cache")
    except Exception:
        pass

def _unpatch_vllm_methods():
    # 恢复成原方法
    try:
        from vllm.model_executor.layers.attention.kv_cache import KVCache
        if "KVCache.allocate" in state__kvprobe.saved_methods:
            setattr(KVCache, "allocate", state__kvprobe.saved_methods["KVCache.allocate"])
    except Exception:
        pass
    try:
        from vllm.engine.cache_engine import CacheEngine
        if "CacheEngine._allocate_kv_cache" in state__kvprobe.saved_methods:
            setattr(CacheEngine, "_allocate_kv_cache", state__kvprobe.saved_methods["CacheEngine._allocate_kv_cache"])
    except Exception:
        pass
    state__kvprobe.saved_methods.clear()

@contextmanager
def kv_probe(phase: str):
    """
    只做记录，不改返回值。
    - 统计：在 vLLM KV 调用栈里的大张量 Python 分配次数与元素量；
           以及 KV 分配相关方法（KVCache/CacheEngine）的被调次数。
    """
    if not state__kvprobe.enabled:
        yield
        return
    prev = state__kvprobe.phase
    state__kvprobe.phase = phase
    _patch_allocators()
    _patch_vllm_methods()
    try:
        yield
    finally:
        _unpatch_allocators()
        _unpatch_vllm_methods()
        state__kvprobe.phase = prev
        # 每个阶段结束都打一条小结
        _probe_log(f"SUMMARY phase={phase} py_alloc_hits={state__kvprobe.summary['py_alloc_hits']}, "
                   f"kv_methods={state__kvprobe.summary['kv_method_calls']}, "
                   f"kv_method_set={sorted(state__kvprobe.summary['kv_method_names'])}, "
                   f"py_alloc_numel={state__kvprobe.summary['py_alloc_numel']}, "
                   f"py_alloc_time_s={state__kvprobe.summary.get('py_alloc_time_s',0.0):.6f},")


# ===== Thin-KV / Fake-KV: 针对 vLLM 的 KV 缓存“薄分配” =====
import sys, inspect, math
from contextlib import contextmanager

def _stack_has_vllm_kv():
    """只在 vLLM 的 KV 分配路径里启用（避免全局影响）。"""
    f = sys._getframe()
    while f:
        fn = (f.f_code.co_filename or "")
        # 任何一个命中即可：不同版本路径略有不同
        if ("/vllm/" in fn) and (
            "kv_cache" in fn or "kvcache" in fn or "cache_engine" in fn or "paged_attention" in fn
        ):
            return True
        f = f.f_back
    return False

def _numel_of_size(size):
    n = 1
    for s in size:
        # 允许 size 是 int 或 torch.Size
        s = int(s)
        if s <= 0: 
            return 0
        n *= s
    return int(n)

class _ThinKVState:
    def __init__(self):
        self.enabled = (os.getenv("BOS_THIN_KV", "1") == "1")
        # 只在“看起来很大”的分配上启用；阈值可调（默认：>= 64MB 元素量/按 fp16 估算相当）
        self.min_numel_threshold = int(os.getenv("BOS_THIN_KV_MIN_NUMEL", str(64*1024*1024//2)))
        # 物理块“最多”保留多少个（通常 1 就够）
        self.phys_block_cap = int(os.getenv("BOS_THIN_KV_BLOCKS", "1"))
        # 跟踪是否已退回真实分配（发生写入时可能触发）
        self.fallback_triggered = False

        # 保存原始分配函数
        self.saved = {}

    def should_thin(self, size, kwargs):
        if not self.enabled or self.fallback_triggered:
            return False
        if not _stack_has_vllm_kv():
            return False
        try:
            numel = _numel_of_size(size)
        except Exception:
            return False
        return (numel >= self.min_numel_threshold)

    def make_thin_view(self, empty_fn, size, kwargs):
        """只分配极小物理块，然后 expand 成目标 shape；dtype/device 与原请求一致。"""
        # 目标 shape
        target_shape = tuple(int(s) for s in size)
        dtype  = kwargs.get("dtype", None)
        device = kwargs.get("device", None)
        # 估计“块维度”在第 0 维（常见：num_blocks, block_size, num_heads, head_dim）
        # 兼容性做法：把第 0 维缩到 phys_block_cap，其余维度保持不变。
        base_shape = list(target_shape)
        if base_shape:
            base_shape[0] = min(max(1, base_shape[0]), self.phys_block_cap)
        base = empty_fn(tuple(base_shape), **kwargs)   # 真实只分配很小
        # 注意：expand 是只读视图；大多数 in-place 写会报错（这是我们需要的“写检测”）
        thin = base.expand(target_shape)
        # 给个小标记，方便排查
        thin._bos_thin_kv = True  # noqa: attribute for debug
        return thin

state__thin_kv = _ThinKVState()

@contextmanager
def enable_thin_kv():
    """
    仅在 vLLM 的 KV 分配调用栈里做“薄分配”，其余地方完全不变。
    遇到写入需求会触发回退到真实分配（避免炸）。
    """
    if not state__thin_kv.enabled:
        yield
        return

    # 需要包裹的分配 API：empty / empty_like / zeros / zeros_like（覆盖常见分配）
    targets = [
        ("torch", "empty"), ("torch", "empty_like"),
        ("torch", "zeros"), ("torch", "zeros_like"),
    ]
    # 备份
    for mod_name, fn_name in targets:
        mod = globals().get(mod_name)
        if mod and hasattr(mod, fn_name):
            state__thin_kv.saved[(mod_name, fn_name)] = getattr(mod, fn_name)

    def _wrap_alloc(fn):
        def _inner(*args, **kwargs):
            try:
                # 解析 size：empty(*size) / empty(size_tuple)
                if len(args) == 1 and isinstance(args[0], (tuple, list, torch.Size)):
                    size = tuple(int(s) for s in args[0])
                else:
                    size = tuple(int(s) for s in args)
            except Exception:
                size = None

            # 只在 vLLM 的 KV 路径 & 超过阈值时薄分配
            if size and state__thin_kv.should_thin(size, kwargs):
                try:
                    return state__thin_kv.make_thin_view(state__thin_kv.saved[("torch","empty")], size, kwargs)
                except Exception:
                    # 如果薄分配失败，退回真实分配
                    return fn(*args, **kwargs)

            return fn(*args, **kwargs)
        return _inner

    # 安装薄分配
    for mod_name, fn_name in targets:
        mod = globals().get(mod_name)
        if mod and hasattr(mod, fn_name):
            setattr(mod, fn_name, _wrap_alloc(state__thin_kv.saved[(mod_name, fn_name)]))

    # 保护：一旦检测到对“expand 视图”的写入需求，立刻回退到真实分配
    # 这里通过拦截常见写入算子来探测（足够覆盖我们的 mock 之外的偶发路径）
    write_ops = []
    for name in ["copy_", "scatter_", "scatter_add_", "index_put_", "masked_scatter_", "fill_"]:
        if hasattr(torch.Tensor, name):
            write_ops.append(name)

    saved_writes = {}
    def _wrap_write(fn):
        def _inner(self, *a, **k):
            # 如果是我们“薄分配”的 expand 视图，切回真实分配模式
            if getattr(self, "_bos_thin_kv", False):
                state__thin_kv.fallback_triggered = True
                # 恢复所有分配函数
                for (mod_name, fn_name), orig in state__thin_kv.saved.items():
                    if mod_name == "torch":
                        setattr(globals()[mod_name], fn_name, orig)
                # 再次调用写操作（这一次会用真实分配走下去）
            return fn(self, *a, **k)
        return _inner

    for name in write_ops:
        saved_writes[name] = getattr(torch.Tensor, name)
        setattr(torch.Tensor, name, _wrap_write(saved_writes[name]))

    try:
        yield
    finally:
        # 收尾：恢复所有分配函数与写入包装
        for (mod_name, fn_name), orig in state__thin_kv.saved.items():
            if mod_name == "torch":
                setattr(globals()[mod_name], fn_name, orig)
        for name, orig in saved_writes.items():
            setattr(torch.Tensor, name, orig)
        state__thin_kv.fallback_triggered = False

@contextlib.contextmanager
def fast_dummy_init(mode: str = "empty"):
    """
    加速 DUMMY 初始化：把 nn.init.* 和 torch.*_ 避免大规模随机填充
    mode:
      - "empty": 只分配，不填充（最快）
      - "zeros": 分配后填 0（比随机快很多，稍慢于 empty）
    使用方法：
      with fast_dummy_init("empty"):
          llm = LLM(..., load_format=LoadFormat.DUMMY, ...)
    """
    saved = {}
    def _noop_ret_(fn):
        def inner(t, *a, **k):
            # 仅确保张量存在；按需填充
            if mode == "zeros":
                return t.zero_()
            return t  # "empty"：什么都不做
        return inner

    # 要劫持的初始化函数（覆盖常见路径；不存在就跳过）
    hook_names = [
        "kaiming_uniform_", "kaiming_normal_",
        "xavier_uniform_", "xavier_normal_",
        "normal_", "uniform_", "trunc_normal_",
        "orthogonal_", "constant_", "zeros_", "ones_",
    ]
    for n in hook_names:
        if hasattr(_init, n):
            saved[("init", n)] = getattr(_init, n)
            setattr(_init, n, _noop_ret_(getattr(_init, n)))

    # 还可以把 torch.Tensor 层面的随机也打掉（更稳妥）
    tensor_level = ["random_", "bernoulli_", "cauchy_", "exponential_", "log_normal_", "normal_", "uniform_"]
    for n in tensor_level:
        if hasattr(torch.Tensor, n):
            saved[("tensor", n)] = getattr(torch.Tensor, n)
            setattr(torch.Tensor, n, _noop_ret_(getattr(torch.Tensor, n)))

    try:
        yield
    finally:
        # 还原
        for (kind, n), fn in saved.items():
            if kind == "init":
                setattr(_init, n, fn)
            else:
                setattr(torch.Tensor, n, fn)

def collect_tensor_args(*args, method = None):
    argCons = []
    hasTensor = False
    for i, arg in enumerate(args):
        if isinstance(arg, Tensor):
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
            elif isinstance(arg[0], Tensor):
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
    # return hasTensor, argCons
    return True, argCons

mock()

def log_and_forward(name, func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):    
        global tensor_calls
        global calls_map
        
        # mock for vllm test
        device = kwargs.get('device', None)
        if device is not None and str(device).startswith('cuda'):
            # print(f"[patched_empty] Redirect CUDA device {device} to CPU")
            kwargs['device'] = 'cpu'   
        if kwargs.get("pin_memory", False):
            # print("[patched_tensor] disabling pin_memory due to missing CUDA")
            kwargs["pin_memory"] = False
        
        if name == "torch.max" or name == "torch.min" or name == "torch.all" or name == "torch.unique" or name == "torch.any" or name == "torch.topk" or name == "torch.zeros" or name == "torch.zeros_like" or name == "torch.cat":
            return func(*args, **kwargs)
        
        if name == "torch.empty":
            return torch.zeros(*args, **kwargs)
        
        # hasTensor, argCons = collect_tensor_args(*args, method=name)
        # if hasTensor:
        #     to_add = {"name": name, "args": argCons}
        #     if to_add not in tensor_calls:
        #         tensor_calls.append(to_add)
        #         # print(name, argCons)
        #     if name not in calls_map:
        #         calls_map[name] = []
        #     if argCons not in calls_map[name]:
        #         calls_map[name].append(argCons)
            # print(name)        
        res = func(*args, **kwargs)
        # if hasTensor:
        #     print("computation done.")
        return res
    return wrapper

def patch_all_torch_functions():
    for attr_name in dir(torch):
        attr = getattr(torch, attr_name)
        if callable(attr) and not attr_name.startswith("_"):
            # Skip classes (like torch.device)
            if inspect.isclass(attr):
                continue
            # Only patch plain functions
            wrapped = log_and_forward(f"torch.{attr_name}", attr)
            try:
                setattr(torch, attr_name, wrapped)
            except Exception:
                pass

    import torch.nn.functional as F
    for attr_name in dir(F):
        attr = getattr(F, attr_name)
        if callable(attr) and not attr_name.startswith("_"):
            if inspect.isclass(attr):
                continue
            
            # update attr to the mock version
            wrapped = log_and_forward(f"torch.nn.functional.{attr_name}", attr)
            try:
                setattr(F, attr_name, wrapped)
            except Exception:
                pass

# Call it after torch is fully loaded
patch_all_torch_functions()

_original_to = torch.Tensor.to

def patched_to(self, *args, **kwargs):
    # Determine if the 'device' argument is being used
    device = None
    if len(args) >= 1 and isinstance(args[0], (str, torch.device, int)):
        device = args[0]
    elif 'device' in kwargs:
        device = kwargs['device']

    if device is not None:
        if len(args) >= 1 and isinstance(args[0], (str, torch.device, int)):
            args = ('cpu',) + args[1:]
        else:
            kwargs['device'] = 'cpu'

    return _original_to(self, *args, **kwargs)

torch.Tensor.to = patched_to

def fake_to_cuda(self, device=None, non_blocking=False, memory_format: torch.memory_format = torch.preserve_format):
    return self

torch.Tensor.cuda = fake_to_cuda

_orig_device = torch.Tensor.device

@property
def fake_device(self):
    dev = _orig_device.__get__(self)
    if dev.type == "cpu":
        # Return cuda instead of cpu
        return torch.device("cuda:0")
    else:
        # Return actual device (including meta)
        return dev

@property
def fake_is_cuda(self):
    return True

torch.Tensor.device = fake_device
torch.Tensor.is_cuda = fake_is_cuda

from torch._subclasses import FakeTensor

# _orig_fake_to = FakeTensor.to
# def fake_to(self, *args, **kwargs):
#     return self
# FakeTensor.to = fake_to
# FakeTensor.cuda = lambda self, *args, **kwargs: self

_original_getitem = FakeTensor.__getitem__
def patched_getitem(self, key):
    if getattr(self, "device", None) == torch.device("cuda:0"):
        # Make a CPU copy and index on that to avoid CUDA execution
        cpu_tensor = self.clone().to("cpu")  # or self.data.to("cpu") if real data exists
        return _original_getitem(cpu_tensor, key)
    else:
        return _original_getitem(self, key)
FakeTensor.__getitem__ = patched_getitem

_orig_fake_device = FakeTensor.device

@property
def fake_tensor_device(self):
    dev = _orig_fake_device.__get__(self)
    if dev.type == "cpu":
        return torch.device("cuda:0")
    else:
        return dev

FakeTensor.device = fake_tensor_device

_real_Generator = torch.Generator

class PatchedGenerator:
    def __new__(cls, device='cpu', *args, **kwargs):
        # If device is fake cuda device or any cuda device string, force to CPU
        if (isinstance(device, torch.device) and device.type == "cuda") or (isinstance(device, str) and device.startswith("cuda")):
            device = torch.device("cpu")
        return _real_Generator(device=device, *args, **kwargs)

torch.Generator = PatchedGenerator


void_funcs = ["paged_attention_v1", "paged_attention_v2", "mla_decode_kvcache_cpu", "merge_attn_states", 
              "convert_vertical_slash_indexes", "convert_vertical_slash_indexes_mergehead", "rotary_embedding", "batched_rotary_embedding",
              "rms_norm", "fused_add_rms_norm", "advance_step_flashattn", "advance_step_flashinfer", "rms_norm_dynamic_per_token_quant", 
              "gptq_shuffle", "cutlass_scaled_fp4_mm", "cutlass_scaled_mm", "cutlass_scaled_mm_azp", "cutlass_scaled_sparse_mm",
              "get_cutlass_moe_mm_data", "cutlass_moe_mm", "cutlass_fp4_group_mm", "scaled_fp4_quant", "scaled_fp4_experts_quant", 
              "static_scaled_fp8_quant", "dynamic_per_token_scaled_fp8_quant", "dynamic_scaled_fp8_quant", "rearrange_kn_weight_as_n32k16_order",
              "static_scaled_int8_quant", "dynamic_scaled_int8_quant", "causal_conv1d_fwd", "causal_conv1d_update", "selective_scan_fwd", "cutlass_mla_decode", 
              "fatrelu_and_mul", "silu_and_mul", "mul_and_silu", "gelu_and_mul", "gelu_tanh_and_mul", "gelu_new", "gelu_fast", "gelu_quick", 
              "silu_and_mul_quant", "fused_add_rms_norm_static_fp8_quant", 
              # ._rocm_C
              "wvSplitKQ", "paged_attention",
              # ._moe_C
              "moe_sum", "moe_align_block_size", "sgl_moe_align_block_size", "moe_wna16_gemm", "topk_softmax",
              # ._C_cache_ops
              "reshape_and_cache", "reshape_and_cache_flash", "concat_and_cache_mla", "copy_blocks", "copy_blocks_mla", "swap_blocks", "convert_fp8", "gather_cache",
              # ._C_custom_ar
              "all_reduce", "dispose", "register_buffer", "register_graph_buffers", "free_shared_buffer"]

def forwardFunc(name, *args, **kwargs):
    if name == "get_cuda_view_from_cpu_tensor":
        return get_cuda_view_from_cpu_tensor_mock(*args, **kwargs)
    if name == "aqlm_gemm":
        return aqlm_gemm_mock(*args, **kwargs)
    if name == "awq_dequantize":
        return awq_dequantize_mock(*args, **kwargs)
    if name == "awq_gemm":
        return awq_gemm_mock(*args, **kwargs)
    if name == "gptq_gemm":
        return gptq_gemm_mock(*args, **kwargs)
    if name == "marlin_gemm":
        return marlin_gemm_mock(*args, **kwargs)
    if name == "gptq_marlin_24_gemm":
        return gptq_marlin_24_gemm_mock(*args, **kwargs)
    if name == "gptq_marlin_gemm":
        return gptq_marlin_gemm_mock(*args, **kwargs)
    if name == "marlin_qqq_gemm":
        return marlin_qqq_gemm_mock(*args, **kwargs)
    if name == "aqlm_dequant":
        return aqlm_dequant_mock(*args, **kwargs)
    if name == "machete_mm":
        return machete_mm_mock(*args, **kwargs)
    if name == "machete_prepack_B":
        return machete_prepack_B_mock(*args, **kwargs)
    if name == "allspark_w8a16_gemm":
        return allspark_w8a16_gemm_mock(*args, **kwargs)
    if name == "ggml_dequantize":
        return ggml_dequantize_mock(*args, **kwargs)
    if name == "ggml_mul_mat_vec_a8":
        return ggml_mul_mat_vec_a8_mock(*args, **kwargs)
    if name == "ggml_mul_mat_a8":
        return ggml_mul_mat_a8_mock(*args, **kwargs)
    if name == "ggml_moe_a8":
        return ggml_moe_a8_mock(*args, **kwargs)
    if name == "ggml_moe_a8_vec":
        return ggml_moe_a8_vec_mock(*args, **kwargs)
    if name == "cutlass_scaled_mm_supports_fp4":
        return cutlass_scaled_mm_supports_fp4_mock(*args, **kwargs)
    if name == "cutlass_scaled_mm_supports_fp8":
        return cutlass_scaled_mm_supports_fp8_mock(*args, **kwargs)
    if name == "cutlass_scaled_mm_supports_block_fp8":
        return cutlass_scaled_mm_supports_block_fp8_mock(*args, **kwargs)
    if name == "cutlass_sparse_scaled_mm_supported":
        return cutlass_sparse_scaled_mm_supported_mock(*args, **kwargs)
    if name == "cutlass_group_gemm_supported":
        return cutlass_group_gemm_supported_mock(*args, **kwargs)
    if name == "cutlass_sparse_compress":
        return cutlass_sparse_compress_mock(*args, **kwargs)
    if name == "gptq_marlin_repack":
        return gptq_marlin_repack_mock(*args, **kwargs)
    if name == "awq_marlin_repack":
        return awq_marlin_repack_mock(*args, **kwargs)
    if name == "machete_supported_schedules":
        return machete_supported_schedules_mock(*args, **kwargs)
    if name == "permute_cols":
        return permute_cols_mock(*args, **kwargs)
    if name == "ggml_moe_get_block_size":
        return ggml_moe_get_block_size_mock(*args, **kwargs)
    
    # torch.ops._rocm_C
    if name == "LLMM1":
        return LLMM1_mock(*args, **kwargs)
    if name == "wvSplitK":
        return wvSplitK_mock(*args, **kwargs)
    
    # torch.ops._moe_C
    if name == "moe_wna16_marlin_gemm":
        return moe_wna16_marlin_gemm_mock(*args, **kwargs)
    if name == "marlin_gemm_moe":
        return marlin_gemm_moe_mock(*args, **kwargs)
    
    # torch.ops._C_cuda_utils
    if name == "get_device_attribute":
        return get_device_attribute_mock(*args, **kwargs)
    if name == "get_max_shared_memory_per_block_device_attribute":
        return get_max_shared_memory_per_block_device_attribute_mock(*args, **kwargs)
    
    # torch.ops._C_custom_ar
    if name == "init_custom_ar":
        return init_custom_ar_mock(*args, **kwargs)
    if name == "meta_size":
        return meta_size_mock(*args, **kwargs)
    if name == "get_graph_buffer_ipc_meta":
        return get_graph_buffer_ipc_meta_mock(*args, **kwargs)
    if name == "allocate_shared_buffer_and_handle":
        return allocate_shared_buffer_and_handle_mock(*args, **kwargs)
    if name == "open_mem_handle":
        return open_mem_handle_mock(*args, **kwargs)
    
    # torch.ops._vllm_fa2_C
    if name == "varlen_fwd":
        return varlen_fwd_mock(*args, **kwargs)
    if name == "fwd_kvcache":
        return fwd_kvcache_mock(*args, **kwargs)
     # torch.ops._vllm_fa3_C
    if name == "fwd":
        return fa3_fwd_mock(*args, **kwargs)
    
    # torch.ops._flashmla_C
    if name == "get_mla_metadata":
        return get_mla_metadata_mock(*args, **kwargs)
    if name == "fwd_kvcache_mla":
        return fwd_kvcache_mla_mock(*args, **kwargs)
    
    return None

def isArgConsSame(base, to_compare):
    if len(base) != len(to_compare):
        return False

    for i in range(len(base)):
        if len(base[i]) != len(to_compare[i]):
            return False 
        
        for k in base[i]:
            if base[i][k] != to_compare[i][k]:
                return False
    return True

def retrieve_stack(stack):
    call_stack = []
    i = 0
    for frame in stack:
        if i >= 5:
            break
        # print(frame)
        if "/vllm/" in frame.filename:
            # print(i, frame.filename)
            call_stack.append((frame.filename.split("vllm/")[1], frame.lineno))
            # call_stack.append((frame.filename.split("vllm/")[1],frame.lineno,frame.function))
            i+=1
    # print("call_stack:", call_stack)
    return tuple(call_stack)


def fallback_op(name, overload_name=None):
    def wrapped(*args, **kwargs):
        global tensor_calls
        global calls_map
        global argChanged
        
        res = forwardFunc(name, *args, **kwargs)
        if name in void_funcs or res is not None:
            hasTensor, argCons = collect_tensor_args(*args, method=name)
            if hasTensor:
                callName = "vllm."+name
                to_add = {"name": callName, "args": argCons}

                # in_calls = False
                # for x in tensor_calls:
                #     if x["name"] != callName:
                #         continue
                #     to_compare_cons = x["args"]
                #     if isArgConsSame(argCons, to_compare_cons):
                #         in_calls = True
                #         break

                # if not in_calls:
                if to_add not in tensor_calls:
                    tensor_calls.append(to_add)
                    # call_stack = retrieve_stack(traceback.extract_stack())
                    call_stack = retrieve_stack(inspect.stack())

                    if callName not in calls_map:
                        calls_map[callName] = {}
                    if call_stack not in calls_map[callName]:
                        calls_map[callName][call_stack] = []
                    if argCons not in calls_map[callName][call_stack]:
                        calls_map[callName][call_stack].append(argCons)
                        argChanged = True
        return res
    return wrapped
    
class FOpWrapper:
    def __init__(self, name):
        self.name = name

    def __getattr__(self, overload_name):
        return fallback_op(self.name, overload_name)

    def __call__(self, *args, **kwargs):
        return fallback_op(self.name)(*args, **kwargs)
    
    def overloads(self):
        return ["default"]

class SafeOpsNamespace:
    def __init__(self, original_ns):
        self._original = original_ns

    def __getattr__(self, name):
        try:
            if hasattr(self._original, name):
                attr = getattr(self._original, name)

                # If it's callable (e.g. rotary_embedding), wrap it
                if callable(attr):
                    def wrapped_op(overload_name=None):
                        def wrapped(*args, **kwargs):  
                            global tensor_calls
                            global calls_map

                            hasTensor, argCons = collect_tensor_args(*args, method=name)         
                            if hasTensor:
                                callName = "vllm."+name
                                to_add = {"name": callName, "args": argCons}
                                if to_add not in tensor_calls:
                                    tensor_calls.append(to_add)
                                    # call_stack = retrieve_stack(traceback.extract_stack())
                                    call_stack = retrieve_stack(inspect.stack())

                                    if callName not in calls_map:
                                        calls_map[callName] = {}
                                    if call_stack not in calls_map[callName]:
                                        calls_map[callName][call_stack] = []
                                    if argCons not in calls_map[callName][call_stack]:
                                        calls_map[callName][call_stack].append(argCons)
                        
                            # if "paged_attention" in name:
                            #     print(name, argCons)
                            if name in void_funcs:
                                # print("void", name)
                                return None
                            
                            res = forwardFunc(name, *args, **kwargs)
                            if res is not None:
                                return res
                            return attr(*args, **kwargs)
                        return wrapped
                        
                    class OpWrapper:
                        def __getattr__(self, overload_name):
                            return wrapped_op(overload_name)

                        def __call__(self, *args, **kwargs):
                            return wrapped_op()(*args, **kwargs)
                        
                        def overloads(self):
                            return ["default"]

                    return OpWrapper()
            else:
                return FOpWrapper(name)

        # except RuntimeError as e:
        #     # Only intercept if the op is truly missing
        #     if "does not exist" in str(e):
        #         def dummy_op(*args, **kwargs):
        #             print(f"[DummyOp] torch.ops._C.{name} called (MISSING)")
        #             return torch.empty(0)
        #         return dummy_op
        #     raise
        except AttributeError as e:
            # print(e)
            return FOpWrapper(name)

    def __dir__(self):
        return dir(self._original)

    def __iter__(self):
        return iter(self._original)

    def __contains__(self, item):
        return item in self._original

    def __repr__(self):
        return repr(self._original)

# Patch before importing vllm or any other libs
torch.ops._C = SafeOpsNamespace(torch.ops._C)
torch.ops._rocm_C = SafeOpsNamespace(torch.ops._rocm_C)
torch.ops._moe_C = SafeOpsNamespace(torch.ops._moe_C)
torch.ops._C_cache_ops = SafeOpsNamespace(torch.ops._C_cache_ops)
torch.ops._C_cuda_utils = SafeOpsNamespace(torch.ops._C_cuda_utils)
torch.ops._C_custom_ar = SafeOpsNamespace(torch.ops._C_custom_ar)
torch.ops._vllm_fa2_C = SafeOpsNamespace(torch.ops._vllm_fa2_C)
torch.ops._vllm_fa3_C = SafeOpsNamespace(torch.ops._vllm_fa3_C)
torch.ops._flashmla_C = SafeOpsNamespace(torch.ops._flashmla_C)


def fake_memory_efficient_attention_forward(q, k, v, *args, **kwargs):
    # q shape: [batch, seqlen_q, nheads, head_dim] or [total, nheads, head_dim]
    # v shape used for type/device info
    out = torch.zeros_like(q)
    return out

def fake_memory_efficient_attention(q, k, v, *args, **kwargs):
    """
    :parameter query: Tensor of shape ``[B, Mq, H, K]``
    :parameter key: Tensor of shape ``[B, Mkv, H, K]``
    :parameter value: Tensor of shape ``[B, Mkv, H, Kv]``
    :return: multi-head attention Tensor with shape ``[B, Mq, H, Kv]``
    """
    B, Mq, H, K = q.shape
    B, Mkv, H, Kv = v.shape
    out = torch.zeros((B, Mq, H, Kv), dtype=q.dtype, device=q.device)
    return out

import xformers.ops as xops
xops.memory_efficient_attention_forward = fake_memory_efficient_attention_forward
xops.memory_efficient_attention = fake_memory_efficient_attention

from vllm_kernel_mock import *


# import torch._higher_order_ops.auto_functionalize as fha
# fha.can_auto_functionalize = lambda op: True


import torch.library
_orig_register_fake = torch.library.Library._register_fake

def patched_register_fake(self, op_name, fn, _stacklevel=1):
    try:
        return _orig_register_fake(self, op_name, fn, _stacklevel=1)
    except RuntimeError as e:
        if "does not exist" in str(e):
            # print(f"[patch] Skipping fake registration: {op_name}")
            return  # skip registration

def reset_peak_memory_stats_fake(device= None) -> None:
    return None

def _get_device_index_fake(
    device: Any, optional: bool = False, allow_cpu: bool = False
) -> int:
    return 0
    
torch.library.Library._register_fake = patched_register_fake
torch.cuda.set_device = lambda device: print(f"[mock] set_device({device})")
torch.cuda.current_device = lambda: 0
# torch.cuda.get_device_capability = lambda device=0: (8, 0)
# torch.cuda.get_device_capability = lambda device=0: (8, 9)
torch.cuda.get_device_capability = lambda device=0: (9, 0)
torch._C._cuda_resetPeakMemoryStats = lambda device: None
torch.cuda.reset_peak_memory_stats = reset_peak_memory_stats_fake
torch.cuda._utils._get_device_index = _get_device_index_fake
torch.utils._get_device_index = _get_device_index_fake
# Patch torch.cuda.mem_get_info to return (free_memory, total_memory) in bytes
torch.cuda.mem_get_info = lambda device=None: (256 * 1024**3, 256 * 1024**3) 
torch.cuda.is_available = lambda: True
torch.cuda.device_count = lambda: 1

class MockDeviceProperties:
    def __init__(self):
        self.multi_processor_count = 80  # a commonly used number, e.g., for an NVIDIA A100
        self.name = "NVIDIA H200"
        # self.major = 8       # major compute capability (e.g., 9 for Hopper)
        self.major = 9
        self.minor = 0       # minor compute capability
        # self.minor = 9
        self.regs_per_multiprocessor = 65536
        self.max_threads_per_multi_processor = 2048
        self.warp_size = 32
        self.gcnArchName = "gfx942"
        self.total_memory = 256 * 1024**3

torch.cuda.get_device_properties = lambda device=0: MockDeviceProperties()

def mock_create_device_prop(cls, device):
    props = MockDeviceProperties()
    return cls(
        type="cuda",
        index=0,
        multi_processor_count=props.multi_processor_count,
        cc=(props.major, props.minor),
        major=props.major,
        regs_per_multiprocessor=props.regs_per_multiprocessor,
        max_threads_per_multi_processor=props.max_threads_per_multi_processor,
        warp_size=props.warp_size,
    )

import torch._inductor.runtime.hints as hints
hints.DeviceProperties.create = classmethod(mock_create_device_prop)

def fake_get_rng_state(device=None):
    # Return a dummy CPU tensor as RNG state
    # The real CUDA RNG state is a ByteTensor with some specific size (e.g. 128 bytes)
    # So here we just mimic the shape and dtype to avoid crashes
    dummy_size = 128  # typical size of CUDA RNG state tensor
    return torch.zeros(dummy_size, dtype=torch.uint8)

torch.cuda.get_rng_state = fake_get_rng_state
torch.cuda.set_rng_state = lambda rng_state: print(f"[mock] set_rng_state.")


original_cuda_device = torch.cuda.device

class FakeCudaDevice:
    def __init__(self, index):
        self.index = index
    def __enter__(self):
        pass
    def __exit__(self, exc_type, exc_value, traceback):
        pass

torch.cuda.device = FakeCudaDevice

def dummy_synchronize():
    # print("[patch] torch.cuda.synchronize() called - skipping due to no GPU")
    return None

torch.cuda.synchronize = dummy_synchronize

class DummyStream:
    def __init__(self, device="cuda:0"):
        self.device = torch.device(device)

    def record_event(self):
        return self
    def wait_stream(self, stream):
        pass
    def synchronize(self):
        pass
    def __enter__(self): return self
    def __exit__(self, *a): pass

class DummyEvent:
    def record(self, stream=None): pass
    def synchronize(self): pass
    def elapsed_time(self, other): return 0.0

    def query(self):
        # pretend the event is always complete
        return True
    
    def wait(self):
        # no-op for CUDA event wait
        pass

torch.cuda.current_stream = lambda device=None: DummyStream()
torch.cuda.Stream = DummyStream
torch.cuda.set_stream = lambda stream: None
torch.cuda.Event = lambda *a, **kw: DummyEvent()


def fake_compile(*args, **kwargs):
    # If called as a decorator factory, return a decorator that returns the function unchanged
    def decorator(fn):
        return fn
    # If called directly with a function as first positional arg, treat as decorator directly
    if args and callable(args[0]):
        return args[0]
    return decorator

torch.compile = fake_compile


import types

fake_vllm_C = types.ModuleType("vllm._C")
sys.modules["vllm._C"] = fake_vllm_C

fake_allocator = types.SimpleNamespace(
    init_module=lambda: None,
    python_create_and_map=lambda *args, **kwargs: 0,
    python_get_device_allocator=lambda: 0,
    python_unmap_and_release=lambda *args, **kwargs: None, 
)
sys.modules["vllm.cumem_allocator"] = fake_allocator

class FakeQuantizationUtils:
    @staticmethod
    def general_compress(tensor, *args, **kwargs):
        # Return zeros with the same shape/dtype/device as input tensor
        # If input is numpy array, convert to tensor first
        if not isinstance(tensor, torch.Tensor):
            tensor = torch.as_tensor(tensor)
        return torch.zeros_like(tensor)

class FakeMatmul:
    BITBLAS_TRICK_DTYPE_MAP = {
        "float64": ("fp", 64),
        "float32": ("fp", 32),
        "float16": ("fp", 16),
        "bfloat16": ("bf", 16),
        "int32": ("int", 32),
        "uint32": ("uint", 32),
        "int16": ("int", 16),
        "uint16": ("uint", 16),
        "int8": ("int", 8),
        "uint8": ("uint", 8),
        "int4": ("int", 4),
        "uint4": ("uint", 4),
        "int2": ("int", 2),
        "uint2": ("uint", 2),
        "int1": ("int", 1),
        "uint1": ("uint", 1),
        "nf4": ("nf", 4),
        "fp4_e2m1": ("fp", 4),
        "e4m3_float8": ("fp_e4m3", 8),  # "e4m3_float8" is a trick for "float8_e4m3fn"
        "e5m2_float8": ("fp_e5m2", 8),
    }

    def __init__(
        self,
        config,
        name: str = "matmul",
        target = None,
        enable_tuning: bool = True,
        from_database: bool = False,
        backend: str = "tl",
    ):
        source_format, bit = self.BITBLAS_TRICK_DTYPE_MAP[config.W_dtype]

        self.source_format = source_format
        self.bit = bit
        self.name = name
        self.config = config
        self.target = target
        self.backend = backend
        self.torch_output_dtype = config.out_dtype
    
    def forward(self, A, W, scale=None, zeros=None, bias=None, output=None):
        if output is None:
            output = torch.zeros(
                A.shape[:-1] + (self.N,), dtype=self.torch_output_dtype, device=A.device)
        return output

    def __call__(self, *args, **kwds):
        return self.forward(*args, **kwds)
    
    def hardware_aware_finetune(self, *args, **kwargs):
        print("[FakeMatmul] hardware_aware_finetune called - no-op")
    
from dataclasses import dataclass
from typing import Optional, Tuple, Union, Literal

@dataclass(frozen=True)
class FakeMatmulConfig:
    M: Union[int, Tuple[int], None] = None
    N: Optional[int] = None
    K: Optional[int] = None
    A_dtype: str = "float16"
    W_dtype: str = "float16"  # Default same as A_dtype
    out_dtype: str = "float16"
    accum_dtype: str = "float16"
    layout: Literal["nn", "nt", "tn", "tt"] = "nt"
    with_bias: bool = False
    group_size: int = -1
    with_scaling: bool = False
    with_zeros: bool = False

    # zeros_mode documentation in comments:
    # original: target = (dequantize_weight - zero_point) * scale
    # rescale: target = dequantize_weight * scale - zero_point
    # quantized: target = (dequantize_weight - dequantize_zeros) * scale
    zeros_mode: Literal["original", "rescale", "quantized"] = "original"
    storage_dtype: str = "int8"

    # weight transform related flags
    fast_decoding: Optional[bool] = None
    propagate_a: Optional[int] = None  # Replace TransformKind with int or None
    propagate_b: Optional[int] = None  # Replace TransformKind with int or None

    # optimize strategy field
    optimize_stratety: Union[int, int] = 0  # Replace OptimizeStrategy.SingleBatchDecodeOnly with 0 or other int

class FakeGlobalOperatorCache:
    def __init__(self):
        self._dict = {}

    def size(self):
        return len(self._dict)

    def __getitem__(self, key):
        return self._dict[key]

    def __setitem__(self, key, value):
        self._dict[key] = value

    def __contains__(self, key):
        return key in self._dict

    def clear(self):
        self._dict.clear()
    
    def get(self, key, default=None):
        return self._dict.get(key, default)
    
    def add(self, key, value):
        print(f"[FakeGlobalOperatorCache] Adding key {key}")
        self._dict[key] = value

    def load_from_database(self, path, *args, **kwargs):
        print(f"[FakeGlobalOperatorCache] Pretending to load database from {path}")
        # no-op or populate dummy data if needed

    def save_into_database(self, database_path=None, target=None):
        print(f"[FakeGlobalOperatorCache] Pretending to save database into {database_path}")

fake_bitblas_module = types.ModuleType("bitblas")
fake_bitblas_module.__version__ = "0.1.0"
fake_bitblas_module.Matmul = FakeMatmul
fake_bitblas_module.auto_detect_nvidia_target = lambda: "fake_nvidia_gpu_target"

fake_cache_module = types.ModuleType("cache")
fake_cache_module.get_database_path = lambda: "/tmp/fake_bitblas_db"
fake_cache_module.global_operator_cache = FakeGlobalOperatorCache()

fake_quant_utils_module = types.ModuleType("utils")
fake_quant_utils_module.general_compress = FakeQuantizationUtils.general_compress

fake_quant_module = types.ModuleType("quantization")
fake_quant_module.utils = fake_quant_utils_module

fake_bitblas_module.cache = fake_cache_module
fake_bitblas_module.quantization = fake_quant_module
fake_bitblas_module.MatmulConfig = FakeMatmulConfig

sys.modules["bitblas"] = fake_bitblas_module
sys.modules["bitblas.cache"] = fake_cache_module
sys.modules["bitblas.quantization"] = fake_quant_module
sys.modules["bitblas.quantization.utils"] = fake_quant_utils_module

# dummy_ssd_bmm = types.ModuleType("vllm.model_executor.layers.mamba.ops.ssd_bmm")
# dummy_ssd_bmm._bmm_chunk_fwd = bmm_chunk_fwd_mock

# sys.modules["vllm.model_executor.layers.mamba.ops.ssd_bmm"] = dummy_ssd_bmm


import vllm.platforms as platforms

def current_platform_cuda_mock():
    print("mock current platform as cuda platform")
    return "vllm.platforms.cuda.CudaPlatform"

def current_platform_rocm_mock():
    print("mock current platform as rocm platform")
    return "vllm.platforms.rocm.RocmPlatform"

platforms._current_platform = None
platforms.resolve_current_platform_cls_qualname = current_platform_cuda_mock
# platforms.resolve_current_platform_cls_qualname = current_platform_rocm_mock
platform = platforms.current_platform
print(f"Forced platform: {platform.__class__.__name__}")

import vllm._custom_ops as custom_ops
custom_ops.current_platform = platform

# from vllm.platforms.interface import Platform
# Platform.has_device_capability = lambda self, cap: True

# from vllm.platforms.cuda import CudaPlatform, DeviceCapability
# CudaPlatform.get_device_capability = classmethod(lambda cls, device_id=None: DeviceCapability(8, 0))


import vllm.utils as vu

_original_direct_register = vu.direct_register_custom_op

def patched_register_custom_op(*args, **kwargs):
    kwargs["dispatch_key"] = "CPU"  # force dispatch_key
    print("[patched] direct_register_custom_op: forcing dispatch_key='CPU'")
    return _original_direct_register(*args, **kwargs)

vu.direct_register_custom_op = patched_register_custom_op


_group_name_counter: dict[str, int] = {}

def _get_unique_name(name: str) -> str:
    """Get a unique name for the group.
    Example:
    _get_unique_name("tp") -> "tp:0"
    _get_unique_name("tp") -> "tp:1"
    """
    if name not in _group_name_counter:
        _group_name_counter[name] = 0
    newname = f"{name}:{_group_name_counter[name]}"
    _group_name_counter[name] += 1
    return newname

class DummyContextManager:
    def __enter__(self):
        return self
    def __exit__(self, exc_type, exc_val, exc_tb):
        pass
    
class DummyGroup:
    def __init__( self,
        # group_ranks: list[list[int]],
        # local_rank: int,
        # torch_distributed_backend,
        # use_device_communicator: bool,
        # use_message_queue_broadcaster: bool = False,
        group_name: Optional[str] = None,):
        self.rank_in_group = 0
        self.rank = 0
        # self.world_size = 2
        self.world_size = 1
        group_name = group_name or "anonymous"
        self.unique_name = _get_unique_name(group_name)

        custom_ops.meta_size()
        self.meta_ptrs = []
        self.buffer_ptrs = []
        # This is a buffer for storing the tuples of pointers pointing to
        # IPC buffers from all ranks. Each registered tuple has size of
        # 8*world_size bytes where world_size is at most 8. Allocating 8MB
        # is enough for 131072 such tuples. The largest model I've seen only
        # needs less than 10000 of registered tuples.
        self.rank_data = torch.zeros(8 * 1024 * 1024,
                                     dtype=torch.uint8,
                                     device="cpu")
        self._ptr = custom_ops.init_custom_ar(self.meta_ptrs, self.rank_data, 0, True)
        custom_ops.register_buffer(self._ptr, self.buffer_ptrs)

    @property
    def is_first_rank(self):
        return True
    
    @property
    def is_last_rank(self):
        return True
    
    def all_reduce(self, input_):
        out = torch.zeros_like(input_)
        custom_ops.all_reduce(self._ptr, input_, out, 0, 0)
        return input_
    
    def gather(self, tensor, dst, dim=0):
        return tensor
    
    def graph_capture(self, context):
        print("[DummyGroup] Skipping graph capture")
        return DummyContextManager()
    
    def dispatch(
            self, hidden_states: torch.Tensor,
            router_logits: torch.Tensor):
        return hidden_states, router_logits
    
    def combine(self, hidden_states):
        return hidden_states
    
    def all_gather(self, tensor, dim=0):
        # world_size=1 → gather returns tensor unchanged
        return tensor

import vllm.distributed.parallel_state as ps
ps._PP = DummyGroup("pp")
ps._TP = DummyGroup("tp")
ps._DP = DummyGroup("dp")
ps._EP = DummyGroup("ep")

# _original_GraphCaptureContext = ps.GraphCaptureContext

class DummyGraphCaptureContext:
    def __init__(self, *args, **kwargs):
        # print("[patched] skipping GraphCaptureContext creation")
        self.stream = torch.cuda.current_stream() if torch.cuda.is_available() else None
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        pass

ps.GraphCaptureContext = DummyGraphCaptureContext

class DummyCUDAMemoryPool:
    def __init__(self):
        print("[patch] dummy CUDA memory pool")

dummy_pool = DummyCUDAMemoryPool()

class DummyCUDAGraph:
    def __init__(self):
        print("[patch] torch.cuda.CUDAGraph mocked")

    def capture_begin(self, *args, **kwargs):
        # print("[patch] capture_begin")
        pass

    def capture_end(self):
        pass

    def replay(self):
        pass

    def reset(self):
        pass
    
    def pool(self):
        return dummy_pool

torch.cuda.CUDAGraph = DummyCUDAGraph


class DummyTritonFunction:
    def __init__(self, fn):
        self.fn = fn
        # Add Triton-like expected attributes
        self.arg_names = getattr(fn, '__code__').co_varnames if hasattr(fn, '__code__') else ()
        self.__name__ = getattr(fn, '__name__', 'dummy_triton_fn')
    
    def __getitem__(self, grid):
        # Triton normally sets up kernel launch parameters here
        def launcher(*args, **kwargs):
            if self.__name__ == "fused_moe_kernel" or self.__name__ == "fused_moe_kernel_gptq_awq":
                return None
            return self.fn(*args, **kwargs)
        return launcher
    
    def __call__(self, *args, **kwargs):
        if self.__name__ == "fused_moe_kernel":
            return None
        return self.fn(*args, **kwargs)

def dummy_triton_jit(fn=None, *args, **kwargs):
    if fn is None:
        # Called with arguments: return decorator
        def decorator(f):
            return DummyTritonFunction(f)
        return decorator
    else:
        # Called as simple decorator
        return DummyTritonFunction(fn)

import triton
triton.jit = dummy_triton_jit

class DummyAutotuner:
    def __init__(self, fn, *args, **kwargs):
        self.fn = fn
        
    def __call__(self, *args, **kwargs):
        return self.fn(*args, **kwargs)

triton.runtime.autotuner.Autotuner = DummyAutotuner

def dummy_autotune(*args, **kwargs):
    def wrapper(fn):
        return fn
    return wrapper

# triton.runtime.autotuner.autotune = dummy_autotune
triton.autotune = dummy_autotune
# sys.modules['triton.autotune'] = dummy_autotune
# sys.modules['triton.runtime.autotuner.Autotuner'] = DummyAutotuner
# sys.modules['triton.runtime.autotuner.autotune'] = dummy_autotune

# class DummyDriver:
#     def get_benchmarker(self):
#         return None

# triton.runtime.driver.active = DummyDriver()
# triton.runtime.driver._initialize_obj = lambda self: setattr(self, "_obj", DummyDriver())
# triton.runtime.driver._create_driver = lambda: DummyDriver()


import flashinfer.jit.core as fjitcore

class DummyPlan:
    def __init__(self):
        self.default = self
    def __call__(self, *args, **kwargs):
        # print("[dummy plan called]")
        # Return a non-None object to satisfy _plan_info
        return object()

class DummyFunc:
    def __call__(self, *args, **kwargs):
        # print("[dummy] called")
        return None

def dummy_build_and_load(self, *args, **kwargs):
    # print("[patch] skipping build_and_load")
    self.plan = DummyPlan()
    self.ragged_run = DummyFunc()
    self.paged_run = DummyFunc()
    self.plan.default = self.plan
    self.ragged_run.default = self.ragged_run
    self.paged_run.default = self.paged_run
    self.block_sparse_indices_to_vector_sparse_offsets = DummyFunc()
    return self

fjitcore.JitSpec.build_and_load = dummy_build_and_load


# import importlib

# _original_import_module = importlib.import_module

# def dummy_import_module(name, package=None):
#     if "vllm.model_executor.layers.mamba.ops.ssd_bmm" in name:
#         print(f"[patch] dummy import for {name}")
#         mod = types.ModuleType(name)
#         mod._bmm_chunk_fwd = bmm_chunk_fwd_mock
#         return mod
#     return _original_import_module(name, package)

# importlib.import_module = dummy_import_module


import vllm.attention.ops.triton_unified_attention as triton_attn
triton_attn.unified_attention = lambda *args, **kwargs: None

import vllm.attention.ops.prefix_prefill as prefix_prefill
def context_attention_fwd_fake(*args, **kwargs):
    return None

prefix_prefill.context_attention_fwd = torch.inference_mode()(context_attention_fwd_fake)

import vllm.attention.ops.triton_decode_attention as triton_decode_attention
triton_decode_attention._decode_att_m_fwd = lambda *args, **kwargs: None
triton_decode_attention._decode_grouped_att_m_fwd = lambda *args, **kwargs: None
triton_decode_attention._decode_softmax_reducev_fwd = lambda *args, **kwargs: None

import vllm.attention.ops.triton_merge_attn_states as triton_merge_attn_states
triton_merge_attn_states.merge_attn_states = lambda *args, **kwargs: None

# import vllm.attention.ops.triton_flash_attention as triton_flash_attention
# triton_flash_attention.has_cdna_target = lambda: True
# triton_flash_attention.triton_attention_rocm = triton_attention_rocm_mock

import vllm.attention.ops.blocksparse_attention.blocksparse_attention_kernel as blocksparse_attention_kernel
blocksparse_attention_kernel.blocksparse_flash_attn_varlen_fwd = blocksparse_flash_attn_varlen_fwd_mock

import vllm.lora.ops.triton_ops.lora_expand_op as lora_expand_op
def _lora_expand_fake(*args, **kwargs):
    return None

lora_expand_op._lora_expand = torch.inference_mode()(_lora_expand_fake)

import vllm.lora.ops.triton_ops.lora_shrink_op as lora_shrink_op
def _lora_shrink_fake(*args, **kwargs):
    return None

lora_shrink_op._lora_shrink = torch.inference_mode()(_lora_shrink_fake)

import vllm.model_executor.layers.quantization.utils.fp8_utils as fp8_utils
fp8_utils.per_token_group_quant_fp8 = per_token_group_quant_fp8_mock
fp8_utils.w8a8_block_fp8_matmul = w8a8_block_fp8_matmul_mock

import vllm.model_executor.layers.quantization.utils.int8_utils as int8_utils
int8_utils.per_token_quant_int8 = per_token_quant_int8_mock
int8_utils.per_token_group_quant_int8 = per_token_group_quant_int8_mock
int8_utils.w8a8_block_int8_matmul = w8a8_block_int8_matmul_mock

import vllm.model_executor.layers.lightning_attn as lightning_attn
lightning_attn.lightning_attention_ = lightning_attention_mock
lightning_attn.linear_decode_forward_triton = linear_decode_forward_triton_mock

# import vllm.model_executor.layers.fused_moe.fused_moe as fused_moe
# fused_moe.invoke_fused_moe_kernel = lambda *args, **kwargs: None

# sys.modules["vllm.model_executor.layers.fused_moe.fused_moe"].invoke_fused_moe_kernel = lambda *args, **kwargs: None

import vllm.model_executor.layers.fused_moe.fused_batched_moe as fused_batched_moe
fused_batched_moe.invoke_moe_batched_triton_kernel = lambda *args, **kwargs: None

# class DummyKernel:
#     def __getitem__(self, grid):
#         def launcher(*args, **kwargs):
#             print("[DummyKernel] Skipped fused_moe_kernel launch")
#             return None
#         return launcher

# fused_moe.fused_moe_kernel = DummyKernel()

import vllm.model_executor.layers.fused_moe.moe_align_block_size as moe_align_block_size
moe_align_block_size.moe_align_block_size_triton = lambda *args, **kwargs: None

import vllm.model_executor.layers.mamba.ops.mamba_ssm as mamba_ssm
mamba_ssm.selective_state_update = selective_state_update_mock

import vllm.model_executor.layers.mamba.ops.ssd_bmm as ssd_bmm
ssd_bmm._bmm_chunk_fwd = bmm_chunk_fwd_mock

import vllm.model_executor.layers.mamba.ops.ssd_chunk_scan as ssd_chunk_scan
ssd_chunk_scan._chunk_scan_fwd = chunk_scan_fwd_mock

import vllm.model_executor.layers.mamba.ops.ssd_chunk_state as ssd_chunk_state
ssd_chunk_state._chunk_cumsum_fwd = chunk_cumsum_fwd_mock
ssd_chunk_state._chunk_state_fwd = chunk_state_fwd_mock
ssd_chunk_state.chunk_state_varlen = chunk_state_varlen_mock

import vllm.model_executor.layers.mamba.ops.ssd_state_passing as ssd_state_passing
ssd_state_passing._state_passing_fwd = state_passing_fwd_mock

import vllm.model_executor.layers.quantization.compressed_tensors.triton_scaled_mm as triton_scaled_mm
triton_scaled_mm.triton_scaled_mm = triton_scaled_mm_mock

# from vllm.model_executor.model_loader.gguf_loader import GGUFModelLoader

# _orig_get_gguf_weights_map = GGUFModelLoader._get_gguf_weights_map

# def _patched_get_gguf_weights_map(self, model_config):
#     if getattr(model_config, "hf_config", None) is not None:
#         if getattr(model_config.hf_config, "model_type", None) == "qwen2_moe":
#             model_config.hf_config.model_type = "qwen2moe"
#     return _orig_get_gguf_weights_map(self, model_config)

# GGUFModelLoader._get_gguf_weights_map = _patched_get_gguf_weights_map


import vllm.worker.worker as worker
worker.init_worker_distributed_environment = lambda *a, **k: print("[mock] skipping distributed init")

def no_op_assert_memory_footprint(self):
    print("[patch] Skipping memory footprint assert during profiling.")

worker.Worker._assert_memory_footprint_increased_during_profiling = no_op_assert_memory_footprint

def patched_raise_if_cache_size_invalid(*args, **kwargs):
    print("[patched] Skipping cache size validation.")

worker.raise_if_cache_size_invalid = patched_raise_if_cache_size_invalid

# import vllm.v1.worker.gpu_worker as gpu_worker
# gpu_worker.init_worker_distributed_environment = lambda *a, **k: print("[mock] skipping distributed init")

import contextlib
@contextlib.contextmanager
def fake_device_loading_context(module, target_device):
    # print(f"Fake loading context for device: {target_device}")
    yield  # no actual device move or CUDA calls

import vllm.model_executor.model_loader.utils as utils
utils.device_loading_context = fake_device_loading_context

# import vllm.core.scheduler as scheduler_mod

# original_can_append_slots = scheduler_mod.Scheduler._can_append_slots

# def patched_can_append_slots(self, *args, **kwargs):
#     # print("[patch] Forcing _can_append_slots to return True")
#     return True

# scheduler_mod.Scheduler._can_append_slots = patched_can_append_slots

import vllm.config.model as model_config_mod

original_get_and_verify_max_len = model_config_mod.ModelConfig.get_and_verify_max_len

def patched_get_and_verify_max_len(self, *args, **kwargs):
    global max_model_len
    global reduce_max_model_len

    verified_max_model_len = original_get_and_verify_max_len(
        self, *args, **kwargs
    )

    if max_model_len is None:
        max_model_len = verified_max_model_len
        print(f"[patch] Recorded max_model_len from ModelConfig: {max_model_len}")
        if max_model_len > 2048 and reduce_max_model_len:
            verified_max_model_len = 1024  # force max_model_len to 1024 to avoid OOM in fake CUDA mode

    return verified_max_model_len

model_config_mod.ModelConfig.get_and_verify_max_len = patched_get_and_verify_max_len

import vllm.model_executor.layers.mamba.ops.mamba_ssm as mamba_ssm

def dummy_selective_state_update(*args, **kwargs):
    x = args[1]
    return torch.zeros_like(x)

mamba_ssm.selective_state_update = dummy_selective_state_update


import vllm.model_executor.layers.quantization.modelopt as modelopt
nvfp4_orig_process_weights_after_loading = modelopt.ModelOptNvFp4FusedMoE.process_weights_after_loading

def patched_nvfp4_process_weights_after_loading(self, layer: torch.nn.Module) -> None:
    if hasattr(layer, "w13_weight_scale_2"):
        layer.w13_weight_scale_2[:, 0] = layer.w13_weight_scale_2[:, 1]
    return nvfp4_orig_process_weights_after_loading(self, layer)

modelopt.ModelOptNvFp4FusedMoE.process_weights_after_loading = patched_nvfp4_process_weights_after_loading

# import vllm.model_executor.layers.quantization.utils.marlin_utils as marlin_utils
# def check_moe_marlin_supports_layer_fake(layer, group_size):
#     return False
# marlin_utils.check_moe_marlin_supports_layer = check_moe_marlin_supports_layer_fake


import subprocess
import vllm.model_executor.models.registry as registry
_original_run_in_subprocess = registry._run_in_subprocess

def _patched_run_in_subprocess(fn):
    import tempfile, os, cloudpickle, pickle

    with tempfile.TemporaryDirectory() as tempdir:
        output_filepath = os.path.join(tempdir, "registry_output.tmp")
        input_bytes = cloudpickle.dumps((fn, output_filepath))

        # Build patched command
        cmd = registry._SUBPROCESS_COMMAND.copy()
        # inject our patch loader before "-m"
        cmd = [cmd[0], "-c", f"exec(open('/home/mvh6224/CUDA-BOSolver/pyanalyzer/framework.py').read()); import runpy; runpy._run_module_as_main('{cmd[2]}')"]

        returned = subprocess.run(cmd, input=input_bytes, capture_output=True)

        try:
            returned.check_returncode()
        except Exception as e:
            raise RuntimeError(f"Error raised in subprocess:\n{returned.stderr.decode()}") from e

        with open(output_filepath, "rb") as f:
            return pickle.load(f)

registry._run_in_subprocess = _patched_run_in_subprocess


# from vllm.model_executor.model_loader.bitsandbytes_loader import BitsAndBytesModelLoader

# def patched_prepare_weights(self, model_name_or_path: str, revision: Optional[str]):
#     return [], True

# def patched_hf_weight_iter(self, f_weights_files, use_safetensors: bool):
#     print("Patched _hf_weight_iter: using self.model to extract param names/shapes")

#     def _maybe_pool_model(module_name: str):
#         if self.is_pool_model and self.target_modules[0].startswith("model.") and not module_name.startswith("model."):
#             return "model." + module_name
#         return module_name

#     for org_name, param in self.tmp_model.named_parameters():
#         # dummy_tensor = torch.zeros(param.shape, dtype=param.dtype)
#         # with torch.no_grad():
#         #     param.data.zero_()
#         mapped_name = self.weight_mapper(org_name)
#         mapped_name = _maybe_pool_model(mapped_name)
#         yield org_name, mapped_name, param

#         # If it's a weight param, add dummy quant_state entries
#         if ".weight" in mapped_name:
#             shape = param.shape
#             dtype = param.dtype
#             device = "cpu"

#             # Regular zero tensors
#             yield org_name + ".quant_state.bitsandbytes__scales", mapped_name + ".quant_state.bitsandbytes__scales", torch.zeros(shape, dtype=dtype, device=device)
#             yield org_name + ".quant_state.bitsandbytes__zeros", mapped_name + ".quant_state.bitsandbytes__zeros", torch.zeros(shape, dtype=dtype, device=device)
#             yield org_name + ".quant_state.bitsandbytes__g_idx", mapped_name + ".quant_state.bitsandbytes__g_idx", torch.zeros(shape, dtype=dtype, device=device)

#             # JSON metadata in .nf4
#             qs_dict = {
#                 "version": 1,
#                 "type": "nf4",
#                 "params": {"dummy": True}
#             }
#             json_str = json.dumps(qs_dict)
#             byte_tensor = torch.tensor(list(json_str.encode("utf-8")), dtype=torch.uint8)
#             yield org_name + ".quant_state.bitsandbytes__nf4", mapped_name + ".quant_state.bitsandbytes__nf4", byte_tensor
    
# original_load_weights = BitsAndBytesModelLoader._load_weights
# def patched_load_weights(self, model_config, model):
#     self.tmp_model = model
#     original_load_weights(self, model_config, model)

# BitsAndBytesModelLoader._load_weights = patched_load_weights
# BitsAndBytesModelLoader._prepare_weights = patched_prepare_weights
# BitsAndBytesModelLoader._hf_weight_iter = patched_hf_weight_iter


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

# mock cpp extension load
from cpp_load import mock_torch_utils_cpp_extension, LoadedCppExtensionMock

def retrieve_stack_hf(stack):
    call_stack = []
    i = 0
    for frame in stack:
        if i >= 5:
            break
        if "/transformers" in frame.filename and "/torch/nn/" not in frame.filename:
            call_stack.append((frame.filename.split("/transformers")[1],frame.lineno))
            # call_stack.append((frame.filename.split("/transformers")[1],frame.lineno,frame.function))
            i+=1
    return tuple(call_stack)

def _on_called(method, *args, **kwargs):
    global tensor_calls
    global calls_map
    global argChanged

    # call_stack = retrieve_stack_hf(traceback.extract_stack())
    call_stack = retrieve_stack_hf(inspect.stack())
    
    hasTensor, argCons = collect_tensor_args(*args[0]) 
    to_add = {"name": method, "args": argCons, "stack": call_stack}
    if to_add not in tensor_calls:
        tensor_calls.append(to_add)

    if method not in calls_map:
        calls_map[method] = {}
    if call_stack not in calls_map[method]:
        calls_map[method][call_stack] = []
    if argCons not in calls_map[method][call_stack]:
        calls_map[method][call_stack].append(argCons)
        argChanged = True
        # print(method, argCons)
    
cpp_mock = LoadedCppExtensionMock(_on_called)
mock_torch_utils_cpp_extension(cpp_mock)