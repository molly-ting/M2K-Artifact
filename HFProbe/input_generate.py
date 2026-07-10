import argparse
import os, json
from huggingface_hub import HfApi, hf_hub_download
import requests
import wrapper

vllm_ignored = {"maxV", "minV", "symRanges"}

current_dir = os.path.dirname(__file__)
gpu_memory_utilization = 1
gpu_memory = 288

def model_info(model_id):
    if model_id == "mosaicml/mpt-7b":
        model_id = "k0t1k/mosaicml-mpt-7b-instruct-lora"
    if model_id == "databricks/dbrx-instruct":
        model_id = "alpindale/dbrx-instruct"
        
    api = HfApi()
    try:
        info = api.model_info(model_id, files_metadata=True)
    except:
        print(f"Failed to get model info for {model_id}")
        return None, None, None, None

    weights_size = 0
    for f in info.siblings:
        if f.rfilename.endswith((".bin", ".safetensors", ".pt")):
            if f.size is None:
                url = f"https://huggingface.co/{model_id}/resolve/main/{f.rfilename}"
                r = requests.head(url, allow_redirects=True)
                size = int(r.headers.get("Content-Length", 0))
                # print(model_id, f.rfilename, size)
                weights_size += size
            else:
                weights_size += f.size

    path = hf_hub_download(
        repo_id=model_id,
        filename="config.json"
    )

    with open(path) as f:
        config = json.load(f)
    
    hidden_size, intermediate_size, num_layers = None, None, None
    if "hidden_size" in config:
        hidden_size = config["hidden_size"]
    elif "text_config" in config and "hidden_size" in config["text_config"]:
        hidden_size = config["text_config"]["hidden_size"]
    elif "llm_config" in config and "hidden_size" in config["llm_config"]:
        hidden_size = config["llm_config"]["hidden_size"]
    elif "vision_config" in config and "hidden_size" in config["vision_config"]:
        hidden_size = config["vision_config"]["hidden_size"]
    elif "n_embed" in config:
        hidden_size = config["n_embed"]
    elif "n_embd" in config:
        hidden_size = config["n_embd"]
    elif "d_model" in config:
        hidden_size = config["d_model"]
        
    if "intermediate_size" in config:
        intermediate_size = config["intermediate_size"]
    elif "text_config" in config and "intermediate_size" in config["text_config"]:
        intermediate_size = config["text_config"]["intermediate_size"]
    elif "llm_config" in config and "intermediate_size" in config["llm_config"]:
        intermediate_size = config["llm_config"]["intermediate_size"]
    elif "vision_config" in config and "intermediate_size" in config["vision_config"]:
        intermediate_size = config["vision_config"]["intermediate_size"]
    elif "ffn_hidden_size" in config:
        intermediate_size = config["ffn_hidden_size"]
    
    if "num_hidden_layers" in config:
        num_layers = config["num_hidden_layers"]
    elif "text_config" in config and "num_hidden_layers" in config["text_config"]:
        num_layers = config["text_config"]["num_hidden_layers"]
    elif "llm_config" in config and "num_hidden_layers" in config["llm_config"]:
        num_layers = config["llm_config"]["num_hidden_layers"]
    elif "vision_config" in config and "num_hidden_layers" in config["vision_config"]:
        num_layers = config["vision_config"]["num_hidden_layers"]
    elif "n_layer" in config:
        num_layers = config["n_layer"]
    elif "n_layers" in config:
        num_layers = config["n_layers"]
    elif "num_layers" in config:    
        num_layers = config["num_layers"]

    return weights_size, hidden_size, intermediate_size, num_layers

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

def get_max_model_len(model_id):
    try:
        path = hf_hub_download(
            repo_id=model_id,
            filename="config.json"
        )
    except:
        return None

    with open(path) as f:
        model_config = json.load(f)
        
    max_seq_len = None
    for key in possible_len_keys:
        if key in model_config:
            if not max_seq_len:
                max_seq_len = model_config[key]
            elif model_config[key] is not None:
                max_seq_len = min(max_seq_len, model_config[key])
        elif "text_config" in model_config and key in model_config["text_config"]:
            if not max_seq_len:
                max_seq_len = model_config["text_config"][key]
            elif model_config["text_config"][key] is not None:
                max_seq_len = min(max_seq_len, model_config["text_config"][key])
        elif "vision_config" in model_config and key in model_config["vision_config"]:
            if not max_seq_len:
                max_seq_len = model_config["vision_config"][key]
            elif model_config["vision_config"][key] is not None:
                max_seq_len = min(max_seq_len, model_config["vision_config"][key])
        elif "llm_config" in model_config and key in model_config["llm_config"]:
            if not max_seq_len:
                max_seq_len = model_config["llm_config"][key]
            elif model_config["llm_config"][key] is not None:
                max_seq_len = min(max_seq_len, model_config["llm_config"][key])
    return max_seq_len

def get_max_token_vllm(model_id):
    weights_size, hidden_size, intermediate_size, num_layers = model_info(model_id)
    if weights_size is None or hidden_size is None:
        return None
        
    if intermediate_size is None:
        intermediate_size = hidden_size * 2

    token_limit = int(((gpu_memory * gpu_memory_utilization * 1024 * 1024 * 1024/1.25) - weights_size) / (2 * num_layers * hidden_size * 2))
    return token_limit

def get_max_token_hf(model_id):
    weights_size, hidden_size, intermediate_size, num_layers = model_info(model_id)
    if weights_size is None or hidden_size is None:
        return None
        
    if intermediate_size is None:
        intermediate_size = hidden_size * 2

    token_limit = int(((gpu_memory * gpu_memory_utilization * 1024 * 1024 * 1024/1.45) - weights_size) / (2 * num_layers * hidden_size * 2))
    return token_limit

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

def _read_vllm_output_file(filepath, kernel_map, compile_path, res, ignore_max, max_seq_len=None, max_token_num=None):
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
                item["seq_len"] = max_seq_len
            if max_token_num is not None:
                item["num_tokens"] = max_token_num
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

def generate_vllm_inputs(result_dir=None, compile_path=None, kernel_map_path=None, ignore_max=True, has_seq_con=False, has_token_con=False):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "benchmarks", "vllm", "compiled_files")
    
    if result_dir is None:
        result_dir = os.path.join(current_dir, "results", "vllm")

    if kernel_map_path is None:
        kernel_map_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "HFProbe_results", "kernel_map", "kernel_map_vllm.json")

    with open(kernel_map_path) as rf:
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
                seq_con_path = os.path.join(input_dir, model_name + "_seq_con.json")
                if os.path.exists(seq_con_path):
                    with open(seq_con_path) as sf:
                        sf_data = json.load(sf)
                        if "seq_len" in sf_data:
                            max_seq_len = sf_data["seq_len"]
                else:
                    max_seq_len = get_max_model_len(model_name.replace("_", "/", 1))
            max_token_num = None
            if has_token_con:
                model_id = name[:-5].replace("_", "/", 1)
                max_token_num = get_max_token_vllm(model_id)

            _read_vllm_output_file(path, kernel_map, compile_path, res, ignore_max, max_seq_len, max_token_num)
            continue
        
        model_dir = path
        max_seq_len = None
        if has_seq_con:
            seq_con_path = os.path.join(model_dir, "seq_con.json")
            if os.path.exists(seq_con_path):
                with open(seq_con_path) as sf:
                    sf_data = json.load(sf)
                    if "seq_len" in sf_data:
                        max_seq_len = sf_data["seq_len"]
            else:
                max_seq_len = get_max_model_len(model_name.replace("_", "/", 1))
        
        max_token_num = None
        if has_token_con:
            model_id = model_dir.replace("_", "/", 1)
            max_token_num = get_max_token_vllm(model_id)

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
                    max_seq_len,
                    max_token_num
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

def generate_vllm_input_load(result_dir, compile_path, kernel_map_path=None, ignore_max=True):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "benchmarks", "vllm", "compiled_files")
    
    if result_dir is None:
        result_dir = os.path.join(current_dir, "results", "vllm")

    if kernel_map_path is None:
        kernel_map_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "HFProbe_results", "kernel_map", "kernel_map_vllm.json")

    if kernel_map_path is None:
        kernel_map_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "HFProbe_results", "kernel_map", "kernel_map_vllm.json")

    input_dir = os.path.join(result_dir, "load")
    write_dir = os.path.join(result_dir, "input")
    os.makedirs(write_dir, exist_ok=True)
    
    with open(kernel_map_path) as rf:
        kernel_map = json.load(rf)

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


def _read_hf_output_file(filepath, kernel_map, compile_path, res, max_seq_len=None, max_token_num=None):
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
                if max_seq_len is not None:
                    item["seq_len"] = max_seq_len
                if max_token_num is not None:
                    item["num_tokens"] = max_token_num
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

def generate_one_hf(model_id, compile_path, kernel_map_path=None, result_dir=None, has_seq_con=False, has_token_con=False):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "benchmarks", "huggingface", "compiled_files")
    
    if not result_dir:
        result_dir = os.path.dirname(__file__) + "/results/huggingface"
    os.makedirs(os.path.join(result_dir, "input"), exist_ok=True)

    if kernel_map_path is None:
        kernel_map_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "intermediate_results", "kernel_map", f"kernel_map_{model_id}.json")

    with open(kernel_map_path) as rf:
        kernel_map = json.load(rf)
    
    max_seq_len = None
    if has_seq_con:
        max_seq_len = get_max_model_len(model_id.replace("_", "/", 1))

    max_token_num = None
    if has_token_con:
        max_token_num = get_max_token_hf(model_id.replace("_", "/", 1))
    
    res = {}
    for file in os.listdir(f"{result_dir}/out/"+model_id):
        _read_hf_output_file(os.path.join(result_dir, "out", model_id, file), kernel_map, compile_path, res, max_seq_len, max_token_num)
    
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

def generate_all_hf(compile_path, result_dir=None, kernel_map_dir=None, has_seq_con=False, has_token_con=False):
    if compile_path is None:
        compile_path = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "benchmarks", "huggingface", "compiled_files")
    
    if not result_dir:
        result_dir = os.path.dirname(__file__) + "/results/huggingface"
    os.makedirs(os.path.join(result_dir, "input"), exist_ok=True)
    
    if kernel_map_dir is None:
        kernel_map_dir = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "intermediate_results", "kernel_map")

    res = {}
    for file in os.listdir(f"{result_dir}/out"):
        if file.endswith(".json"):
            model_id = file[:-5]
            with open(f"{kernel_map_dir}/kernel_map_{model_id}.json") as rf:
                kernel_map = json.load(rf)
            
            max_seq_len = None
            if has_seq_con:
                max_seq_len = get_max_model_len(model_id.replace("_", "/", 1))

            max_token_num = None
            if has_token_con:
                max_token_num = get_max_token_hf(model_id.replace("_", "/", 1))
            _read_hf_output_file(os.path.join(result_dir, "out", file), kernel_map, os.path.join(compile_path, model_id), res, max_seq_len, max_token_num)
        else:
            model_id = file
            with open(f"{kernel_map_dir}/kernel_map_{model_id}.json") as rf:
                kernel_map = json.load(rf)

            max_seq_len = None
            if has_seq_con:
                max_seq_len = get_max_model_len(model_id.replace("_", "/", 1))
            max_token_num = None
            if has_token_con:
                max_token_num = get_max_token_hf(model_id.replace("_", "/", 1))
            _read_hf_output_file(os.path.join(result_dir, "out", file), kernel_map, os.path.join(compile_path, model_id), res, max_seq_len, max_token_num)

def generate_research_paper_input():
    compile_path = os.path.join(os.path.dirname(current_dir), "compile", "papers")
    result_dir = os.path.dirname(__file__) + "/results/research_paper"
    kernel_map_dir = os.path.join(os.path.dirname(current_dir), "evaluation", "section-6-1-bug-detection", "intermediate_results", "kernel_map")
    generate_all_hf(compile_path, result_dir, kernel_map_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="generate input files for cuKLEE."
    )

    parser.add_argument(
        "--vllm-benchmark", action=argparse.BooleanOptionalAction, default=False, required=False, help="vLLM benchmark result directory"
    )
    parser.add_argument(
        "--hf-benchmark", action=argparse.BooleanOptionalAction, default=False, required=False, help="HuggingFace benchmark result directory"
    )
    parser.add_argument(
        "--research-paper", action=argparse.BooleanOptionalAction, default=False, required=False, help="Generate input files for the research paper"
    )
    
    parser.add_argument(
        "--cuda-source-dir", type=str, required=False, help="directory containing the CUDA and C++ files (or the repository directory)"
    )
    parser.add_argument(
        "--profile-out-dir", type=str, required=False, help="vLLM result directory"
    )
    parser.add_argument(
        "--compiled-kernel-dir", type=str, required=False, help="directory containing vLLM compiled cuda files"
    )
    parser.add_argument(
        "--vllm", action=argparse.BooleanOptionalAction, default=True, help="Whether is vLLM output or HuggingFace output"
    )
    parser.add_argument(
        "--model-id", type=str, required=False, help="Model ID for HuggingFace output"
    )   
    parser.add_argument(
        "--add-memory-max-num-tokens", action=argparse.BooleanOptionalAction, default=True, help="add num_tokens limit of 288GB GPU memory"
    ) 

    args = parser.parse_args()
    if args.research_paper:
        generate_research_paper_input()
    elif args.vllm_benchmark:
        kernel_map_path = os.path.join(current_dir, "kernel_map", "kernel_map_vllm.json")
        wrapper.find_kernel_rel(args.profile_out_dir, kernel_map_path)
        generate_vllm_inputs(None, None, kernel_map_path, True, False)
        generate_vllm_input_load(None, None, True)
    elif args.hf_benchmark:
        generate_all_hf(None, None)
    elif args.vllm:
        kernel_map_path = os.path.join(current_dir, "kernel_map", "kernel_map_vllm.json")
        wrapper.find_kernel_rel(args.cuda_source_dir, kernel_map_path)
        generate_vllm_inputs(args.profile_out_dir, args.compiled_kernel_dir, kernel_map_path, False, True, args.add_memory_max_num_tokens)
        generate_vllm_input_load(args.profile_out_dir, args.compiled_kernel_dir, kernel_map_path, False)
    elif args.model_id:
        kernel_map_path = os.path.join(current_dir, "kernel_map", f"kernel_map_{args.model_id}.json")
        wrapper.find_kernel_rel(args.cuda_source_dir, kernel_map_path)
        generate_one_hf(args.model_id, args.compiled_kernel_dir, kernel_map_path, args.profile_out_dir, True, args.add_memory_max_num_tokens)