import ast
from typing import Any, Union




def serialize_value(val):
    if isinstance(val, Value):
        return val.to_dict()
    elif isinstance(val, dict):
        return {k: serialize_value(v) for k, v in val.items()}
    elif isinstance(val, list) or isinstance(val, tuple):
        return [serialize_value(v) for v in val]
    else:
        return val


class Value:
    def __init__(
        self,
        value: Union[list, dict[str, Union[list, dict, "Value"]]],
        def_at: Union[ast.stmt, ast.arg],
        sym_name=None,
        ty=None,
    ):
        self.def_at = def_at
        self.value = value
        self.sym_name = sym_name
        self.constraint = None
        self.ty = ty
        self.metadata = None

    def is_symbol(self) -> bool:
        return self.sym_name is not None

    def to_dict(self):
        return {
            "value": serialize_value(self.value),
            "sym_name": self.sym_name,
            "constraint": self.constraint,  # make sure these are JSON serializable too
            "ty": self.ty,  # same here
        }

    def named_children(self):
        """Return a list of tuples (name, value) for named children."""
        if self.ty == "torch.nn.ModuleList":
            return self.value.get("_list").items()
        if (
            isinstance(self.value, dict)
            and isinstance(self, ClassInstanceValue)
            and not isinstance(self, FuncValue)
        ):
            return [(k, v) for k, v in self.value.items()]
        else:
            return []

    def __mul__(self, other):
        if not self.is_symbol():
            raise TypeError("Cannot multiply non-symbol value")

        if isinstance(other, Value):
            if not other.is_symbol():
                raise TypeError("Cannot multiply non-symbol value")
            new_sym = new_symbol(
                def_at=None,
                ty=self.ty,
            )
            new_sym.constraint = f"{self.sym_name} * {other.sym_name}"
            return new_sym
        elif isinstance(other, int) or isinstance(other, float):
            new_sym = new_symbol(
                def_at=None,
                ty=self.ty,
            )
            new_sym.constraint = f"{self.sym_name} * {other}"
            return new_sym
        else:
            raise TypeError(
                f"Unsupported type for multiplication of value: {type(other)}"
            )

    def __str__(self):
        if self.sym_name:
            return f"Symbol({self.sym_name})"
        return f"{self.value}"

    def __repr__(self):
        return str(self)

    def get(self, key: str) -> "Value":
        """Resolve a value by its attribute.

        Args:
            key (str): can be a dot separated string or index

        Raises:
            ValueError: If value is not a dict or list

        Returns:
            Value: Resolved value
        """
        if isinstance(key, int):
            assert isinstance(self.value, list)
            return self.value[key]
        elif isinstance(key, str):
            parts = key.split(".")
            base = self
            for part in parts:
                if isinstance(base, Value):
                    assert isinstance(base.value, dict)
                    base = base.value[part]
                elif isinstance(base, dict):
                    base = base[part]
                elif isinstance(base, list):
                    for bi in base:
                        if isinstance(bi, Value):
                            assert isinstance(bi.value, dict)
                            base = bi.value[part]
                        elif isinstance(bi, dict):
                            base = bi[part]
            return base

    def set(self, key: str, value):
        if isinstance(key, int):
            assert isinstance(self.value, list)
            self.value[key] = value
        elif isinstance(key, str):
            parts = key.split(".")
            base = self
            for part in parts[:-1]:
                if isinstance(base, Value):
                    assert isinstance(base.value, dict)
                    base = base.value[part]
                elif isinstance(base, dict):
                    base = base[part]
            base.value[parts[-1]] = value

    def extend(self, value: "Value"):
        assert isinstance(self.value, list) or isinstance(self.value, dict)
        assert isinstance(value.value, list) or isinstance(value.value, dict)
        assert type(value.value) is type(self.value)
        if isinstance(self.value, dict):
            for k, v in value.value.items():
                self.value[k] = v
        else:
            self.value.extend(value.value)

    @staticmethod
    def from_ast_constant(thing: ast.Constant) -> "Value":
        return Value.from_constant(thing.value)

    @staticmethod
    def from_constant(value: Any) -> "Value":
        return Value(def_at=None, value=value)


sym_id = 0


def new_symbol(name: str = None, def_at=None, ty=None) -> Value:
    if name is None:
        global sym_id
        sym_id += 1
        name = f"sym_{sym_id}"

    if def_at is not None:
        assert isinstance(def_at, ast.AST)
    return Value(None, def_at, name, ty)


class CppBindingValue(Value):
    def __init__(self, def_at: ast.AST, name: str):
        super().__init__(name, def_at)


class CppBindingChildValue(Value):
    def __init__(self, def_at: ast.AST, name: str):
        super().__init__(name, def_at)


class ModuleValue(Value):
    def __init__(self, def_at: ast.Module, value=None):
        super().__init__(value, def_at)


class ModuleInstanceValue(ModuleValue):
    def __init__(self, def_at: ast.Module, file_path: str = None):
        super().__init__(def_at, {})
        self.star_imports: list[ImportValue] = []
        self.file_path = file_path

    def list_classes(self) -> "list[ClassValue]":
        classes = []
        for value in self.value.values():
            if isinstance(value, ClassValue):
                classes.append(value)
        return classes

    @staticmethod
    def from_file(file_path: str) -> "ModuleInstanceValue":
        with open(file_path, "r", encoding="utf-8") as f:
            tree = ast.parse(f.read(), filename=file_path)
        mod_inst = ModuleInstanceValue.from_ast_module(tree)
        mod_inst.file_path = file_path
        return mod_inst

    def add_import_from(self, node: ast.ImportFrom):
        # from module import submodule
        # submodule will be mapped to module.submodule
        for alias in node.names:
            import_value = ImportValue(
                def_at=node,
                value=f"{node.module}.{alias.name}" if node.module else alias.name,
                level=node.level,
            )
            if alias.name == "*":
                self.star_imports.append(import_value)
            else:
                keyName = alias.asname or alias.name
                if keyName not in self.value:
                    self.value[keyName] = import_value
                elif isinstance(self.value[keyName], list):
                    if not import_value in self.value[keyName]:
                        self.value[keyName].append(import_value)
                else:
                    old_value = self.value[keyName]
                    if old_value is not import_value:
                        self.value[keyName] = [
                            old_value,
                            import_value,
                        ]

    @staticmethod
    def from_ast_module(module: ast.Module) -> "ModuleInstanceValue":
        mod = ModuleInstanceValue(module)
        _top_level_init(mod, module.body)
        return mod


def _top_level_init(inst_value, stmts: list[ast.stmt]):
    """Initialize top-level statements in a module instance."""
    for stmt in stmts:
        if isinstance(stmt, ast.ClassDef):
            inst_value.value[stmt.name] = ClassValue(stmt, inst_value)
        elif isinstance(stmt, ast.FunctionDef):
            if stmt.name in inst_value.value:
                continue
            fn_value = FuncValue(stmt, inst_value)
            inst_value.value[stmt.name] = fn_value

            for decorator_item in stmt.decorator_list:
                if isinstance(decorator_item, ast.Name):
                    if decorator_item.id == "classmethod":
                        fn_value.classmethod = True
                    elif decorator_item.id == "staticmethod":
                        fn_value.staticmethod = True

        elif isinstance(stmt, ast.ImportFrom):
            inst_value.add_import_from(stmt)
        elif isinstance(stmt, ast.Import):
            # import module
            # module will be mapped to module.module
            for alias in stmt.names:
                keyName = alias.asname or alias.name
                if keyName not in inst_value.value:
                    inst_value.value[keyName] = ImportValue(
                        stmt, alias.name
                    )
                elif isinstance(inst_value.value[keyName], list):
                    tmp = ImportValue(stmt, alias.name)
                    if tmp not in inst_value.value[keyName]:
                        inst_value.value[keyName].append(tmp)
                else:
                    old_value = inst_value.value[keyName]
                    tmp = ImportValue(stmt, alias.name)
                    if tmp is not old_value:
                        inst_value.value[keyName] = [
                            old_value,
                            tmp
                        ]
        elif isinstance(stmt, ast.Try):
            # global try statements are also initialized
            # usually they are used to load C++ extensions
            _top_level_init(inst_value, stmt.body)
        elif isinstance(stmt, ast.If):
            _top_level_init(inst_value, stmt.body)
            _top_level_init(inst_value, stmt.orelse)

        key = None
        value = None
        if isinstance(stmt, ast.Assign):
            key = stmt.targets[0]
            value = stmt.value
        elif isinstance(stmt, ast.AnnAssign):
            key = stmt.target
            value = stmt.value
        else:
            continue

        if isinstance(key, ast.Name):
            if isinstance(value, ast.Constant):
                if value.value is not None:
                    if key.id not in inst_value.value:
                        inst_value.value[key.id] = Value.from_ast_constant(value)
                    elif isinstance(inst_value.value[key.id], list):
                        inst_value.value[key.id].append(
                            Value.from_ast_constant(value)
                        )
                    else:
                        old_value = inst_value.value[key.id]
                        inst_value.value[key.id] = [old_value, Value.from_ast_constant(value)]
                elif key.id not in inst_value.value:
                    inst_value.value[key.id] = Value.from_constant(value)
            elif isinstance(value, ast.Subscript):
                base = value.value
                slice = value.slice
                if isinstance(base, ast.Attribute):
                    if isinstance(base.value, ast.Name):
                        if base.value.id == "sys":
                            if base.attr == "modules":
                                if isinstance(slice, ast.Name):
                                    if slice.id == "__name__":
                                        inst_value.value[key.id] = inst_value
            elif isinstance(value, ast.Call):
                if (
                    isinstance(value.func, ast.Name)
                    and value.func.id == "load_extension"
                ):
                    inst_value.value[key.id] = CppBindingValue(def_at=value, name="")
                if (
                    isinstance(value.func, ast.Name)
                    and value.func.id == "LazyDict"
                ):
                    inst_value.value[key.id] = value.args[0]


def _special_handle_class(inst_value, cls_def: ast.ClassDef):
    from sxia.utils.ast import get_inherited_classes

    bases = get_inherited_classes(cls_def)
    if "torch.autograd.Function" in bases:
        # This is a special case for torch.autograd.Function
        # We need to handle it differently
        inst_value.value["apply"] = inst_value.get("forward")


class ClassValue(Value):
    def __init__(self, def_at: ast.ClassDef, parent: ModuleValue = None):
        super().__init__({}, def_at, ty=def_at.name if def_at else None)
        self.parent = parent
        if def_at:
            _top_level_init(self, def_at.body)
            _special_handle_class(self, def_at)

    def add_functions_from(self, cls_def: ast.ClassDef):
        _top_level_init(self, cls_def.body)


class ClassInstanceValue(ClassValue):
    def __init__(self, def_at: ast.ClassDef, parent: ModuleValue = None):
        super().__init__(def_at, parent)
        self.inheritance: list[ClassValue] = []


class SuperValue(Value):
    def __init__(self, def_at: ast.AST, parent: ClassInstanceValue):
        super().__init__(f"Super({parent.ty})", def_at, None)
        self.parent = parent

    def __str__(self):
        return f"Super({self.parent.ty})"


class FuncValue(Value):
    def __init__(
        self,
        def_at: ast.FunctionDef,
        parent: Union[ClassValue, ModuleValue] = None,
        classmethod: bool = False,
        staticmethod: bool = False,
        nested: bool = False,
    ):
        super().__init__("[function]", def_at, None)
        self.parent = parent
        self.classmethod = classmethod
        self.staticmethod = staticmethod
        self.nested = nested


class ImportValue(Value):
    def __init__(
        self, def_at: Union[ast.ImportFrom, ast.Import], value: str, level: int = 0
    ):
        super().__init__(
            value,
            def_at,
        )
        self.level = level


class LambdaValue(Value):
    def __init__(self, def_at: ast.Lambda, local_env=None, env=None):
        super().__init__("[lambda]", def_at, None)
        self.local_env = local_env or None
        self.env = env or None

    def __str__(self):
        return "Lambda"
