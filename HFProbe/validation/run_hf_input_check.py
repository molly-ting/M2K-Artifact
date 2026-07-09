import ast
import json
import os
from pathlib import Path

import run_transformers_check as rt


root_dir = Path(__file__).resolve().parent.parent
repo_root = root_dir.parent
result_dir = root_dir / "results" / "huggingface"

INPUT_CHECK_PATH = result_dir / "input_check.json"
HF_MODELS_PATH = root_dir / "data" / "hfmodels0.json"
OUT_DIR = result_dir / "out_check"
DATA_DIR = result_dir / "data_check"
LOCAL_MODELS_DIR = Path(os.getenv("HF_LOCAL_MODELS_DIR", root_dir / "data" / "models"))


def resolve_repo_path(path):
    path = Path(path)
    if path.is_absolute():
        return path
    root_candidate = root_dir / path
    if root_candidate.exists():
        return root_candidate.resolve()
    repo_candidate = repo_root / path
    if repo_candidate.exists():
        return repo_candidate.resolve()
    return root_candidate.resolve()


def load_model_map():
    mapping = {}
    if HF_MODELS_PATH.exists():
        model_ids = json.loads(HF_MODELS_PATH.read_text())
        for model_id in model_ids:
            mapping[model_id.replace("/", "_")] = model_id
    return mapping


def infer_hf_repo_id(model_key):
    if "/" in model_key:
        return model_key
    if "_" not in model_key:
        return model_key
    org, repo = model_key.split("_", 1)
    return f"{org}/{repo}"


def resolve_model_id(model_key, model_map):
    local_model_dir = LOCAL_MODELS_DIR / model_key
    if local_model_dir.exists():
        return str(local_model_dir)
    if "/" in model_key:
        return model_key
    if model_key in model_map:
        mapped = model_map[model_key]
        if "/" in mapped:
            return mapped
    return infer_hf_repo_id(model_key)


def eval_shape_expr(expr, batch_size, seq_len):
    if isinstance(expr, int):
        return expr
    if isinstance(expr, float):
        return int(expr)
    if isinstance(expr, str):
        safe = expr.replace("b", str(batch_size)).replace("s", str(seq_len))
        node = ast.parse(safe, mode="eval")
        for subnode in ast.walk(node):
            if not isinstance(
                subnode,
                (
                    ast.Expression,
                    ast.BinOp,
                    ast.UnaryOp,
                    ast.Add,
                    ast.Sub,
                    ast.Mult,
                    ast.Div,
                    ast.FloorDiv,
                    ast.Mod,
                    ast.Pow,
                    ast.USub,
                    ast.UAdd,
                    ast.Constant,
                ),
            ):
                raise ValueError(f"Unsafe shape expr: {expr}")
        value = eval(compile(node, "<shape-expr>", "eval"), {"__builtins__": {}}, {})
        return int(round(float(value)))
    raise TypeError(f"Unsupported shape expr type: {type(expr)}")


def concretize_args(args, batch_size, seq_len):
    concretized = []
    for arg in args:
        new_arg = dict(arg)
        if "shape" in new_arg:
            new_arg["shape"] = [
                eval_shape_expr(dim, batch_size, seq_len) for dim in new_arg["shape"]
            ]
        concretized.append(new_arg)
    return concretized


def load_expected_entry(cuda_function_name, index):
    path = result_dir / "input" / f"{cuda_function_name}.json"
    data = json.loads(path.read_text())
    return data[int(index)]


def load_recorded_calls(data_path):
    data = json.loads(Path(data_path).read_text())
    calls = []
    for item in data:
        calls.extend(item.get("calls", []))
    return calls


def shapes_match(expected_args, recorded_args):
    if len(expected_args) != len(recorded_args):
        return False
    for expected, recorded in zip(expected_args, recorded_args):
        if expected.get("shape") != recorded.get("shape"):
            return False
    return True


def normalize_config_path(config_path):
    if not config_path:
        return None
    return str(resolve_repo_path(config_path))


def resolve_config_path(model_key, config_path):
    if not config_path:
        return None
    direct = resolve_repo_path(config_path)
    if direct.exists():
        return direct
    candidate = result_dir / "config" / model_key / Path(config_path).name
    if candidate.exists():
        return candidate.resolve()
    raise FileNotFoundError(f"Cannot resolve config path for {model_key}: {config_path}")


def build_case_key(model_id, config_path, batch_size, seq_len):
    return (model_id, normalize_config_path(config_path), batch_size, seq_len)


def run_case(model_id, case_cfg, suffix):
    config_path = case_cfg.get("config")
    override_configs = None
    if config_path:
        resolved = resolve_config_path(case_cfg["model_key"], config_path)
        override_configs = json.loads(resolved.read_text())

    batch_size = case_cfg["batch_size"]
    seq_len = case_cfg["seq_len"]

    return rt.run(
        model_id=model_id,
        override_configs=override_configs,
        suffix=suffix,
        output_dir=str(OUT_DIR),
        data_dir=str(DATA_DIR),
        batch_size_configs=[batch_size],
        seq_lens_configs=[seq_len],
        record_only=True,
    )


def validate_case(cuda_function_name, bug_id, model_key, index, case_cfg, model_map, case_cache):
    model_id = resolve_model_id(model_key, model_map)
    case_cfg = dict(case_cfg)
    case_cfg["model_key"] = model_key
    batch_size = case_cfg["batch_size"]
    seq_len = case_cfg["seq_len"]
    config_path = case_cfg.get("config")
    resolved_config_path = None
    if config_path:
        resolved_config_path = str(resolve_config_path(model_key, config_path))
    case_key = build_case_key(model_id, resolved_config_path, batch_size, seq_len)
    if case_key not in case_cache:
        suffix = f"case_{model_key}_{index}_{batch_size}_{seq_len}"
        try:
            case_cache[case_key] = run_case(model_id, case_cfg, suffix)
        except Exception as e:
            case_cache[case_key] = {"error": f"{type(e).__name__}: {e}"}
    result = case_cache[case_key]
    if "error" in result:
        return {
            "matched": False,
            "model_id": model_id,
            "model_key": model_key,
            "index": index,
            "batch_size": batch_size,
            "seq_len": seq_len,
            "config": config_path,
            "error": result["error"],
        }

    expected_entry = load_expected_entry(cuda_function_name, index)
    expected_args = concretize_args(expected_entry["args"], batch_size, seq_len)
    expected_name = expected_entry.get("py_function", cuda_function_name)
    recorded_calls = load_recorded_calls(result["data_path"])

    for call in recorded_calls:
        if call.get("name") != expected_name:
            continue
        if shapes_match(expected_args, call.get("args", [])):
            return {
                "matched": True,
                "model_id": model_id,
                "index": index,
                "batch_size": batch_size,
                "seq_len": seq_len,
                "data_path": result["data_path"],
                "expected_name": expected_name,
            }

    return {
        "matched": False,
        "model_id": model_id,
        "model_key": model_key,
        "index": index,
        "batch_size": batch_size,
        "seq_len": seq_len,
        "config": config_path,
        "data_path": result["data_path"],
        "expected_name": expected_name,
    }


def main():
    model_map = load_model_map()
    input_check = json.loads(INPUT_CHECK_PATH.read_text())
    summary = {}
    case_cache = {}

    for cuda_function_name, bugs in input_check.items():
        summary[cuda_function_name] = {}
        for bug_id, models in bugs.items():
            bug_result = {"matched": False, "attempts": []}
            for model_key, case_entries in models.items():
                for index, case_cfg in case_entries.items():
                    res = validate_case(
                        cuda_function_name,
                        bug_id,
                        model_key,
                        index,
                        case_cfg,
                        model_map,
                        case_cache,
                    )
                    bug_result["attempts"].append(res)
            bug_result["matched"] = any(item["matched"] for item in bug_result["attempts"])
            bug_result["matches"] = [item for item in bug_result["attempts"] if item["matched"]]
            summary[cuda_function_name][bug_id] = bug_result

    summary_path = result_dir / "input_check_results.json"
    summary_path.write_text(json.dumps(summary, indent=2, ensure_ascii=False))
    print(f"[OK] wrote results to {summary_path}")


if __name__ == "__main__":
    main()
