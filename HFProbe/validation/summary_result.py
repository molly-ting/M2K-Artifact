import json

def getBugCountVllm():
    # with open("/data/szx5097/hfplayground/vllm_text_model_structures_map.json") as mf:
    #     structure_model_map = json.load(mf)
    
    # with open("/data/szx5097/hfplayground/vllm_other_model_structures_map.json") as mf:
    #     other_structure_model_map = json.load(mf)
    #     structure_model_map.update(other_structure_model_map)
    
    with open("./vllm_model_max_len.json") as mf:
        max_model_lens = json.load(mf)
    
    with open("./vllm-exp/token_limit_by_gpu.json", "r") as f:
        vllm_token_limit = json.load(f)
    
    with open("./vllm-exp/input_check_TP.json") as rf:
        inputs = json.load(rf)
    
    with open("./vllm-exp/initial_bugs.json") as bf:
        bugs = json.load(bf)
    
    with open("./vllm-exp/input_check_results.json") as rf:
        checks = json.load(rf)
    
    res = {}
    gpu_config = [512, 480, 448, 416, 384, 352, 320, 288, 192, 144, 141, 128, 80, 64, 48, 32, 24, 16]
    gpu_config.reverse()
    to_print = []
    
    for mem in gpu_config:
        if mem not in res:
            res[mem] = {"io": 0, "oob": 0}

        for cuda_func in inputs:
            if cuda_func not in bugs:
                # print(f"{cuda_func} not in initial_bugs") 
                continue
            if "paged_attention" in cuda_func:
                continue
            
            for bug_type in ["io", "oob"]:
                if bug_type in bugs[cuda_func] and "TP" in bugs[cuda_func][bug_type]:
                    for item in bugs[cuda_func][bug_type]["TP"]:
                        has_bug = False
                        if isinstance(item, list):
                            for lineno in item:
                                for modelIdStr in inputs[cuda_func][lineno]:
                                    modelId = modelIdStr.replace("_", "/", 1)
                                    max_seq_len = max_model_lens[modelId]
                                    max_num_token = vllm_token_limit[modelId][str(mem)]
                                    for index in inputs[cuda_func][lineno][modelIdStr]:
                                        # if index in checks[cuda_func][lineno][modelIdStr] and "mismatch" in checks[cuda_func][lineno][modelIdStr][index]:
                                        #     # print()
                                        #     continue
                                        if index in checks[cuda_func][lineno][modelIdStr] and not "Pass" in checks[cuda_func][lineno][modelIdStr][index]:
                                            # print()
                                            continue
                                        if index not in checks[cuda_func][lineno][modelIdStr]:
                                            # print(cuda_func, lineno, modelIdStr, index)
                                            continue
                                        batch_size = int(inputs[cuda_func][lineno][modelIdStr][index]["batch_size"])
                                        seq_len = int(inputs[cuda_func][lineno][modelIdStr][index]["seq_len"])
                                        if not max_seq_len or seq_len <= max_seq_len:
                                            if not max_num_token or batch_size * seq_len <= max_num_token:
                                                # print(cuda_func, lineno)
                                                if mem==288:
                                                    to_print.append((cuda_func, lineno))
                                                has_bug = True
                                                break
                                    if has_bug:
                                        break
                                if has_bug:
                                    break
                        else:
                            for modelIdStr in inputs[cuda_func][item]:
                                modelId = modelIdStr.replace("_", "/", 1)
                                max_seq_len = max_model_lens[modelId]
                                max_num_token = vllm_token_limit[modelId][str(mem)]
                                for index in inputs[cuda_func][item][modelIdStr]:
                                    if index in checks[cuda_func][item][modelIdStr] and not "Pass" in checks[cuda_func][item][modelIdStr][index]:
                                        continue
                                    if index not in checks[cuda_func][item][modelIdStr]:
                                        # print(cuda_func, item, modelIdStr, index)
                                        continue
                                        
                                    batch_size = int(inputs[cuda_func][item][modelIdStr][index]["batch_size"])
                                    seq_len = int(inputs[cuda_func][item][modelIdStr][index]["seq_len"])
                                    if not max_seq_len or seq_len <= max_seq_len:
                                        if not max_num_token or batch_size * seq_len <= max_num_token:
                                            # print(cuda_func, item)
                                            if mem==288:
                                                to_print.append((cuda_func, item))
                                            has_bug = True
                                            break
                                if has_bug:
                                    break
                        if has_bug:
                            res[mem][bug_type]+=1
    
    for mem in res:
        print(mem, res[mem]["io"], res[mem]["oob"])    
    # to_print.sort()    
    # for a in to_print:
    #     print(a)
        
# getBugCountVllm()

def getBugCountHF():
    with open("./hf_model_max_len.json") as mf:
        max_model_lens = json.load(mf)
    
    with open("./hf-exp/token_limit_by_gpu.json", "r") as f:
        token_limit = json.load(f)
    
    with open("./hf-exp/input_check.json") as rf:
        inputs = json.load(rf)
    
    res = {}
    gpu_config = [512, 480, 448, 416, 384, 352, 320, 288, 192, 144, 141, 128, 80, 64, 48, 32, 24, 16]
    gpu_config.reverse()
    chinoll_count = {"vecquant4matmul_cuda": [["8278_4477_4388_io", "8281_4477_4388_io"], ["8512_4477_4388_io", "8514_4477_4388_io"]], 
                     "vecquant8matmul_cuda": [["8798_5095_5006_io", "8801_5095_5006_io"], ["8964_5095_5006_io", "8966_5095_5006_io"]]}
    to_print = []
    
    for mem in gpu_config:
        if mem not in res:
            res[mem] = 0
        
        for cuda_func in inputs:
            if cuda_func in chinoll_count:
                for item in chinoll_count[cuda_func]:
                    has_bug = False
                    for lineno in item:
                        for modelIdStr in inputs[cuda_func][lineno]:
                            modelId = modelIdStr.replace("_", "/", 1)
                            max_seq_len = max_model_lens[modelId]
                            max_num_token = token_limit[modelId][str(mem)]
                            for index in inputs[cuda_func][lineno][modelIdStr]:
                                batch_size = int(inputs[cuda_func][lineno][modelIdStr][index]["batch_size"])
                                seq_len = int(inputs[cuda_func][lineno][modelIdStr][index]["seq_len"])
                                if not max_seq_len or seq_len <= max_seq_len:
                                    if not max_num_token or batch_size * seq_len <= max_num_token:
                                        if mem==288:
                                            to_print.append((cuda_func, lineno, modelIdStr))
                                        has_bug = True
                                        break
                            if has_bug:
                                break
                        if has_bug:
                            break
                    if has_bug:
                        res[mem]+=1               
            else:
                for lineno in inputs[cuda_func]:
                    for modelIdStr in inputs[cuda_func][lineno]:
                        modelId = modelIdStr.replace("_", "/", 1)
                        max_seq_len = max_model_lens[modelId]
                        max_num_token = token_limit[modelId][str(mem)]
                        has_bug = False
                        for index in inputs[cuda_func][lineno][modelIdStr]:
                            batch_size = int(inputs[cuda_func][lineno][modelIdStr][index]["batch_size"])
                            seq_len = int(inputs[cuda_func][lineno][modelIdStr][index]["seq_len"])
                            if not max_seq_len or seq_len <= max_seq_len:
                                if not max_num_token or batch_size * seq_len <= max_num_token:
                                    if mem==288:
                                        to_print.append((cuda_func, lineno, modelIdStr))
                                    has_bug = True
                                    break
                        if has_bug:
                            res[mem]+=1
        print(res[mem])
    
    # to_print.sort()    
    # for a in to_print:
    #     print(a)

getBugCountHF()