import os, json
from huggingface_hub import HfApi, hf_hub_download
import requests

vllm_ignored = {"maxV", "minV", "symRanges"}

def remove_ignored(obj, ignored=None):
    if ignored is None:
        ignored = vllm_ignored
    # Case 1: Dict → remove keys and recurse into values
    if isinstance(obj, dict):
        return {
            k: remove_ignored(v, ignored)
            for k, v in obj.items()
            if k not in ignored
        }

    # Case 2: List / tuple → recurse each element
    if isinstance(obj, (list, tuple)):
        return type(obj)(remove_ignored(v, ignored) for v in obj)

    # Case 3: Other (int, str, float, None…) → return as-is
    return obj

def locate_index(item, file_path, ignored=None):
    if not os.path.exists(file_path):
        return -1
    
    with open(file_path) as f:
        data = json.load(f)
    
    for (index, v) in enumerate(data):
        if v["args"] == item:
            return index
        
        if ignored is not None:
            if remove_ignored(v["args"], ignored) == remove_ignored(item, ignored):
                return index
    
    return -2

def scan_one_model(res, kernel_map, model_id, model_file, input_dir, config_dir, solution_file, ignored=None):
    if "mgalkin" in model_file and "ultra" in model_file:
        return
    
    with open(model_file) as rf:
        data = json.load(rf)
    
    with open(solution_file) as rf:
        solution = json.load(rf)
    
    config_file = None
    if not model_file.endswith(model_id + ".json"):
        config_file = config_dir + "/" + os.path.basename(model_file)[:-5] + ".json"
    
    if isinstance(data, dict):
        for key in data:
            op_name = key.split(".")[-1]
            if op_name not in kernel_map:
                # print(op_name, "not in kernel_map")
                continue
            
            cuda_func = kernel_map[op_name]["func_name"]
            if cuda_func not in solution:
                continue
            
            if cuda_func not in res:
                res[cuda_func] = {}

            i=0
            for item in data[key]:
                index = locate_index(item, input_dir+"/"+cuda_func+".json", ignored)
                if op_name == "gather_cache":
                    index = 0
                if index >= 0:
                    if str(index) in solution[cuda_func]:
                        for lineno in solution[cuda_func][str(index)]:
                            if lineno not in res[cuda_func]:
                                res[cuda_func][lineno] = {}
                            if model_id not in res[cuda_func][lineno]:
                                res[cuda_func][lineno][model_id] = {}
                            
                            if index in res[cuda_func][lineno][model_id]:
                                # print(model_file, "duplicate index for", cuda_func, "lineno", lineno, "model_id", model_id, "index:", index)
                                continue
                                    
                            res[cuda_func][lineno][model_id][index] = solution[cuda_func][str(index)][lineno]
                            if config_file is not None:
                                res[cuda_func][lineno][model_id][index]["config"] = config_file
                else:
                    print(model_file, op_name, f"[{i}]", "not in", input_dir+"/"+cuda_func+".json", " resIndex:", index)
                i += 1
    else:
        print("not dict format:", model_file)

def generate_input_check(read_dir, input_dir, config_dir, solution_file, outpath, ignored=None):
    if "vllm" in read_dir:
        with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
            kernel_map = json.load(rf)
    
    res = {}
    for model_id in os.listdir(read_dir):
        real_model_id = model_id[:-5] if model_id.endswith(".json") else model_id

        if not "vllm" in read_dir:
            with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_{real_model_id}.json") as rf:
                kernel_map = json.load(rf)
        
        if model_id.endswith(".json"):
            scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+model_id, input_dir, config_dir, solution_file, ignored)
        else:
            for file in os.listdir(read_dir+"/"+real_model_id):
                scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+real_model_id+"/"+file, input_dir, config_dir, solution_file, ignored)
    
    with open(outpath, "w") as wf:
        json.dump(res, wf, indent=4)

# generate_input_check("./hf-exp/out", "./hf-exp/input", "./hf-exp/config","./hf-exp/solution.json", "./hf-exp")
# generate_input_check("./vllm-exp/out", "./vllm-exp/input", "./vllm-exp/config","./vllm-exp/solution_TP.json", "./vllm-exp/input_check_TP.json", vllm_ignored)
# generate_input_check("./vllm-exp/out", "./vllm-exp/input", "./vllm-exp/config","./vllm-exp/solution_FP.json", "./vllm-exp/input_check_FP.json", vllm_ignored)
generate_input_check("./vllm-exp/out", "./vllm-exp/input", "./vllm-exp/config","./vllm-exp/solution_advance.json", "./vllm-exp/input_check_advance.json", vllm_ignored)


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
    
    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    res = {}
    failed_models = []
    for model_id in structure_model_map:
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
    
    with open("./vllm-exp/token_limit_by_gpu.json", "w") as wf:
        json.dump(res, wf, indent=4)
    
    print("failed models:", failed_models)

def compute_hf_token_limit_by_gpu():
    gpu_memory_utilization = 1
    
    with open("./hfmodels0.json") as f:
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
    
    with open("./hf-exp/token_limit_by_gpu.json", "w") as wf:
        json.dump(res, wf, indent=4)
    
    print("failed models:", failed_models)

# compute_vllm_token_limit_by_gpu()    
# compute_hf_token_limit_by_gpu()

def check_config():
    with open("./vllm-exp/input_check_TP.json") as rf:
        input_check = json.load(rf)
    
    for cuda_func in input_check:
        for lineno in input_check[cuda_func]:
            for model_str in input_check[cuda_func][lineno]:
                for index in input_check[cuda_func][lineno][model_str]:
                    item = input_check[cuda_func][lineno][model_str][index]
                    if "config" in item:
                        if not os.path.exists(item["config"]):
                            print(f"Config file {item['config']} does not exist for {model_str} {cuda_func} at line {lineno} index {index}.")

# check_config()

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

def filterInValidConfig():
    with open("./vllm-exp/input_check_TP.json") as rf:
        input_check = json.load(rf)
        
    with open("./vllm-exp/input_check_results.json") as rf:
        res = json.load(rf)
    
    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    for cuda_func in input_check:
        for lineno in input_check[cuda_func]:
            for model_str in input_check[cuda_func][lineno]:
                for index in input_check[cuda_func][lineno][model_str]:
                    item = input_check[cuda_func][lineno][model_str][index]
                    
                    model_config = None
                    if "config" in item:
                        if os.path.exists(item["config"]):
                            with open(item["config"]) as cf:
                                model_config = json.load(cf)
                    
                    if not model_config:
                        continue
                    
                    model_id = model_str.replace("_", "/", 1)
                    structure = structure_model_map.get(model_id, None)
                    if not structure:
                        print(f"Model {model_id} not found in structure map.")
                        continue
                    
                    if cuda_func in res and lineno in res[cuda_func] and model_str in res[cuda_func][lineno] and index in res[cuda_func][lineno][model_str]:
                        if res[cuda_func][lineno][model_str][index] == "Parameter mismatch":
                            with open("./vllm-configs-examples/"+structure+".json") as ef:
                                original_config = json.load(ef)
                            
                            config_mismatch = False
                            for key in ["hidden_size", "intermediate_size", "n_embed", "n_embd", "d_model", "ffn_hidden_size"]:
                                if key in original_config and key in model_config:
                                    if original_config[key] != model_config[key]:
                                        config_mismatch = True
                                        print(f"Parameter mismatch for {model_id} in {cuda_func} at line {lineno} index {index}: {key} is {model_config[key]} but expected {original_config[key]}")
                                        break
                                elif "text_config" in original_config and key in original_config["text_config"] and "text_config" in model_config and key in model_config["text_config"]:
                                    if original_config["text_config"][key] != model_config["text_config"][key]:
                                        config_mismatch = True
                                        print(f"Parameter mismatch for {model_id} in {cuda_func} at line {lineno} index {index}: text_config.{key} is {model_config['text_config'][key]} but expected {original_config['text_config'][key]}")
                                        break
                                elif "llm_config" in original_config and key in original_config["llm_config"] and "llm_config" in model_config and key in model_config["llm_config"]:
                                    if original_config["llm_config"][key] != model_config["llm_config"][key]:
                                        config_mismatch = True
                                        print(f"Parameter mismatch for {model_id} in {cuda_func} at line {lineno} index {index}: llm_config.{key} is {model_config['llm_config'][key]} but expected {original_config['llm_config'][key]}")
                                        break
                                elif "vision_config" in original_config and key in original_config["vision_config"] and "vision_config" in model_config and key in model_config["vision_config"]:
                                    if original_config["vision_config"][key] != model_config["vision_config"][key]:
                                        config_mismatch = True
                                        print(f"Parameter mismatch for {model_id} in {cuda_func} at line {lineno} index {index}: vision_config.{key} is {model_config['vision_config'][key]} but expected {original_config['vision_config'][key]}")
                                        break
                            
                            if config_mismatch:
                                res[cuda_func][lineno][model_str][index] = "invalid config"
        
    with open("./vllm-exp/input_check_results1.json", "w") as wf:
        json.dump(res, wf, indent=2)

# filterInValidConfig()