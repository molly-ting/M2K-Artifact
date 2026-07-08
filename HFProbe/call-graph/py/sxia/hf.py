from dataclasses import asdict
import os
import logging
import json
import re
from typing import Optional
import ast
import traceback
import time

from pydantic import BaseModel

from sxia.analysis_types import Analysis, CudaFunction, PyCppBinding, TorchCall
from sxia.astrunner.utils import analyze_transformers_model, get_torch_calls_from_file
from sxia.utils.vllm import analyze_vllm_model, extract_path_model_pairs


logger = logging.getLogger(__name__)
current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(os.path.dirname(current_path_string)))


def get_cuda_functions(cuda_file: str) -> list["CudaFunction"]:
    """
    Use simple regex to find CUDA functions in a CUDA file.
    """
    cuda_functions = []
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
                    out_path=os.path.join(root_dir, "cgout-models", repo_path.split("/")[-1] + ".json"),
                )
            )
    return torch_calls


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

    
def build_class_and_import_maps(tree):
    class_map = {}
    import_map = {}  # alias → (module, original)

    for node in tree.body:
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


def transformers_with_config(path: str):
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

    get_torch_calls(
        path, auto_model_cls_list, class_defs, bindings, auto_config_cls
    )

def transformers_test(repo_path, out_dir):
    if not os.path.exists(repo_path):
        print(f"Repository path {repo_path} does not exist.")
        return
    
    logger.info(f"Analyzing huggingface repository {repo_path}")
    if not out_dir:
        out_dir = os.path.join(root_dir, "cgout-models")

    config_obj = None
    auto_model_cls_list = []

    py_files = find_files(repo_path, lambda file: file.endswith(".py"))
    # Get all class definitions
    class_defs = {
        cls: py_file for py_file in py_files for cls in get_class_defs(py_file)
    }
    with open(os.path.join(repo_path, "config.json"), "r") as f:
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

    for cls in auto_model_cls_list:
        if cls["local"]:
            cls_name = cls["name"]
            out_path=os.path.join(out_dir, repo_path.split("/")[-1] + ".json")
            analyze_transformers_model(repo_path, cls_name, class_defs[cls_name], "forward", out_path)
    
def vllm_test(vllm_dir, out_dir=None):
    if not os.path.exists(vllm_dir):
        print(f"vLLM directory {vllm_dir} does not exist.")
        return
    
    vllm_model2path = extract_path_model_pairs(vllm_dir)
    if not out_dir:
        out_dir = os.path.join(root_dir, "cgout")
    os.makedirs(out_dir, exist_ok=True)
    
    for architecture in vllm_model2path:
        try:
            out_path = os.path.join(out_dir, architecture+"_forward.json")
            analyze_vllm_model(architecture, vllm_model2path[architecture], vllm_dir, None, None, out_path)
        except Exception as ex:
            traceback.print_exc()
            continue

def vllm_test_one(vllm_dir, architecture, out_dir=None):
    if not os.path.exists(vllm_dir):
        print(f"vLLM directory {vllm_dir} does not exist.")
        return
    
    vllm_model2path = extract_path_model_pairs(vllm_dir)
    if not out_dir:
        out_dir = os.path.join(root_dir, "cgout")
    os.makedirs(out_dir, exist_ok=True)
    
    out_path = os.path.join(out_dir, architecture+"_forward.json")
    analyze_vllm_model(architecture, vllm_model2path[architecture], vllm_dir, None, None, out_path)

def indirect_fill(vllm_dir, target_file, out_dir=None):
    if not os.path.exists(vllm_dir):
        print(f"vLLM directory {vllm_dir} does not exist.")
        return
    
    if not os.path.exists(target_file):
        print(f"Target file {target_file} does not exist.")
        return
    
    if not out_dir:
        out_dir = os.path.join(root_dir, "cgout")
    os.makedirs(out_dir, exist_ok=True)

    unknown_calls = {}
    with open(target_file) as f:
        call_graph = json.load(f)
    
    for key in call_graph:
        value = call_graph[key]
        if "unknown" in value and value["unknown"]:
            for call in value["unknown"]:
                if call["type"]:
                    func = call["function"].split(".")[-1]
                    unknown_calls[(call["type"], func)] = call["filepath"]
    
    for key in unknown_calls:
        class_name, func_name = key
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
                    print(c, new_path)
                    os.makedirs(out_dir+"/"+class_name, exist_ok=True)
                    out_path = os.path.join(out_dir+"/"+class_name, c+"_"+func_name+".json")
                    if os.path.exists(out_path):
                        continue
                    try:
                        analyze_vllm_model(c, new_path, vllm_dir, None, func_name, out_path)
                    except Exception as ex:
                        traceback.print_exc()
                        continue