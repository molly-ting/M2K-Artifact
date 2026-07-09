import z3
import os, re, json, time

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# TODO: read vllm_exp_out for solution.json
processed = {}

def solve_with_bounds(smt_file, N1, N2):
    global processed
    
    if smt_file in processed:
        if (N1, N2) in processed[smt_file]:
            return processed[smt_file][(N1, N2)]
    else:
        processed[smt_file] = {}
        
    with open(smt_file, "r") as f:
        content = f.read()
    content = content.replace("(check-sat)", "")  
    content = content.replace("(get-model)", "")
    content = content.replace("(reset)", "")
    
    constraints = z3.parse_smt2_string(content)

    tactic = z3.Then("simplify", "purify-arith", "nlsat")
    s = tactic.solver()
    s.set(timeout=30000)
    s.add(constraints)

    # Declare variables
    batch_size = z3.Int('batch_size')
    seq_len = z3.Int('seq_len')

    # Add new constraints
    s.add(batch_size <= N1)
    s.add(seq_len <= N2)
    result = s.check()

    if result == z3.sat:
        model = s.model()
        bs_val = model.evaluate(batch_size, model_completion=True)
        sl_val = model.evaluate(seq_len, model_completion=True)
        processed[smt_file][(N1, N2)] = (bs_val.as_long(), sl_val.as_long())
        return bs_val.as_long(), sl_val.as_long()
    elif result == z3.unknown:
        processed[smt_file][(N1, N2)] = (None, None)
        print(f"Solver returned UNKNOWN. {s.reason_unknown()}")
        return None, None
    else:
        processed[smt_file][(N1, N2)] = (None, None)
        return None, None

def _read_itanium_name_component(mangled, index):
    if index >= len(mangled) or not mangled[index].isdigit():
        return None, index

    end = index
    while end < len(mangled) and mangled[end].isdigit():
        end += 1

    length = int(mangled[index:end])
    name_start = end
    name_end = name_start + length
    if name_end > len(mangled):
        return None, index

    return mangled[name_start:name_end], name_end

def getFuncName(str):
    start = str.find("_Z")
    if start < 0:
        return None

    index = start + 2

    if index < len(str) and str[index] == "N":
        index += 1
        names = []
        while index < len(str) and str[index] != "E":
            name, index = _read_itanium_name_component(str, index)
            if name is None:
                break
            names.append(name)

        if names:
            return names[-1]
    else:
        name, _ = _read_itanium_name_component(str, index)
        if name is not None:
            return name

    print(str, "does not match the expected pattern.")
    return None

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


def solve_vllm_model_bs(target_dir, result_file, output_dir):
    data = {}
    if os.path.exists(result_file):
        with open(result_file, "r") as f:
            data = json.load(f)
    
    with open(f"{root_dir}/data/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open(f"{root_dir}/data/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    with open(f"{output_dir}/model_max_len.json", "r") as f:
        model_max_len = json.load(f)
    
    res = {}
    for subdir in os.listdir(target_dir):
        if not os.path.isdir(os.path.join(target_dir, subdir)):
            continue
        
        function_name = getFuncName(subdir)
        if function_name is None or function_name not in data:
            print(f"Function name {function_name} not found in data.")
            continue
        
        for lineno in data[function_name]:
            for model_str in data[function_name][lineno]:
                model_id = model_str.replace("_", "/", 1)
                max_seq_len = None
                if model_id in model_max_len:
                    max_seq_len = model_max_len[model_id]
                
                if model_id not in structure_model_map:
                    print(f"Model ID {model_id} not found in structure_model_map.")
                    # continue
                
                if max_seq_len is None:
                    if function_name not in res:
                        res[function_name] = {}
                    if lineno not in res[function_name]:
                        res[function_name][lineno] = {}
                    res[function_name][lineno][model_str] = data[function_name][lineno][model_str]
                    continue
                        
                for index in data[function_name][lineno][model_str]:
                    smt_file = f"{target_dir}/{subdir}/klee-out-jindex-{index}-0/{lineno}.txt"
                    if not os.path.exists(smt_file):
                        print(f"SMT file {smt_file} does not exist.")
                        continue
                    
                    config_file = None
                    if "config" in data[function_name][lineno][model_str][index]:
                        config_file = data[function_name][lineno][model_str][index]["config"]
                        if not config_file.startswith("/") or not os.path.exists(config_file):
                            config_file  = f"{output_dir}/config/" + structure_model_map[model_id] + "/" + config_file.split("/")[-1]
                        
                    batch_size, seq_len = None, None
                    for N1 in [128, 256, 512, 1000]:
                        for N2 in [max_seq_len/4, max_seq_len/2, max_seq_len]:
                            batch_size, seq_len = solve_with_bounds(smt_file, N1, N2)
                            if batch_size is not None and seq_len is not None:
                                if function_name not in res:
                                    res[function_name] = {}
                                if lineno not in res[function_name]:
                                    res[function_name][lineno] = {}
                                if model_str not in res[function_name][lineno]:
                                    res[function_name][lineno][model_str] = {}
                                if index not in res[function_name][lineno][model_str]:
                                    res[function_name][lineno][model_str][index] = {}
                                res[function_name][lineno][model_str][index] = {
                                    "batch_size": batch_size,
                                    "seq_len": seq_len,
                                }
                                if config_file:
                                    res[function_name][lineno][model_str][index]["config"] = config_file
                                break
                            
                        if batch_size is not None and seq_len is not None:
                            break
    
    with open(result_file, "w") as f:
        json.dump(res, f, indent=4)                                     

solve_vllm_model_bs()

def solve_hf_model_bs():
    start_time = time.time()
    with open("hf_exp_out/input_check0.json", "r") as f:
        data = json.load(f)
    
    with open("hf_exp_out/model_max_len.json", "r") as f:
        model_max_len = json.load(f)
    
    res = {}
    # if os.path.exists("hf_exp_out/input_check.json"):
    #     with open("hf_exp_out/input_check.json", "r") as f:
    #         res = json.load(f)
    
    target_dir = "hf_exp_out"
    for subdir in os.listdir(target_dir):
        if not os.path.isdir(os.path.join(target_dir, subdir)):
            continue
        
        if "rspmm_" in subdir:
            continue
        
        function_name = getFuncName(subdir)
        if function_name is None or function_name not in data:
            print(f"Function name {function_name} not found in data.")
            continue
        
        for lineno in data[function_name]:
            for model_str in data[function_name][lineno]:
                model_id = model_str.replace("_", "/", 1)
                max_seq_len = None
                if model_id not in model_max_len:
                    print(f"Model ID {model_id} not found in model_max_len.")
                    # continue
                else:
                    max_seq_len = model_max_len[model_id]
                
                if max_seq_len is None:
                    # if function_name not in res:
                    #     res[function_name] = {}
                    # if lineno not in res[function_name]:
                    #     res[function_name][lineno] = {}
                    # res[function_name][lineno][model_str] = data[function_name][lineno][model_str]
                    # print(f"Max sequence length for model {model_id} is not available. Skipping SMT solving for {function_name} {lineno} {model_str}.")
                    continue
                        
                for index in data[function_name][lineno][model_str]:
                    smt_file = f"{target_dir}/{subdir}/klee-out-jindex-{index}-0/{lineno}.txt"
                    if not os.path.exists(smt_file):
                        print(f"SMT file {smt_file} does not exist.")
                        continue
                    
                    if function_name in res and lineno in res[function_name] and model_str in res[function_name][lineno] and index in res[function_name][lineno][model_str]:
                        # print(f"Already have results for {function_name} {lineno} {model_str} {index}, skipping SMT solving.")
                        if res[function_name][lineno][model_str][index]["seq_len"] <= max_seq_len:
                            # print(f"Existing seq_len {res[function_name][lineno][model_str][index]['seq_len']} is valid for max_seq_len {max_seq_len}, skipping SMT solving for {function_name} {lineno} {model_str} {index}.")
                            continue
                    
                    config_file = None
                    if "config" in data[function_name][lineno][model_str][index]:
                        config_file = data[function_name][lineno][model_str][index]["config"]
                        config_file  = "./hf-exp/config/" + model_str + "/" + config_file.split("/")[-1]
                        
                    batch_size, seq_len = None, None
                    for N1 in [128, 256, 512, 1000]:
                        for N2 in [max_seq_len/4, max_seq_len/2, max_seq_len]:
                            print(f"Solving SMT for {function_name} {lineno} {model_str} {index} with bounds N1={N1}, N2={N2}...")
                            batch_size, seq_len = solve_with_bounds(smt_file, N1, N2)
                            if batch_size is not None and seq_len is not None:
                                if function_name not in res:
                                    res[function_name] = {}
                                if lineno not in res[function_name]:
                                    res[function_name][lineno] = {}
                                if model_str not in res[function_name][lineno]:
                                    res[function_name][lineno][model_str] = {}
                                res[function_name][lineno][model_str][index] = {
                                    "batch_size": batch_size,
                                    "seq_len": seq_len,
                                }
                                if config_file:
                                    res[function_name][lineno][model_str][index]["config"] = config_file
                                # with open("hf_exp_out/input_check.json", "w") as f:
                                #     json.dump(res, f, indent=4) 
                                # print(f"Found valid batch_size and seq_len for {function_name} {lineno} {model_str} {index}: batch_size={batch_size}, seq_len={seq_len}.")
                                break
                            
                        if batch_size is not None and seq_len is not None:
                            break
                    
                    # if not batch_size or not seq_len:
                    #     print(f"Could not find valid batch_size and seq_len for {function_name} {lineno} {model_str} {index}.")
                    #     if function_name not in res:
                    #         res[function_name] = {}
                    #     if lineno not in res[function_name]:
                    #         res[function_name][lineno] = {}
                    #     if model_str not in res[function_name][lineno]:
                    #         res[function_name][lineno][model_str] = {}
                    #     res[function_name][lineno][model_str][index] = data[function_name][lineno][model_str][index]
                    #     if config_file:
                    #         res[function_name][lineno][model_str][index]["config"] = config_file
                    #     with open("hf_exp_out/input_check.json", "w") as f:
                    #         json.dump(res, f, indent=4) 
    
    # with open("hf_exp_out/input_check.json", "w") as f:
    #     json.dump(res, f, indent=4)                
    end_time = time.time() # 5.16s
    print(f"Total time taken for solving HF model SMT problems: {end_time - start_time} seconds.")                    

# solve_hf_model_bs()