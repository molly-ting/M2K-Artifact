from typing import Optional, Tuple
import os
import logging
import ast

from sxia.utils.ast import get_inherited_classes
from sxia.value import ClassValue, ModuleInstanceValue


logger = logging.getLogger(__name__)

def get_transformers_dir() -> str:
    """
    Get the transformers directory
    """
    import transformers

    return os.path.dirname(transformers.__file__)


_MODELS = None


def get_transformers_models(dir: Optional[str] = None) -> list[str]:
    global _MODELS
    if _MODELS is not None:
        return _MODELS
    _MODELS = {}

    model_dirs_parent = os.path.join(dir, "models")
    model_dirs = [
        os.path.join(model_dirs_parent, d)
        for d in os.listdir(model_dirs_parent)
        if not d.endswith(".py")
    ]

    for md in model_dirs:
        if not os.path.isdir(md):
            continue
        configs, models = _list_config_and_model(md)

        for model in models:
            _MODELS[model.def_at.name] = model

    return _MODELS


def _list_config_and_model(model_dir: str) -> Tuple[list[ClassValue], list[ClassValue]]:
    """
    List entrypoints from the transformers model
    1. list all python files
    2. find the configs (if any)
    3. find the models (if any)
    """
    py_files = [
        os.path.join(model_dir, f) for f in os.listdir(model_dir) if f.endswith(".py")
    ]

    config_cls_list = []
    model_cls_list = []
    for f in py_files:
        mod_inst = ModuleInstanceValue.from_file(f)
        cls_list = mod_inst.list_classes()
        for cls in cls_list:
            base_cls_list = get_inherited_classes(cls.def_at)
            for base_cls in base_cls_list:
                if base_cls.endswith("PreTrainedModel"):
                    model_cls_list.append(cls)
                    break
                elif base_cls.endswith("PretrainedConfig"):
                    config_cls_list.append(cls)
                    break

    return config_cls_list, model_cls_list
