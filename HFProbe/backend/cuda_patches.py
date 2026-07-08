import os, sys, types, functools
from contextlib import contextmanager

# Disable Dynamo as a safeguard, even if torchao is not stubbed successfully.
os.environ.setdefault("TORCHDYNAMO_DISABLE", "1")
os.environ.setdefault("TRANSFORMERS_NO_TF", "1")

import torch
import importlib.machinery as _machinery

# ---- Idempotency guard: do not apply patches twice on repeated imports ------
if getattr(torch, "_FAKE_CUDA_PATCHED", False):
    # Patches are already installed; no further action is required.
    pass
else:
    setattr(torch, "_FAKE_CUDA_PATCHED", True)

    # ---- A) Stub torchao to prevent it from importing torch._dynamo ---------
    def _stub_pkg(name, is_package=True):
        if name in sys.modules and getattr(sys.modules[name], "__spec__", None):
            return sys.modules[name]
        mod = types.ModuleType(name)
        mod.__spec__ = _machinery.ModuleSpec(name=name, loader=None, is_package=is_package)
        if is_package:
            mod.__path__ = []
        sys.modules[name] = mod
        return mod

    def _ensure_torchao_stub():
        _stub_pkg("torchao", is_package=True)
        qa = _stub_pkg("torchao.quantization", is_package=True)
        class Int4WeightOnlyConfig:
            def __init__(self, *a, **k): pass
        qa.Int4WeightOnlyConfig = Int4WeightOnlyConfig
        _stub_pkg("torchao.kernel", is_package=True)
        _stub_pkg("torchao.kernel.bsr_triton_ops", is_package=False)

    _ensure_torchao_stub()

    # ---- B) Pretend CUDA is available so upper layers select CUDA paths -----
    torch.cuda.is_available        = lambda: True
    torch.cuda.is_initialized      = lambda: True
    torch.cuda.device_count        = lambda: 1
    torch.cuda.current_device      = lambda: 0
    torch.cuda.get_device_capability = lambda device=0: (9, 0)  # pretend Hopper
    torch.cuda.get_device_name     = lambda device=0: "Fake GPU (No-Op)"
    torch.cuda.is_bf16_supported   = lambda device=None: True

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

    class _MockProps:
        name = "Mock CUDA Device (Hopper)"
        major, minor = 9, 0
        multi_processor_count = 128
        total_memory = 80 * 1024**3
        @property
        def warpSize(self): return 32
        @property
        def sharedMemPerBlockOptin(self): return 0

    _props_cache = {}
    def _mock_get_props(device=0):
        try:
            idx = device.index if hasattr(device, "index") else int(device)
        except Exception:
            idx = 0
        if idx not in _props_cache:
            _props_cache[idx] = _MockProps()
        return _props_cache[idx]
    torch.cuda.get_device_properties = _mock_get_props

    # ---- C) Disable lazy initialization to avoid torch._C._cuda_init --------
    if hasattr(torch.cuda, "_lazy_init"):
        def _patched_lazy_init(*a, **k):
            return None
        torch.cuda._lazy_init = _patched_lazy_init

    # ---- D) Redirect .to/.cuda device transfers to CPU ----------------------
    def _is_cuda_dev(d):
        return (isinstance(d, str) and d.startswith("cuda")) or \
               (isinstance(d, torch.device) and getattr(d, "type", "") == "cuda")

    _orig_tensor_to = torch.Tensor.to
    def _tensor_to_cpu(self, *args, **kwargs):
        if str(self.device) == "meta":
            return self
        dev = kwargs.get("device", args[0] if (args and isinstance(args[0], (str, torch.device, int))) else None)
        if dev is not None:
            if args and isinstance(args[0], (str, torch.device, int)):
                args = ("cpu",) + args[1:]
            else:
                kwargs["device"] = "cpu"
        return _orig_tensor_to(self, *args, **kwargs)

    _orig_module_to = torch.nn.Module.to
    def _module_to_cpu(self, *args, **kwargs):
        dev = kwargs.get("device", args[0] if (args and isinstance(args[0], (str, torch.device))) else None)
        if _is_cuda_dev(dev):
            if args and isinstance(args[0], (str, torch.device)):
                args = ("cpu",) + args[1:]
            else:
                kwargs["device"] = "cpu"
        return _orig_module_to(self, *args, **kwargs)
    torch.Tensor.to       = _tensor_to_cpu
    torch.nn.Module.to    = _module_to_cpu
    torch.Tensor.cuda     = lambda self, *a, **k: _orig_tensor_to(self, "cpu")
    torch.nn.Module.cuda  = lambda self, *a, **k: _orig_module_to(self, "cpu")

    # ---- E) Sanitize factory calls by replacing device='cuda' with 'cpu' ----
    def _sanitize_device_kw(func):
        @functools.wraps(func)
        def wrap(*args, **kwargs):
            dev = kwargs.get("device", None)
            if _is_cuda_dev(dev):
                kwargs["device"] = "cpu"
            return func(*args, **kwargs)
        return wrap

    for _name in (
        "empty","zeros","ones","full","arange","linspace","logspace",
        "rand","randn","randint","tensor","as_tensor",
        "empty_like","zeros_like","ones_like","full_like","rand_like","randn_like"
    ):
        if hasattr(torch, _name):
            setattr(torch, _name, _sanitize_device_kw(getattr(torch, _name)))

    # ---- F) Stub common CUDA APIs with independent no-op functions ----------
    def _make_noop():
        def _f(*a, **k): return None
        return _f
    def _make_zero():
        def _f(*a, **k): return 0
        return _f
    def _make_meminfo():
        def _f(*a, **k): return (16 * 1024**3, 16 * 1024**3)  # (free,total)
        return _f

    for _n in ("set_device","synchronize","empty_cache","ipc_collect",
               "manual_seed","manual_seed_all","seed","seed_all"):
        if hasattr(torch.cuda, _n):
            setattr(torch.cuda, _n, _make_noop())  # Use a distinct function for each attribute.

    for _n, _factory in {
        "mem_get_info": _make_meminfo,
        "memory_allocated": _make_zero, "max_memory_allocated": _make_zero,
        "memory_reserved": _make_zero,  "max_memory_reserved": _make_zero
    }.items():
        if hasattr(torch.cuda, _n):
            setattr(torch.cuda, _n, _factory())

    # Stream, event, and device contexts.
    class _Dummy:
        def __getattr__(self, name): 
            def _f(*a, **k): return None
            return _f
        def __call__(self, *a, **k): return None
    torch.cuda.Stream         = lambda *a, **k: _Dummy()
    torch.cuda.Event          = lambda *a, **k: _Dummy()
    torch.cuda.current_stream = lambda device=None: _Dummy()
    torch.cuda.default_stream = lambda device=None: _Dummy()
    @contextmanager
    def _fake_device_ctx(*a, **k): 
        yield
    torch.cuda.device = _fake_device_ctx

    # RNG state.
    torch.cuda.get_rng_state = lambda device=None: torch.tensor([], dtype=torch.uint8)
    torch.cuda.set_rng_state = lambda *a, **k: None

    # Replace AMP autocast with an empty context.
    if hasattr(torch.cuda, "amp"):
        @contextmanager
        def _fake_autocast(*a, **k): 
            yield
        torch.cuda.amp.autocast = _fake_autocast

# ---- Self-check -------------------------------------------------------------
if int(os.getenv("FAKE_CUDA_DEBUG", "1")):
    print("[FAKE-CUDA][check] is_available:", torch.cuda.is_available())
    print("[FAKE-CUDA][check] device_count:", torch.cuda.device_count())
    print("[FAKE-CUDA][check] props:", torch.cuda.get_device_properties(0).name, torch.cuda.get_device_capability(0))
    _x = torch.zeros(2, device="cuda")
    print("[FAKE-CUDA][check] tensor.device:", _x.device)
    import torch.nn as _nn
    _m = _nn.Linear(4,4).cuda()
    print("[FAKE-CUDA][check] module param device:", next(_m.parameters()).device)

print("[FAKE-CUDA] Fake CUDA shell ready.")
