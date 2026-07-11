import importlib
import os

from sxia.analysis_types import VllmAnalysis
from sxia.astrunner.runner import TorchCallVisitor
from sxia.value import ClassInstanceValue


def _get_vllm_dir() -> str:
    """
    Get the vllm directory
    """
    spec = importlib.util.find_spec("vllm")
    if spec is None or spec.origin is None:
        raise ModuleNotFoundError("No module named 'vllm'")

    vllm_dir = (
        spec.submodule_search_locations[0]
        if spec.submodule_search_locations
        else os.path.dirname(spec.origin)
    )
    return vllm_dir


def extract_path_model_pairs(vllm_dir: str) -> dict[str, str]:
    registry_py = os.path.join(vllm_dir, "model_executor/models/registry.py")
    with open(registry_py, "r") as f:
        lines = f.readlines()

    models_dir = os.path.dirname(registry_py)
    res = {}
    started = False
    for line in lines:
        line = line.strip()
        if line.startswith("#"):
            continue
        # if line.startswith("_TEXT_GENERATION_MODELS"):
        if line.startswith("_") and "_MODELS = {" in line:
            started = True
            continue
        if not started:
            continue
        if line.startswith("}"):
            # break
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
