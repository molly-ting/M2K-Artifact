
from vllm import LLM, SamplingParams
import os, json
import traceback
import torch


batch_size_configs = [1, 3, 5]
seq_lens_configs = [1, 7, 17]
HF_TOKEN = os.getenv("HF_TOKEN")
bug_res = []

def runVllm(modelId, framework_config, model_config, op_name):
    global batch_size_configs
    global seq_lens_configs
    global bug_res
    env_old = os.environ.copy()

    configs = {}
    if framework_config:
        if "envs" in framework_config:
            for k in framework_config["envs"]:
                os.environ[k] = framework_config["envs"][k]
        
        if "vllmconfig" in framework_config:
            configs = framework_config["vllmconfig"]
        if "batch_size" in framework_config:
            batch_size_configs = framework_config["batch_size"]
        if "seq_len" in framework_config:
            seq_lens_configs = framework_config["seq_len"]  
    
    if model_config:
        if "architectures" in model_config:
            model_config.pop("architectures")
        if "rope_scaling" in model_config:
            if "rope_type" not in model_config["rope_scaling"] and "type" in model_config["rope_scaling"]:
                model_config["rope_scaling"]["rope_type"] = model_config["rope_scaling"]["type"]

        configs["hf_overrides"] = model_config
        if "quantization_config" in model_config:
            if "quant_method" in model_config["quantization_config"] and "quantization" not in configs:
                quant_method = model_config["quantization_config"]["quant_method"]
                configs["quantization"] = quant_method
                if op_name and op_name == "moe_wna16_gemm":
                    configs["quantization"] = "moe_wna16"
            else:
                batch_size_configs = [1, 3, 5]
                seq_lens_configs = [1, 7, 17]
                return False, None
    
    configs["dtype"] = "float16"

    print("Running model ", modelId, "...")
    if "max_num_seqs" not in configs:
        configs["max_num_seqs"] = 20
    if "max_model_len" not in configs:
        configs["max_model_len"] = 514
    if "block_size" not in configs:
        configs["block_size"] = 512
    if "num_gpu_blocks_override" not in configs:
        configs["num_gpu_blocks_override"] = 30
    if os.environ.get("VLLM_USE_V1", "0") != "1":
        configs["preemption_mode"] = "swap"
    if "compilation_config" not in configs:
        configs["enforce_eager"] = True
    if "enable_chunked_prefill" not in configs:
        configs["enable_chunked_prefill"] = False
    
    try:
        llm = LLM(model=modelId, device="cuda", gpu_memory_utilization=1.0, trust_remote_code=True, hf_token=HF_TOKEN, **configs)
        sampling_params = SamplingParams(
            temperature=0
        )
        tokenizer = llm.get_tokenizer()

        for batch_size in batch_size_configs:
            for seq_len in seq_lens_configs:
                single_prompt = "word " * seq_len
                single_prompt = single_prompt.strip() 
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                print(f"batch_size={batch_size}, seq_len={seq_len_real} ...")

                out = llm.generate([single_prompt]*batch_size, sampling_params)
        
        # Force GPU synchronization to catch any latent kernel errors
        if torch.cuda.is_available():
            torch.cuda.synchronize()
        
    except RuntimeError as e:
        err_str = str(e).lower()
        if "illegal memory access" in err_str:
            bug_res.append((modelId, op_name, batch_size, seq_len))
            print("Caught CUDA illegal memory access!")
        traceback.print_exc()
        pass
    except:
        traceback.print_exc()
        pass
    
    if framework_config:
        os.environ = env_old
        batch_size_configs = [1, 3, 5]
        seq_lens_configs = [1, 7, 17]


def main(config_path, run_large=False):
    global bug_res

    with open("./vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("./vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    with open("./models.json", "r") as mf:
        all_models = json.load(mf)
    
    with open("./large_models.json", "r") as mf:
        large_models = json.load(mf)

    if run_large:
        all_models = large_models
    else:
        all_models = [m for m in all_models if m not in large_models]
        
    with open("./framework_config.json", "r") as ff:
        framework_configs = json.load(ff)

    processed_models = set()
    if os.path.exists("./processed_models.json"):
        with open("./processed_models.json") as mf:
            processed_models = set(json.load(mf))

    for model_id in all_models:
        structure = structure_model_map[model_id]

        if not os.path.exists(os.path.join(config_path, structure)):
            continue

        if model_id in processed_models:
            continue

        triggered_ops = set()
        trigger_res_file = os.path.join(config_path, structure, "result.json") 
        if os.path.exists(trigger_res_file):
            with open(trigger_res_file, "r") as rf:
                trigger_data = json.load(rf)
                if "initial" in trigger_data:
                    triggered_ops.update(set(trigger_data["initial"]))
                if "new" in trigger_data:
                    triggered_ops.update(set(trigger_data["new"]))
        else:
            triggered_ops = set(framework_configs.keys())
        
        for op_name in triggered_ops:
            if not op_name in framework_configs:
                continue
            runVllm(model_id, framework_configs[op_name], None, op_name)

        for op_config in os.listdir(os.path.join(config_path, structure)):
            if op_config.startswith("cost") or op_config.startswith("no_tri") or op_config.startswith("result"):
                continue
            config_file_path = os.path.join(config_path, structure, op_config)
            op_name = op_config.replace(".json", "")

            with open(config_file_path, "r") as cf:
                mconfigs = json.load(cf)
                fcon = None
                if op_name in framework_configs:
                    fcon = framework_configs[op_name]
                runVllm(model_id, fcon, mconfigs, op_name)

        processed_models.add(model_id)
        with open("./processed_models.json", "w") as pf:
            json.dump(list(processed_models), pf)
        
        with open("./bug_results.json", "w") as bf:
            json.dump(bug_res, bf)

main("./pyanalyzer/vllm-exp/config")

        



