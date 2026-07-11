import z3
import os, re, json, time

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
project_dir = os.path.dirname(root_dir)

def eval_expr(expr, symvals):
    """Evaluate symbolic expression safely."""
    if isinstance(expr, (int, float)):
        return expr
    if isinstance(expr, str):
        try:
            return eval(expr, {}, symvals)
        except NameError:
            return expr  # unresolved symbol like 'u0'
    return expr

def in_range(symbol, value, sym_ranges):
    """Check if value falls within symbol range."""
    if symbol not in sym_ranges:
        return False
    low, high = sym_ranges[symbol]
    return low <= value <= high

def compare_shapes(shape1, shape2, symvals, sym_ranges):
    if len(shape1) != len(shape2):
        return False

    for d1, d2 in zip(shape1, shape2):
        v1 = eval_expr(d1, symvals)

        if isinstance(v1, str):
            # unresolved symbol → use range
            if not in_range(v1, d2, sym_ranges):
                return False
        else:
            if int(v1) != int(d2):
                return False

    return True

def compare_tensor(t1, t2, symvals):
    if t1["type"] != t2["type"]:
        return False
    
    if "dtype" in t1 and "dtype" in t2 and t1["dtype"] != t2["dtype"]:
        if not ("float16" in t1["dtype"] and "float16" in t2["dtype"]):
            return False

    sym_ranges = t1.get("symRanges", {})

    # Compare shapes
    if "shape" in t1 and "shape" in t2:
        if not compare_shapes(t1["shape"], t2["shape"], symvals, sym_ranges):
            return False
    
    if "value" in t1 and "value" in t2:
        if t1["value"] in sym_ranges:
            if not in_range(t1["value"], t2["value"], sym_ranges):
                return False
        else:   
            v1 = eval_expr(t1["value"], symvals)
            v2 = t2["value"]
            if isinstance(v1, int):
                if int(v1) != int(v2):
                    return False
            if isinstance(v1, float) and float(v1) != float(v2):
                return False
            if v1 != v2:
                return False

    # Optional: compare min/max
    for key in ["maxV", "minV"]:
        if key in t1 and key in t2:
            if not isinstance(t1[key], str) and not isinstance(t2[key], str):
                continue
            
            v1 = eval_expr(t1[key], symvals)
            v2 = t2[key]
            if isinstance(v1, str):
                return False
            if int(v1) != int(v2):
                return False

    return True

def compare_json_arrays(arr1, arr2, symvals):
    if len(arr1) != len(arr2):
        return False

    for t1, t2 in zip(arr1, arr2):
        if not compare_tensor(t1, t2, symvals):
            return False

    return True

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

def solve_with_bounds(smt_file, num_tokens, max_model_len=None):        
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
    if num_tokens:
        s.add(batch_size * seq_len <= num_tokens)
    if max_model_len:
        s.add(seq_len <= max_model_len)
    result = s.check()

    if result == z3.sat:
        model = s.model()
        bs_val = model.evaluate(batch_size, model_completion=True)
        sl_val = model.evaluate(seq_len, model_completion=True)
        return bs_val.as_long(), sl_val.as_long()
    elif result == z3.unknown:
        return None, None
    else:
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

def scan_one_out_file(res, kernel_map, model_id, model_file, input_dir, config_dir, ignored=None):
    if "mgalkin" in model_file and "ultra" in model_file:
        return
    
    with open(model_file) as rf:
        data = json.load(rf)
    
    config_file = None
    if not model_file.endswith(model_id + ".json"):
        config_file = config_dir + "/" + os.path.basename(model_file)[:-5] + ".json"
    
    if isinstance(data, dict):
        for key in data:
            op_name = key.split(".")[-1]
            if op_name not in kernel_map:
                continue
            
            cuda_func = kernel_map[op_name]["func_name"]            
            if cuda_func not in res:
                res[cuda_func] = {}
            res[cuda_func]["py_func"] = op_name

            for item in data[key]:
                index = locate_index(item, input_dir+"/"+cuda_func+".json", ignored)
                if index >= 0:
                    if index not in res[cuda_func]:
                        res[cuda_func][index] = {}
                    if model_id not in res[cuda_func][index]:
                        res[cuda_func][index][model_id] = {}
                    if config_file is not None:
                        res[cuda_func][index][model_id]["config"] = config_file

def init_vllm_input_check(profile_out_dir, kernel_map_path, model_arch_map_path, outpath, ignored=vllm_ignored):
    if not kernel_map_path:
        kernel_map_path = f"{project_dir}/evaluation/section-6-1-bug-detection/intermediate_results/kernel_map/kernel_map_vllm.json"
    with open(kernel_map_path) as rf:
        kernel_map = json.load(rf)
    
    if not model_arch_map_path:
        model_arch_map_path = f"{project_dir}/evaluation/section-6-1-bug-detection/benchmarks/vllm/vllm_models.json"
    with open(model_arch_map_path) as mf:
        model_arch_map = json.load(mf)
    
    res = {}
    read_dir = os.path.join(profile_out_dir, "out")
    input_dir = os.path.join(profile_out_dir, "input")
    for filename in os.listdir(read_dir):
        if "seq_con.json" in filename:
            continue

        model_id = filename[:-5] if filename.endswith(".json") else filename
        config_dir = os.path.join(profile_out_dir, "config", model_arch_map[model_id.replace("_", "/", 1)])
        
        if filename.endswith(".json"):
            scan_one_out_file(res, kernel_map, model_id, read_dir+"/"+filename, input_dir, config_dir, ignored)
        else:
            for subfile in os.listdir(read_dir+"/"+model_id):
                if "seq_con.json" in subfile:
                    continue
                scan_one_out_file(res, kernel_map, model_id, read_dir+"/"+model_id+"/"+subfile, input_dir, config_dir, ignored)
    
    with open(outpath, "w") as wf:
        json.dump(res, wf, indent=4)
    
    return res

def init_hf_input_check(profile_out_dir, kernel_map_dir, outpath):
    if not kernel_map_dir:
        kernel_map_dir = f"{project_dir}/evaluation/section-6-1-bug-detection/intermediate_results/kernel_map"
    
    res = {}
    read_dir = os.path.join(profile_out_dir, "out")
    input_dir = os.path.join(profile_out_dir, "input")

    for model_id in os.listdir(read_dir):
        real_model_id = model_id[:-5] if model_id.endswith(".json") else model_id
        config_dir = os.path.join(profile_out_dir, "config", model_id)

        with open(f"{kernel_map_dir}/kernel_map_{real_model_id}.json") as rf:
            kernel_map = json.load(rf)
        
        if model_id.endswith(".json"):
            scan_one_out_file(res, kernel_map, real_model_id, read_dir+"/"+model_id, input_dir, config_dir)
        else:
            for file in os.listdir(read_dir+"/"+real_model_id):
                scan_one_out_file(res, kernel_map, real_model_id, read_dir+"/"+real_model_id+"/"+file, input_dir, config_dir)
    
    with open(outpath, "w") as wf:
        json.dump(res, wf, indent=4)
    
    return res