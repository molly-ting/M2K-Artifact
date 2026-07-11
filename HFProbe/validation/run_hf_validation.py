import argparse
import os, json
import ast
from ..input_generate import get_max_token_vllm, get_max_model_len
from verify_input import solve_with_bounds, getFuncName, init_hf_input_check, compare_json_arrays
import run_transformers_check as rt

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(current_dir)

def run_case(model_id, override_configs, op_name, batch_size, seq_len, lineno, index, result_dir):
    out_path = f"{result_dir}/validation/{model_id.replace('/', '_')}/{op_name}-{lineno}-{index}.json"
    if os.path.exists(out_path):
        with open(out_path) as f:
            return json.load(f)

    rt.run(
        model_id=model_id,
        override_configs=override_configs,
        suffix=op_name,
        output_dir=None,
        data_dir=None,
        out_path=out_path,
        batch_size_configs=[batch_size],
        seq_lens_configs=[seq_len],
        record_only=True,
    )

    if os.path.exists(out_path):
        with open(out_path) as f:
            return json.load(f)
    
    return None

def hf_validate_one(klee_out_dir, cuda_func, py_func, index, model_id, config_file, result_dir):
    klee_function_out_path = None
    for dirname in os.listdir(klee_out_dir):
        if len(cuda_func) + cuda_func in dirname:
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
        params_data = run_case(model_id, model_config, py_func, batch_size, seq_len, lineno, index, result_dir)

        if params_data is None:
            error_msg = "model config is invalid"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            print(f"config_file: {config_file} is not valid for model {model_id}.")
            continue

        i = int(index)
        with open(f"{result_dir}/input/{cuda_func}.json") as f:
            op_param_data = json.load(f)
        target_params = op_param_data[i]["args"]
        
        match_found = False
        for item in params_data:
            batch_size = item["batch_size"]
            seq_len = item["seq_len"]
                
            for t in item["calls"]:
                if t["name"] != py_func:
                    continue
                if compare_json_arrays(target_params, t["args"], {"s": seq_len, "b": batch_size}):
                    match_found = True
                    break
            if match_found:
                break
        
        if match_found:
            res[lineno] = {"status": "success", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
            print(f"Running model {model_id} with batch_size: {batch_size} seq_len: {seq_len} config_file: {config_file} can trigger bug {lineno} for {cuda_func}.")
        else:
            res[lineno] = {"status": "failed", "reason": "Parameter mismatch", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
            print(f"Running model {model_id} with batch_size: {batch_size} seq_len: {seq_len} config_file: {config_file} can trigger {cuda_func}, but cannot trigger bug {lineno} due to different parameters.")

    with open(f"{current_dir}/{model_id.replace('/', '_')}_{cuda_func}_{index}_validate_results.json", "w") as wf:
        json.dump(res, wf, indent=2)

def hf_validate_one_inner(klee_function_out_dir, cuda_func, py_func, index, model_id, config_file, result_dir):
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
        params_data = run_case(model_id, model_config, py_func, batch_size, seq_len, lineno, index, result_dir)

        if params_data is None:
            error_msg = "model config is invalid"
            res[lineno] = {"status": "failed", "reason": error_msg, "config": config_file}
            print(f"config_file: {config_file} is not valid for model {model_id}.")
            continue

        i = int(index)
        with open(f"{result_dir}/input/{cuda_func}.json") as f:
            op_param_data = json.load(f)
        target_params = op_param_data[i]["args"]
        
        match_found = False
        for item in params_data:
            batch_size = item["batch_size"]
            seq_len = item["seq_len"]
                
            for t in item["calls"]:
                if t["name"] != py_func:
                    continue
                if compare_json_arrays(target_params, t["args"], {"s": seq_len, "b": batch_size}):
                    match_found = True
                    break
            if match_found:
                break
        
        if match_found:
            res[lineno] = {"status": "success", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}
        else:
            res[lineno] = {"status": "failed", "reason": "Parameter mismatch", "batch_size": batch_size, "seq_len": seq_len, "config": config_file}

    return res

def hf_benchmark_validate(klee_out_dir, profile_dir):
    result_path = os.path.join(profile_dir, "hf_benchmark_validation_results.json")
    res = {}
    if os.path.exists(result_path):
        with open(result_path) as rf:
            res = json.load(rf)
    if not res:
        res = init_hf_input_check(profile_dir, None, None, result_path)
    
    klee_func_out_map = {}
    for dirname in os.listdir(klee_out_dir):
        cuda_func = getFuncName(dirname)
        klee_func_out_map[cuda_func] = dirname
    
    for cuda_func in res:
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
                validate_res = hf_validate_one_inner(klee_function_out_dir, cuda_func, index, model_id, config_file, profile_dir)
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
        "--py-func", type=str, required=False, help="python function name corresponding to the kernel"
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
        hf_benchmark_validate(args.cuklee_out_dir, args.profile_out_dir)
    elif args.kernel_name and args.model_id and args.config_file:
        hf_validate_one(args.cuklee_out_dir, args.kernel_name, args.py_func, args.index, args.model_id, args.config_file, args.profile_out_dir)