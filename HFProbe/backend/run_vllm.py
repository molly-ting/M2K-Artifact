from . import framework
from .utils import *
from datetime import datetime, timezone
import json
import shutil
import resource
import sys
import traceback
import jsonpickle

from vllm import LLM, SamplingParams
from vllm.config import LoadFormat

from huggingface_hub import snapshot_download
from huggingface_hub.errors import GatedRepoError, HfHubHTTPError, RepositoryNotFoundError


current_path_string = os.path.abspath(__file__)
result_dir = os.path.join(os.path.dirname(os.path.dirname(current_path_string)), "results")

GB = 1024 ** 3
soft, hard = resource.getrlimit(resource.RLIMIT_AS)
new_soft = min(4 * GB, hard)
resource.setrlimit(resource.RLIMIT_AS, (new_soft, hard))
oom_models = []
failed_models = []
batch_size_configs = [1, 3, 5]
seq_lens_configs = [1, 7, 17]

def _handle_repository_not_found(model_id):
    print(f"Repository not found for model {model_id}.")

def _handle_repository_access_error(model_id, exc):
    response = getattr(exc, "response", None)
    status_code = getattr(response, "status_code", None)
    if status_code in (401, 403):
        print(f"No access to repository for model {model_id} (HTTP {status_code}).")

def _is_repository_access_error(exc):
    response = getattr(exc, "response", None)
    status_code = getattr(response, "status_code", None)
    return status_code in (401, 403)

def clean(modelId):
    # --- Cleanup HuggingFace cache ---
    try:
        model_cache_dir = snapshot_download(modelId, local_files_only=True, ignore_patterns=["*.bin", "*.safetensors"])
        shutil.rmtree(model_cache_dir)
        print(f"[{modelId}] Cache removed: {model_cache_dir}")
    except Exception as e:
        pass
  
def handleVLLMModel(modelId, configs={}, suffix=None, outdir=result_dir+"/vllm-out", loadDir=result_dir+"/vllm-load", dataDir=result_dir+"/vllm-data", is_op_suffix=False):
    global batch_size_configs
    global seq_lens_configs
    global failed_models, oom_models
    
    os.makedirs(outdir, exist_ok=True)
    if not is_op_suffix:
        outPath = outdir+"/"+modelId.replace('/', '_')
        if suffix:
            outPath+="_"+suffix
        outPath+=".json"
        seq_con_path = outdir+"/"+modelId.replace('/', '_')+"_seq_con.json"
    else:
        outdir = os.path.join(outdir, modelId.replace('/', '_'))
        os.makedirs(outdir, exist_ok=True)
        outPath = os.path.join(outdir, suffix+".json")
        seq_con_path = os.path.join(outdir, "seq_con.json")
        
    if os.path.exists(outPath):
        return
    
    if seq_lens_configs[0] > 1024:
        framework.reduce_max_model_len = False
    else:
        framework.reduce_max_model_len = True
        
    print("Running model", modelId, "...")
    if "max_num_seqs" not in configs:
        configs["max_num_seqs"] = 5
    if "num_gpu_blocks_override" not in configs:
        configs["num_gpu_blocks_override"] = 300
    if os.environ.get("VLLM_USE_V1", "0") != "1":
        configs["preemption_mode"] = "swap"
    if "compilation_config" not in configs:
        configs["enforce_eager"] = True
    if "enable_chunked_prefill" not in configs:
        configs["enable_chunked_prefill"] = False
    
    os.makedirs(loadDir, exist_ok=True)
    if not is_op_suffix:
        loadOutPath = loadDir+"/"+modelId.replace('/', '_')
        if suffix:
            loadOutPath+="_"+suffix
        loadOutPath+=".json"
    else:
        loadDir = os.path.join(loadDir, modelId.replace('/', '_'))
        os.makedirs(loadDir, exist_ok=True)
        loadOutPath = os.path.join(loadDir, suffix+".json")
    
    try:
        with framework.fast_dummy_init(mode=os.getenv("BOS_FAST_DUMMY_INIT", "empty")):
            with framework.kv_probe("init"):
                with framework.enable_thin_kv():
                    llm = LLM(
                        model=modelId,
                        load_format=LoadFormat.DUMMY,
                        device="cuda",
                        gpu_memory_utilization=1.0,
                        trust_remote_code=True,
                        hf_token=framework.HF_TOKEN,
                        **configs
                    )
                    if not os.path.exists(loadOutPath):
                        tmp_calls = framework.tensor_calls.copy()
                        with open(loadOutPath, "w") as wf:
                            json.dump(tmp_calls, wf)
    except GatedRepoError as e:
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        _handle_repository_access_error(modelId, e)
        failed_models.append(modelId)
        return
    except RepositoryNotFoundError as e:
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        if _is_repository_access_error(e):
            _handle_repository_access_error(modelId, e)
        else:
            _handle_repository_not_found(modelId)
        failed_models.append(modelId)
        return
    except HfHubHTTPError as e:
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        _handle_repository_access_error(modelId, e)
        failed_models.append(modelId)
        return
    except Exception as e: 
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        failed_models.append(modelId)
        return
    except MemoryError:
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        oom_models.append(modelId)
        return
    
    sampling_params = SamplingParams(
        temperature=0
    )
    tokenizer = llm.get_tokenizer()
    
    framework.tensor_calls.clear()
    framework.calls_map.clear()
    total_calls_map = {}
    
    with framework.kv_probe("gen"):
        for batch_size in batch_size_configs:
            for seq_len in seq_lens_configs:
                single_prompt = "word " * seq_len
                single_prompt = single_prompt.strip() 
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                print(f"batch_size={batch_size}, seq_len={seq_len_real} ...")
            
                with framework.enable_thin_kv():
                    with framework.torch.inference_mode():
                        out = llm.generate([single_prompt]*batch_size, sampling_params)

                for func_name in framework.calls_map:
                    if func_name not in total_calls_map:
                        total_calls_map[func_name] = {}
                    for call_stack in framework.calls_map[func_name]:
                        if call_stack not in total_calls_map[func_name]:
                            total_calls_map[func_name][call_stack] = {}
                        total_calls_map[func_name][call_stack][(batch_size, seq_len_real)] = framework.calls_map[func_name][call_stack].copy()

                framework.tensor_calls.clear()
                framework.calls_map.clear()
    
    os.makedirs(dataDir, exist_ok=True)
    if not is_op_suffix:
        dataOutPath = dataDir+"/"+modelId.replace('/', '_')
        if suffix:
            dataOutPath+="_"+suffix
        dataOutPath+=".json"
    else:
        dataDir = os.path.join(dataDir, modelId.replace('/', '_'))
        os.makedirs(dataDir, exist_ok=True)
        dataOutPath = os.path.join(dataDir, suffix+".json")
        
    with open(dataOutPath, "w") as wf:
        wf.write(jsonpickle.encode(total_calls_map, indent=2))
    
    if not os.path.exists(seq_con_path):
        if framework.max_model_len:
            with open(seq_con_path, "w") as wf:
                json.dump({"seq_len": framework.max_model_len}, wf)
            
    framework.max_model_len = None
    framework.reduce_max_model_len = True

    computeSymbolicArgsWithMap(total_calls_map, outPath)
    clean(modelId)

def testRepro(modelId, batch_size, seq_len, configs, op_name, outpath):
    if os.environ.get("VLLM_USE_V1", "0") != "1":
        configs["preemption_mode"] = "swap"
    if "compilation_config" not in configs:
        configs["enforce_eager"] = True
    if "enable_chunked_prefill" not in configs:
        configs["enable_chunked_prefill"] = False
    if "num_gpu_blocks_override" not in configs:
        configs["num_gpu_blocks_override"] = max(30, 2*batch_size*seq_len//16)
    if not "max_num_batched_tokens" in configs:
        configs["max_num_batched_tokens"] = max(batch_size*seq_len+1, 4096)

    max_token = None
    if "sampling" in configs:
        max_token = configs["sampling"]["max_tokens"]
        configs.pop("sampling")
    
    framework.reduce_max_model_len = False
        
    try:
        with framework.fast_dummy_init(mode=os.getenv("BOS_FAST_DUMMY_INIT", "empty")):
            with framework.kv_probe("init"):
                with framework.enable_thin_kv():
                    llm = LLM(
                        model=modelId,
                        load_format=LoadFormat.DUMMY,
                        device="cuda",
                        gpu_memory_utilization=1.0,
                        trust_remote_code=True,
                        hf_token=framework.HF_TOKEN,
                        **configs
                    )
    except GatedRepoError as e:
        clean(modelId)
        _handle_repository_access_error(modelId, e)
        return -1
    except RepositoryNotFoundError as e:
        clean(modelId)
        if _is_repository_access_error(e):
            _handle_repository_access_error(modelId, e)
        else:
            _handle_repository_not_found(modelId)
        return -1
    except HfHubHTTPError as e:
        clean(modelId)
        _handle_repository_access_error(modelId, e)
        return -1
    except Exception as e: 
        clean(modelId)
        return -1 
    except MemoryError:
        clean(modelId)
        return -3
    
    if max_token:
        sampling_params = SamplingParams(
            temperature=0,
            max_tokens = max_token
        )
    else:
        sampling_params = SamplingParams(
            temperature=0
        )
    tokenizer = llm.get_tokenizer()
    
    framework.tensor_calls.clear()
    framework.calls_map.clear()
    total_calls_map = {}
    
    with framework.kv_probe("gen"):
        single_prompt = "word " * seq_len
        single_prompt = single_prompt.strip() 
        tokens = tokenizer(single_prompt)["input_ids"]
        seq_len_real = len(tokens)
        if seq_len_real != seq_len:
            max_retry_times = 5
            retry_count = 0
            seq_len_tmp = seq_len
            while seq_len_real > seq_len:
                seq_len_tmp -= 1
                single_prompt = "word" * seq_len_tmp
                single_prompt = single_prompt.strip()
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                retry_count += 1
                if retry_count >= max_retry_times:
                    break
            
            retry_count = 0
            while seq_len_real < seq_len:
                seq_len_tmp += 1
                single_prompt = "word" * seq_len_tmp
                single_prompt = single_prompt.strip()
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                retry_count += 1
                if retry_count >= max_retry_times:
                    break
        print(f"real_seq_len={seq_len_real} ...")
    
        with framework.enable_thin_kv():
            with framework.torch.inference_mode():
                out = llm.generate([single_prompt]*batch_size, sampling_params)

        for func_name in framework.calls_map:
            if func_name not in total_calls_map:
                total_calls_map[func_name] = {}
            for call_stack in framework.calls_map[func_name]:
                if call_stack not in total_calls_map[func_name]:
                    total_calls_map[func_name][call_stack] = {}
                total_calls_map[func_name][call_stack][(batch_size, seq_len_real)] = framework.calls_map[func_name][call_stack].copy()
        framework.tensor_calls.clear()
        framework.calls_map.clear()

    if "vllm."+op_name in total_calls_map:
        with open(outpath, "w") as wf:
            wf.write(jsonpickle.encode(total_calls_map["vllm."+op_name], indent=2))
        return total_calls_map["vllm."+op_name]
    else:
        print(f"{modelId} {batch_size} {seq_len} {op_name} not found in calls_map.")
        return None
