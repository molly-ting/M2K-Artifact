import os, json


def find_op_lines(op_name, filePath):
    with open(filePath) as f:
        call_graph = json.load(f)
        
    for key in call_graph:
        value = call_graph[key]
        for callee in value.get("callees", []):
            if callee["function"] and callee["function"].startswith("torch.ops._"):
                # if len(callee["function"].split("."))>4:
                #     func_name = callee["function"].split(".")[3]
                # else:
                func_name = callee["function"].split(".")[-1]
                if func_name == op_name:
                    if value["loc"][0] == callee["line"] or value["loc"][0] + 1 == callee["line"]:
                        continue
                    return value["filepath"], value["loc"][0], callee["line"]
            if callee["function"] and callee["function"] == op_name and callee["filepath"].endswith("/_custom_ops.py"):
                if value["loc"][0] == callee["line"] or value["loc"][0] + 1 == callee["line"]:
                    continue
                return value["filepath"], value["loc"][0], callee["line"]
    return None, None, None

def extract_op_info(op_name, structure, call_op_map, dir):
    for func in call_op_map:
        type_name = func.split("-")[0]
        for sub_class in call_op_map[func]:
            if op_name in call_op_map[func][sub_class]:
                filePath, start_line, end_line = find_op_lines(op_name, dir+"/"+type_name+"/"+sub_class)
                if filePath:
                    return filePath, start_line, end_line
                
    return find_op_lines(op_name, f"{dir}/{structure}_forward.json") 

def findAllOps(filePath, call_op_map, dir):
    ops = set()
    with open(filePath) as f:
        call_graph = json.load(f)
        
    for key in call_graph:
        value = call_graph[key]
        for callee in value.get("callees", []):
            if callee["function"] and callee["function"].startswith("torch.ops._"):
                # if len(callee["function"].split("."))>4:
                #     func_name = callee["function"].split(".")[3]
                # else:
                func_name = callee["function"].split(".")[-1]
                ops.add(func_name)
                
        if "unknown" in value and value["unknown"]:
            for call in value["unknown"]:
                if call["type"]:
                    call_type = call["type"]
                    # call_type = call["type"].split(".")[-1]
                    func = call["function"].split(".")[-1]
                    map_key = call_type+"-"+func
                    if map_key in call_op_map:
                        for sub_class in call_op_map[map_key]:
                            ops.update(call_op_map[map_key][sub_class])
                    elif os.path.isdir(dir+"/"+call_type):
                        for fname in os.listdir(dir+"/"+call_type):
                            if fname.endswith(func+".json"):
                                sub_ops = findAllOps(dir+"/"+call_type+"/"+fname, call_op_map, dir)
                                if map_key not in call_op_map:
                                    call_op_map[map_key] = {}
                                call_op_map[map_key][fname] = sub_ops
                                ops.update(sub_ops)
    return ops

def handle_sructure(filepath, out_dir):
    structure = filepath.split("/")[-1].split(".")[0].split("_forward")[0]
    if os.path.exists(os.path.join(out_dir, structure+".json")):
        return
    
    print("processing", structure)
    call_op_map = {}
    op_names = findAllOps(filepath, call_op_map, os.path.dirname(filepath))
    
    res = {}
    for op in op_names:
        filePath, start_line, end_line = extract_op_info(op, structure, call_op_map, os.path.dirname(filepath))
        res[op] = {"filePath": filePath, "lines": [start_line, end_line]}
    
    with open(os.path.join(out_dir, structure+".json"), "w") as f:
        json.dump(res, f, indent=4)

def collect_ops(input_dir, out_dir):
    if not os.path.exists(input_dir):
        print(f"Input directory {input_dir} does not exist.")
        return
    
    os.makedirs(out_dir, exist_ok=True)
    for file in os.listdir(input_dir):
        if not file.endswith(".json"):
            continue
        
        handle_sructure(os.path.join(input_dir, file), out_dir)