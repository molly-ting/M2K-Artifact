import argparse
import os, json

vllm_ignored = {"maxV", "minV", "symRanges"}

current_dir = os.path.dirname(__file__)

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

def _vllm_input_file_path(compile_path, kernel_info):
    file_path = kernel_info["file_path"]
    cuda_file_name = os.path.basename(file_path)
    cuda_file_name = os.path.splitext(cuda_file_name)[0] + "_combined.bc"

    parent_dir = os.path.basename(os.path.dirname(file_path))
    if parent_dir != "csrc":
        cuda_file_name = parent_dir + "_" + cuda_file_name

    return os.path.join(compile_path, cuda_file_name)

def _numeric_value(value):
    if isinstance(value, bool):
        return None
    if isinstance(value, (int, float)):
        return value
    return None

def _merge_max_min(old_value, new_value, take_max):
    old_num = _numeric_value(old_value)
    new_num = _numeric_value(new_value)
    if old_num is None or new_num is None:
        return old_value
    return max(old_value, new_value) if take_max else min(old_value, new_value)

def _merge_sym_ranges(old_ranges, new_ranges):
    if not isinstance(old_ranges, dict) or not isinstance(new_ranges, dict):
        return old_ranges

    for symbol, new_range in new_ranges.items():
        if symbol not in old_ranges:
            old_ranges[symbol] = new_range
            continue

        old_range = old_ranges[symbol]
        if not (
            isinstance(old_range, list)
            and isinstance(new_range, list)
            and len(old_range) == 2
            and len(new_range) == 2
        ):
            continue

        old_low = _numeric_value(old_range[0])
        old_high = _numeric_value(old_range[1])
        new_low = _numeric_value(new_range[0])
        new_high = _numeric_value(new_range[1])
        if None in (old_low, old_high, new_low, new_high):
            continue

        old_range[0] = min(old_range[0], new_range[0])
        old_range[1] = max(old_range[1], new_range[1])
    return old_ranges

def _merge_vllm_ignored_fields(existing, incoming):
    if isinstance(existing, dict) and isinstance(incoming, dict):
        if "maxV" in existing and "maxV" in incoming:
            existing["maxV"] = _merge_max_min(existing["maxV"], incoming["maxV"], True)
        elif "maxV" in incoming:
            existing["maxV"] = incoming["maxV"]

        if "minV" in existing and "minV" in incoming:
            existing["minV"] = _merge_max_min(existing["minV"], incoming["minV"], False)
        elif "minV" in incoming:
            existing["minV"] = incoming["minV"]

        if "symRanges" in existing and "symRanges" in incoming:
            existing["symRanges"] = _merge_sym_ranges(existing["symRanges"], incoming["symRanges"])
        elif "symRanges" in incoming:
            existing["symRanges"] = incoming["symRanges"]

        for key, value in incoming.items():
            if key in vllm_ignored or key not in existing:
                continue
            _merge_vllm_ignored_fields(existing[key], value)
    elif isinstance(existing, list) and isinstance(incoming, list):
        for old_item, new_item in zip(existing, incoming):
            _merge_vllm_ignored_fields(old_item, new_item)

def _append_or_merge_vllm_input(items, item, ignore_max):
    for existing in items:
        if ignore_max:
            if remove_ignored(existing) == remove_ignored(item):
                _merge_vllm_ignored_fields(existing, item)
                return False
        elif existing == item:
            return False

    items.append(item)
    return True

def _read_vllm_output_file(filepath, kernel_map, compile_path, res, ignore_max, max_seq_len=None):
    if not os.path.exists(filepath):
        return

    with open(filepath) as f:
        data = json.load(f)

    for func_name, arg_constraints in data.items():
        if "vllm." not in func_name:
            continue

        py_func_name = func_name.split(".")[-1]
        if py_func_name not in kernel_map:
            continue

        kernel_info = kernel_map[py_func_name]
        cuda_func = kernel_info["func_name"]
        if cuda_func not in res:
            res[cuda_func] = []

        for args in arg_constraints:
            item = {
                "py_function": py_func_name,
                "cuda_function": cuda_func,
                "input_file_path": _vllm_input_file_path(compile_path, kernel_info),
                "args": args,
            }
            if max_seq_len is not None:
                item["max_seq_len"] = max_seq_len
            _append_or_merge_vllm_input(res[cuda_func], item, ignore_max)

def _read_vllm_load_file(filepath, kernel_map, compile_path, res, ignore_max):
    if not os.path.exists(filepath):
        return

    with open(filepath) as f:
        data = json.load(f)

    if not isinstance(data, list):
        return

    for item in data:
        if not isinstance(item, dict) or "name" not in item or "args" not in item:
            continue
        if "vllm." not in item["name"]:
            continue

        py_func_name = item["name"].split(".")[-1]
        if py_func_name not in kernel_map:
            continue

        kernel_info = kernel_map[py_func_name]
        cuda_func = kernel_info["func_name"]
        if cuda_func not in res:
            res[cuda_func] = []

        tmp = {
            "py_function": py_func_name,
            "cuda_function": cuda_func,
            "input_file_path": _vllm_input_file_path(compile_path, kernel_info),
            "args": item["args"],
        }
        _append_or_merge_vllm_input(res[cuda_func], tmp, ignore_max)

def generate_vllm_inputs(result_dir=None, compile_path=None, ignore_max=True, has_seq_con=False):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "compile", "vllm_0_9_0")
    
    if result_dir is None:
        result_dir = os.path.join(current_dir, "results", "vllm")

    with open(os.path.join(current_dir, "kernel_map", "kernel_map_vllm.json")) as rf:
        kernel_map = json.load(rf)

    input_dir = os.path.join(result_dir, "out")
    write_dir = os.path.join(result_dir, "input")
    os.makedirs(write_dir, exist_ok=True)

    res = {}
    for name in os.listdir(input_dir):
        path = os.path.join(input_dir, name)
        if name.endswith(".json") and not name.endswith("seq_con.json"):
            max_seq_len = None
            if has_seq_con:
                model_name = name[:-5] 
                with open(os.path.join(input_dir, model_name + "_seq_con.json")) as sf:
                    sf_data = json.load(sf)
                    if "seq_len" in sf_data:
                        max_seq_len = sf_data["seq_len"]

            _read_vllm_output_file(path, kernel_map, compile_path, res, ignore_max, max_seq_len)
            continue
        
        model_dir = path
        max_seq_len = None
        if has_seq_con:
            with open(os.path.join(model_dir, "seq_con.json")) as sf:
                sf_data = json.load(sf)
                if "seq_len" in sf_data:
                    max_seq_len = sf_data["seq_len"]

        for op_file in os.listdir(model_dir):
            if "seq_con" in op_file:
                continue

            if op_file.endswith(".json"):
                _read_vllm_output_file(
                    os.path.join(model_dir, op_file),
                    kernel_map,
                    compile_path,
                    res,
                    ignore_max,
                    max_seq_len
                )

    for cuda_func, items in res.items():
        out_filepath = os.path.join(write_dir, cuda_func + ".json")
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath) as rf:
                write_data = json.load(rf)

        if write_data:
            for item in items:
                _append_or_merge_vllm_input(write_data, item, ignore_max)
        else:
            write_data = items

        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

    return res

def generate_vllm_input_load(result_dir, compile_path, ignore_max=True):
    with open(os.path.join(current_dir, "kernel_map", "kernel_map_vllm.json")) as rf:
        kernel_map = json.load(rf)

    input_dir = os.path.join(result_dir, "load")
    write_dir = os.path.join(result_dir, "input-load")
    os.makedirs(write_dir, exist_ok=True)

    res = {}
    for root, _, files in os.walk(input_dir):
        for file in files:
            if not file.endswith(".json"):
                continue
            _read_vllm_load_file(
                os.path.join(root, file),
                kernel_map,
                compile_path,
                res,
                ignore_max,
            )

    for cuda_func, items in res.items():
        if os.path.exists(os.path.join(result_dir, "input", cuda_func + ".json")):
            continue 

        out_filepath = os.path.join(write_dir, cuda_func + ".json")
        write_data = []
        if os.path.exists(out_filepath):
            with open(out_filepath) as rf:
                write_data = json.load(rf)

        if write_data:
            for item in items:
                _append_or_merge_vllm_input(write_data, item, ignore_max)
        else:
            write_data = items

        with open(out_filepath, "w") as wf:
            json.dump(write_data, wf, indent=4)

    return res


def _read_hf_output_file(filepath, kernel_map, compile_path, res):
    if not os.path.exists(filepath):
        return

    with open(filepath) as f:
        data = json.load(f)

    if "mgalkin" in filepath and "ultra" in filepath:
        for item in data:
            for call in item["calls"]:
                func_name = call["name"]
                if "::" in func_name:
                    py_func_name = func_name.split("::")[-1]
                elif "." in func_name:
                    py_func_name = func_name.split(".")[-1]
                else:
                    py_func_name = func_name
                if py_func_name not in kernel_map:
                    continue

                kernel_info = kernel_map[py_func_name]
                cuda_func = kernel_info["func_name"]
                file_path = kernel_info["file_path"]
                cuda_file_name = os.path.basename(file_path).split(".")[0] + "_combined.bc"
                input_file_path = os.path.join(compile_path, cuda_file_name)

                if cuda_func not in res:
                    res[cuda_func] = []

                item = {
                    "py_function": py_func_name,
                    "cuda_function": cuda_func,
                    "input_file_path": input_file_path,
                    "args": call["args"],
                }
                if item not in res[cuda_func]:
                    res[cuda_func].append(item)
    else:
        for func_name in data:
            if "::" in func_name:
                py_func_name = func_name.split("::")[-1]
            elif "." in func_name:
                py_func_name = func_name.split(".")[-1]
            else:
                py_func_name = func_name
            if py_func_name not in kernel_map:
                continue

            kernel_info = kernel_map[py_func_name]
            cuda_func = kernel_info["func_name"]
            file_path = kernel_info["file_path"]
            cuda_file_name = os.path.basename(file_path).split(".")[0] + "_combined.bc"
            input_file_path = os.path.join(compile_path, cuda_file_name)

            if cuda_func not in res:
                res[cuda_func] = []

            for argCons in data[func_name]:
                item = {
                    "py_function": py_func_name,
                    "cuda_function": cuda_func,
                    "input_file_path": input_file_path,
                    "args": argCons,
                }
                if item not in res[cuda_func]:
                    res[cuda_func].append(item)

def generate_one_hf(model_id, compile_path, result_dir=None):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "compile", "huggingface", model_id)

    if not result_dir:
        result_dir = os.path.dirname(__file__) + "/results/huggingface"
    os.makedirs(os.path.join(result_dir, "input"), exist_ok=True)

    with open(f"{current_dir}/kernel_map/kernel_map_{model_id}.json") as rf:
        kernel_map = json.load(rf)
    
    res = {}
    for file in os.listdir(f"{result_dir}/out/"+model_id):
        _read_hf_output_file(os.path.join(result_dir, "out", model_id, file), kernel_map, compile_path, res)
    
    for func in res:    
        out_filepath = result_dir+"/input/"+func+".json"
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

def generate_all_hf(compile_path, result_dir=None):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "compile", "huggingface")

    if not result_dir:
        result_dir = os.path.dirname(__file__) + "/results/huggingface"
    os.makedirs(os.path.join(result_dir, "input"), exist_ok=True)

    res = {}
    for file in os.listdir(f"{result_dir}/out"):
        if file.endswith(".json"):
            model_id = file[:-5]
            with open(f"{current_dir}/kernel_map/kernel_map_{model_id}.json") as rf:
                kernel_map = json.load(rf)
            _read_hf_output_file(os.path.join(result_dir, "out", file), kernel_map, os.path.join(compile_path, model_id), res)
        else:
            model_id = file
            with open(f"{current_dir}/kernel_map/kernel_map_{model_id}.json") as rf:
                kernel_map = json.load(rf)
            _read_hf_output_file(os.path.join(result_dir, "out", file), kernel_map, os.path.join(compile_path, model_id), res)

def generate_research_paper_input():
    compile_path = os.path.join(os.path.dirname(current_dir), "compile", "papers")
    result_dir = os.path.dirname(__file__) + "/results/research_paper"
    generate_all_hf(compile_path, result_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="generate input files for cuKLEE."
    )

    parser.add_argument(
        "--vllm-benchmark", type=bool, required=False, help="vLLM benchmark result directory"
    )
    parser.add_argument(
        "--hf-benchmark", type=bool, required=False, help="HuggingFace benchmark result directory"
    )

    parser.add_argument(
        "--vllm-result-dir", type=str, required=False, help="vLLM result directory"
    )
    parser.add_argument(
        "--vllm-compile-path", type=str, required=False, help="directory containing vLLM compiled cuda files"
    )

    parser.add_argument(
        "--vllm-hf-dir", type=str, required=False, help="HuggingFace result directory"
    )
    parser.add_argument(
        "--vllm-hf-compile-path", type=str, required=False, help="directory containing HuggingFace compiled cuda files"
    )

    parser.add_argument(
        "--research-paper", type=bool, required=False, help="Generate input files for the research paper"
    )

    args = parser.parse_args()
    if args.research_paper:
        generate_research_paper_input()
    elif args.vllm_benchmark:
        generate_vllm_inputs(None, None, True, False)
    elif args.hf_benchmark:
        generate_all_hf(None, None)
    elif args.vllm_result_dir:
        generate_vllm_inputs(args.vllm_result_dir, args.vllm_compile_path, False, True)
    elif args.vllm_hf_dir:
        generate_all_hf(args.vllm_hf_compile_path, args.vllm_hf_dir)