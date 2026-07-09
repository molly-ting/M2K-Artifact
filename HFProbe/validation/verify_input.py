import os, json

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

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
                continue
            
            cuda_func = kernel_map[op_name]["func_name"]
            if cuda_func not in solution:
                continue
            
            if cuda_func not in res:
                res[cuda_func] = {}

            i=0
            for item in data[key]:
                index = locate_index(item, input_dir+"/"+cuda_func+".json", ignored)
                if index >= 0:
                    if str(index) in solution[cuda_func]:
                        for lineno in solution[cuda_func][str(index)]:
                            if lineno not in res[cuda_func]:
                                res[cuda_func][lineno] = {}
                            if model_id not in res[cuda_func][lineno]:
                                res[cuda_func][lineno][model_id] = {}
                            
                            if index in res[cuda_func][lineno][model_id]:
                                continue
                                    
                            res[cuda_func][lineno][model_id][index] = solution[cuda_func][str(index)][lineno]
                            if config_file is not None:
                                res[cuda_func][lineno][model_id][index]["config"] = config_file
                i += 1

def generate_vllm_input_check(read_dir, input_dir, config_dir, solution_file, outpath, ignored=None):
    with open(f"{root_dir}/kernel_map/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    res = {}
    for model_id in os.listdir(read_dir):
        real_model_id = model_id[:-5] if model_id.endswith(".json") else model_id
        
        if model_id.endswith(".json"):
            scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+model_id, input_dir, config_dir, solution_file, ignored)
        else:
            for file in os.listdir(read_dir+"/"+real_model_id):
                scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+real_model_id+"/"+file, input_dir, config_dir, solution_file, ignored)
    
    with open(outpath, "w") as wf:
        json.dump(res, wf, indent=4)

def generate_hf_input_check(read_dir, input_dir, config_dir, solution_file, outpath, ignored=None):
    res = {}
    for model_id in os.listdir(read_dir):
        real_model_id = model_id[:-5] if model_id.endswith(".json") else model_id

        with open(f"{root_dir}/kernel_map/kernel_map_{real_model_id}.json") as rf:
            kernel_map = json.load(rf)
        
        if model_id.endswith(".json"):
            scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+model_id, input_dir, config_dir, solution_file, ignored)
        else:
            for file in os.listdir(read_dir+"/"+real_model_id):
                scan_one_model(res, kernel_map, real_model_id, read_dir+"/"+real_model_id+"/"+file, input_dir, config_dir, solution_file, ignored)
    
    with open(outpath, "w") as wf:
        json.dump(res, wf, indent=4)