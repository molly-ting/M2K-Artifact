import os, json

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

def checkOutExist(op_name, item):
    path1 = f"./input/{op_name}.json"
    path2 = f"./input-max/{op_name}.json"
    path3 = f"./vllm-exp/input/{op_name}.json"
    
    if os.path.exists(path1):
        with open(path1) as f1:
            data = json.load(f1)
        for d in data:
            if remove_ignored(d) == remove_ignored(item):
                return True
        # if item in data:
        #     return True
    
    if os.path.exists(path2):
        with open(path2) as f2:
            data = json.load(f2)
        for d in data:
            if remove_ignored(d) == remove_ignored(item):
                return True
    
    if os.path.exists(path3):
        with open(path3) as f3:
            data = json.load(f3)
        for d in data:
            if remove_ignored(d) == remove_ignored(item):
                return True
            
    return False

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

def get_token_limit(modelId):
    modelId = modelId.replace('_', '/', 1)
    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    if modelId in structure_model_map:
        structure = structure_model_map[modelId]
    else:
        print(f"{modelId} not found in structure map.")
        return None

    config_example_path = os.path.join("./vllm-configs-examples", structure+".json")
    with open(config_example_path, "r") as f:
        config_example = json.load(f)
    
    max_token = None
    for key in possible_len_keys:
        if key in config_example:
            if not max_token:
                max_token = config_example[key]
            elif config_example[key]:
                max_token = min(max_token, config_example[key])

    if not max_token and "llm_config" in config_example:
        llm_config = config_example["llm_config"]
        for key in possible_len_keys:
            if key in llm_config:
                if not max_token:
                    max_token = llm_config[key]
                elif llm_config[key]:
                    max_token = min(max_token, llm_config[key])
                    
    if not max_token:
        print(f"No token limit key found for {modelId}, {structure} in config example.")
    return max_token

def generate_input_one(filepath, kernel_map, res, ignore_max=True, max_token=None):    
    if not os.path.exists(filepath):
        return
    with open(filepath) as f:
        data  = json.load(f)
    
    for func_name in data:
        if not "vllm." in func_name:
            continue
        
        py_func_name = func_name.split(".")[-1]
        if py_func_name in kernel_map:
            cuda_func = kernel_map[py_func_name]["func_name"]
            file_path = kernel_map[py_func_name]["file_path"]
            cuda_file_name = file_path.split("/")[-1]
            cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
            parent_dir = file_path.split("/")[-2]
            if parent_dir != "csrc":
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+parent_dir+"_"+cuda_file_name
            else:
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+cuda_file_name
            
            for argCons in data[func_name]:
                if cuda_func not in res:
                    res[cuda_func] = []
                tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": argCons}
                if max_token:
                    tmp["num_token"] = max_token
                    
                isExist = False
                for i in res[cuda_func]:
                    if ignore_max:
                        if remove_ignored(tmp) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if tmp == i:
                            isExist = True
                            break
                if not isExist:
                # if not isExist and not checkOutExist(cuda_func, tmp):
                    res[cuda_func].append(tmp)
        elif py_func_name not in ["varlen_fwd", "fwd_kvcache", "fwd_kvcache_mla", "get_mla_metadata"]:
            print(py_func_name)
    return res
    
def generate_input_batch(ignore_max=True, outdir=None):
    with open("/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    if not outdir:
        outdir = "./vllm-exp/input"
    os.makedirs(outdir, exist_ok=True)
    res = {} 
    
    readDir = "./vllm-exp/out"
    for file in os.listdir(readDir):
        if not file.endswith(".json"):
            continue
        name = file[:-5]       
        max_token = get_token_limit(name) 
        generate_input_one(readDir+"/"+file, kernel_map, res, ignore_max, max_token)
        
        if not os.path.exists(readDir+"/"+name):
            continue
        
        for opfile in os.listdir(readDir+"/"+name):
            generate_input_one(readDir+"/"+name+"/"+opfile, kernel_map, res, ignore_max, max_token)
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        # write_data.extend(res[func])
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                isExist = False
                for i in write_data:
                    if ignore_max:
                        if remove_ignored(item) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if item == i:
                            isExist = True
                            break
                if not isExist:
                # if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

def generate_input_one_load(filepath, kernel_map, res, ignore_max=True):    
    if not os.path.exists(filepath):
        return
    with open(filepath) as f:
        data  = json.load(f)
    
    for item in data:
        if not "vllm." in item["name"]:
            continue
        
        py_func_name = item["name"].split(".")[-1]
        
        if py_func_name in kernel_map:
            cuda_func = kernel_map[py_func_name]["func_name"]
            if os.path.exists("./vllm-exp/input/"+cuda_func+".json"):
                continue

            file_path = kernel_map[py_func_name]["file_path"]
            cuda_file_name = file_path.split("/")[-1]
            cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
            parent_dir = file_path.split("/")[-2]
            if parent_dir != "csrc":
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+parent_dir+"_"+cuda_file_name
            else:
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+cuda_file_name
            
            if cuda_func not in res:
                res[cuda_func] = []
            tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": item["args"]}
            isExist = False
            for i in res[cuda_func]:
                if ignore_max:
                    if remove_ignored(tmp) == remove_ignored(i):
                        isExist = True
                        break
                else:
                    if tmp == i:
                        isExist = True
                        break
            if not isExist:
                res[cuda_func].append(tmp)
        elif py_func_name not in ["varlen_fwd", "fwd_kvcache", "fwd_kvcache_mla", "get_mla_metadata"]:
            print(py_func_name)
    return res

def generate_input_load_batch(ignore_max=True, outdir=None):
    with open("/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    if not outdir:
        outdir = "./vllm-exp/input"
    os.makedirs(outdir, exist_ok=True)
    res = {} 
    
    readDir = "./vllm-exp/load"
    for file in os.listdir(readDir):
        if not file.endswith(".json"):
            continue
        name = file.split(".")[0]        
        generate_input_one_load(readDir+"/"+file, kernel_map, res, ignore_max)
        
        if not os.path.exists(readDir+"/"+name):
            print(readDir+"/"+name, "not exist")
            continue
        
        for opfile in os.listdir(readDir+"/"+name):
            generate_input_one_load(readDir+"/"+name+"/"+opfile, kernel_map, res, ignore_max)
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        # write_data.extend(res[func])
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                isExist = False
                for i in write_data:
                    if ignore_max:
                        if remove_ignored(item) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if item == i:
                            isExist = True
                            break
                if not isExist:
                # if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)
        
def generate_input_incre(name, ignore_max=True, outdir=None):
    with open("/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    if not outdir:
        outdir = "./vllm-exp/input"
    os.makedirs(outdir, exist_ok=True)
    res = {} 
    
    readDir = "./vllm-exp/out"
    generate_input_one(readDir+"/"+name+".json", kernel_map, res, ignore_max)
    for opfile in os.listdir(readDir+"/"+name):
        generate_input_one(readDir+"/"+name+"/"+opfile, kernel_map, res, ignore_max)
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        # write_data.extend(res[func])
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                isExist = False
                for i in write_data:
                    if ignore_max:
                        if remove_ignored(item) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if item == i:
                            isExist = True
                            break
                if not isExist:
                # if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

def generate_op(op_name, ignore_max=True, outdir=None):
    with open("/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    if not outdir:
        outdir = "./vllm-exp/input"
    os.makedirs(outdir, exist_ok=True)
    res = []
    cuda_func = ""
    
    readDir = "./vllm-exp/out"
    for file in os.listdir(readDir):
        if file.endswith(".json"):
            continue
        
        target_path = f"{readDir}/{file}/{op_name}.json"
        if not os.path.exists(target_path):
            continue
        
        with open(target_path) as f:
            data  = json.load(f)
        
        for func_name in data:
            if not "vllm." in func_name:
                continue
            if op_name != func_name.split(".")[-1]:
                continue

            cuda_func = kernel_map[op_name]["func_name"]
            file_path = kernel_map[op_name]["file_path"]
            cuda_file_name = file_path.split("/")[-1]
            cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
            parent_dir = file_path.split("/")[-2]
            if parent_dir != "csrc":
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+parent_dir+"_"+cuda_file_name
            else:
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_compile/"+cuda_file_name
            
            for argCons in data[func_name]:
                tmp = {"py_function": op_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": argCons}
                isExist = False
                for i in res:
                    if ignore_max:
                        if remove_ignored(tmp) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if tmp == i:
                            isExist = True
                            break
                if not isExist:
                # if not isExist and not checkOutExist(cuda_func, tmp):
                    res.append(tmp)
    
    out_filepath = outdir+"/"+cuda_func+".json"
    # write_data = []
    # if os.path.exists(out_filepath):
    #     with open(out_filepath, "r") as rf:
    #         write_data = json.load(rf)
    
    # if not write_data:
    #     write_data = res
    # else:
    #     for item in res:
    #         isExist = False
    #         for i in write_data:
    #             if remove_ignored(item) == remove_ignored(i):
    #                 isExist = True
    #                 break
    #         if not isExist:
    #         # if item not in write_data:
    #             write_data.append(item)
            
    with open(out_filepath, "w") as wf:
        json.dump(res, wf, indent=4)

# generate_op("paged_attention_v1")
# generate_op("paged_attention_v2")

# for name in ["baichuan-inc_Baichuan-7B", "bigscience_bloom-560m", "deepseek-ai_DeepSeek-V2-Lite-Chat", "ibm-ai-platform_Bamba-9B"]:
#     generate_input_incre(name)

# readDir = "./vllm-exp/out"
# for file in os.listdir(readDir):
#     if os.path.isdir(os.path.join(readDir, file)):
#         if file.startswith("facebook") or file.startswith("mistral") or file.startswith("bigcode") or file.startswith("in"):
#             continue
#         if file in handled:
#             print(file, "already handled")
#             continue
#         print(file)
#         generate_input_incre(file)
    
# generate_input_load_batch(True, "./vllm-exp/input-load")     
# generate_input_load_batch(False, "./vllm-exp/input-load-all")       
# generate_input_incre("baichuan-inc_Baichuan-7B")
# generate_input_batch(False, "./vllm-exp/input-all")
generate_input_batch(True, "./vllm-exp/input-new")

def add_all():
    for file in os.listdir("./vllm-exp/input-all"):
        with open("./vllm-exp/input-all/"+file) as af:
            data0 = json.load(af)
        with open("./vllm-exp/input/"+file) as of:
            data1 = json.load(of)
        
        for item in data0:
            if item not in data1:
                data1.append(item)
        
        with open("./vllm-exp/input/"+file, "w") as wf:
            json.dump(data1, wf, indent=4)

def compare_input_max(dir1, dir2):
    for file in os.listdir(dir1):
        with open(dir1+"/"+file) as of:
            data0 = json.load(of)
        data1 = []
        if os.path.exists(dir2+"/"+file):
            with open(dir2+"/"+file) as nf:
                data1 = json.load(nf)
        
        print(file, len(data0), len(data1))

# compare_input_max("./vllm-e/xp/input-load", "./vllm-exp/input-load-all")
# compare_input_max("./vllm-exp/input", "./vllm-exp/input-max")
# add_all()

# mgalkin_ultra_3g
def generate_input_ultra(model_id, outdir=None):
    if not outdir:
        outdir = "./hf-exp/input"
        os.makedirs(outdir, exist_ok=True)

    # outdir = os.path.join(outdir, model_id)
    # os.makedirs(outdir, exist_ok=True)

    with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_{model_id}.json") as rf:
        kernel_map = json.load(rf)
    
    res = {}
    for file in os.listdir("./hf-exp/out/"+model_id):
        with open("./hf-exp/out/"+model_id+"/"+file) as rf:
            data = json.load(rf)
        
        for item in data:
            for call in item["calls"]:
                func_name = call["name"]
                if "::" in func_name:
                    py_func_name = func_name.split("::")[-1]
                else:
                    py_func_name = func_name
                cuda_func = kernel_map[py_func_name]["func_name"]
                file_path = kernel_map[py_func_name]["file_path"]
                cuda_file_name = file_path.split("/")[-1]
                cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/huggingface/mgalkin_ultra_3g/" + cuda_file_name

                if cuda_func not in res:
                    res[cuda_func] = []
                tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": call["args"]}
                if not tmp in res[cuda_func]:
                    res[cuda_func].append(tmp)   
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

# Qwen_Qwen-7B-Chat
# chinoll_chatsakura-3b-int4
def generate_one_hf(model_id, outdir=None):
    if model_id.startswith("mgalkin"):
        generate_input_ultra(model_id, outdir)
        return

    if not outdir:
        outdir = "./hf-exp/input"
        os.makedirs(outdir, exist_ok=True)

    # outdir = os.path.join(outdir, model_id)
    # os.makedirs(outdir, exist_ok=True)

    with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_{model_id}.json") as rf:
        kernel_map = json.load(rf)
    
    res = {}
    for file in os.listdir("./hf-exp/out/"+model_id):
        with open("./hf-exp/out/"+model_id+"/"+file) as rf:
            data = json.load(rf)
        
        for func_name in data:
            if "::" in func_name:
                py_func_name = func_name.split("::")[-1]
            else:
                py_func_name = func_name
            cuda_func = kernel_map[py_func_name]["func_name"]
            file_path = kernel_map[py_func_name]["file_path"]
            cuda_file_name = file_path.split("/")[-1]
            cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
            if model_id.startswith("chinoll"):
                model_sepc = "chinoll_chatsakura-3b-int4"
            else:
                model_sepc = "Qwen_Qwen-7B-Chat"
            input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/huggingface/" + model_sepc + "/" + cuda_file_name
                
            for argCons in data[func_name]:
                if cuda_func not in res:
                    res[cuda_func] = []
                tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": argCons}
                if not tmp in res[cuda_func]:
                    res[cuda_func].append(tmp)
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

def generate_hf(outdir=None):
    if not outdir:
        outdir = "./hf-exp/input"
    os.makedirs(outdir, exist_ok=True)

    for file in os.listdir("./hf-exp/out"):
        if file.endswith(".json"):
            continue
        if not file.startswith("mgalkin"):
            continue
        generate_one_hf(file, outdir)

def hf_add_init():
    outdir = "./hf-exp/input"
    # res = {}
    # with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_chinoll_chatsakura-3b-int4.json") as rf:
    #     kernel_map = json.load(rf)

    # for file in ["./hf-exp/out/chinoll_chatsakura-3b-int4.json", "./hf-exp/out/chinoll_chatsakura-3b-int8.json"]:
    #     with open(file) as rf:
    #         data = json.load(rf)

    #     for func_name in data:
    #         if "::" in func_name:
    #             py_func_name = func_name.split("::")[-1]
    #         else:
    #             py_func_name = func_name
    #         cuda_func = kernel_map[py_func_name]["func_name"]
    #         file_path = kernel_map[py_func_name]["file_path"]
    #         cuda_file_name = file_path.split("/")[-1]
    #         cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
    #         input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/huggingface/chinoll_chatsakura-3b-int4/" + cuda_file_name
                
    #         for argCons in data[func_name]:
    #             if cuda_func not in res:
    #                 res[cuda_func] = []
    #             tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": argCons}
    #             if not tmp in res[cuda_func]:
    #                 res[cuda_func].append(tmp)
    
    # for func in res:    
    #     out_filepath = outdir+"/"+func+".json"
    #     write_data = []
    #     if os.path.exists(out_filepath):
    #         with open(out_filepath, "r") as rf:
    #             write_data = json.load(rf)
        
    #     if not write_data:
    #         write_data = res[func]
    #     else:
    #         for item in res[func]:
    #             if item not in write_data:
    #                 write_data.append(item)
                
    #     with open(out_filepath, "w") as wf:
    #         json.dump(write_data, wf, indent=4)
    
    with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_mgalkin_ultra_3g.json") as rf:
        kernel_map = json.load(rf)

    res = {}
    for file in ["./hf-exp/out/mgalkin_ultra_3g.json","./hf-exp/out/mgalkin_ultra_4g.json","./hf-exp/out/mgalkin_ultra_50g.json"]:
        with open(file) as rf:
            data = json.load(rf)
        
        for item in data:
            for call in item["calls"]:
                func_name = call["name"]
                if "::" in func_name:
                    py_func_name = func_name.split("::")[-1]
                else:
                    py_func_name = func_name
                cuda_func = kernel_map[py_func_name]["func_name"]
                file_path = kernel_map[py_func_name]["file_path"]
                cuda_file_name = file_path.split("/")[-1]
                cuda_file_name = cuda_file_name[:-3]+"_combined.bc"
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/huggingface/mgalkin_ultra_3g/" + cuda_file_name

                if cuda_func not in res:
                    res[cuda_func] = []
                tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": call["args"]}
                if not tmp in res[cuda_func]:
                    res[cuda_func].append(tmp)   
    
    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

def generate_input_shiftadd(filepath, res, ignore_max=True):    
    with open(filepath) as rf:
        data = json.load(rf)
    
    for item in data:
        for call in item["calls"]:
            func_name = call["name"]
            py_func_name = func_name
            if func_name == "lutgemm_compute_block_shiftInt8":
                cuda_func = "lutgemm_block_shiftInt8_cuda"
                input_file_path = "/home/mvh6224/CUDA-BOSolver/scripts/papers/ShiftAddLLM/lutgemm_cuda_kernel_combined.bc"

                if cuda_func not in res:
                    res[cuda_func] = []
                tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": call["args"]}
                isExist = False
                for i in res[cuda_func]:
                    if ignore_max:
                        if remove_ignored(tmp) == remove_ignored(i):
                            isExist = True
                            break
                    else:
                        if tmp == i:
                            isExist = True
                            break
                if not isExist:
                    res[cuda_func].append(tmp)
            else:
                print("miss", func_name)
    return res

# any-precision-llm.json, /home/mvh6224/CUDA-BOSolver/scripts/papers/any-precision-llm/main_combined.bc
# pv-tuning.json, /home/mvh6224/CUDA-BOSolver/scripts/papers/AQLM/cuda_kernel_combined.bc
# /home/mvh6224/CUDA-BOSolver/scripts/papers/Mixture-Compressor-MoE/hqq_aten_cuda_kernel_combined.bc
def generate_input_rs(filepath, bcpath, res, ignore_max=False):
    with open(filepath) as rf:
        data = json.load(rf)
    
    for func_name in data:
        real_func_name = func_name
        if "::" in real_func_name:
            real_func_name = real_func_name.split("::")[-1]
        if "." in real_func_name:
            real_func_name = real_func_name.split(".")[-1]
        py_func_name = real_func_name
        cuda_func = real_func_name
        input_file_path = bcpath

        if cuda_func not in res:
            res[cuda_func] = []

        for call in data[func_name]:
            tmp = {"py_function": py_func_name, "cuda_function": cuda_func, "input_file_path": input_file_path, "args": call}
            isExist = False
            for i in res[cuda_func]:
                if ignore_max:
                    if remove_ignored(tmp) == remove_ignored(i):
                        isExist = True
                        break
                else:
                    if tmp == i:
                        isExist = True
                        break
            if not isExist:
                res[cuda_func].append(tmp)

    return res

def generate_input_rs_batch(ignore_max=True, outdir=None):
    if not outdir:
        outdir = "./rs-exp/input"
    os.makedirs(outdir, exist_ok=True)

    res = {}
    # generate_input_shiftadd("./rs-exp/out/ShiftAddLLM.json", res, ignore_max=ignore_max)
    # for file in os.listdir("./rs-exp/out/ShiftAddLLM"):
    #     generate_input_shiftadd("./rs-exp/out/ShiftAddLLM/"+file, res, ignore_max=ignore_max)   
    
    # generate_input_rs("./rs-exp/out/AQLM.json", "/home/mvh6224/CUDA-BOSolver/scripts/papers/AQLM/cuda_kernel_combined.bc", res)
    # for file in os.listdir("./rs-exp/out/AQLM"):
    #     generate_input_rs("./rs-exp/out/AQLM/"+file, "/home/mvh6224/CUDA-BOSolver/scripts/papers/AQLM/cuda_kernel_combined.bc", res)

    # generate_input_rs("./rs-exp/out/Mixture-Compressor-MoE.json", "/home/mvh6224/CUDA-BOSolver/scripts/papers/Mixture-Compressor-MoE/hqq_aten_cuda_kernel_combined.bc", res)
    # for file in os.listdir("./rs-exp/out/Mixture-Compressor-MoE"):
    #     generate_input_rs("./rs-exp/out/Mixture-Compressor-MoE/"+file, "/home/mvh6224/CUDA-BOSolver/scripts/papers/Mixture-Compressor-MoE/hqq_aten_cuda_kernel_combined.bc", res)

    generate_input_rs("./rs-exp/out/any-precision-llm.json", "/home/mvh6224/CUDA-BOSolver/scripts/papers/any-precision-llm/main_combined.bc",  res, ignore_max=ignore_max)
    # for file in os.listdir("./rs-exp/out/any-precision-llm"):
    #     generate_input_rs("./rs-exp/out/any-precision-llm/"+file, "/home/mvh6224/CUDA-BOSolver/scripts/papers/any-precision-llm/main_combined.bc",  res)

    for func in res:    
        out_filepath = outdir+"/"+func+".json"
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath, "r") as rf:
                write_data = json.load(rf)
        
        if not write_data:
            write_data = res[func]
        else:
            for item in res[func]:
                if item not in write_data:
                    write_data.append(item)
                
        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

# generate_hf()
# hf_add_init()
# generate_input_rs_batch(True)
# generate_input_rs_batch(False, "./rs-exp/input-all")
# compare_input_max("./rs-exp/input", "./rs-exp/input-all")


def compare_diff():
    res = {}
    for model_id in os.listdir("./hf-exp/input"):
        for file in os.listdir("./hf-exp/input/"+model_id):
            with open("./hf-exp/input/"+model_id+"/"+file) as nf:
                data0 = json.load(nf)
        
            for item in data0:
                func = item["cuda_function"]
                if func not in res:
                    res[func] = []
                res[func].append(item)
    
    missed = {}
    new = {}
    for func in res:
        if not os.path.exists("./hfinput/"+func+".json"):
            new[func] = res[func]
            continue
        with open("./hfinput/"+func+".json") as of:
            data1 = json.load(of)
        for item in data1:
            if item not in res[func]:
                if func not in missed:
                    missed[func] = []
                missed[func].append(item)

        for item in res[func]:
            if item not in data1:
                if func not in new:
                    new[func] = []
                new[func].append(item)
    
    if missed:
        with open("./hf-exp/missed.json", "w") as mf:
            json.dump(missed, mf, indent=4)
    if new:
        with open("./hf-exp/new.json", "w") as nf:
            json.dump(new, nf, indent=4)

# compare_diff()


from datetime import datetime
import shutil

# out_dir = "./vllm-exp/stat"
# read_dir = "/data/mvh6224-home/vllm_exp_out"
def sum_res(out_dir, read_dir):
    # out_dir = "./vllm-exp/stat"
    os.makedirs(out_dir, exist_ok=True)
    # read_dir = "/data/mvh6224-home/vllm_exp_out"
    fmt = "%Y-%m-%d %H:%M:%S"
    for func_name in os.listdir(read_dir):
        if os.path.exists(out_dir+"/"+func_name+".json"):
            continue

        res = {}
        io_bugs = set()
        oob_bugs = set()
        dr_bugs = set()
        all_path = 0
        for ke in os.listdir(read_dir+"/"+func_name):
            if not ke.startswith("klee-out-jindex-"):
                continue
            index = int(ke.split("-")[3])

            info_file = read_dir+"/"+func_name+"/"+ke+"/info"
            with open(info_file) as f:
                data = f.readlines()
            total_path = 0
            complete_path = 0
            z3_queries = 0
            instructions = 0
            start_time, end_time = 0, 0
            for line in data:
                if line.startswith("Started:"):
                    start_time = datetime.strptime(line.split("Started:")[1].strip(), fmt)
                if line.startswith("Finished"):
                    end_time = datetime.strptime(line.split("Finished:")[1].strip(), fmt)
                if line.startswith("KLEE: done: explored paths"):
                    total_path = int(line.split("=")[1].strip())
                if line.startswith("KLEE: done: total queries"):
                    z3_queries = int(line.split("=")[1].strip())
                if line.startswith("KLEE: done: completed paths"):
                    complete_path = int(line.split("=")[1].strip())
                    all_path += complete_path
                if line.startswith("KLEE: done: total instructions"):
                    instructions = int(line.split("=")[1].strip())
            # if not end_time:
            #     res[index] = None
            #     continue
            # if not instructions:
            #     res[index] = None
            #     continue 
            if not end_time:
                time_cost = 0
            else:
                time_cost = end_time-start_time
                time_cost = time_cost.total_seconds()
            res[index] = {"time": time_cost, "total_path": total_path, "complete_path": complete_path, "instructions": instructions, "z3_queries": z3_queries}

            tmp_io_bugs = set()
            tmp_oob_bugs = set()
            tmp_dr_bugs = set()
            for file in os.listdir(read_dir+"/"+func_name+"/"+ke):
                if file.endswith("_io.txt"):
                    tmp_io_bugs.add(file.split(".")[0])
                if file.endswith("_oob.txt"):
                    tmp_oob_bugs.add(file.split(".")[0])
                if file.endswith("_dr.txt"):
                    tmp_dr_bugs.add(file.split(".")[0])
            io_bugs.update(tmp_io_bugs)
            oob_bugs.update(tmp_oob_bugs)
            dr_bugs.update(tmp_dr_bugs)
            res[index]["io"] = list(tmp_io_bugs)
            res[index]["oob"] = list(tmp_oob_bugs)
            res[index]["dr"] = list(tmp_dr_bugs)
        
        res["total"] = {"io": list(io_bugs), "oob": list(oob_bugs), "dr": list(dr_bugs), "path": all_path}
        with open(out_dir+"/"+func_name+".json", "w") as wf:
            json.dump(res, wf, indent=4)

def countMaxTime():
    max_time = 5253.0
    min_time = 0.0
    time_map = {}
    for file in os.listdir("./vllm-exp/stat"):
        with open("./vllm-exp/stat/"+file) as rf:
            data = json.load(rf)
        
        tmp_max = 0
        for key in data:
            if key == "total":
                continue
            if data[key] is None:
                continue
            if "time" in data[key]:
                if data[key]["time"] > tmp_max:
                    tmp_max = data[key]["time"]
                if data[key]["time"] < min_time or min_time == 0.0:
                    min_time = data[key]["time"]
        if tmp_max == 0:
            print("zero max time:", file)
        time_map[file] = tmp_max
    
    count = 1
    max_name = ""
    total_time = 0
    for key in time_map:
        if time_map[key] > 0:
            count += 1
            total_time += time_map[key]

        if time_map[key] > max_time:
            max_time = time_map[key]
            max_name = key
    
    print("max time:", max_time, "in", max_name)
    print("min time:", min_time)
    print("count:", count, "length", len(time_map))
    print("avg time:", total_time/count)
    for key in time_map:
        print(key.split(".")[0], time_map[key])

# countMaxTime()
# sum_res(out_dir="./vllm-exp/stat", read_dir="/data/mvh6224-home/vllm_exp_out")
# sum_res(out_dir="./vllm-exp/stat", read_dir="/data/mvh6224-home/vllm_exp_out")
# sum_res(out_dir="./hf-exp/stat", read_dir="/data/mvh6224-home/hf_exp_out")

# file_path = f"./vllm-exp/input/{op_name}.json"
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

import re
def matches_pattern(str1, str2):
    pattern = rf".*[0-9]{re.escape(str2)}[A-Z].*"
    return re.fullmatch(pattern, str1) is not None

def find_index_bug(index, op_name, stat_dir):
    for file in os.listdir(stat_dir):
        if not file.endswith(".json"):
            continue
        if not op_name in file:
            continue

        if not matches_pattern(file.split(".")[0], op_name):
            continue

        with open(stat_dir+"/"+file) as rf:
            data = json.load(rf)
        
        for key in data:
            if key == "total":
                continue
            if int(key) == index:
                return data[key]

def count_one_model_file(res, kernel_map, model_file, input_dir, stat_dir, ignored=None):
    with open(model_file) as rf:
        data = json.load(rf)
    
    if "mgalkin" in model_file and "ultra" in model_file:
        for item in data:
            for call in item["calls"]:
                func_name = call["name"]
                if "::" in func_name:
                    py_func_name = func_name.split("::")[-1]
                else:
                    py_func_name = func_name
                op_name = py_func_name
                if op_name not in res:
                    res[op_name] = {}
                cuda_func = kernel_map[op_name]["func_name"]

                index = locate_index(call["args"], input_dir+"/"+cuda_func+".json", ignored)
                if index >= 0:
                    bugs = find_index_bug(index, cuda_func, stat_dir)
                    res[op_name][index] = bugs
                    if "total" not in res[op_name]:
                        res[op_name]["total"] = {"io": [], "oob": [], "dr": []}
                    if bugs:
                        for bug_type in ["io", "oob", "dr"]:
                            for bug in bugs.get(bug_type, []):
                                if bug not in res[op_name]["total"][bug_type]:
                                    res[op_name]["total"][bug_type].append(bug)
    elif isinstance(data, dict):
        for key in data:
            op_name = key.split(".")[-1]
            if op_name not in res:
                res[op_name] = {}
            if op_name not in kernel_map:
                print(op_name, "not in kernel_map")
                continue
            cuda_func = kernel_map[op_name]["func_name"]

            i=0
            for item in data[key]:
                index = locate_index(item, input_dir+"/"+cuda_func+".json", ignored)
                if op_name == "gather_cache":
                    index = 0
                if index >= 0:
                    bugs = find_index_bug(index, cuda_func, stat_dir)
                    res[op_name][index] = bugs
                    if "total" not in res[op_name]:
                        res[op_name]["total"] = {"io": [], "oob": [], "dr": []}
                    if bugs:
                        for bug_type in ["io", "oob", "dr"]:
                            for bug in bugs.get(bug_type, []):
                                if bug not in res[op_name]["total"][bug_type]:
                                    res[op_name]["total"][bug_type].append(bug)
                else:
                    print(op_name, f"[{i}]", "in", model_file, " resIndex:", index)
                i += 1
    elif isinstance(data, list):
        i=0
        for item in data:
            op_name = item['name'].split(".")[-1]
            if op_name not in res:
                res[op_name] = {}
            if op_name not in kernel_map:
                print(op_name, "not in kernel_map")
                continue
            cuda_func = kernel_map[op_name]["func_name"]

            index = locate_index(item["args"], input_dir+"/"+cuda_func+".json", ignored)
            if index >= 0:
                bugs = find_index_bug(index, cuda_func, stat_dir)
                res[op_name][index] = bugs
                if "total" not in res[op_name]:
                    res[op_name]["total"] = {"io": [], "oob": [], "dr": []}
                if bugs:
                    for bug_type in ["io", "oob", "dr"]:
                        for bug in bugs.get(bug_type, []):
                            if bug not in res[op_name]["total"][bug_type]:
                                res[op_name]["total"][bug_type].append(bug)
            else:
                print(op_name, f"[{i}]", "in", model_file, " resIndex:", index)
            i += 1

def model2bugs(read_dir, out_dir, input_dir, stat_dir, ignored=None):
    # read_dir = "./vllm-exp/out"
    os.makedirs(out_dir, exist_ok=True)

    if "vllm" in read_dir:
        with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
            kernel_map = json.load(rf)
        
    for model_id in os.listdir(read_dir):
        res = {}
        real_model_id = model_id[:-5] if model_id.endswith(".json") else model_id

        if not "vllm" in read_dir:
            with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_{real_model_id}.json") as rf:
                kernel_map = json.load(rf)

        if model_id.endswith(".json"):
            count_one_model_file(res, kernel_map, read_dir+"/"+model_id, input_dir, stat_dir, ignored)

            if os.path.exists(read_dir+"/"+real_model_id):
                for file in os.listdir(read_dir+"/"+real_model_id):
                    count_one_model_file(res, kernel_map, read_dir+"/"+real_model_id+"/"+file, input_dir, stat_dir, ignored)
        else:
            if not os.path.exists(read_dir+"/"+model_id+".json"):
                for file in os.listdir(read_dir+"/"+real_model_id):
                    count_one_model_file(res, kernel_map, read_dir+"/"+real_model_id+"/"+file, input_dir, stat_dir, ignored)
            else:
                continue
        
        # out_path = f"./vllm-exp/model_bug_stat/{model_id}.json"
        out_path = os.path.join(out_dir, real_model_id + ".json")
        existing_data = {}
        if os.path.exists(out_path):
            with open(out_path) as rf:
                existing_data = json.load(rf)
        
        for op_name in res:
            if op_name not in existing_data:
                existing_data[op_name] = res[op_name]

        with open(out_path, "w") as wf:
            json.dump(existing_data, wf, indent=4)

# model2bugs("./hf-exp/out", "./hf-exp/model_bug_stat", "./hf-exp/input", "./hf-exp/stat")
# model2bugs("./vllm-exp/out", "./vllm-exp/model_bug_stat", "./vllm-exp/input", "./vllm-exp/stat", vllm_ignored)
# model2bugs("./vllm-exp/load", "./vllm-exp/model_bug_stat", "./vllm-exp/input-load", "./vllm-exp/stat", vllm_ignored)

def computeInitialBugStats():
    read_dir = "./vllm-exp/out"
    with open(f"/home/mvh6224/CUDA-BOSolver/libanalyzer/kernel_map_vllm.json") as rf:
        kernel_map = json.load(rf)
    
    models = []
    res = {}
    for model_id in os.listdir(read_dir):
        if model_id.endswith(".json"):
            continue

        if not os.path.exists(read_dir+"/"+model_id+".json"):
            print("miss model file:", model_id)
        
        models.append(model_id)
        with open(read_dir+"/"+model_id+".json") as rf:
            data = json.load(rf)
        
        for key in data:
            op_name = key.split(".")[-1]
            if op_name not in kernel_map:
                continue

            if op_name not in res:
                res[op_name] = {"io": set(), "oob": set(), "dr": set()}
                
            for item in data[key]:
                cuda_func = kernel_map[op_name]["func_name"]

                index = locate_index(item, "./vllm-exp/input/"+cuda_func+".json", vllm_ignored)
                if op_name == "gather_cache":
                    index = 0
                if index >= 0:
                    bugs = find_index_bug(index, cuda_func, "./vllm-exp/stat")
                    if bugs:
                        for bug_type in ["io", "oob", "dr"]:
                            for bug in bugs.get(bug_type, []):
                                res[op_name][bug_type].add(bug)
                else:       
                    print(op_name, "in", model_id, " resIndex:", index)

    load_dir = "./vllm-exp/load"
    for model_id in os.listdir(load_dir): 
        if model_id.endswith(".json"):
            continue

        if not model_id in models:
            continue

        if not os.path.exists(load_dir+"/"+model_id+".json"):
            print("miss model file:", model_id)
        
        with open(load_dir+"/"+model_id+".json") as rf:
            data = json.load(rf)
        
        for item in data:
            op_name = item['name'].split(".")[-1]
            if op_name not in kernel_map:
                continue

            if op_name not in res:
                res[op_name] = {"io": set(), "oob": set(), "dr": set()}
            cuda_func = kernel_map[op_name]["func_name"]

            index = locate_index(item["args"], load_dir+"/"+cuda_func+".json", vllm_ignored)
            if index >= 0:
                bugs = find_index_bug(index, cuda_func, "./vllm-exp/stat")
                if bugs:
                    for bug_type in ["io", "oob", "dr"]:
                        for bug in bugs.get(bug_type, []):
                            res[op_name][bug_type].add(bug)
    
    with open("./vllm-exp/bug_info.json") as f:
        bug_info = json.load(f)
    
    new_res = {}
    for op_name in res:
        if op_name not in new_res:
            new_res[op_name] = {}
        for bug_type in ["io", "oob", "dr"]:
            bug_list = list(res[op_name][bug_type])
            tp_list = bug_list
            fp_list = []
            if op_name in bug_info:
                if "ignore" in bug_info[op_name]:
                    bug_list = [bug for bug in bug_list if bug not in bug_info[op_name]["ignore"]]
                    tp_list = bug_list
                if "FP" in bug_info[op_name]:
                    tp_list = [bug for bug in bug_list if bug not in bug_info[op_name]["FP"]]
                    fp_list = [bug for bug in bug_list if bug in bug_info[op_name]["FP"]]
            if bug_type not in new_res[op_name]:    
                new_res[op_name][bug_type] = {"TP": tp_list, "FP": fp_list}
            else:
                new_res[op_name][bug_type]["TP"] = list(set(new_res[op_name][bug_type]["TP"] + tp_list))
                new_res[op_name][bug_type]["FP"] = list(set(new_res[op_name][bug_type]["FP"] + fp_list))
            
    with open("./vllm-exp/initial_bugs.json", "w") as wf:
        json.dump(new_res, wf, indent=4)
    
    with open("./vllm-exp/TP_count.json") as rf:
        tp_count = json.load(rf)
    with open("./vllm-exp/FP_count.json") as f:
        fp_count = json.load(f)

    io_tp_total = 0
    oob_tp_total = 0
    io_fp_total = 0
    oob_fp_total = 0
    for op_name in new_res:
        io_tp = len(new_res[op_name]["io"]["TP"])
        oob_tp = len(new_res[op_name]["oob"]["TP"])
        io_fp = len(new_res[op_name]["io"]["FP"])
        oob_fp = len(new_res[op_name]["oob"]["FP"])

        if op_name in tp_count:
            if "io" in tp_count[op_name]:
                io_tp = min(io_tp, tp_count[op_name]["io"])
            if "oob" in tp_count[op_name]:
                oob_tp = min(oob_tp, tp_count[op_name]["oob"])
        
        if op_name in fp_count:
            if "io" in fp_count[op_name]:
                io_fp = min(io_fp, fp_count[op_name]["io"])
            if "oob" in fp_count[op_name]:
                oob_fp = min(oob_fp, fp_count[op_name]["oob"])
        
        io_tp_total += io_tp
        oob_tp_total += oob_tp
        io_fp_total += io_fp
        oob_fp_total += oob_fp
        print(f"{op_name}: IO TP: {io_tp}, IO FP: {io_fp}, OOB TP: {oob_tp}, OOB FP: {oob_fp}")

    print(f"Total: IO TP: {io_tp_total}, IO FP: {io_fp_total}, OOB TP: {oob_tp_total}, OOB FP: {oob_fp_total}")

# computeInitialBugStats()

def modelResVllm():
    with open("./vllm-exp/bug_info.json") as rf:
        bug_info = json.load(rf)
    
    with open("./vllm-exp/TP_count.json") as f: 
        tp_count = json.load(f)

    res = {}
    for file in os.listdir("./vllm-exp/model_bug_stat"):
        with open("./vllm-exp/model_bug_stat/"+file) as rf:
            data = json.load(rf)
        
        total_io = 0
        total_oob = 0
        total_time = 0
        avg_time = 0.0
        valid_count = 0
        timeout_num = 0
        for op_name in data:
            for index in data[op_name]:
                if index == "total":
                    tmp_io = set(data[op_name]["total"].get("io", []))
                    tmp_oob = set(data[op_name]["total"].get("oob", []))
                    if op_name in bug_info:
                        if "ignore" in bug_info[op_name]:
                            tmp_io -= set(bug_info[op_name]["ignore"])
                            tmp_oob -= set(bug_info[op_name]["ignore"])
                        if "FP" in bug_info[op_name]:
                            tmp_io -= set(bug_info[op_name]["FP"])
                            tmp_oob -= set(bug_info[op_name]["FP"])
                    if op_name in tp_count and "io" in tp_count[op_name] and tp_count[op_name]["io"] < len(tmp_io):
                        total_io += tp_count[op_name]["io"]
                    else:
                        total_io += len(tmp_io)
                    
                    if op_name in tp_count and "oob" in tp_count[op_name] and tp_count[op_name]["oob"] < len(tmp_oob):
                        total_oob += tp_count[op_name]["oob"]
                    else:
                        total_oob += len(tmp_oob)

                elif data[op_name][index] and "time" in data[op_name][index] and data[op_name][index]["time"]>0 and data[op_name][index]["time"]<=3600:
                    total_time += data[op_name][index]["time"]
                    valid_count += 1
                    # if data[op_name][index]["time"] >= 3600:
                    #     print(file, op_name, index, "time:", data[op_name][index]["time"])
                else:
                    timeout_num += 1
        
        model_id = file[:-5]
        res[model_id] = {"io": total_io, "oob": total_oob, "total_time": total_time+(timeout_num*3600), "total_time_valid": total_time, "valid_count": valid_count, "timeout_num": timeout_num}
    
    with open("./vllm-exp/model_res_summary.json", "w") as wf:
        json.dump(res, wf, indent=4)

# modelResVllm()

def removeUnfinish():
    for file in os.listdir("./vllm-exp/stat"):
        name = file.split(".")[0]
        with open("./vllm-exp/stat/"+file) as rf:
            data = json.load(rf)
        if data["total"]["path"] == 0:
            continue

        for index in data:
            if index == "total":
                continue
            if not data[index]:
                print(name, index)
                continue
            if "complete_path" not in data[index]:
                print(name, index)
                continue
            if data[index]["complete_path"] > 0:
                continue
            print(name, index)
            # shutil.rmtree(f"/data/mvh6224-home/vllm_exp_out/{name}/klee-out-jindex-{index}-0")
    
    # for file in os.listdir("./vllm-exp/model_bug_stat"):
    #     with open("./vllm-exp/model_bug_stat/"+file) as rf:
    #         data = json.load(rf)
        
    #     for op_name in data:
    #         for index in data[op_name]:
    #             if not data[op_name][index]:
    #                 print(op_name, index)
                    # shutil.rmtree(f"/data/mvh6224-home/vllm_exp_out/{file.split('.')[0]}/klee-out-jindex-{index}-0")

# removeUnfinish()
            
def countSETime(target_dir):
    total_time = 0
    count = 0
    for file in os.listdir(target_dir):
        with open(target_dir+"/"+file) as rf:
            data = json.load(rf)
        
        for key in data:
            if key == "total":
                continue
            if not data[key]:
                continue
            if "time" not in data[key]:
                continue
            total_time += data[key]["time"]
            count+=1
    print("total_time:", total_time, "average time:", total_time/count, "count:", count)

def countGPTTime(target_dir):
    total_time = 0
    gpt_time = 0
    gpt_money = 0
    count = 0
    for file in os.listdir(target_dir):
        cost_file = target_dir+"/"+file+"/cost.json"
        if not os.path.exists(cost_file):
            print("not exist:", cost_file)
            continue

        with open(cost_file) as rf:
            data = json.load(rf)
        
        for key in data:
            if key == "total":
                total_time+=data[key]["time_cost"]
                continue
            if not data[key]:
                continue
            if "gpt_time_cost" in data[key]:
                gpt_time += data[key]["gpt_time_cost"]
            if "money_cost" in data[key]:
                gpt_money += data[key]["money_cost"]
            count+=1
    print("total_time:", total_time, "average time:", total_time/count, "count:", count)
    print("gpt_time:", gpt_time, "average gpt time:", gpt_time/count)
    print("gpt_money:", gpt_money, "average gpt money:", gpt_money/count)

def printVllmModel():
    total_time_map = {}
    gpt_time_map = {}
    gpt_money_map = {}

    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    for model_id in structure_model_map:
        architecture = structure_model_map[model_id]
        if not os.path.exists("./vllm-exp/config/"+architecture):
            print("not exist:", architecture)
            continue
        
        if not os.path.exists("./vllm-exp/out/"+model_id.replace('/', '_')):
            print("not exist in out:", model_id)
            continue

        cost_file = "./vllm-exp/config/"+architecture+"/cost.json"
        if not os.path.exists(cost_file):
            print("not exist:", cost_file)
            continue

        with open(cost_file) as rf:
            data = json.load(rf)
        
        for key in data:
            if key == "total":
                total_time_map[model_id]=data[key]["time_cost"]
                continue
            if not data[key]:
                continue
            if "gpt_time_cost" in data[key]:
                if model_id not in gpt_time_map:
                    gpt_time_map[model_id] = 0
                gpt_time_map[model_id] += data[key]["gpt_time_cost"]
            if "money_cost" in data[key]:
                if model_id not in gpt_money_map:
                    gpt_money_map[model_id] = 0
                gpt_money_map[model_id] += data[key]["money_cost"]
    
    for model_id in total_time_map:
        # print(f"{model_id}\t{structure_model_map[model_id]}\t{total_time_map[model_id]}\t{gpt_time_map.get(model_id, 0)}")
        print(f"{model_id},{structure_model_map[model_id]}, {total_time_map[model_id]}, {gpt_time_map.get(model_id, 0)}")
    
    # for model_id in total_time_map:
    #     print(gpt_time_map.get(model_id, 0))

# printVllmModel()
# countSETime("./hf-exp/stat")
# countGPTTime("./hf-exp/config")
# countGPTTime("./vllm-exp/config")

def printVllmRes():
    time_map = {}
    io_map = {}
    oob_map = {}

    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    with open("./vllm-exp/model_res_summary.json") as rf:
        data = json.load(rf)

    for model_id in structure_model_map:
        architecture = structure_model_map[model_id]
        if not os.path.exists("./vllm-exp/config/"+architecture):
            print("not exist:", architecture)
            continue
        
        if not os.path.exists("./vllm-exp/out/"+model_id.replace('/', '_')):
            print("not exist in out:", model_id)
            continue

        cost_file = "./vllm-exp/config/"+architecture+"/cost.json"
        if not os.path.exists(cost_file):
            print("not exist:", cost_file)
            continue

        model_id_str = model_id.replace('/', '_').split('.')[0]
        if model_id_str not in data:
            print("not in model res summary:", model_id)
            continue

        time_map[model_id] = data[model_id_str]["total_time"]
        io_map[model_id] = data[model_id_str]["io"]
        oob_map[model_id] = data[model_id_str]["oob"]

    for model_id in time_map:
        print(f"{model_id},{structure_model_map[model_id]}, {time_map[model_id]}, {io_map.get(model_id, 0)}, {oob_map.get(model_id, 0)}")

# printVllmRes()    

def printVllmOpTime():
    for dname in os.listdir("/data/mvh6224-home/vllm_exp_out"):
        valid_count = 0
        timeout_num = 0
        total_time = 0
        for klee_dir in os.listdir("/data/mvh6224-home/vllm_exp_out/"+dname):
            if not klee_dir.startswith("klee-out-jindex-"):
                continue

            index = int(klee_dir.split("-")[3])
            info_file = f"/data/mvh6224-home/vllm_exp_out/{dname}/{klee_dir}/info"
            with open(info_file) as f:
                data = f.readlines()
            start_time, end_time = 0, 0
            for line in data:
                if line.startswith("Started:"):
                    start_time = datetime.strptime(line.split("Started:")[1].strip(), "%Y-%m-%d %H:%M:%S")
                if line.startswith("Finished"):
                    end_time = datetime.strptime(line.split("Finished:")[1].strip(), "%Y-%m-%d %H:%M:%S")
            if not end_time:
                timeout_num+=1
                continue
            time_cost = end_time-start_time
            time_cost = time_cost.total_seconds()
            if time_cost >= 3600:
                timeout_num += 1
            else:
                total_time += time_cost
                valid_count += 1
        avg_time = 0.0
        if valid_count>0:
            avg_time = total_time/valid_count
        # print(f"{dname},{total_time+(timeout_num*3600)}, {(total_time+(timeout_num*3600))/(valid_count+timeout_num)}, {avg_time}, {total_time}, {valid_count},{timeout_num}")
        print(f"{dname},  {(total_time+(timeout_num*3600))/(valid_count+timeout_num)}")

# printVllmOpTime()


def countTriggeredOp(model_id):
    initial_triggered = set()
    triggered_ops = set()
    outPath = "./vllm-exp/out/"+model_id.replace('/', '_')
    if os.path.exists(outPath+".json"):
        with open(outPath+".json") as f:
            out_data = json.load(f)
        for key in out_data:
            initial_triggered.add(key.split(".")[-1])

    loadPath = "./vllm-exp/load/"+model_id.replace('/', '_')
    if os.path.exists(loadPath+".json"):        
        with open(loadPath+".json") as f:
            load_data = json.load(f)        
        for item in load_data:
            initial_triggered.add(item["name"].split(".")[-1])
    
    for f in os.listdir(outPath):
        with open(outPath+"/"+f) as f:
            out_data = json.load(f)
        for key in out_data:
            triggered_ops.add(key.split(".")[-1])
    
    for f in os.listdir(loadPath):
        with open(loadPath+"/"+f) as f:
            load_data = json.load(f)        
        for item in load_data:
            triggered_ops.add(item["name"].split(".")[-1])
            
    return initial_triggered, triggered_ops

def printOpCount():
    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    res_map = {}
    for model_id in structure_model_map:
        architecture = structure_model_map[model_id]
        if not os.path.exists("./vllm-exp/config/"+architecture):
            print("not exist:", architecture)
            continue

        op_res_path = "./vllm-exp/config/"+architecture+"/result.json"
        if not os.path.exists(op_res_path):
            initial_triggered, triggered_ops = countTriggeredOp(model_id)
            res_map[model_id] = {"initial": len(initial_triggered), "increase": len(triggered_ops-initial_triggered)}
            to_write = {"initial": list(initial_triggered), "initial_num": len(initial_triggered), "new": list(triggered_ops-initial_triggered), "inre_len": len(triggered_ops-initial_triggered)}
            with open(op_res_path, "w") as wf:
                json.dump(to_write, wf, indent=4)
        else:
            with open(op_res_path) as rf:
                data = json.load(rf)
            res_map[model_id] = {"initial": data["initial_num"], "increase": len(data["new"])}
        
    for model_id in res_map:
        print(f"{model_id},{structure_model_map[model_id]},{res_map[model_id]['initial']},{res_map[model_id]['increase']}")

# printOpCount()

def countModel():
    with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)

    readDir = "./vllm-exp/out"
    count = 0
    for file in os.listdir(readDir):
        path = os.path.join(readDir, file)
        if os.path.isdir(path) and len(os.listdir(path))>0:
            count+=1
    print("model count", count)

# countModel()  
# print(len(os.listdir("./vllm-exp/input")))
# ops = []
# for f in os.listdir("./input"):
#     ops.append(f)

# for f in os.listdir("./input-max"):
#     ops.append(f)

# newos = []
# for f in ops:
#     if not os.path.exists("./vllm-exp/input/"+f):
#         print(f)

# for f in os.listdir("./vllm-exp/input"):
#     if f not in ops:
#         newos.append(f)
# print(newos, len(newos))


def findTriggeredOps(model_id, op_name=None):
    triggered_ops = set()
    outPath = "./vllm-exp/out/"+model_id.replace('/', '_')
    if op_name:
        outPath+="/"+op_name
    outPath+=".json"
    
    loadPath = "./vllm-exp/load/"+model_id.replace('/', '_')
    if op_name:
        loadPath+="/"+op_name
    loadPath+=".json"
    
    if os.path.exists(outPath):
        with open(outPath) as f:
            out_data = json.load(f)
        for key in out_data:
            triggered_ops.add(key.split(".")[-1])
            
    if os.path.exists(loadPath):        
        with open(loadPath) as f:
            load_data = json.load(f)        
        for item in load_data:
            triggered_ops.add(item["name"].split(".")[-1])
            
    return triggered_ops

def measure_deepseek3():
    model_id = "kebeliu/DeepSeek-R1-tiny"
    intiail_tri = findTriggeredOps(model_id)
    final_tri = set()
    for f in os.listdir("./vllm-exp/out/kebeliu_DeepSeek-R1-tiny"):
        op_name = f.split(".")[0]
        tmp_tri = findTriggeredOps(model_id, op_name)
        if tmp_tri:
            final_tri.update(tmp_tri)

    print(intiail_tri, len(intiail_tri))
    print(final_tri, len(final_tri))
    print(final_tri-intiail_tri)

# measure_deepseek3()
# print(len(os.listdir("./hf-exp/config")))
# count = 0
# for f in os.listdir("./hf-exp/out"):
#     if f.endswith(".json"):
#         continue
#     count+=1
#     if len(os.listdir(f"./hf-exp/out/{f}")) == 0:
#         print(f, "empty")

# for f in os.listdir("./hf-exp/config"):
#     if not os.path.exists(f"./hf-exp/out/{f}"):
#         print(f, "not triggered")
# print(count)

# with open("./hfmodels0.json") as f:
#     model_list = json.load(f)
#     print(len(model_list))
#     for model_id in model_list:
#         if not os.path.exists(f"./hf-exp/out/{model_id}"):
#             print(model_id, "not handled")

# print(len(os.listdir("./vllm-exp/out")))
# count = 0
# for f in os.listdir("./vllm-exp/out"):
#     if f.endswith(".json"):
#         count+=1
# print(count, len(os.listdir("./vllm-exp/out"))-count)

def countRSExp():
    # for dname in os.listdir("./rs-exp/config"):
    #     model_dir = "./rs-exp/config/"+dname
    #     total_gpt_time = 0
    #     count = 0
    #     with open(model_dir+"/cost.json") as rf:
    #         data = json.load(rf)
        
    #     for key in data:
    #         if key == "total":
    #             continue
    #         if not data[key]:
    #             continue
    #         if "gpt_time_cost" in data[key]:
    #             total_gpt_time += data[key]["gpt_time_cost"]
    #             count+=1
    #     if count == 0:
    #         continue
    #     print(dname, "total gpt time:", total_gpt_time, "avg gpt time:", total_gpt_time/count, "count:", count)

    for dname in os.listdir("/data/mvh6224-home/rs_exp_out"):
        count = 0
        total_time = 0
        total_ir = 0
        total_path = 0
        total_query = 0
        time_count = 0

        for f in os.listdir("/data/mvh6224-home/rs_exp_out/"+dname):
            if f == "klee-last":
                continue
            path = "/data/mvh6224-home/rs_exp_out/"+dname+"/"+f
            info_file = path+"/info"
            start_time = 0
            end_time = 0
            count+=1
            has_data = False
            with open(info_file) as rf:
                data = rf.readlines()
            for line in data:
                if line.startswith("KLEE: done: total instructions"):
                    total_ir += int(line.split("=")[1].strip())
                    has_data = True
                if line.startswith("KLEE: done: explored paths"):
                    total_path += int(line.split("=")[1].strip())
                if line.startswith("KLEE: done: total queries"):
                    total_query += int(line.split("=")[1].strip())
                if line.startswith("Finished:"):
                    end_time = datetime.strptime(line.split("Finished:")[1].strip(), "%Y-%m-%d %H:%M:%S")
                if line.startswith("Started:"):
                    start_time = datetime.strptime(line.split("Started:")[1].strip(), "%Y-%m-%d %H:%M:%S")

            if has_data:
                time_count += 1
                time_cost = end_time - start_time
                time_cost = time_cost.total_seconds()
            else:
                time_cost = 0
            total_time += time_cost
        if count == 0:
            continue
        print(dname, "count:", count, "total time:", total_time, "total ir:", total_ir, "total path:", total_path, "total query:", total_query)
        if time_count == 0:
            continue
        print(dname, time_count , "avg time:", total_time/time_count, "avg ir:", total_ir/time_count, "avg path:", total_path/time_count, "avg query:", total_query/time_count)
            
# countRSExp()

def printTotalSETime(target_dir):
    total_time = 0
    total_count = 0
    valid_count = 0
    time_out = 0
    for dname in os.listdir(target_dir):
        for f in os.listdir(target_dir+"/"+dname):
            if f == "klee-last":
                continue
            total_count += 1
            path = target_dir+"/"+dname+"/"+f
            info_file = path+"/info"
            with open(info_file) as rf:
                data = rf.readlines()
            start_time = 0
            end_time = 0
            for line in data:
                if line.startswith("Finished:"):
                    end_time = datetime.strptime(line.split("Finished:")[1].strip(), "%Y-%m-%d %H:%M:%S")
                if line.startswith("Started:"):
                    start_time = datetime.strptime(line.split("Started:")[1].strip(), "%Y-%m-%d %H:%M:%S")
            if not end_time:
                time_cost = 3600
                time_out+=1
            else:
                time_cost = end_time - start_time
                time_cost = time_cost.total_seconds()
                if time_cost >= 3600:
                    time_cost = 3600
                    time_out+=1
                else:
                    valid_count += 1
            total_time += time_cost

    print("Total SE time:", total_time, "Total count:", total_count, "Valid count:", valid_count, "Timeout count:", time_out, "Average time:", total_time/total_count)
    return total_time, total_count, valid_count, time_out

# total_time_vllm, total_count_vllm, valid_count_vllm, time_out_vllm = printTotalSETime("/data/mvh6224-home/vllm_exp_out")
# total_time_hf, total_count_hf, valid_count_hf, time_out_hf = printTotalSETime("/data/mvh6224-home/hf_exp_out")
# total_time_rs, total_count_rs, valid_count_rs, time_out_rs = printTotalSETime("/data/mvh6224-home/rs_exp_out")
# grand_total_time = total_time_vllm + total_time_hf + total_time_rs
# grand_total_count = total_count_vllm + total_count_hf + total_count_rs
# grand_valid_count = valid_count_vllm + valid_count_hf + valid_count_rs
# grand_time_out = time_out_vllm + time_out_hf + time_out_rs
# print("Grand Total SE time:", grand_total_time, "Grand Total count:", grand_total_count, "Grand Valid count:", grand_valid_count, "Grand Timeout count:", grand_time_out, "Grand Average time:", grand_total_time/grand_total_count)
# printTotalSETime("/data/mvh6224-home/vllm_exp_out")
# printTotalSETime("/data/mvh6224-home/hf_exp_out")

def countConfigs(target_dir):
    count = 0
    for f in os.listdir(target_dir):
        if f.endswith(".json"):
            continue
        
        for file in os.listdir(target_dir+"/"+f):
            if file.startswith("cost") or file.startswith("no_tri") or file.startswith("result"):
                continue

            count+=1

    return count

# total_configs = countConfigs("./vllm-exp/config")
# print("vllm configs:", total_configs)
# hf_con = countConfigs("./hf-exp/config")
# print("hf configs:", hf_con)
# rs_con = countConfigs("./rs-exp/config")
# print("rs configs:", rs_con)
# print("total configs:", total_configs + hf_con + rs_con)

def countSymTimes(target_dir):
    count = 0
    for dname in os.listdir(target_dir):
        for f in os.listdir(target_dir+"/"+dname):
            if f == "klee-last":
                continue
            count+=1
    
    return count

# vllm_sym_times = countSymTimes("/data/mvh6224-home/vllm_exp_out")
# print("vllm sym times:", vllm_sym_times)   
# hf_sym_times = countSymTimes("/data/mvh6224-home/hf_exp_out")
# print("hf sym times:", hf_sym_times)   
# rs_sym_times = countSymTimes("/data/mvh6224-home/rs_exp_out")
# print("rs sym times:", rs_sym_times)   
# print("total sym times:", vllm_sym_times + hf_sym_times + rs_sym_times)