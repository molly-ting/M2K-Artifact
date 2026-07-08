import re, json, os
from pathlib import Path
from collections import defaultdict
import yaml


# Match macro calls (later matched dynamically based on known macros)
def make_macro_call_pattern(name):
    return re.compile(rf'(?<!#define\s){name}\s*\(([^)]*)\)', re.DOTALL)

def parse_macros(content):
    # macro_func_pattern = re.compile(
    #     r'(?m)^#define\s+(\w+)\s*\(([^)]*)\)\s*\\\s*'       # macro name + param list
    #     r'([^\n{]*?\b((?:[\w:]+|##)+)\s*\()',          # full line (Group 3), token-pasted name (Group 4)
    #     re.MULTILINE
    # )
    macro_func_pattern = re.compile(
        r'(?m)^#define\s+(\w+)\s*\(([^)]*)\)\s*\\\s*'        # macro name + params + backslash + optional spaces
        r'([^\n(]*?\b((?:[\w:]+(?:##[\w:]+)+))\s*\()',       # macro body line (Group 3), token-pasted name (Group 4)
    )

    macros = {}
    for macro_name, param_str, func_line, func_template in macro_func_pattern.findall(content):
        params = [p.strip() for p in param_str.split(',')]
        # print(macro_name, params)
        # print("Params:", params)
        # print(func_line)
        # print("Function template:", func_template)
        macros[macro_name] = {"params": params, "func": func_template}
    return macros

def get_macros_func(content, macros):
    funcs = []
    for macro_name in macros:
        params = macros[macro_name]["params"]
        func_template = macros[macro_name]["func"]
        tokens = re.findall(r'##(\w+)##', func_template)
        replaceIndex = []
        for i in range(len(tokens)):
            for j in range(len(params)):
                if params[j] == tokens[i]:
                    replaceIndex.append(j)

        # token_num = len(tokens)
        pattern = make_macro_call_pattern(macro_name)
        for match in pattern.finditer(content):
            args = [a.strip() for a in match.group(1).split(',')]
            # print(macro_name, args)
            if len(args) != len(params):
                continue  # Skip malformed calls
            
            replacements = []
            for index in replaceIndex:
                replacements.append(args[index])
            # replacements = args[:token_num]

            real_func_name = func_template
            for token, value in zip(tokens, replacements):
                real_func_name = real_func_name.replace(f"##{token}##", value)
            # print(real_func_name)
            funcs.append(real_func_name)
    return funcs

def find_cuda_path(op_to_impl, cu_files):
    # Pattern to detect function definition
    func_def_pattern = re.compile(r'^\s*(?:inline\s+)?(?:__global__\s+)?([\w:<>]+(?:\s*[*&]+)?)\s+(\w+)\s*\(', re.MULTILINE)
    structured_func_pattern = re.compile(r'TORCH_IMPL_FUNC\s*\(\s*(\w+)\s*\)')

    b_to_cu_path = {}
    for cu_file in cu_files:
        # print(cu_file)
        content = cu_file.read_text()
        
        # 1. Parse and expand all macros
        macros = parse_macros(content)
        mfuncs = get_macros_func(content, macros)
        for func_name in mfuncs:
            for A in op_to_impl:
                # print(A, func_name)
                B = op_to_impl[A]
                if (isinstance(B, set) and func_name in B) or func_name == B:                    
                    b_to_cu_path[A] = {"func_name": func_name, "file_path": str(cu_file)}
                    del op_to_impl[A]
                    break
        
        # print(content)
        for match in func_def_pattern.finditer(content):
            return_type, func_name = match.groups()
            for A in op_to_impl:
                # print(A, func_name, "iter")
                B = op_to_impl[A]
                if (isinstance(B, set) and func_name in B) or func_name == B:
                    b_to_cu_path[A] = {"func_name": func_name, "file_path": str(cu_file)}
                    del op_to_impl[A]
                    break
                
        for match in structured_func_pattern.finditer(content):
            func_name = "structured_"+match.group(1)
            for A in op_to_impl:
                # print(A, func_name, "structure")
                B = op_to_impl[A]
                if (isinstance(B, set) and func_name in B) or func_name == B:
                    b_to_cu_path[A] = {"func_name": func_name, "file_path": str(cu_file)}
                    del op_to_impl[A]
                    break
    
    return b_to_cu_path    

def locate_cuda(op_to_impl, cu_files, cpp_files):
    # print(op_to_impl)
    b_to_cu_path = find_cuda_path(op_to_impl, cu_files)
    b_to_cu_path.update(find_cuda_path(op_to_impl, cpp_files))
    if len(op_to_impl)==0:
        return b_to_cu_path
    # print("remain:", op_to_impl)
    
    func_def_pattern = re.compile(
        r'^\s*(?:__global__\s+)?([\w:<>]+(?:\s*[*&]+)?)\s+(\w+)\s*\([^)]*\)\s*\{',
        re.MULTILINE
    )
    
    # Match all function calls inside body: any::any::func(...)
    call_pattern = re.compile(
        r'([\w:]+)\s*\(', re.MULTILINE
    )

    # Match structured_* op initialization: structured_foo_bar_out_functional op;
    structured_op_pattern = re.compile(
        r'(structured_\w+_out_functional)\s+op\s*;', re.MULTILINE
    )
    
    for filepath in cpp_files:
        content = filepath.read_text()
        for match in func_def_pattern.finditer(content):
            return_type, func_name = match.groups()
            body_start = match.end() - 1  # include the opening brace `{`
            
            # Match braces to find end of body
            brace_count = 1
            body_end = body_start + 1
            while brace_count > 0 and body_end < len(content):
                if content[body_end] == '{':
                    brace_count += 1
                elif content[body_end] == '}':
                    brace_count -= 1
                body_end += 1

            func_body = content[body_start:body_end]         
            # Remove block comments: /* ... */
            func_body = re.sub(r'/\*.*?\*/', '', func_body, flags=re.DOTALL)
            # Remove line comments: // ...
            func_body = re.sub(r'//.*', '', func_body)
            callees = set()
            
            # Check for structured op
            structured_match = structured_op_pattern.search(func_body)
            if structured_match:
                structured_name = structured_match.group(1)
                callees.add(structured_name)
            else:
                # Extract all normal calls like: x.y(), z()
                # print(func_name, "******")
                # print("body:", func_body)
                for call_match in call_pattern.finditer(func_body):
                    callee = call_match.group(1)
                    # Filter out constructors and keywords
                    if callee != func_name and not callee.startswith('return'):
                        callee = callee.split("::")[-1]
                        callees.add(callee)
                # print("callees: ", callees)

            for A in op_to_impl:
                B = op_to_impl[A]
                if isinstance(B, list) and func_name in B:
                    B.remove(func_name)
                    B.extend(callees)
                    op_to_impl[A] = B
                elif func_name == B:
                    op_to_impl[A] = callees
    
    # print("new:", op_to_impl)
    extend_res = find_cuda_path(op_to_impl, cu_files)    
    b_to_cu_path.update(extend_res)
    return b_to_cu_path

def find_kernel_rel(dir):
    lib_dir = Path(dir)
    cpp_files = list(lib_dir.rglob("*.cpp"))
    cu_files = list(lib_dir.rglob("*.cu"))

    # Pattern to find TORCH_LIBRARY_EXPAND block
    torch_lib_expand_pattern = re.compile(r"TORCH_LIBRARY_EXPAND\s*\(\s*TORCH_EXTENSION_NAME\s*,")
    ops_impl_cuda_pattern = re.compile(r'\w+\.impl\s*\(\s*"([^"]+)"\s*,\s*torch::kCUDA\s*,\s*&(\w+)\s*\)')
    ops_impl_cuda_pattern2 = re.compile(r'\w+\.impl\s*\(\s*"([^"]+)"\s*,\s*&(\w+)\s*\)')

    torch_lib_impl_expand_pattern = re.compile(r"TORCH_LIBRARY_IMPL_EXPAND\s*\(\s*TORCH_EXTENSION_NAME\s*,\s*CUDA")
    ops_impl_2p_pattern = re.compile(r'm\.impl\s*\(\s*"([^"]+)"\s*,\s*&(\w+)\s*\)')
    
    # Pattern to find PYBIND11_MODULE block
    pybind_module_pattern = re.compile(r'^\s*PYBIND11_MODULE\s*\(', re.MULTILINE)
    m_def_pattern = re.compile(
        r'm\.def\s*\(\s*"([^"]+)"\s*,\s*&\s*([\w:]+)',
        re.MULTILINE
    )

    # Pattern to find TORCH_LIBRARY_IMPL block
    torch_lib_impl_pattern = re.compile(r'TORCH_LIBRARY_IMPL\s*\(\s*([^\s,]+)\s*,\s*CUDA')
    m_impl_pattern = re.compile(
        r'm\.impl\s*\(\s*"([^"]+)"\s*,\s*TORCH_FN\s*\(\s*(\w+)\s*\)\s*\)',
        re.MULTILINE | re.DOTALL
    )
    
    op_to_impl = {}  # A -> B

    for filepath in cpp_files+cu_files:
        content = filepath.read_text()
        if torch_lib_expand_pattern.search(content):
            for match in ops_impl_cuda_pattern.finditer(content):
                A, B = match.groups()
                B = B.split("::")[-1]
                op_to_impl[A] = B
            for match in ops_impl_cuda_pattern2.finditer(content):
                A, B = match.groups()
                B = B.split("::")[-1]
                op_to_impl[A] = B
        
        if torch_lib_impl_expand_pattern.search(content):
            for match in ops_impl_2p_pattern.finditer(content):
                A, B = match.groups()
                B = B.split("::")[-1]
                op_to_impl[A] = B
                
        elif pybind_module_pattern.search(content):
            for match in m_def_pattern.finditer(content):
                A, B = match.groups()
                B = B.split("::")[-1]
                op_to_impl[A] = B
                
        elif torch_lib_impl_pattern.search(content):
            for match in m_impl_pattern.finditer(content):
                A, B = match.groups()
                B = B.split("::")[-1]
                op_to_impl[A] = B

    # Step 2: Find where each B is implemented
    b_to_cu_path = locate_cuda(op_to_impl.copy(), cu_files, cpp_files)    

    # print(b_to_cu_path)
    if not b_to_cu_path:
        return
    
    origin_data = None
    model_name = dir.split("/")[-1]
    out_path = f"./kernel_map_{model_name}.json"
    if os.path.exists(out_path):
        with open(out_path, "r") as f:
            origin_data = json.load(f)
    
    if origin_data:
        b_to_cu_path.update(origin_data)
        
    with open(out_path, "w") as f:
        json.dump(b_to_cu_path, f, indent=4)
        

# find_kernel_rel("/home/mvh6224/vllm")
# find_kernel_rel("home/mvh6224/pytorch")   
# find_kernel_rel("/data/szx5097/hfplayground/test_models/Qwen_Qwen-7B") 
# find_kernel_rel("/data/szx5097/hfplayground/test_models/chinoll_chatsakura-3b-int4")

# with open("/home/mvh6224/CUDA-BOSolver/pyanalyzer/hfmodels0.json") as f:
#     model_list = json.load(f)
    
# for model_id in model_list:
#     repo_path = f"/data/szx5097/hfplayground/_models/{model_id.replace('/', '_')}"
#     find_kernel_rel(repo_path)

# for framework_name in os.listdir("/home/mvh6224/CUDA-BOSolver/pyanalyzer/models_rs"):
#     find_kernel_rel(os.path.join("/home/mvh6224/CUDA-BOSolver/pyanalyzer/models_rs", framework_name))

# find_kernel_rel("/home/mvh6224/CUDA-BOSolver/pyanalyzer/models_rs/ShiftAddLLM")