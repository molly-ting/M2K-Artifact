import argparse
import os, json
import backend.run_vllm as run
import ast
from ..input_generate import get_max_token_vllm, get_max_model_len

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

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

def run_vllm_config(framework_config, model_config, model_id, op_name, batch_size, seq_len, max_model_len, lineno, index, result_dir, rerun=False, run_benchmark_existent=False):
    out_path = f"{result_dir}/validation/{model_id.replace('/', '_')}/{op_name}-{lineno}-{index}.json"
    if os.path.exists(out_path) and not rerun:
        with open(out_path) as f:
            return json.load(f)
        
    env_old = os.environ.copy()
    config = {}
    if framework_config:
        if "envs" in framework_config:
            for k in framework_config["envs"]:
                os.environ[k] = framework_config["envs"][k]
        
        if "vllmconfig" in framework_config:
            config = framework_config["vllmconfig"]
            
    if model_config:
        if "architectures" in model_config:
            model_config.pop("architectures")
        if "rope_scaling" in model_config and model_config["rope_scaling"] is not None:
            if "rope_type" not in model_config["rope_scaling"] and "type" in model_config["rope_scaling"]:
                model_config["rope_scaling"]["rope_type"] = model_config["rope_scaling"]["type"]
        if "blocksparse_block_size" in model_config and "block_size" not in model_config:
            model_config["block_size"] = model_config["blocksparse_block_size"]

        for key in possible_len_keys:
            if key in model_config:
                model_config.pop(key)
            
        config["hf_overrides"] = model_config
        if "quantization_config" in model_config:
            if "quant_method" in model_config["quantization_config"]:
                if "quantization" not in config:
                    config["quantization"] = model_config["quantization_config"]["quant_method"]
            else:
                return -4
    
    config["dtype"] = "float16"
    max_num_batched_tokens=batch_size*seq_len
    if max_model_len and max_num_batched_tokens > max_model_len:
        config["max_num_batched_tokens"] = max_num_batched_tokens
    if batch_size > 128:
        config["max_num_seqs"] = batch_size
    
    if run_benchmark_existent:
        if op_name == "advance_step_flashinfer":
            config["block_size"] = 2048
    
    os.makedirs(f"{result_dir}/validation/", exist_ok=True)
    os.makedirs(f"{result_dir}/validation/{model_id.replace('/', '_')}", exist_ok=True)

    res = None
    try:
        res = run.testRepro(model_id, batch_size, seq_len, config, op_name, out_path)
    except:
        run.traceback.print_exc()
        pass
        
    if framework_config:
        os.environ = env_old
    
    return res

import z3

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(current_dir)

def solve_with_bounds(smt_file, num_tokens):        
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
    s.add(batch_size * seq_len <= num_tokens)
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
    
def vllm_validate_one(klee_out_dir, op_name, index, model_id, config_file, result_dir):
    klee_function_out_path = None
    for dirname in os.listdir(klee_out_dir):
        if len(op_name) + op_name in dirname:
            klee_function_out_path = os.path.join(klee_out_dir, dirname)
            break
    
    if not index:
        index = 0
    constraint_path = os.path.join(klee_function_out_path, f"klee-out-jindex-{index}-0")
    max_num_tokens = get_max_token_vllm(model_id)
    max_model_len = get_max_model_len(model_id)

    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff)

    fcon = None
    if op_name in framework_configs:
        fcon = framework_configs[op_name]
    
    model_config = None
    with open(config_file) as cf:
        model_config = json.load(cf)

    res = {}
    for lineno in os.listdir(constraint_path):
        if not lineno.endswith(".txt"):
            continue

        smt_file_path = os.path.join(constraint_path, lineno)
        batch_size, seq_len = solve_with_bounds(smt_file_path, max_num_tokens)
        if batch_size is None or seq_len is None:
            continue
        
        print(f"Running model {model_id} with {config_file}, batch_size: {batch_size} seq_len: {seq_len}.")
        params_data = run_vllm_config(fcon, model_config, model_id, op_name, batch_size, seq_len, max_model_len, lineno, index, result_dir)

        if params_data and isinstance(params_data, int):
            error_msg = "model config is invalid"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            print(f"config_file: {config_file} is not valid for model {model_id}.")
            continue
        elif params_data is None:
            error_msg = f"{op_name} is not triggered"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            print(f"Running model {model_id} with batch_size: {batch_size} seq_len: {seq_len} config_file: {config_file} cannot trigger {op_name}.")
            continue

        i = int(index)
        with open(f"{result_dir}/input/{op_name}.json") as f:
            op_param_data = json.load(f)
        target_params = op_param_data[i]["args"]
        
        match_found = False
        for key in params_data:
            for bs in params_data[key]:
                if isinstance(bs, tuple):
                    b, s = bs
                else:
                    b, s = ast.literal_eval(bs)
                    
                if not batch_size == int(b) or seq_len != int(s):
                    continue
                
                for t in params_data[key][bs]:
                    if compare_json_arrays(target_params, t, {"s": seq_len, "b": batch_size}):
                        match_found = True
                        break
            if match_found:
                break
        
        if match_found:
            res[lineno] = {"status": "success", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
            print(f"Running model {model_id} with batch_size: {batch_size} seq_len: {seq_len} config_file: {config_file} can trigger bug {lineno} for {op_name}.")
        else:
            res[lineno] = {"status": "failed", "reason": "Parameter mismatch", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
            print(f"Running model {model_id} with batch_size: {batch_size} seq_len: {seq_len} config_file: {config_file} can trigger {op_name}, but cannot trigger bug {lineno} due to different parameters.")

    with open(f"{current_dir}/{model_id.replace('/', '_')}_{op_name}_{index}_validate_results.json", "w") as wf:
        json.dump(res, wf, indent=2)

def vllm_input_check(input_file, output_file, result_dir):
    with open(input_file) as rf:
        input_check = json.load(rf)
    
    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff) 
    
    with open(f"{result_dir}/model_max_len.json", "r") as f:
        model_max_len = json.load(f)
        
    with open(f"{result_dir}/token_limit_by_gpu.json", "r") as f:
        vllm_token_limit = json.load(f)
    
    generated_configs_path = f"{result_dir}/config/diff.json"
    with open(generated_configs_path) as f:
        generated_configs = json.load(f)
    
    with open(f"{root_dir}/data/vllm_text_model_structures_map.json") as mf:
        structure_model_map = json.load(mf)
    
    with open(f"{root_dir}/data/vllm_other_model_structures_map.json") as mf:
        other_structure_model_map = json.load(mf)
        structure_model_map.update(other_structure_model_map)
    
    res = {}
    if os.path.exists(output_file):
        with open(output_file) as rf:
            res = json.load(rf)
        
    for cuda_func in input_check:
        for lineno in input_check[cuda_func]:
            for model_str in input_check[cuda_func][lineno]:
                for index in input_check[cuda_func][lineno][model_str]:
                    if cuda_func not in res:
                        res[cuda_func] = {}
                    if lineno not in res[cuda_func]:
                        res[cuda_func][lineno] = {}
                    if model_str not in res[cuda_func][lineno]:
                        res[cuda_func][lineno][model_str] = {}
                    if index in res[cuda_func][lineno][model_str]:
                        continue
                    
                    item = input_check[cuda_func][lineno][model_str][index]
                    batch_size = item["batch_size"]
                    seq_len = item["seq_len"]
                    
                    op_name = cuda_func
                    framework_config = None
                    if op_name in framework_configs:
                        framework_config = framework_configs[op_name]
                    
                    if op_name == "aqlm_dequant" and seq_len == 1:
                        seq_len = 8
                    
                    if op_name == "gather_cache" and batch_size == 1 and seq_len == 1:
                        seq_len = framework_config["seq_len"][1]
                    
                    # TODO: write script to modify the json file
                    if op_name == "rms_norm":
                        batch_size = batch_size * 2
                    
                    model_id = model_str.replace("_", "/", 1)
                    model_config = None
                    if "config" in item:
                        config_path = item["config"]
                        if "LM" not in item["config"] and "Generation" not in item["config"] and "Ovis" not in item["config"]:
                            config_path = f"{result_dir}/config/" + structure_model_map[model_id] + item["config"].split("/")[-1]
                        if not config_path.startswith("/"):
                            config_path = os.path.join(os.path.dirname(root_dir), config_path)
                        if os.path.exists(config_path):
                            with open(config_path) as cf:
                                model_config = json.load(cf)
                    
                    error_msg = None        
                    if model_id in vllm_token_limit and batch_size * seq_len > vllm_token_limit[model_id]["288"]:
                        res[cuda_func][lineno][model_str][index] = "May OOM due to large num_tokens"
                        continue

                    print(f"Running model {model_id} with {item['config'] if 'config' in item else 'default config'} batch_size: {batch_size} seq_len: {seq_len} for bug {op_name} {lineno} index {index}.")
                    params_data = run_vllm_config(framework_config, model_config, model_id, op_name, batch_size, seq_len, model_max_len[model_id], lineno, index, result_dir)
                    
                    if not params_data and op_name in generated_configs:
                        model_config = generated_configs[op_name][-1]
                        params_data = run_vllm_config(framework_config, model_config, model_id, op_name, batch_size, seq_len, model_max_len[model_id], lineno, index, result_dir)
                        
                    if params_data and params_data == -2:
                        error_msg = "Seq len mismatch"
                    elif params_data and params_data == -4:
                        error_msg = "Config invalid"
                    elif params_data and isinstance(params_data, int):
                        error_msg = "Error model loading"
                    elif params_data is None:
                        error_msg = f"{op_name} not triggered"
                    
                    if error_msg:
                        res[cuda_func][lineno][model_str][index] = error_msg
                        with open(output_file, "w") as wf:
                            json.dump(res, wf, indent=2)
                        continue
                    
                    i = int(index)
                    with open(f"{result_dir}/input/{op_name}.json") as f:
                        op_param_data = json.load(f)
                    target_params = op_param_data[i]["args"]
                    
                    match_found = False
                    for key in params_data:
                        for bs in params_data[key]:
                            if isinstance(bs, tuple):
                                b, s = bs
                            else:
                                b, s = ast.literal_eval(bs)
                                
                            if not batch_size == int(b) or seq_len != int(s):
                                continue
                            
                            for t in params_data[key][bs]:
                                if compare_json_arrays(target_params, t, {"s": seq_len, "b": batch_size}):
                                    res[cuda_func][lineno][model_str][index] = "Pass"
                                    match_found = True
                                    break
                        if match_found:
                            break
                    
                    if not match_found:
                        res[cuda_func][lineno][model_str][index] = "Parameter mismatch"
                        print(f"Parameter mismatch for {model_id} {batch_size} {seq_len} {op_name} at line {lineno} index {index}.")
                        
                    with open(output_file, "w") as wf:
                        json.dump(res, wf, indent=2)
    
    with open(output_file, "w") as wf:
        json.dump(res, wf, indent=2)

# vllm_input_check("./vllm-exp/input_check_TP.json", "./vllm-exp/input_check_results.json")
# vllm_input_check("./vllm-exp/input_check_FP.json", "./vllm-exp/input_check_FP_results.json")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="generate input files for cuKLEE."
    )

    parser.add_argument(
        "--profile-out-dir", type=str, required=False, help="out directory of profiling backend"
    )
    parser.add_argument(
        "--cuklee-out-dir", type=str, required=False, help="out directory of cuKLEE"
    )
    parser.add_argument(
        "--kernel-name", type=str, required=False, help="target kernel name"
    )
    parser.add_argument(
        "--index", type=int, required=False, default=0, help="index in the input file"
    )
    parser.add_argument(
        "--model-id", type=str, required=False, help="target model ID"
    )
    parser.add_argument(
        "--config-file", type=str, required=False, help="target model config file"
    )

    args = parser.parse_args()
    if args.kernel_name and args.model_id and args.config_file:
        vllm_validate_one(args.cuklee_out_dir, args.kernel_name, args.index, args.model_id, args.config_file, args.profile_out_dir)