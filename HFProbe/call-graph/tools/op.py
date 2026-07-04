import os, json


def extract_path_model_pairs(vllm_dir: str) -> dict[str, str]:
    registry_py = os.path.join(vllm_dir, "model_executor/models/registry.py")
    with open(registry_py, "r") as f:
        lines = f.readlines()

    models_dir = os.path.dirname(registry_py)
    res = {}
    started = False
    for line in lines:
        line = line.strip()
        if line.startswith("#"):
            continue
        # if line.startswith("_TEXT_GENERATION_MODELS"):
        if line.startswith("_") and "_MODELS = {" in line:
            started = True
            continue
        if not started:
            continue
        if line.startswith("}"):
            # break
            started = False
            continue

        parts = line.split(":")
        if len(parts) != 2:
            continue
        pair = parts[1]
        pair = (
            pair.strip()
            .replace("'", "")
            .replace('"', "")
            .replace("(", "")
            .replace(")", "")
            .replace(",", "")
        )
        items = pair.split(" ")
        if len(items) < 2:
            continue

        res[items[1]] = os.path.join(models_dir, items[0] + ".py")
        print(f"Found model {items[1]} at {res[items[1]]}")
    return res

def find_op_lines(op_name, filePath):
    with open(filePath) as f:
        call_graph = json.load(f)
        
    for key in call_graph:
        value = call_graph[key]
        for callee in value.get("callees", []):
            if callee["function"] and callee["function"].startswith("torch.ops._"):
                # print(callee["function"], op_name, value["filepath"], value["function"])
                if len(callee["function"].split("."))>4:
                    func_name = callee["function"].split(".")[3]
                else:
                    func_name = callee["function"].split(".")[-1]
                if func_name == op_name:
                    if value["loc"][0] == callee["line"] or value["loc"][0] + 1 == callee["line"]:
                        continue
                    # if value["filepath"].endswith("/_custom_ops.py"):
                    #     return find_op_lines(value["function"], filePath)
                    return value["filepath"], value["loc"][0], callee["line"]
            if callee["function"] and callee["function"] == op_name and callee["filepath"].endswith("/_custom_ops.py"):
                if value["loc"][0] == callee["line"] or value["loc"][0] + 1 == callee["line"]:
                    continue
                return value["filepath"], value["loc"][0], callee["line"]
    return None, None, None

def extract_op_info(op_name, structure, call_op_map, dir="/Users/molly/Workspace/pyanalyzer/cgout"):
    # print("extract_op_code", op_name, structure)
    for func in call_op_map:
        type_name = func.split("-")[0]
        for sub_class in call_op_map[func]:
            if op_name in call_op_map[func][sub_class]:
                # print(op_name, "in", func, sub_class)
                filePath, start_line, end_line = find_op_lines(op_name, dir+"/"+type_name+"/"+sub_class)
                # print(type_name, sub_class, filePath, start_line, end_line)
                if filePath:
                    return filePath, start_line, end_line
                
    return find_op_lines(op_name, f"{dir}/{structure}_forward.json") 

def extract_op_code(op_name, structure, call_op_map, dir="/Users/molly/Workspace/pyanalyzer/cgout"):
    # print("extract_op_code", op_name, structure)
    for func in call_op_map:
        type_name = func.split("-")[0]
        for sub_class in call_op_map[func]:
            if op_name in call_op_map[func][sub_class]:
                # print(op_name, "in", func, sub_class)
                filePath, start_line, end_line = find_op_lines(op_name, dir+"/"+type_name+"/"+sub_class)
                # print(type_name, sub_class, filePath, start_line, end_line)
                if filePath:
                    code_snippet = read_code_snippet(filePath, start_line, end_line)
                    return code_snippet
                
    filePath, start_line, end_line = find_op_lines(op_name, f"{dir}/{structure}_forward.json") 
    # print(filePath, start_line, end_line)
    if filePath:
        code_snippet = read_code_snippet(filePath, start_line, end_line)
        return code_snippet
    return None
    
def read_code_snippet(filePath, start_line, end_line):
    if filePath.startswith("vllm"):
        filePath = os.path.join("/home/mvh6224/vllm", filePath)
    elif filePath.startswith("/User/"):
        filePath = filePath.replace("/Users/molly/Workspace/vllm", "/home/mvh6224/vllm")
        
    code_snippet = ""
    with open(filePath) as f:
        lines = f.readlines()
        for i in range(start_line-1, end_line):
            code_snippet += lines[i]
    return code_snippet

def findAllOps(filePath, call_op_map, dir="/Users/molly/Workspace/pyanalyzer/cgout"):
    ops = set()
    with open(filePath) as f:
        call_graph = json.load(f)
        
    for key in call_graph:
        value = call_graph[key]
        for callee in value.get("callees", []):
            if callee["function"] and callee["function"].startswith("torch.ops._"):
                if len(callee["function"].split("."))>4:
                    func_name = callee["function"].split(".")[3]
                else:
                    func_name = callee["function"].split(".")[-1]
                ops.add(func_name)
                
        if "unknown" in value and value["unknown"]:
            for call in value["unknown"]:
                if call["type"]:
                    call_type = call["type"].split(".")[-1]
                    func = call["function"].split(".")[-1]
                    map_key = call_type+"-"+func
                    if map_key in call_op_map:
                        for sub_class in call_op_map[map_key]:
                            ops.update(call_op_map[map_key][sub_class])
                        # ops.update(call_op_map[call["type"]+"-"+func])
                    elif os.path.isdir(dir+"/"+call_type):
                        # tmp_ops = set()
                        for fname in os.listdir(dir+"/"+call_type):
                            if fname.endswith(func+".json"):
                                sub_ops = findAllOps(dir+"/"+call_type+"/"+fname, call_op_map)
                                if map_key not in call_op_map:
                                    call_op_map[map_key] = {}
                                call_op_map[map_key][fname] = sub_ops
                                ops.update(sub_ops)
                                # tmp_ops.update(sub_ops)
                        # call_op_map[call["type"]+"-"+func] = tmp_ops
                        # ops.update(tmp_ops)
    return ops

def handle_sructure(structure):
    outdir = "/Users/molly/Workspace/pyanalyzer/opout"
    os.makedirs(outdir, exist_ok=True)
    if os.path.exists(os.path.join(outdir, structure+".json")):
        return
    
    print("processing", structure)
    call_op_map = {}
    op_names = findAllOps(f"/Users/molly/Workspace/pyanalyzer/cgout/{structure}_forward.json", call_op_map)
    
    res = {}
    for op in op_names:
        filePath, start_line, end_line = extract_op_info(op, structure, call_op_map)
        res[op] = {"filePath": filePath, "lines": [start_line, end_line]}
    
    with open(os.path.join(outdir, structure+".json"), "w") as f:
        json.dump(res, f, indent=4)

def main():
    # vllm_dir = "/Users/molly/Workspace/vllm/vllm"
    # vllm_dir = "/Users/molly/Downloads/vllm-main/vllm"
    # vllm_model2path = extract_path_model_pairs(vllm_dir)
    # for architecture in vllm_model2path:
        # if os.path.exists(f"/Users/molly/Workspace/pyanalyzer/cgout/{architecture}_forward.json"):
        #     print("processing", architecture)
        #     handle_sructure(architecture)
    for file in os.listdir("/Users/molly/Workspace/pyanalyzer/cgout"):
        if not file.endswith(".json"):
            continue
        architecture = file.split(".")[0].split("_forward")[0]
        handle_sructure(architecture)

main()
# handle_sructure("DeepseekV3ForCausalLM")

def test_sum():
    outdir = "/Users/molly/Workspace/pyanalyzer/opout"
    count_map = {}
    total_ops = 0
    num = 0
    # all_ops = set()
    for file in os.listdir(outdir):
        with open(os.path.join(outdir, file)) as f:
            data = json.load(f)
            total_ops+=len(set(data.keys()))
            num+=1
            count_map[file.split(".")[0]] = len(set(data.keys()))
            # all_ops.update(set(data.keys()))
    print(num, total_ops, total_ops/num)
    for key in count_map:
        print(key, count_map[key])
    # for o in all_ops:
    #     print(o)
    # print(len(all_ops))
    # print("*****************")
    # with open("./tmp.json") as tf:
    #     vllm_ops = json.load(tf)
    
    # print(len(vllm_ops))
    # for o in vllm_ops:
    #     if o not in all_ops:
    #         print(o)

# test_sum()

def compare():
    outdir = "/Users/molly/Workspace/pyanalyzer/opout0"
    outdir2 = "/Users/molly/Workspace/pyanalyzer/opout"
    for file in os.listdir(outdir):
        if file.endswith("_test.json"):
            continue
        ops_0 = set()
        with open(os.path.join(outdir, file)) as f:
            data = json.load(f)
            ops_0.update(set(data.keys()))
        ops_1 = set()
        with open(os.path.join(outdir2, file)) as f:
            data = json.load(f)
            ops_1.update(set(data.keys()))
        print(file.split(".")[0])
        print(len(ops_0), len(ops_1), ops_0-ops_1, ops_1-ops_0)

# compare()


def printRes():
    model_archi_map = {}
    with open("/Users/molly/Workspace/pyanalyzer/test-autogen/vllm_text_model_structures_map.json") as f:
        model_archi_map = json.load(f)
    
    with open("/Users/molly/Workspace/pyanalyzer/test-autogen/vllm_other_model_structures_map.json") as f:
        tmp_map = json.load(f)
        model_archi_map.update(tmp_map)
    
    with open("/Users/molly/Workspace/pyanalyzer/time.json") as f:
        time_info = json.load(f)
    
    count_map = {}
    for file in os.listdir("/Users/molly/Workspace/pyanalyzer/opout"):
        with open(os.path.join("/Users/molly/Workspace/pyanalyzer/opout", file)) as f:
            data = json.load(f)
            count_map[file.split(".")[0]] = len(set(data.keys()))
    
    for model_id in model_archi_map:
        arch = model_archi_map[model_id]
        if arch not in time_info:
            # print(arch, "not in time.json")
            continue
        
        if arch not in count_map:
            # print(arch, "not in opout")
            continue
        
        # print(f"{model_id},{arch},{count_map[arch]},{time_info[arch]+time_info["indirect_call"]}")
        
# printRes()       
        
        
# with open("/Users/molly/Workspace/pyanalyzer/opout/Qwen3MoeForCausalLM_test.json") as tf:
#     qwen_ops = json.load(tf)

# with open("/Users/molly/Workspace/pyanalyzer/opout/DeepseekV3ForCausalLM_test.json") as tf:
#     deep_ops = json.load(tf)

# print(len(qwen_ops), len(deep_ops))
# print("deepseek miss:")
# for op in qwen_ops:
#     if op not in deep_ops:
#         print(op)

# print("qwen miss:")
# for op in deep_ops:
#     if op not in qwen_ops:
#         print(op)
#     for op in vllm_ops:
#         print(op)
#     print(len(vllm_ops))