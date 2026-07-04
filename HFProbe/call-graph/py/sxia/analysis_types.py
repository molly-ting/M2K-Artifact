from dataclasses import dataclass

from sxia.value import Value


@dataclass
class TorchCall:
    name: str
    args: list[Value]
    kwargs: dict[str, Value]
    lineno: int


@dataclass
class CudaFunction:
    file: str
    function: str


@dataclass
class PyCppBinding:
    file: str
    py_function: str
    cpp_function: str
    calls: list[str] = None


@dataclass
class VllmAnalysis:
    entry_point: str
    torch_calls: list[TorchCall]


@dataclass
class Analysis:
    repo_path: str
    auto_config_cls: str
    auto_model_cls_list: list[dict[str, str]]
    class_defs: dict[str, str]
    torch_calls: list[TorchCall]
    bindings: list[PyCppBinding]
    cuda_functions: list[CudaFunction]
    vllm: VllmAnalysis
    vllm_error: str = None
