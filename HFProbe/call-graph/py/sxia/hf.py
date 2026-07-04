from dataclasses import asdict
import os
import logging
import json
import re
from typing import Optional

from pydantic import BaseModel

from sxia.analysis_types import Analysis, CudaFunction, PyCppBinding, TorchCall
from sxia.astrunner.utils import get_torch_calls_from_file
from sxia.utils.vllm import analyze_vllm_model, extract_path_model_pairs

logger = logging.getLogger(__name__)


def get_cuda_functions(cuda_file: str) -> list["CudaFunction"]:
    """
    Use simple regex to find CUDA functions in a CUDA file.
    """
    cuda_functions = []
    # function_pattern = re.compile(r"__\w+\s+void\s+(\w+)\s*\(")
    function_pattern = re.compile(
        r"(?:__\w+\s+)*[\w:<>\*&]+\s+(\w+)\s*\([^)]*\)\s*(?:const)?\s*\{",
        re.MULTILINE,
    )

    try:
        with open(cuda_file, "r", encoding="utf-8") as f:
            content = f.read()

        matches = function_pattern.findall(content)
        for match in matches:
            if match == "if":
                continue
            cf = CudaFunction(file=cuda_file, function=match)
            if cf not in cuda_functions:
                cuda_functions.append(cf)

    except FileNotFoundError:
        print(f"File {cuda_file} not found.")
    except Exception as e:
        print(f"Error processing {cuda_file}: {e}")

    return cuda_functions


def parse_cpp_cudas(cpp_content: str):
    """
    Parses C++ code to extract:
    1. Function name.
    2. Function body.
    3. Calls inside the function.

    Args:
        cpp_content (str): The C++ code as a string.

    Returns:
        list[dict]: A list of dictionaries, each containing:
            - 'function_name': Name of the parsed function.
            - 'body': Full function body as a string.
            - 'calls': List of function calls inside the function body.
    """
    function_pattern = re.compile(r"\b[\w:<>~]+\s+(\w+)\s*\(([^)]*)")
    # function_pattern = re.compile(r"void\s+(\w+)\s*\(([^)]*)")
    call_pattern = re.compile(r"(\w+)\(")  # Matches function calls

    lines = cpp_content.splitlines()
    results = []
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        match = function_pattern.match(line)

        if match:
            function_name = match.group(1)
            is_declaration = False
            while i < len(lines) and not line.endswith("{"):
                if line.endswith(";"):
                    is_declaration = True
                    break
                i += 1
                line = lines[i].strip()
            if is_declaration:
                i += 1
                continue
            function_body = []
            calls = []
            bracket_count = 1  # Track nested braces

            i += 1
            while i < len(lines) and bracket_count > 0:
                body_line = lines[i].strip()
                function_body.append(body_line)

                # Check for function calls
                call_matches = call_pattern.findall(body_line)
                for call in call_matches:
                    if call != function_name:  # Avoid recursive calls
                        calls.append(call)

                # Track braces to detect function end
                bracket_count += body_line.count("{")
                bracket_count -= body_line.count("}")

                i += 1

            results.append(
                {
                    "function_name": function_name,
                    "body": "\n".join(function_body),
                    "calls": list(set(calls)),  # Remove duplicates
                }
            )

        else:
            i += 1

    return results


def parse_m_def_relationships(file_path: str) -> list[PyCppBinding]:
    """
    Parses a C++ file to extract relationships from m.def() calls.

    Args:
        file_path (str): Path to the C++ file.

    Returns:
        list[tuple[str, str]]: A list of PyCppBinding.
    """
    relationships: list[PyCppBinding] = []
    pattern = re.compile(r'm\.def\(\s*"(\w+)"\s*,\s*&(\w+)\s*,', re.MULTILINE)

    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()

        cpp_impls = parse_cpp_cudas(content)

        indexed_cpp_impls = {
            cpp_impl["function_name"]: cpp_impl for cpp_impl in cpp_impls
        }

        matches = pattern.findall(content)
        for match in matches:
            py_function = match[0]
            cpp_function = match[1]
            calls = indexed_cpp_impls.get(cpp_function, {}).get("calls", [])
            relationships.append(
                PyCppBinding(
                    file=file_path,
                    py_function=py_function,
                    cpp_function=cpp_function,
                    calls=calls,
                )
            )

    except FileNotFoundError:
        print(f"File {file_path} not found.")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

    return relationships


def find_files(dir: str, filter: callable):
    filtered_files = []
    for root, _, files in os.walk(dir):
        if root.find(".git") != -1:
            continue
        for file in files:
            if filter(file):
                filtered_files.append(os.path.join(root, file))
    return filtered_files


def get_class_defs(py_file: str) -> list[str]:
    """
    Get class definitions from a python file.
    """
    class_defs = []
    with open(py_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line.startswith("class "):
                class_defs.append(line.split("(")[0][6:])
    return class_defs


def get_analysis(path: str, vllm_dir: str) -> Analysis:
    logger.info(f"Analyzing huggingface repository {path}")

    config_obj = None
    auto_config_cls = None
    auto_model_cls_list = []

    py_files = find_files(path, lambda file: file.endswith(".py"))
    # Get all class definitions
    class_defs = {
        cls: py_file for py_file in py_files for cls in get_class_defs(py_file)
    }
    with open(os.path.join(path, "config.json"), "r") as f:
        config_obj = json.load(f)

    if "auto_map" in config_obj:
        for key, value in config_obj["auto_map"].items():
            if key.startswith("AutoModel"):
                cls_name = value.split(".")[-1]
                auto_model_cls_list.append(
                    {
                        "name": cls_name,
                        "local": cls_name in class_defs,
                    }
                )

            elif "AutoConfig" == key:
                if auto_config_cls is not None:
                    raise ValueError("Multiple auto_config_cls found")
                auto_config_cls = value.split(".")[-1]

    ## Analyze cuda and cpp bindings
    cuda_files = find_files(
        path, lambda file: file.endswith(".cu") or file.endswith(".cuh")
    )
    cpp_files = find_files(
        path, lambda file: file.endswith(".cpp") or file.endswith(".hpp")
    )
    cuda_fns = [fn for cuda_file in cuda_files for fn in get_cuda_functions(cuda_file)]
    bindings = [
        fn for cpp_file in cpp_files for fn in parse_m_def_relationships(cpp_file)
    ]

    ##############
    # Get torch calls
    torch_calls = get_torch_calls(
        path, auto_model_cls_list, class_defs, bindings, auto_config_cls
    )
    
    # va = analyze_vllm_model(
    #                 "LLM", "/opt/anaconda3/envs/vllm-env/lib/python3.10/site-packages/vllm/entrypoints/llm.py", vllm_dir, config_obj
    #             )
    # va = analyze_vllm_model(
    #                 "UnquantizedFusedMoEMethod", "/opt/anaconda3/envs/vllm-env/lib/python3.10/site-packages/vllm/model_executor/layers/fused_moe/layer.py", vllm_dir, config_obj
    #             )

    # ### try to get the calls from vLLM if any
    va = None
    va_err = None
    try:
        architectures = config_obj.get("architectures", [])
        architecture = None
        if len(architectures) == 1 and vllm_dir is not None:
            architecture = architectures[0]

            vllm_model2path = extract_path_model_pairs(vllm_dir)
            if architecture and architecture in vllm_model2path:
                va = analyze_vllm_model(
                    architecture, vllm_model2path[architecture], vllm_dir, config_obj
                )
    except Exception as e:
        logger.warning(f"Failed to analyze vLLM model: {e}")
        va = None
        va_err = str(e)

    return Analysis(
        repo_path=path,
        auto_config_cls=auto_config_cls,
        auto_model_cls_list=auto_model_cls_list,
        class_defs=class_defs,
        torch_calls=torch_calls,
        bindings=bindings,
        cuda_functions=cuda_fns,
        vllm=va,
        # vllm_error=va_err,
        vllm_error="",
    )


def get_torch_calls(
    repo_path: str,
    auto_model_cls_list: list[dict[str, str]],
    class_defs: dict[str, str],
    bindings: list[PyCppBinding],
    auto_config_cls: str = None,
) -> list[TorchCall]:
    torch_calls = []
    for cls in auto_model_cls_list:
        if cls["local"]:
            cls_name = cls["name"]
            torch_calls.extend(
                get_torch_calls_from_file(
                    repo_path,
                    cls_name,
                    class_defs[cls_name],
                    bindings,
                    auto_config_cls if auto_config_cls in class_defs else None,
                    class_defs[auto_config_cls] if auto_config_cls else None,
                )
            )
    return torch_calls


# def cfg_get_torch_calls_from_file(
#     repo_path: str,
#     entry_cls: str,
#     entry_cls_py_path: str,
#     bindings: list[PyCppBinding],
#     auto_config_cls: str = None,
#     auto_config_cls_py_path: str = None,
#     entry_func="forward",
# ) -> list[TorchCall]:
#     config_value = None

#     # evaluate config if available
#     # 1. find config.json if available
#     # 2. find class `auto_config_cls` if available
#     # 3. evaluate class `auto_config_cls` with config.json
#     if auto_config_cls:
#         if not os.path.exists(auto_config_cls_py_path):
#             raise FileNotFoundError(auto_config_cls_py_path)

#         mod_env = ModuleInstanceValue.from_file(auto_config_cls_py_path)

#         cls_val = mod_env.get(auto_config_cls)

#         config_json_path = os.path.join(repo_path, "config.json")
#         if not os.path.exists(config_json_path):
#             raise FileNotFoundError(config_json_path)
#         with open(config_json_path, "r") as f:
#             config_json = json.load(f)

#         paths = FuncRunner(CachedCFGBuilder()).run(
#             cls_val.def_at,
#             env=mod_env,
#             kwargs=config_json,
#         )
#         config_value = paths[0].return_value

#         if "seq_length" not in config_value.value:
#             if "seq_length" in config_json:
#                 config_value.value["seq_length"] = config_json["seq_length"]

#         if "output_attentions" not in config_value.value:
#             config_value.value["output_attentions"] = config_json.get(
#                 "output_attentions", False
#             )

#         config_value.value["use_cache_quantization"] = True

#         if "output_hidden_states" not in config_value.value:
#             config_value.value["output_hidden_states"] = config_json.get(
#                 "output_hidden_states", False
#             )

#     # inject some common AutoConfig properties
#     if config_value:
#         config_value.value["use_return_dict"] = Value.from_constant(True)

#     return TorchCallVisitor.starts_from(
#         entry_cls_py_path, entry_cls, config_value, entry_func, bindings
#     )


class HfAnalysisConfig(BaseModel):
    path: str
    out: str
    transformers_dir: Optional[str]
    vllm_dir: Optional[str]


def analyze(config: HfAnalysisConfig):
    if not os.path.exists(config.path):
        raise FileNotFoundError(config.path)
    if not os.path.exists(config.out):
        os.makedirs(config.out, exist_ok=True)

    error = None
    analysis = None
    try:
        analysis = get_analysis(config.path, config.vllm_dir)
    except Exception as e:
        error = str(e)
        logger.exception(error)

    result = {"analysis": asdict(analysis) if analysis else None, "error": error}
    model_name = os.path.basename(config.path)
    out_path = os.path.join(config.out, model_name)
    os.makedirs(out_path, exist_ok=True)
    with open(os.path.join(out_path, "analysis.json"), "w") as f:
        json.dump(result, f, indent=4)

def transformers_test(path: str):
    logger.info(f"Analyzing huggingface repository {path}")

    config_obj = None
    auto_config_cls = None
    auto_model_cls_list = []

    py_files = find_files(path, lambda file: file.endswith(".py"))
    # Get all class definitions
    class_defs = {
        cls: py_file for py_file in py_files for cls in get_class_defs(py_file)
    }
    with open(os.path.join(path, "config.json"), "r") as f:
        config_obj = json.load(f)

    if "auto_map" in config_obj:
        for key, value in config_obj["auto_map"].items():
            if key.startswith("AutoModel"):
                cls_name = value.split(".")[-1]
                auto_model_cls_list.append(
                    {
                        "name": cls_name,
                        "local": cls_name in class_defs,
                    }
                )

            elif "AutoConfig" == key:
                if auto_config_cls is not None:
                    raise ValueError("Multiple auto_config_cls found")
                auto_config_cls = value.split(".")[-1]

    ## Analyze cuda and cpp bindings
    cuda_files = find_files(
        path, lambda file: file.endswith(".cu") or file.endswith(".cuh")
    )
    cpp_files = find_files(
        path, lambda file: file.endswith(".cpp") or file.endswith(".hpp")
    )
    cuda_fns = [fn for cuda_file in cuda_files for fn in get_cuda_functions(cuda_file)]
    bindings = [
        fn for cpp_file in cpp_files for fn in parse_m_def_relationships(cpp_file)
    ]

    ##############
    # Get torch calls
    torch_calls = get_torch_calls(
        path, auto_model_cls_list, class_defs, bindings, auto_config_cls
    )
    
def vllm_test(vllm_dir: str = "/Users/molly/Downloads/vllm-main/vllm"):
    start_time = time.time()
    time_map = {}
    # model_dir = "/Users/molly/Workspace/vllm/model_executor/models"
    vllm_model2path = extract_path_model_pairs(vllm_dir)
    # vllm_model2path.update({"GraniteMoeSharedForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/granitemoeshared.py",
    #                   "MiMoForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/mimo.py", 
    #                   "TeleChat2ForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/telechat2.py",
    #                   "Phi3ForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/phi3.py",
    #                   "MiniCPM3ForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/minicpm3.py",
    #                   "GraniteMoeHybridForCausalLM": "/Users/molly/Workspace/vllm/vllm/model_executor/models/granitemoehybrid.py"})
    os.makedirs("/Users/molly/Workspace/pyanalyzer/cgout", exist_ok=True)
    for architecture in vllm_model2path:
        try:
            out_path = os.path.join("/Users/molly/Workspace/pyanalyzer/cgout", architecture+"_forward.json")
            # if os.path.exists(out_path):
            #     continue
            va = analyze_vllm_model(architecture, vllm_model2path[architecture], vllm_dir, None, None)
        except Exception as ex:
            print(ex)
            traceback.print_exc()
            continue
    # architecture = "ArcticForCausalLM"
    # architecture = "Qwen3MoeForCausalLM"
    # va = analyze_vllm_model(architecture, vllm_model2path[architecture], vllm_dir, None, None)
    # architecture = "LlamaForCausalLM"
    # architecture = "Gemma3ForCausalLM"
    # architecture = "DeepseekV3ForCausalLM"
    # architecture = "BartForConditionalGeneration"
    # architecture = "MolmoForCausalLM"
    # py_file = vllm_model2path[architecture]
    # architecture = "MLACommonImpl"
    # py_file = "/Users/molly/Workspace/vllm/vllm/attention/backends/mla/common.py"
    # start_time = time.time()
    # out_path = os.path.join("/Users/molly/Workspace/pyanalyzer/cgout", architecture+"_forward_new.json")
    # va = analyze_vllm_model(architecture, py_file, vllm_dir, None, None, out_path)
    end_time = time.time()
    time_map["total"] = end_time - start_time
    logger.info(f"total time cost: {end_time - start_time} seconds.")
    with open("/Users/molly/Workspace/pyanalyzer/time.json", "w") as f:
        json.dump(time_map, f, indent=4)

import ast
import traceback
import time

def indirect_fill(
    vllm_dir: str = "/Users/molly/Downloads/vllm-main/vllm",
    target_file: str = "/Users/molly/Workspace/pyanalyzer/cgout/Qwen3MoeForCausalLM_forward.json",
):
    start_time = time.time()
    unknown_calls = {}
    # target_file = "/Users/molly/Workspace/pyanalyzer/cgout/Qwen3MoeForCausalLM_forward.json"
    # target_file = "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/AWQMarlinLinearMethod_apply.json"
    # target_file = "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/CompressedTensorsLinearMethod_apply.json"
    # target_file = "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/QuarkLinearMethod_apply.json"
    # target_file = "/Users/molly/Workspace/pyanalyzer/cgout/scheme/QuarkW8A8Int8_apply_weights.json"
    with open(target_file) as f:
        call_graph = json.load(f)
    
    for key in call_graph:
        value = call_graph[key]
        if "unknown" in value and value["unknown"]:
            for call in value["unknown"]:
                if call["type"]:
                    func = call["function"].split(".")[-1]
                    unknown_calls[(call["type"], func)] = call["filepath"]
    
    print("unknown_calls", unknown_calls)
    for key in unknown_calls:
        class_name, func_name = key
        # if class_name == "AttentionImpl":
        # if class_name == "LinearMethodBase":
        #     print("@")
        # else:
        #     continue
        # if func_name == "apply":
        #     continue
        # if func_name == "apply":
        #     print("@")
        # else:
        #     continue
        filepath = unknown_calls[key] 
        dirpath = os.path.dirname(filepath)
        if filepath.endswith("fused_moe/layer.py") or filepath.endswith("fused_moe/fused_moe_method_base.py"):
            dirpath = os.path.dirname(dirpath)
        for root, _, files in os.walk(dirpath):
            for f in files:
                if not f.endswith(".py") or f.startswith("_"):
                    continue
                new_path = os.path.join(root, f)
                if "apply_weights" in func_name and "scheme" in class_name:
                    children = find_all_schemes(os.path.dirname(vllm_dir), new_path)
                    class_name = "scheme"
                else:
                    children = find_all_subclasses(os.path.dirname(vllm_dir), new_path, class_name)
                for c in children:
                    # if c == "QuarkLinearMethod":
                    #     print("#")
                    # else:
                    #     continue
                    # if c.startswith("GPTQ"):
                    #     print("#")
                    print(c, new_path)
                    os.makedirs("/Users/molly/Workspace/pyanalyzer/cgout/"+class_name, exist_ok=True)
                    out_path = os.path.join("/Users/molly/Workspace/pyanalyzer/cgout/"+class_name, c+"_"+func_name+".json")
                    if os.path.exists(out_path):
                        continue
                    try:
                        va = analyze_vllm_model(c, new_path, vllm_dir, None, func_name, out_path)
                    except Exception as ex:
                        print(ex)
                        traceback.print_exc()
                        continue
    end_time = time.time()
    print(f"time cost: {end_time - start_time} seconds.")
    logger.info(f"time cost: {end_time - start_time} seconds.")
    
def build_class_and_import_maps(tree):
    class_map = {}
    import_map = {}  # alias → (module, original)

    for node in tree.body:
    # for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef):
            class_map[node.name] = node
        elif isinstance(node, ast.ImportFrom):
            mod = node.module
            for alias in node.names:
                import_map[alias.asname or alias.name] = (mod, alias.name)
        elif isinstance(node, ast.Import):
            for alias in node.names:
                import_map[alias.asname or alias.name] = (alias.name, alias.name)
    return class_map, import_map

def find_module_file(mod_name, root_dir, current_file):
    if not mod_name:
        return None
    
    if not mod_name.startswith("."):
        rel_path = mod_name.replace(".", os.sep) + ".py"
        mod_path = os.path.join(root_dir, rel_path)
    else:
        m = re.match(r"^(\.+)", mod_name)
        level = len(m.group(1)) if m else 0
        rel_mod = mod_name[level:].lstrip(".")
        new_path = os.path.dirname(current_file)
        for _ in range(level - 1):
            new_path = os.path.dirname(new_path)
        if rel_mod:
            mod_path = os.path.join(new_path, rel_mod.replace(".", os.sep)) + ".py"
    
    if mod_path and os.path.exists(mod_path):
        return mod_path
    return None

def get_base_names(node):
    bases = []
    for base in node.bases:
        if isinstance(base, ast.Name):
            bases.append(base.id)
        elif isinstance(base, ast.Attribute):
            parts = []
            cur = base
            while isinstance(cur, ast.Attribute):
                parts.append(cur.attr)
                cur = cur.value
            if isinstance(cur, ast.Name):
                parts.append(cur.id)
            bases.append(".".join(reversed(parts)))
        elif isinstance(base, ast.Subscript) and hasattr(base.value, "id"):
            bases.append(base.value.id)
        elif hasattr(ast, "unparse"):
            bases.append(ast.unparse(base))
    return bases

def inherits_from(root_dir, py_file, cls_name, base_class_name, class_map=None, import_map=None, visited=None):
    """Recursively check if class `cls_name` in `py_file` inherits from base_class_name."""
    if visited is None:
        visited = set()
    key = (py_file, cls_name)
    if key in visited:
        return False
    visited.add(key)

    if not class_map or not import_map:
        with open(py_file, "r", encoding="utf-8") as f:
            tree = ast.parse(f.read(), filename=py_file)
        class_map, import_map = build_class_and_import_maps(tree)
    cls_node = class_map.get(cls_name)
    if not cls_node:
        return False

    for b in get_base_names(cls_node):
        if b.split(".")[-1] == base_class_name:
            return True
        # defined locally → recurse
        if b in class_map and inherits_from(root_dir, py_file, b, base_class_name, class_map, import_map, visited):
            return True
        # imported → open its module
        if b in import_map:
            mod_name, orig_name = import_map[b]
            mod_path = find_module_file(mod_name, root_dir, py_file)
            if not mod_path:
                if not mod_name.startswith("."):
                    mod_name = "." + mod_name
                    mod_path = find_module_file(mod_name, root_dir, py_file)
            if not mod_path:
                continue
            if mod_path and inherits_from(root_dir, mod_path, orig_name, base_class_name, None, None, visited):
                return True
    return False

def find_all_subclasses(root_dir, py_file, base_class_name):
    with open(py_file, "r", encoding="utf-8") as f:
        tree = ast.parse(f.read(), filename=py_file)
        
    class_map, import_map = build_class_and_import_maps(tree)
    subclasses = []
    for cls in class_map:
        if inherits_from(root_dir, py_file, cls, base_class_name, class_map, import_map):
            subclasses.append(cls)
    return subclasses

def find_all_schemes(root_dir, py_file):
    with open(py_file, "r", encoding="utf-8") as f:
        tree = ast.parse(f.read(), filename=py_file)
        
    class_map, import_map = build_class_and_import_maps(tree)
    subclasses = []
    for cls in class_map:
        cls_node = class_map.get(cls)
        if not cls_node:
            continue

        for b in get_base_names(cls_node):
            if b.split(".")[-1].endswith("Scheme"):
                subclasses.append(cls)
                break
    return subclasses
