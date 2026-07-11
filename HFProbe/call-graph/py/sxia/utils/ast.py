import ast
from typing import Union
import os
from sxia.value import (
    ClassValue,
    CppBindingValue,
    ImportValue,
    ModuleInstanceValue,
)



def get_cls_from_mod(mod: ast.Module, cls_name: str) -> ast.ClassDef:
    cls_defs = [
        stmt
        for stmt in mod.body
        if isinstance(stmt, ast.ClassDef) and stmt.name == cls_name
    ]
    if not cls_defs:
        raise ValueError(
            f"Class {cls_name} not found in module {mod.__class__.__name__}"
        )
    return cls_defs[0]


def get_func_from_cls(cls: ast.ClassDef, func_name: str) -> ast.FunctionDef:
    func_defs = [
        stmt
        for stmt in cls.body
        if isinstance(stmt, ast.FunctionDef) and stmt.name == func_name
    ]
    if not func_defs:
        raise ValueError(f"Function {func_name} not found in class {cls.name}")
    return func_defs[0]


def divide_imports(key: str):
    i = 0
    rel_part = False
    while i < len(key):
        if key[i] == ".":
            if rel_part:
                break
        else:
            rel_part = True
        i += 1

    if i > 0:
        key_parts = [key[:i]] + key[i + 1 :].split(".")
    else:
        key_parts = key.split(".")

    if key_parts and key_parts[-1] == "":
        key_parts.pop()
    return key_parts

def getImport(
    mod_inst: ModuleInstanceValue, key: str, resolve_dirs: list[str], **kwargs
):
    try:
        item = mod_inst.value.get(key)
        return item
    except Exception as ex:
        pass

def env_resolve(
    mod_inst: ModuleInstanceValue, key: str, resolve_dirs: list[str], **kwargs
):
    key_parts = divide_imports(key)
    curr = mod_inst
    curr_key_idx = 0
    while len(key_parts) > 0:
        key = key_parts.pop(0)
        curr_key_idx += 1
        if (
            key.startswith(".")
            or curr_key_idx != 1
            and isinstance(curr, ModuleInstanceValue)
        ):
            curr_dir = os.path.dirname(curr.file_path)
            stars_num = key.count(".")
            new_base = os.path.join(curr_dir, "." * stars_num)
            mod_name = key[stars_num:]
            while True:
                init_file = os.path.join(new_base, mod_name, "__init__.py")
                if os.path.exists(init_file):
                    curr = ModuleInstanceValue.from_file(init_file)
                    break
                else:
                    py_file = os.path.join(new_base, f"{mod_name}.py")
                    if os.path.isfile(py_file):
                        curr = ModuleInstanceValue.from_file(py_file)
                        break
                    else:
                        # maybe because is directory's next file
                        py_dir = os.path.join(new_base, mod_name)
                        if os.path.isdir(py_dir):
                            new_base = py_dir
                            mod_name = key_parts.pop(0) if key_parts else None
                            continue
                        else:
                            if key in curr.value:
                                curr = curr.value[key]
                                break
                            return None
            continue

        # try value and import
        matched = False
        try:
            tmp = []
            if isinstance(curr, list):
                for ci in curr:
                    it = ci.value.get(key)
                    if isinstance(it, ImportValue):
                        it = resolve_import_value(ci, it, resolve_dirs, **kwargs)
                        if it not in tmp:
                            tmp.append(it)
                    
                    elif isinstance(it, list):
                        for iii in it:
                            if isinstance(iii, ImportValue):
                                jjj = resolve_import_value(ci, iii, resolve_dirs, **kwargs)
                                if jjj not in tmp:
                                    tmp.append(jjj)
                    elif it not in tmp:
                        tmp.append(it)
                    
            else:
                item = curr.value.get(key)
                if isinstance(item, ImportValue):
                    item = resolve_import_value(curr, item, resolve_dirs, **kwargs)
                
                if isinstance(item, list):
                    for it in item:
                        if isinstance(it, ImportValue):
                            it = resolve_import_value(curr, it, resolve_dirs, **kwargs)
                            if it not in tmp:
                                tmp.append(it)
            
            if tmp:
                item = tmp
                
            if item is not None:
                curr = item
                matched = True
                continue
        except Exception as ex:
            pass

        # try start imports
        if not matched and isinstance(curr, ModuleInstanceValue):
            for start_import in curr.star_imports:
                result = resolve_import_value(
                    curr,
                    start_import,
                    resolve_dirs=resolve_dirs,
                    **kwargs,
                )
                if isinstance(result, ModuleInstanceValue):
                    if key in result.value:
                        curr = result.value[key]
                        matched = True
                        break
        if matched:
            continue

        if len(key_parts) == 0 and isinstance(curr, ModuleInstanceValue):
            py_dir = os.path.dirname(curr.file_path)
            filename = key
            if key.endswith("_cpp"):
                filename = key[:-4]
            cpp_file = os.path.join(py_dir, f"{filename}.cpp")
            if os.path.isfile(cpp_file):
                return CppBindingValue(None, key)

        return None

    return curr


def resolve_import_value(
    module_instance: ModuleInstanceValue,
    import_value: ImportValue,
    resolve_dirs: list[str],
    **kwargs,
) -> Union[ModuleInstanceValue, ImportValue, ClassValue, None]:
    if not resolve_dirs:
        return None

    parts = [p for p in import_value.value.split(".") if p != "*"]
    if parts[0] == "transformers":
        from sxia.utils.tf import get_transformers_dir, get_transformers_models

        # transformers is a special case, we need to resolve it to the transformers directory
        transformers_dir = kwargs.get("transformers_dir") or get_transformers_dir()
        if not transformers_dir:
            raise ValueError(
                "transformers_dir not found, please either install transformers through pip or specify the directory"
            )
        model_name = parts[1]
        models = get_transformers_models(transformers_dir)
        return models.get(model_name)

    mod_file = module_instance.file_path
    if (
        isinstance(import_value.def_at, ast.ImportFrom)
        and import_value.def_at.level > 0
    ):
        # relative import
        # get the current module path
        return _resolve_import_value(
            os.path.join(os.path.dirname(mod_file), "." * import_value.def_at.level),
            parts,
            resolve_dirs,
        )

    for dir in resolve_dirs:
        resolved = _resolve_import_value(dir, parts, resolve_dirs)
        if resolved:
            return resolved
    return None


def _resolve_import_value(
    dir: str,
    parts: list[str],
    resolve_dirs: list[str],
):
    if not parts:
        return None
    part = parts[0]

    # check if the part is a directory
    py_mod_dir = os.path.join(dir, part)
    if os.path.isdir(py_mod_dir):
        init_file = os.path.join(py_mod_dir, "__init__.py")
        if os.path.exists(init_file):
            mod_inst = ModuleInstanceValue.from_file(init_file)
            if len(parts) == 1:
                return mod_inst
            
            if parts[1] == "current_platform":
                parts[1] = "NonNvmlCudaPlatform"
                parts.insert(1, "cuda")

            # first try to get from init
            try:
                child = mod_inst.get(".".join(parts[1:]))
                if isinstance(child, ImportValue):
                    return resolve_import_value(
                        mod_inst,
                        child,
                        resolve_dirs=resolve_dirs,
                    )
                return child
            except KeyError:
                pass
            except Exception:
                pass

            # try start imports
            for start_import in mod_inst.star_imports:
                result = resolve_import_value(
                    mod_inst, start_import, resolve_dirs=resolve_dirs
                )
                if isinstance(result, ModuleInstanceValue):
                    res = env_resolve(
                        result,
                        ".".join(parts[1:]),
                        resolve_dirs=resolve_dirs,
                    )
                    if res is not None:
                        return res

        # if not, keep looking in the xxx.py file
        return _resolve_import_value(py_mod_dir, parts[1:], resolve_dirs)
    # check if the part is a file
    py_file = os.path.join(dir, f"{part}.py")
    if os.path.isfile(py_file):
        mod_inst = ModuleInstanceValue.from_file(py_file)
        if len(parts) == 1:
            return mod_inst
        child = mod_inst.get(".".join(parts[1:]))
        if isinstance(child, ImportValue):
            return resolve_import_value(
                mod_inst,
                child,
                resolve_dirs=resolve_dirs,
            )
        return child
    return None


def name_or_full_attr(
    node: Union[ast.Attribute, ast.Name], name_ext: dict = None
) -> str:
    """Reconstruct full call path from AST."""
    parts = []
    while isinstance(node, ast.Attribute):
        parts.append(node.attr)
        node = node.value
    if isinstance(node, ast.Name):
        parts.append(name_ext.get(node.id, node.id) if name_ext else node.id)
    return ".".join(reversed(parts))


def resolve_type_annotation(annotation: ast.expr) -> str:
    """Resolve the type annotation to a string."""
    if isinstance(annotation, ast.Name):
        return annotation.id
    elif isinstance(annotation, ast.Subscript):
        base = resolve_type_annotation(annotation.value)
        index = resolve_type_annotation(annotation.slice)
        return f"{base}[{index}]"
    elif isinstance(annotation, ast.Attribute):
        return f"{resolve_type_annotation(annotation.value)}.{annotation.attr}"
    else:
        raise ValueError(f"Unsupported annotation type: {type(annotation)}")


def get_inherited_classes(cls: ast.ClassDef) -> list[str]:
    """Get the inherited classes from a class definition."""
    if not cls.bases:
        return []
    inherited_classes = []
    for base in cls.bases:
        if isinstance(base, ast.Name):
            inherited_classes.append(base.id)
        elif isinstance(base, ast.Attribute):
            inherited_classes.append(name_or_full_attr(base))
        elif isinstance(base, ast.Subscript):
            inherited_classes.append(resolve_type_annotation(base))
    return inherited_classes
