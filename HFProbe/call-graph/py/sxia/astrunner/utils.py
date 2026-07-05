import json
import os
from sxia.analysis_types import PyCppBinding, TorchCall
from sxia.value import ClassInstanceValue, ModuleInstanceValue, Value


def get_torch_calls_from_file(
    repo_path: str,
    entry_cls: str,
    entry_cls_py_path: str,
    bindings: list[PyCppBinding],
    auto_config_cls: str = None,
    auto_config_cls_py_path: str = None,
    entry_func="forward",
    out_path: str = None
) -> list[TorchCall]:
    if os.path.exists(out_path):
        return []
    
    from sxia.astrunner.runner import FuncRunner, TorchCallVisitor

    config_json_path = os.path.join(repo_path, "config.json")
    if not os.path.exists(config_json_path):
        raise FileNotFoundError(config_json_path)
    with open(config_json_path, "r") as f:
        config_json = json.load(f)
    config_value = None

    # evaluate config if available
    # 1. find config.json if available
    # 2. find class `auto_config_cls` if available
    # 3. evaluate class `auto_config_cls` with config.json
    if auto_config_cls:
        if not os.path.exists(auto_config_cls_py_path):
            raise FileNotFoundError(auto_config_cls_py_path)

        mod_env = ModuleInstanceValue.from_file(auto_config_cls_py_path)

        cls_val = mod_env.value.get(auto_config_cls)

        config_value = FuncRunner(
            cls_val.def_at,
            env=mod_env,
            kwargs=config_json,
            resolve_import_dirs=[repo_path],
        ).run()

        if "seq_length" not in config_value.value:
            if "seq_length" in config_json:
                config_value.value["seq_length"] = config_json["seq_length"]

        if "output_attentions" not in config_value.value:
            config_value.value["output_attentions"] = config_json.get(
                "output_attentions", False
            )

        config_value.value["use_cache_quantization"] = True
        config_value.value["use_cache_kernel"] = True

        if "output_hidden_states" not in config_value.value:
            config_value.value["output_hidden_states"] = config_json.get(
                "output_hidden_states", False
            )
    else:
        config_value = Value(value=config_json, def_at=None)

    if "num_hidden_layers" not in config_value.value:
        config_value.value["num_hidden_layers"] = config_json.get("n_layer")

    if "num_attention_heads" not in config_value.value:
        config_value.value["num_attention_heads"] = config_json.get("n_head")

    # inject some common AutoConfig properties
    if config_value:
        config_value.value["use_return_dict"] = Value.from_constant(True)
    
    return TorchCallVisitor.starts_from(
        entry_cls_py_path,
        entry_cls,
        # config_value,
        Value(None, def_at=None),
        entry_func,
        bindings,
        resolve_import_dirs=[repo_path],
        out_path=out_path
    )

def analyze_transformers_model(
    repo_path: str, entry_cls: str, entry_cls_py_path: str, func_name: str = None, out_path: str = None
):
    hf_config = ClassInstanceValue(None)

    return TorchCallVisitor.starts_from(
        entry_cls_py_path,
        entry_cls,
        hf_config,
        func_name or "forward",
        [],
        resolve_import_dirs=[repo_path],
        out_path=out_path
    )
