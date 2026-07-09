import json, os, traceback
from huggingface_hub import HfApi, hf_hub_download
import requests

possible_len_keys = [
    # OPT
    "max_position_embeddings",
    # GPT-2
    "n_positions",
    # MPT
    "max_seq_len",
    # ChatGLM2
    "seq_length",
    # Command-R
    "model_max_length",
    # Whisper
    "max_target_positions",
    # Others
    "max_sequence_length",
    "max_seq_length",
    "seq_len",
]
root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def get_vllm_max_model_len():
    with open(f"{root_dir}/data/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open(f"{root_dir}/data/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)

    with open(f"{root_dir}/data/vllm_models.json", "w") as mf:
        vllm_models = json.load(mf)

    model_max_len = {}
    for model_id in vllm_models:  
        if "/" not in model_id:
            model_id = model_id.replace("_", "/", 1)

        max_seq_len = None
        seq_con_path = f"{root_dir}/results/vllm/out/{model_id}_seq_con.json"
        if os.path.exists(seq_con_path):
            with open(seq_con_path) as cf:
                seq_con = json.load(cf)
            if "seq_len" in seq_con:
                max_seq_len = seq_con["seq_len"]
        else:
            structure = structure_model_map[model_id]
            with open(f"{root_dir}/vllm-configs-examples/{structure}.json") as cf:
                model_config = json.load(cf)
                
            for key in possible_len_keys:
                if key in model_config:
                    if not max_seq_len:
                        max_seq_len = model_config[key]
                    elif model_config[key] is not None:
                        max_seq_len = min(max_seq_len, model_config[key])
                elif "text_config" in model_config and key in model_config["text_config"]:
                    if not max_seq_len:
                        max_seq_len = model_config["text_config"][key]
                    elif model_config["text_config"][key] is not None:
                        max_seq_len = min(max_seq_len, model_config["text_config"][key])
                elif "vision_config" in model_config and key in model_config["vision_config"]:
                    if not max_seq_len:
                        max_seq_len = model_config["vision_config"][key]
                    elif model_config["vision_config"][key] is not None:
                        max_seq_len = min(max_seq_len, model_config["vision_config"][key])
                elif "llm_config" in model_config and key in model_config["llm_config"]:
                    if not max_seq_len:
                        max_seq_len = model_config["llm_config"][key]
                    elif model_config["llm_config"][key] is not None:
                        max_seq_len = min(max_seq_len, model_config["llm_config"][key])

        model_max_len[model_id] = max_seq_len

    with open(f"{root_dir}/results/vllm/model_max_len.json", "w") as mf:
        json.dump(model_max_len, mf, indent=4)

def get_hf_max_model_len():
    with open(f"{root_dir}/data/hfmodels.json") as mf:
        models = json.load(mf)

    model_max_len = {}
    for model_str in models:  
        model_id = model_str.replace("_", "/", 1)    
        
        try:
            path = hf_hub_download(
                repo_id=model_id,
                filename="config.json"
            )
        except:
            print(f"Failed to download config for {model_id}")
            traceback.print_exc()
            continue

        with open(path) as f:
            model_config = json.load(f)
            
        max_seq_len = None
        for key in possible_len_keys:
            if key in model_config:
                if not max_seq_len:
                    max_seq_len = model_config[key]
                elif model_config[key] is not None:
                    max_seq_len = min(max_seq_len, model_config[key])
            elif "text_config" in model_config and key in model_config["text_config"]:
                if not max_seq_len:
                    max_seq_len = model_config["text_config"][key]
                elif model_config["text_config"][key] is not None:
                    max_seq_len = min(max_seq_len, model_config["text_config"][key])
            elif "vision_config" in model_config and key in model_config["vision_config"]:
                if not max_seq_len:
                    max_seq_len = model_config["vision_config"][key]
                elif model_config["vision_config"][key] is not None:
                    max_seq_len = min(max_seq_len, model_config["vision_config"][key])
            elif "llm_config" in model_config and key in model_config["llm_config"]:
                if not max_seq_len:
                    max_seq_len = model_config["llm_config"][key]
                elif model_config["llm_config"][key] is not None:
                    max_seq_len = min(max_seq_len, model_config["llm_config"][key])

        model_max_len[model_id] = max_seq_len

    with open(f"{root_dir}/results/huggingface/model_max_len.json", "w") as mf:
        json.dump(model_max_len, mf, indent=4)


def model_info(model_id):
    if model_id == "mosaicml/mpt-7b":
        model_id = "k0t1k/mosaicml-mpt-7b-instruct-lora"
    if model_id == "databricks/dbrx-instruct":
        model_id = "alpindale/dbrx-instruct"
        
    api = HfApi()
    try:
        info = api.model_info(model_id, files_metadata=True)
    except:
        print(f"Failed to get model info for {model_id}")
        return None, None, None, None

    weights_size = 0
    for f in info.siblings:
        if f.rfilename.endswith((".bin", ".safetensors", ".pt")):
            if f.size is None:
                url = f"https://huggingface.co/{model_id}/resolve/main/{f.rfilename}"
                r = requests.head(url, allow_redirects=True)
                size = int(r.headers.get("Content-Length", 0))
                # print(model_id, f.rfilename, size)
                weights_size += size
            else:
                weights_size += f.size

    path = hf_hub_download(
        repo_id=model_id,
        filename="config.json"
    )

    with open(path) as f:
        config = json.load(f)
    
    hidden_size, intermediate_size, num_layers = None, None, None
    if "hidden_size" in config:
        hidden_size = config["hidden_size"]
    elif "text_config" in config and "hidden_size" in config["text_config"]:
        hidden_size = config["text_config"]["hidden_size"]
    elif "llm_config" in config and "hidden_size" in config["llm_config"]:
        hidden_size = config["llm_config"]["hidden_size"]
    elif "vision_config" in config and "hidden_size" in config["vision_config"]:
        hidden_size = config["vision_config"]["hidden_size"]
    elif "n_embed" in config:
        hidden_size = config["n_embed"]
    elif "n_embd" in config:
        hidden_size = config["n_embd"]
    elif "d_model" in config:
        hidden_size = config["d_model"]
        
    if "intermediate_size" in config:
        intermediate_size = config["intermediate_size"]
    elif "text_config" in config and "intermediate_size" in config["text_config"]:
        intermediate_size = config["text_config"]["intermediate_size"]
    elif "llm_config" in config and "intermediate_size" in config["llm_config"]:
        intermediate_size = config["llm_config"]["intermediate_size"]
    elif "vision_config" in config and "intermediate_size" in config["vision_config"]:
        intermediate_size = config["vision_config"]["intermediate_size"]
    elif "ffn_hidden_size" in config:
        intermediate_size = config["ffn_hidden_size"]
    
    if "num_hidden_layers" in config:
        num_layers = config["num_hidden_layers"]
    elif "text_config" in config and "num_hidden_layers" in config["text_config"]:
        num_layers = config["text_config"]["num_hidden_layers"]
    elif "llm_config" in config and "num_hidden_layers" in config["llm_config"]:
        num_layers = config["llm_config"]["num_hidden_layers"]
    elif "vision_config" in config and "num_hidden_layers" in config["vision_config"]:
        num_layers = config["vision_config"]["num_hidden_layers"]
    elif "n_layer" in config:
        num_layers = config["n_layer"]
    elif "n_layers" in config:
        num_layers = config["n_layers"]
    elif "num_layers" in config:    
        num_layers = config["num_layers"]

    return weights_size, hidden_size, intermediate_size, num_layers

gpu_config = [512, 480, 448, 416, 384, 352, 320, 288, 192, 144, 141, 128, 80, 64, 48, 32, 24, 16]

def compute_vllm_token_limit_by_gpu():
    gpu_memory_utilization = 1
    
    with open(f"{root_dir}/data/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open(f"{root_dir}/data/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    with open(f"{root_dir}/data/vllm_models.json") as mf:
        vllm_models = json.load(mf)
    
    res = {}
    failed_models = []
    for model_id in structure_model_map:
        model_str = model_id.replace("/", "_")
        if model_str not in vllm_models and model_id not in vllm_models:
            continue
        
        weights_size, hidden_size, intermediate_size, num_layers = model_info(model_id)
        if weights_size is None:
            print(model_id, "missing weights size info")
            failed_models.append(model_id)
            continue
        
        if hidden_size is None:
            print(model_id, "missing hidden size info")
            failed_models.append(model_id)
            continue
        
        if intermediate_size is None:
            print(model_id, "missing intermediate size info, set to hidden_size*2")
            intermediate_size = hidden_size * 2
        
        for gpu_memory in gpu_config:
            token_limit = int(((gpu_memory * gpu_memory_utilization * 1024 * 1024 * 1024/1.25) - weights_size) / (2 * num_layers * hidden_size * 2))
            if model_id not in res:
                res[model_id] = {}
            if gpu_memory not in res[model_id]:
                res[model_id][gpu_memory] = token_limit
    
    with open(f"{root_dir}/results/vllm/token_limit_by_gpu.json", "w") as wf:
        json.dump(res, wf, indent=4)

def compute_hf_token_limit_by_gpu():
    gpu_memory_utilization = 1
    
    with open(f"{root_dir}/data/hfmodels.json") as f:
        model_list = json.load(f)
    
    res = {}
    failed_models = []
    for item in model_list:
        model_id = item.replace("_", "/", 1)
        weights_size, hidden_size, intermediate_size, num_layers = model_info(model_id)
        if weights_size is None:
            print(model_id, "missing weights size info")
            failed_models.append(model_id)
            continue
        
        if hidden_size is None:
            print(model_id, "missing hidden size info")
            failed_models.append(model_id)
            continue
        
        if intermediate_size is None:
            print(model_id, "missing intermediate size info, set to hidden_size*2")
            intermediate_size = hidden_size * 2
        
        for gpu_memory in gpu_config:
            token_limit = int(((gpu_memory * gpu_memory_utilization * 1024 * 1024 * 1024/1.45) - weights_size) / (2 * num_layers * hidden_size * 2))
            if model_id not in res:
                res[model_id] = {}
            if gpu_memory not in res[model_id]:
                res[model_id][gpu_memory] = token_limit
    
    with open(f"{root_dir}/results/hf/token_limit_by_gpu.json", "w") as wf:
        json.dump(res, wf, indent=4)