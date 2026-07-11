import argparse
import os, json
import backend.run_vllm as run
import ast
from ..input_generate import get_max_token_vllm, get_max_model_len
from verify_input import solve_with_bounds, getFuncName, init_vllm_input_check, compare_json_arrays


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

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(current_dir)
    
def vllm_validate_one(klee_out_dir, op_name, index, model_id, config_file, result_dir):
    klee_function_out_path = None
    for dirname in os.listdir(klee_out_dir):
        if len(op_name) + op_name in dirname:
            klee_function_out_path = os.path.join(klee_out_dir, dirname)
            break
    
    if not klee_function_out_path:
        print("no constraints files found")
        return
    
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
        batch_size, seq_len = solve_with_bounds(smt_file_path, max_num_tokens, max_model_len)
        if batch_size is None or seq_len is None:
            print("no solution found for batch_size and seq_len")
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

def vllm_validate_one_inner(klee_function_out_dir, cuda_func, index, model_id, config_file, framework_config, profile_dir):
    if not klee_function_out_dir:
        return
    
    if not index:
        index = 0
    constraint_path = os.path.join(klee_function_out_dir, f"klee-out-jindex-{index}-0")
    max_num_tokens = get_max_token_vllm(model_id)
    max_model_len = get_max_model_len(model_id)
    
    model_config = None
    with open(config_file) as cf:
        model_config = json.load(cf)

    res = {}
    for lineno in os.listdir(constraint_path):
        if not lineno.endswith(".txt"):
            continue

        smt_file_path = os.path.join(constraint_path, lineno)
        batch_size, seq_len = solve_with_bounds(smt_file_path, max_num_tokens, max_model_len)
        if batch_size is None or seq_len is None:
            res[lineno] = {"status": "failed", "reason": "no solution for token limit", "config": config_file}
            continue
        
        print(f"Running model {model_id} with {config_file}, batch_size: {batch_size} seq_len: {seq_len}.")
        params_data = run_vllm_config(framework_config, model_config, model_id, cuda_func, batch_size, seq_len, max_model_len, lineno, index, profile_dir)

        if params_data and isinstance(params_data, int):
            error_msg = "model config is invalid"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            continue
        elif params_data is None:
            error_msg = "kernel is not triggered"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            continue

        i = int(index)
        with open(f"{profile_dir}/input/{cuda_func}.json") as f:
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
        else:
            res[lineno] = {"status": "failed", "reason": "Parameter mismatch", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
    
    return res

def vllm_benchmark_validate(klee_out_dir, profile_dir):
    result_path = os.path.join(profile_dir, "vllm_benchmark_validation_results.json")
    res = {}
    if os.path.exists(result_path):
        with open(result_path) as rf:
            res = json.load(rf)
    if not res:
        res = init_vllm_input_check(profile_dir, None, None, result_path)
    
    klee_func_out_map = {}
    for dirname in os.listdir(klee_out_dir):
        cuda_func = getFuncName(dirname)
        klee_func_out_map[cuda_func] = dirname

    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff)
    
    for cuda_func in res:
        py_func = res[cuda_func]["py_func"]
        fcon = None
        if py_func in framework_configs:
            fcon = framework_configs[py_func]

        for index in res[cuda_func]:
            if "py_func" in index:
                continue

            for model_id in res[cuda_func][index]:
                config_file = None
                if "config" in res[cuda_func][index][model_id]:
                    config_file = res[cuda_func][index][model_id]["config"]

                klee_func_name = None
                if cuda_func in klee_func_out_map:
                    klee_func_name = klee_func_out_map[cuda_func]
                else:
                    for dirname in os.listdir(klee_out_dir):
                        if len(cuda_func) + cuda_func in dirname:
                            klee_func_name = dirname
                            klee_func_out_map[cuda_func] = dirname
                            break

                klee_function_out_dir = os.path.join(klee_out_dir, klee_func_name) if klee_func_name else None
                validate_res = vllm_validate_one_inner(klee_function_out_dir, cuda_func, index, model_id, config_file, fcon, profile_dir)
                res[cuda_func][index][model_id] = validate_res

    with open(result_path, "w") as wf:
        json.dump(res, wf, indent=4)

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
    parser.add_argument(
        "--dir", action=argparse.BooleanOptionalAction, default=False, help="Whether to run on directory of cuKLEE output or on a single kernel"
    )

    args = parser.parse_args()
    if args.dir:
        vllm_benchmark_validate(args.cuklee_out_dir, args.profile_out_dir)
    elif args.kernel_name and args.model_id and args.config_file:
        vllm_validate_one(args.cuklee_out_dir, args.kernel_name, args.index, args.model_id, args.config_file, args.profile_out_dir)