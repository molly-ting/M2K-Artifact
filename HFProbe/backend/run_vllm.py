import framework
from utils import *
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


current_path_string = os.path.abspath(__file__)
result_dir = os.path.join(os.path.dirname(os.path.dirname(current_path_string)), "result")

GB = 1024 ** 3
soft, hard = resource.getrlimit(resource.RLIMIT_AS)
new_soft = min(4 * GB, hard)
resource.setrlimit(resource.RLIMIT_AS, (new_soft, hard))
oom_models = []
failed_models = []
batch_size_configs = [1, 3, 5]
seq_lens_configs = [1, 7, 17]

def clean(modelId):
    # --- Cleanup HuggingFace cache ---
    try:
        model_cache_dir = snapshot_download(modelId, local_files_only=True, ignore_patterns=["*.bin", "*.safetensors"])
        shutil.rmtree(model_cache_dir)
        print(f"[{modelId}] Cache removed: {model_cache_dir}")
    except Exception as e:
        print(f"[{modelId}] Cache cleanup error:", e)
  
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
        
    print("Running model ", modelId, "...")
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
    except Exception as e: 
        traceback.print_exc()
        print(e)
        clean(modelId)
        framework.tensor_calls.clear()
        framework.calls_map.clear()
        failed_models.append(modelId)
        return
    except MemoryError:
        print("Caught MemoryError - likely trying to allocate too much RAM")
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

    max_token = None
    if "sampling" in configs:
        max_token = configs["sampling"]["max_tokens"]
        configs.pop("sampling")
        
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
                        max_num_batched_tokens=max(batch_size*seq_len+1, 4096),
                        **configs
                    )
    except Exception as e: 
        traceback.print_exc()
        print(e)
        clean(modelId)
        return -1 
    except MemoryError:
        print("Caught MemoryError - likely trying to allocate too much RAM")
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
            if seq_len_real == seq_len + 1:
                single_prompt = "word " * (seq_len-1)
                single_prompt = single_prompt.strip() 
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                if seq_len_real != seq_len:
                    print(f"Error: seq_len_real ({seq_len_real}) does not match expected seq_len ({seq_len}) even after adjustment.")
                    return -2
            else:
                print(f"Error: seq_len_real ({seq_len_real}) does not match expected seq_len ({seq_len}).")
                return -2
            
        print("Running model ", modelId, "...", f"batch_size={batch_size}, seq_len={seq_len_real} ...")
    
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
