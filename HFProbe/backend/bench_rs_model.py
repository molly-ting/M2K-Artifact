"""
use the following command format to run the script:
BOS_HIGHLEVEL=null BOS_BIN_HOOK=1 BOS_CE_MODE=bypass LOCAL_ONLY=1 python bench_rs_model.py
"""
import os, torch, sys, inspect
import shutil, subprocess, json
import types
from huggingface_hub import snapshot_download, list_repo_files
import io, contextlib
from utils import computeSymbolicArgsWithMap
from collections import defaultdict
import traceback

current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(current_path_string))
research_paper_dir = os.path.join(root_dir, "data", "research_paper")
default_rs_out_dir = os.path.join(root_dir, "results", "research_paper", "out")
default_rs_data_dir = os.path.join(root_dir, "results", "research_paper", "data")

tensor_calls = []
CPP_SEARCH_DIRS = []
_CPP_LOAD_SEEN = False

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
    """
    Reentrancy gate used before entering a wrapper; return False if already inside one.
    """
    if getattr(_BOS_TLS, "busy", False):
        return False
    _BOS_TLS.busy = True
    return True

def _exit_guard():
    """
    Always call this when leaving a wrapper (preferably from a try/finally block).
    """
    _BOS_TLS.busy = False

# === General utilities ===

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

torch.empty = torch.zeros

class NvccPatch:
    """
    Enter: Fake CUDA_HOME and nvcc -V output (often probed by Transformers/JIT).
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

        # Fake nvcc -V output (compatible with text=True / universal_newlines=True).
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

from collections import defaultdict

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
    
    hasTensor, argCons = collect_tensor_args(*args[0], method = method) 
    to_add = {"name": method, "args": argCons, "stack": call_stack}
    if to_add not in tensor_calls:
        tensor_calls.append(to_add)
    
cpp_mock = LoadedCppExtensionMock(_on_called)
mock_torch_utils_cpp_extension(cpp_mock)

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
                        # A placeholder would work; call the original function to minimize disruption.
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

bnb_dummy = types.ModuleType("bitsandbytes")
bnb_dummy.nn = types.ModuleType("bitsandbytes.nn")
sys.modules["bitsandbytes"] = bnb_dummy
bnb_dummy.__spec__ = importlib.machinery.ModuleSpec(name="bitsandbytes", loader=None)
bnb_dummy.nn.__spec__ = importlib.machinery.ModuleSpec(name="bitsandbytes.nn", loader=None)

def patch_binary_imports(name_patterns=(
    "bitsandbytes", "flash_attn", "xformers", "exllama", "awq", "gptq", "marlin",
    "aqlm", "hqq_aten", "hqq"
)):
    pats = tuple(name_patterns)
    def _pred(name: str) -> bool:
        return name.startswith(pats) or any(p in name for p in pats)
    if any(isinstance(f, _WrappingFinder) for f in sys.meta_path):
        return
    sys.meta_path.insert(0, _WrappingFinder(_pred))
    print("[INFO] Binary import hook installed for:", pats)

import types

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

def prepare_snapshot_and_stage_sources(model_id: str,
                                       hf_token: str | None = None,
                                       local_only: bool = False,
                                       include_weights: bool = True):
    allow_patterns = [
        "*.py", "*.json", "tokenizer.*", "vocab.*", "merges.txt", "*.model",
        "*.cpp", "*.cu", "*.h", "*.cuh",
    ]
    ignore_patterns = []
    if not include_weights:
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
    copy_config_to_modules_if_needed(local_dir)
    return local_dir


if os.getenv("BOS_FAKE_CUDA", "1") == "1":
    import cuda_patches

from torchmock.torchmocks import *
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

# === Import transformers only after all patches are enabled ===
from transformers import (
    TextStreamer,
    AutoTokenizer, AutoConfig,
    AutoModelForCausalLM
)

# === Trigger one computation (prefer generate; otherwise use a minimal forward pass) ===
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

# === Main flow ===
HF_TOKEN       = os.getenv("HF_TOKEN")
LOCAL_ONLY     = os.getenv("LOCAL_ONLY", "1") == "1"
INCLUDE_WEIGHTS= os.getenv("INCLUDE_WEIGHTS", "1") == "1"
NEW_TOKENS     = int(os.getenv("NEW_TOKENS", "2"))
BATCH_SIZE_CONFIGS = [1, 3, 5]
SEQ_LENS_CONFIGS = [1, 7, 17]

def skip(*args, **kwargs):
    # This is a helper function to save time during the initialization! 
    pass

DEV = torch.device('cuda:0') if torch.cuda.is_available() else torch.device('cpu')

fake_fht = types.ModuleType("fast_hadamard_transform")
def fake_hadamard_transform(x, scale):
    return torch.zeros_like(x)

fake_fht.hadamard_transform = fake_hadamard_transform
sys.modules["fast_hadamard_transform"] = fake_fht

def fake_script(fn=None, **_kwargs):
    # Works as both @torch.jit.script and torch.jit.script(fn)
    if fn is None:
        return lambda f: f
    return fn

torch.jit.script = fake_script


def testAqlmManual(override_configs=None, out_dir=None, data_dir=None, op_name=None):
    if not out_dir:
        out_dir = default_rs_out_dir
    os.makedirs(out_dir, exist_ok=True)

    if not data_dir:
        data_dir = default_rs_data_dir
    os.makedirs(data_dir, exist_ok=True)
    if op_name:
        out_dir = os.path.join(out_dir, "AQLM")
        os.makedirs(out_dir, exist_ok=True)
        agg_path = os.path.join(out_dir, f"{op_name}.json")

        data_dir = os.path.join(data_dir, "AQLM")
        os.makedirs(data_dir, exist_ok=True)
        rs_data_path = os.path.join(data_dir, f"{op_name}.json")
    else:
        agg_path = os.path.join(out_dir, "AQLM.json")
        rs_data_path = os.path.join(data_dir, "AQLM.json")

    # --- 1. Basic setup ---
    def skip(*args, **kwargs): pass
    torch.nn.init.kaiming_uniform_ = skip
    torch.nn.init.uniform_ = skip
    torch.nn.init.normal_ = skip

    modelId = "meta-llama/Llama-2-7b-hf"
    
    # --- 2. Import from the corrected path ---
    repo_root = os.path.join(research_paper_dir, "AQLM")
    inference_lib_path = os.path.join(repo_root, "inference_lib", "src")
    
    if inference_lib_path not in sys.path:
        sys.path.insert(0, inference_lib_path)
    
    print(f"[INFO] Importing AQLM from {inference_lib_path}")

    # --- 3. Import core classes under NvccPatch protection ---
    QuantizedLinear = None
    with NvccPatch():
        try:
            from aqlm.inference import QuantizedLinear
            print("[INFO] Successfully imported QuantizedLinear inside NvccPatch")
        except ImportError as e:
            print(f"[Error] Import failed: {e}")
            print("Trying fallback import...")
            try:
                from aqlm import QuantizedLinear
            except ImportError:
                print("[FATAL] Unable to find QuantizedLinear. Please confirm that this class is defined in inference_lib/src/aqlm/inference.py.")
                return

    # --- 4. Prepare the standard model ---
    local_dir = prepare_snapshot_and_stage_sources(
        model_id=modelId,
        hf_token=HF_TOKEN or None,
        local_only=False,
        include_weights=False
    )
    
    config = AutoConfig.from_pretrained(local_dir, trust_remote_code=True)
    if override_configs:
        if "architectures" in override_configs:
            override_configs.pop("architectures")
        
        for k in override_configs:
            if hasattr(config, k):
                try:
                    setattr(config, k, override_configs[k])
                except Exception:
                    pass
    config.use_cache = True 
    
    tokenizer = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token
    
    # Load the standard model.
    with NvccPatch():
        model = AutoModelForCausalLM.from_pretrained(
            local_dir,
            config=config,
            torch_dtype=torch.float16,
            device_map="cpu",
            low_cpu_mem_usage=True
        ).eval()

    # --- 5. Define replacement and mock-data generation logic ---
    def replace_linear_with_aqlm(module):
        for name, child in module.named_children():
            if isinstance(child, torch.nn.Linear):
                if name in ["lm_head"]: 
                    continue
                
                in_features = child.in_features
                out_features = child.out_features
                bias = child.bias is not None
                dev = child.weight.device
                dtype = child.weight.dtype 
                
                # AQLM parameters.
                nbits_per_codebook = 8
                num_codebooks = 1 
                in_group_size = 8 
                out_group_size = 1
                
                try:
                    new_layer = QuantizedLinear(
                        in_features=in_features,
                        out_features=out_features,
                        in_group_size=in_group_size,
                        out_group_size=out_group_size,
                        num_codebooks=num_codebooks,
                        nbits_per_codebook=nbits_per_codebook,
                        bias=bias,
                        device=dev,
                        dtype=dtype
                    )
                    
                    # --- Corrected data-population version ---
                    
                    # codes: Use random_() to avoid int8 range-overflow errors.
                    if hasattr(new_layer, 'codes'):
                        new_layer.codes.data.random_()
                    
                    # codebooks
                    if hasattr(new_layer, 'codebooks'):
                        new_layer.codebooks.data.normal_()
                        
                    # scales
                    if hasattr(new_layer, 'scales'):
                        new_layer.scales.data.fill_(1.0)

                    # bias
                    if bias and hasattr(new_layer, 'bias') and new_layer.bias is not None:
                         new_layer.bias.data = child.bias.data.to(dtype=new_layer.bias.dtype)
                    
                    setattr(module, name, new_layer)
                    
                except TypeError as e:
                    print(f"\n[Replacement Failed] {name}: {e}")
                    import inspect
                    print(f"  -> Expected parameters: {inspect.signature(QuantizedLinear.__init__)}")
                except Exception as e:
                    print(f"[Error] Creating AQLM layer for {name}: {e}")
            else:
                replace_linear_with_aqlm(child)

    print("Starting to replace Linear layers...")
    with NvccPatch():
        replace_linear_with_aqlm(model)
    print("Layer replacement complete.")


    # --- 6. Inference loop ---
    total_calls_map = defaultdict(dict)
    data = []

    # Reapply NvccPatch so kernel calls during forward are intercepted.
    with NvccPatch():
        for batch_size in BATCH_SIZE_CONFIGS:
            for seq_len in SEQ_LENS_CONFIGS:
                print(f"\n--- AQLM Manual Running: b={batch_size}, s={seq_len} ---")
                
                prompt_text = ("hi " * seq_len).strip()
                prompts = [prompt_text] * batch_size
                inputs = tokenizer(prompts, return_tensors="pt", padding=True)
                real_seq_len = inputs["input_ids"].shape[1]
                
                tensor_calls.clear() # Clear old logs.

                try:
                    run_once(model, tokenizer, config, prompts, new_tokens=NEW_TOKENS)

                    if not tensor_calls:
                        print("[WARN] tensor_calls is EMPTY! Check import/patching.")

                    for call in tensor_calls:
                        func_name = call.get('name', 'unknown_function')
                        argCons = call.get('args', [])
                        call_stack = call.get('stack', ())
                        run_key = (batch_size, real_seq_len)
                        total_calls_map.setdefault(func_name, {}).setdefault(call_stack, {}).setdefault(run_key, []).append(argCons)
                    
                    data.append({
                        "batch_size": batch_size, 
                        "seq_len": real_seq_len, 
                        "calls": tensor_calls.copy()
                    })
                except Exception as e:
                    print(f"[ERROR] Failed at b={batch_size}, s={seq_len}: {e}")

    # --- 7. Save and analyze ---
    print("\n--- Symbolization analysis... ---")
    
    # Save the raw time-series data.
    with open(rs_data_path, "w") as wf:
        json.dump(data, wf)

    # Prepare to capture output.
    buf = io.StringIO()

    try:
        # Suppress computeSymbolicArgsWithMap console output.
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            computeSymbolicArgsWithMap(total_calls_map, agg_path)

        print(f"\n[Success] Aggregated symbolized log has been saved to: {agg_path}")
        
        if os.path.exists(local_dir):
            shutil.rmtree(local_dir)

    except Exception as e:
        print(f"\n[Error] Failed to generate symbolized log: {e}")
        traceback.print_exc()
        if os.path.exists(local_dir):
            shutil.rmtree(local_dir)


def testMCM(override_configs=None, out_dir=None, data_dir=None, op_name=None):
    if not out_dir:
        out_dir = default_rs_out_dir
    os.makedirs(out_dir, exist_ok=True)

    if not data_dir:
        data_dir = default_rs_data_dir
    os.makedirs(data_dir, exist_ok=True)
    if op_name:
        out_dir = os.path.join(out_dir, "Mixture-Compressor-MoE")
        os.makedirs(out_dir, exist_ok=True)
        agg_path = os.path.join(out_dir, f"{op_name}.json")

        data_dir = os.path.join(data_dir, "Mixture-Compressor-MoE")
        os.makedirs(data_dir, exist_ok=True)
        rs_data_path = os.path.join(data_dir, f"{op_name}.json")
    else:
        agg_path = os.path.join(out_dir, "Mixture-Compressor-MoE.json")
        rs_data_path = os.path.join(data_dir, "Mixture-Compressor-MoE.json")

    # --- 1. Basic setup ---
    def skip(*args, **kwargs): pass
    torch.nn.init.kaiming_uniform_ = skip
    torch.nn.init.uniform_ = skip
    torch.nn.init.normal_ = skip

    modelId = "meta-llama/Llama-2-7b-hf"
    
    # --- 2. Add the repository path ---
    repo_root = os.path.join(research_paper_dir, "Mixture-Compressor-MoE")
    if repo_root not in sys.path:
        sys.path.insert(0, repo_root)
    print(f"[INFO] Importing MCM from {repo_root}")

    # [FIX] Disable torch.compile.
    if hasattr(torch, "compile"):
        def fake_compile(model=None, *args, **kwargs):
            if model is None: return lambda x: x
            return model
        torch.compile = fake_compile

    # --- 3. [Core] Mock hqq_aten to handle an unavailable backend ---
    import types
    fake_hqq_aten = types.ModuleType("hqq_aten")
    
    # Define the low-level mock C++ function.
    def mock_dequantize_kernel(W_q, scale, zero, shape, group_size, nbits, axis, packing):
        # Simulate C++ dispatch logic to select the kernel name.
        kernel_name = f"dequantize_{nbits}bit_kernel" # Default kernel.
        if nbits == 4: kernel_name = "dequantize_4bit_u8_kernel"
        elif nbits == 3: kernel_name = "dequantize_3bit_32_kernel"
        elif nbits == 2: kernel_name = "dequantize_2bit_u8_kernel"
        elif nbits == 8: kernel_name = "dequantize_8bit_u8_kernel"

        # Record the trace.
        call_stack = retrieve_stack(inspect.stack())
        hasTensor, argCons = collect_tensor_args(W_q, scale, zero, shape, group_size, nbits, axis, packing, method=kernel_name)
        
        to_add = {
            "name": f"custom_cpp::hqq::{kernel_name}", 
            "args": argCons, 
            "stack": call_stack
        }
        if to_add not in tensor_calls:
            tensor_calls.append(to_add)

        # Return dummy output.
        out_shape = list(shape)
        return torch.zeros(out_shape, dtype=scale.dtype, device=W_q.device)

    fake_hqq_aten.dequantize = mock_dequantize_kernel
    sys.modules["hqq_aten"] = fake_hqq_aten
    print("[INFO] Injected Mock hqq_aten module.")

    # --- 4. Import core classes and apply monkey patches ---
    QLinear = None
    BaseQuantizeConfig = None
    HQQBackend = None
    
    quant_dir = os.path.join(repo_root, "quant")
    if quant_dir not in sys.path:
        sys.path.insert(0, quant_dir)
        
    with NvccPatch():
        try:
            import quant.QLinear as QLinearModule
            from quant.QLinear import QLinear, BaseQuantizeConfig, HQQBackend
            
            # 1. Override the available flag.
            QLinearModule.hqq_aten = fake_hqq_aten
            QLinearModule.hqq_aten_is_available = True
            QLinear.backend = HQQBackend.ATEN 
            
            # 2. Replace QLinear.dequantize_aten directly.
            def mock_dequantize_aten_method(self):
                # Retain only the source's core logic and remove the assertion.
                W_q, meta = self.W_q, self.meta
                device = W_q.device
                
                return fake_hqq_aten.dequantize(
                    W_q,
                    meta.get("scale", torch.ones(1)), # This is a mock, so use a default when the value is unavailable.
                    meta.get("zero", torch.zeros(1)),
                    meta["shape"],
                    meta.get("group_size", -1),
                    meta["nbits"],
                    meta["axis"],
                    meta["packing"]
                )

            QLinear.dequantize_aten = mock_dequantize_aten_method
            print("[INFO] Monkey-patched QLinear.dequantize_aten to bypass axis check.")
            
        except ImportError as e:
            print(f"[FATAL] Import failed: {e}")
            return

    # --- 5. Prepare the standard model ---
    local_dir = prepare_snapshot_and_stage_sources(
        model_id=modelId,
        hf_token=HF_TOKEN or None,
        local_only=False,
        include_weights=False
    )
    config = AutoConfig.from_pretrained(local_dir, trust_remote_code=True)
    if override_configs:
        if "architectures" in override_configs:
            override_configs.pop("architectures")
        
        for k in override_configs:
            if hasattr(config, k):
                try:
                    setattr(config, k, override_configs[k])
                except Exception:
                    pass
    config.use_cache = True 
    tokenizer = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
    if tokenizer.pad_token is None: tokenizer.pad_token = tokenizer.eos_token
    
    with NvccPatch():
        model = AutoModelForCausalLM.from_pretrained(
            local_dir, config=config, torch_dtype=torch.float16, 
            device_map="cpu", low_cpu_mem_usage=True
        ).eval()

    # --- 6. Core replacement logic ---
    def replace_linear_with_mcm(module):
        for name, child in module.named_children():
            if isinstance(child, torch.nn.Linear):
                if name in ["lm_head"]: continue
                
                target_bits = 4
                target_group_size = 64
                
                try:
                    quant_config = BaseQuantizeConfig(
                        nbits=target_bits,
                        group_size=target_group_size,
                        axis=1
                    )
                    
                    new_layer = QLinear(
                        quant_config=quant_config,
                        compute_dtype=torch.float16,
                        device="cpu"
                    )
                    
                    # Initialize mock weights.
                    dummy_weight = torch.randn(
                        child.out_features, child.in_features, 
                        dtype=torch.float16, device="cpu"
                    )
                    n_scales = (child.out_features * child.in_features) // target_group_size
                    dummy_scales = torch.ones((n_scales, 1), dtype=torch.float16, device="cpu")
                    dummy_zeros = torch.zeros_like(dummy_scales)
                    
                    new_layer.replace_quantized_weight(
                        W=dummy_weight,
                        scales=dummy_scales,
                        zeros=dummy_zeros,
                        bitpack=True
                    )
                    
                    if child.bias is not None:
                        new_layer.bias = torch.nn.Parameter(child.bias.data.clone().half())
                    
                    new_layer = new_layer.to(child.weight.device)
                    new_layer.set_backend(HQQBackend.ATEN)

                    setattr(module, name, new_layer)
                    
                except Exception as e:
                    print(f"[Replacement Failed] {name}: {e}")
            else:
                replace_linear_with_mcm(child)

    print(f"Starting to replace Linear layers (MCM, bits={4})...")
    with NvccPatch():
        replace_linear_with_mcm(model)
    print("Layer replacement complete.")

    # --- 7. Inference loop ---
    total_calls_map = defaultdict(dict)
    data = []

    with NvccPatch():
        for batch_size in BATCH_SIZE_CONFIGS:
            for seq_len in SEQ_LENS_CONFIGS:
                print(f"\n--- MCM Running: b={batch_size}, s={seq_len} ---")
                
                prompt_text = ("hi " * seq_len).strip()
                prompts = [prompt_text] * batch_size
                inputs = tokenizer(prompts, return_tensors="pt", padding=True)
                real_seq_len = inputs["input_ids"].shape[1]
                
                tensor_calls.clear()

                try:
                    run_once(model, tokenizer, config, prompts, new_tokens=NEW_TOKENS)

                    if tensor_calls:
                        hqq_trace = [c['name'] for c in tensor_calls if "dequantize" in c['name']]
                        if hqq_trace:
                            print(f"[SUCCESS] Captured Kernels: {list(set(hqq_trace))}")
                        else:
                            print("[WARN] No dequantize kernels captured.")
                    else:
                        print("[WARN] tensor_calls is EMPTY.")

                    for call in tensor_calls:
                        func_name = call.get('name', 'unknown_function')
                        argCons = call.get('args', [])
                        call_stack = call.get('stack', ())
                        run_key = (batch_size, real_seq_len)
                        total_calls_map.setdefault(func_name, {}).setdefault(call_stack, {}).setdefault(run_key, []).append(argCons)
                    
                    data.append({
                        "batch_size": batch_size, 
                        "seq_len": real_seq_len, 
                        "calls": tensor_calls.copy()
                    })
                except Exception as e:
                    print(f"[ERROR] Failed at b={batch_size}, s={seq_len}: {e}")
                    traceback.print_exc()

    # --- 8. Save and analyze ---
    print("\n--- Symbolization analysis... ---")
    with open(rs_data_path, "w") as wf:
        json.dump(data, wf, indent=4)

    buf = io.StringIO()
    try:
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            computeSymbolicArgsWithMap(total_calls_map, agg_path)

        print(f"\n[Success] Aggregated symbolized log has been saved to: {agg_path}")
        shutil.rmtree(local_dir)

    except Exception as e:
        print(f"\n[Error] Failed to generate symbolized log: {e}")
        traceback.print_exc()
        shutil.rmtree(local_dir)

def testAnyPrecision(override_configs=None, out_dir=None, data_dir=None, op_name=None):
    if not out_dir:
        out_dir = default_rs_out_dir
    os.makedirs(out_dir, exist_ok=True)

    if not data_dir:
        data_dir = default_rs_data_dir
    os.makedirs(data_dir, exist_ok=True)
    if op_name:
        out_dir = os.path.join(out_dir, "any-precision-llm")
        os.makedirs(out_dir, exist_ok=True)
        agg_path = os.path.join(out_dir, f"{op_name}.json")

        data_dir = os.path.join(data_dir, "any-precision-llm")
        os.makedirs(data_dir, exist_ok=True)
        rs_data_path = os.path.join(data_dir, f"{op_name}.json")
    else:
        agg_path = os.path.join(out_dir, "any-precision-llm.json")
        rs_data_path = os.path.join(data_dir, "any-precision-llm.json")
    
    model_path = os.path.join(research_paper_dir, "any-precision-llm")
    model_id = 'meta-llama/Llama-2-7b-chat-hf'
    if model_path not in sys.path:
        sys.path.insert(0, model_path)

    # Configure the precisions to benchmark
    do_fp16 = True
    precisions = None  # Benchmark all available precisions

    # Load model and tokenizer
    local_dir = prepare_snapshot_and_stage_sources(
        model_id=model_id,
        hf_token=HF_TOKEN or None,
        local_only=False,
        include_weights=False
    )
                
    tokenizer = AutoTokenizer.from_pretrained(local_dir, trust_remote_code=True, use_fast=True)
    streamer = TextStreamer(tokenizer)
    if tokenizer.pad_token is None:
        tokenizer.pad_token = tokenizer.eos_token

    from any_precision import AnyPrecisionForCausalLM
    model = AnyPrecisionForCausalLM.from_quantized(local_dir, precisions=[4,8])
    model = model.eval().cuda()
    config = model.config
    if override_configs:
        if "architectures" in override_configs:
            override_configs.pop("architectures")
        
        for k in override_configs:
            if hasattr(config, k):
                try:
                    setattr(config, k, override_configs[k])
                except Exception:
                    pass
    model.config = config

    # Warm up CUDA cache for stable performance
    print("~~~~~~~ Warming up CUDA cache ~~~~~~~")
    input_context = "A CUDA cache warm-up is needed to"
    input_ids = tokenizer.encode(input_context, return_tensors="pt").cuda()
    output = model.generate(
        input_ids,
        precision=8,
        max_new_tokens=32,
        pad_token_id=tokenizer.eos_token_id,
        streamer=streamer,
    )
    print("~~~~~~~ Warm up complete ~~~~~~~\n")

    total_calls_map = defaultdict(dict)
    data = []

    with NvccPatch():
        for batch_size in BATCH_SIZE_CONFIGS:
            for seq_len in SEQ_LENS_CONFIGS:
                print(f"\n--- any_precision Running: b={batch_size}, s={seq_len} ---")
                
                prompt_text = ("hi " * seq_len).strip()
                prompts = [prompt_text] * batch_size
                inputs = tokenizer(prompts, return_tensors="pt")
                real_seq_len = inputs["input_ids"].shape[1]
                
                tensor_calls.clear()

                try:
                    input_ids = tokenizer.encode(prompts, return_tensors="pt").cuda()
                    model.generate(
                        input_ids,
                        precision=8,
                        max_new_tokens=32,
                        pad_token_id=tokenizer.eos_token_id,
                        streamer=streamer,
                    )
                    if not tensor_calls:
                        print("[WARN] tensor_calls is EMPTY! Check import/patching.")

                    for call in tensor_calls:
                        func_name = call.get('name', 'unknown_function')
                        argCons = call.get('args', [])
                        call_stack = call.get('stack', ())
                        run_key = (batch_size, real_seq_len)
                        total_calls_map.setdefault(func_name, {}).setdefault(call_stack, {}).setdefault(run_key, []).append(argCons)
                    
                    data.append({
                        "batch_size": batch_size, 
                        "seq_len": real_seq_len, 
                        "calls": tensor_calls.copy()
                    })
                except Exception as e:
                    print(f"[ERROR] Failed at b={batch_size}, s={seq_len}: {e}")
                    traceback.print_exc()

    # --- 8. Save and analyze ---
    print("\n--- Symbolization analysis... ---")
    with open(rs_data_path, "w") as wf:
        json.dump(data, wf, indent=4)

    buf = io.StringIO()
    try:
        with contextlib.redirect_stdout(buf), contextlib.redirect_stderr(buf):
            computeSymbolicArgsWithMap(total_calls_map, agg_path)

        print(f"\n[Success] Aggregated symbolized log has been saved to: {agg_path}")
        shutil.rmtree(local_dir)

    except Exception as e:
        print(f"\n[Error] Failed to generate symbolized log: {e}")
        traceback.print_exc()
        shutil.rmtree(local_dir)

if __name__ == "__main__":
    testAqlmManual()
    testMCM()
    testAnyPrecision()
