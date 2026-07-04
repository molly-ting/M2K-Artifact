import os
import logging
import ast

from sxia.analysis_types import VllmAnalysis
from sxia.astrunner.runner import TorchCallVisitor
from sxia.value import ClassInstanceValue


logger = logging.getLogger(__name__)


# def analyze_if_any_vllm(dir: Optional[str] = None) -> VllmAnalysis:
#     """
#     Analyze the vllm models
#     """
#     try:
#         dir = dir or _get_vllm_dir()
#     except ImportError:
#         pass
#     if not dir:
#         raise ValueError(
#             "vllm directory not found, please either install transformers through pip or specify the directory"
#         )
#     if not os.path.exists(dir):
#         raise ValueError(f"{dir} does not exist")
#     if not os.path.isdir(dir):
#         raise ValueError(f"{dir} is not a directory")

#     # find the models directory
#     registry_py = os.path.join(dir, "model_executor/models/registry.py")
#     model2path = _extract_path_model_pairs(registry_py)

#     # for m in models:
#     #     if not os.path.isdir(m):
#     #         logger.error(f"{m} is not a directory")
#     #         continue
#     #     _analyze_vllm_model(m)


def _get_vllm_dir() -> str:
    """
    Get the transformers directory
    """
    import vllm

    return os.path.dirname(vllm.__file__)


def extract_path_model_pairs(vllm_dir: str) -> dict[str, str]:
    registry_py = os.path.join(vllm_dir, "model_executor/models/registry.py")
    with open(registry_py, "r", encoding="utf-8") as f:
        source = f.read()

    models_dir = os.path.dirname(registry_py)
    res: dict[str, str] = {}

    def _get_str(node: ast.AST) -> str | None:
        if isinstance(node, ast.Constant) and isinstance(node.value, str):
            return node.value
        if isinstance(node, ast.Str):
            return node.s
        return None

    def _extract_model_entry(value: ast.AST, name_map: dict[str, ast.AST]) -> tuple[str | None, str | None]:
        if isinstance(value, ast.Name) and value.id in name_map:
            value = name_map[value.id]

        if isinstance(value, (ast.Tuple, ast.List)) and len(value.elts) >= 2:
            module_name = _get_str(value.elts[0])
            cls_name = _get_str(value.elts[1])
            return module_name, cls_name

        if isinstance(value, ast.Call):
            module_name = _get_str(value.args[0]) if len(value.args) > 0 else None
            cls_name = _get_str(value.args[1]) if len(value.args) > 1 else None

            for kw in value.keywords:
                if kw.arg in {"module", "model", "model_file", "model_name"}:
                    module_name = _get_str(kw.value) or module_name
                if kw.arg in {"cls", "model_cls", "class_name", "class", "entry"}:
                    cls_name = _get_str(kw.value) or cls_name

            return module_name, cls_name

        return None, None

    def _merge_dict(dst: dict[ast.AST, ast.AST], src: dict[ast.AST, ast.AST]) -> None:
        for k, v in src.items():
            dst[k] = v

    try:
        tree = ast.parse(source, filename=registry_py)
    except SyntaxError:
        tree = None

    dict_map: dict[str, dict[ast.AST, ast.AST]] = {}
    name_map: dict[str, ast.AST] = {}

    if tree is not None:
        for node in tree.body:
            if isinstance(node, ast.Assign):
                if len(node.targets) != 1 or not isinstance(node.targets[0], ast.Name):
                    continue
                target_name = node.targets[0].id
                if isinstance(node.value, ast.Dict):
                    dict_map[target_name] = dict(zip(node.value.keys, node.value.values))
                elif isinstance(node.value, (ast.Tuple, ast.List, ast.Call)):
                    name_map[target_name] = node.value
            elif isinstance(node, ast.Expr) and isinstance(node.value, ast.Call):
                call = node.value
                if isinstance(call.func, ast.Attribute) and call.func.attr == "update":
                    if isinstance(call.func.value, ast.Name) and call.args:
                        base_name = call.func.value.id
                        if base_name not in dict_map:
                            continue
                        arg0 = call.args[0]
                        if isinstance(arg0, ast.Name) and arg0.id in dict_map:
                            _merge_dict(dict_map[base_name], dict_map[arg0.id])
                        elif isinstance(arg0, ast.Dict):
                            tmp = dict(zip(arg0.keys, arg0.values))
                            _merge_dict(dict_map[base_name], tmp)

    model_dict = dict_map.get("_TEXT_GENERATION_MODELS")
    if model_dict:
        for key_node, val_node in model_dict.items():
            model_name = _get_str(key_node)
            module_name, cls_name = _extract_model_entry(val_node, name_map)
            if not model_name or not module_name or not cls_name:
                continue
            if module_name.endswith(".py"):
                module_name = module_name[:-3]
            res[cls_name] = os.path.join(models_dir, module_name + ".py")
            logger.debug("Found model %s at %s", cls_name, res[cls_name])
        return res

    # Fallback: original line-based parse for unexpected formats.
    started = False
    for line in source.splitlines():
        line = line.strip()
        if line.startswith("#"):
            continue
        if line.startswith("_TEXT_GENERATION_MODELS"):
            started = True
            continue
        if not started:
            continue
        if line.startswith("}"):
            started = False
            continue
        parts = line.split(":")
        if len(parts) != 2:
            continue
        pair = parts[1]
        pair = (
            pair.strip()
            .replace("'", "")
            .replace('"', "")
            .replace("(", "")
            .replace(")", "")
            .replace(",", "")
        )
        items = pair.split(" ")
        if len(items) < 2:
            continue
        res[items[1]] = os.path.join(models_dir, items[0] + ".py")
    return res


def analyze_vllm_model(
    cls_name: str, py_file: str, vllm_dir: str, config: dict, func_name: str = None, out_path: str = None
):
    if config is None:
        config = {}
    # first, construct VllmConfig from config dictionary
    vllm_config = ClassInstanceValue(None)
    vllm_config.ty = "vllm.config.VllmConfig"
    vllm_config.value["model_config"] = ClassInstanceValue(None)
    vllm_config.value["model_config"].ty = "vllm.config.ModelConfig"
    vllm_config.value["model_config"].value["hf_config"] = config

    return TorchCallVisitor.starts_from(
        py_file,
        cls_name,
        vllm_config,
        func_name or "forward",
        # "forward_cuda",
        # "generate",
        # "apply",
        [],
        resolve_import_dirs=[os.path.dirname(vllm_dir)],
        out_path=out_path
    )
