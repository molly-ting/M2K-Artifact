import ast
import unittest
from sxia.ast_ext.cfg import CachedCFGBuilder
from sxia.runner.runner import FuncRunner
from sxia.utils.ast import (
    get_cls_from_mod,
    get_func_from_cls,
    get_module_instance_value,
)
from sxia.value import ModuleInstanceValue, Value


class TestFuncRunner(unittest.TestCase):
    def test_get_class_attributes_with_constants(self):
        class_code = """
class Foo:
    a = 10
    b = "hello"
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]  # Get the class definition node
        paths = FuncRunner(CachedCFGBuilder()).run(class_def)
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value
        self.assertEqual(result.value["a"], 10)
        self.assertEqual(result.value["b"], "hello")

    def test_get_class_attributes_with_no_attributes(self):
        class_code = """
class Foo:
    pass
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]  # Get the class definition node
        paths = FuncRunner(CachedCFGBuilder()).run(class_def)
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        expected = {}
        self.assertEqual(result.value, expected)

    def test_get_class_attributes_with_annotated_assignments(self):
        class_code = """
class Foo:
    a: int = 42
    b: str = "world"
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]  # Get the class definition node
        paths = FuncRunner(CachedCFGBuilder()).run(class_def)
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["a"], 42)
        self.assertEqual(result.value["b"], "world")

    def test_get_class_attributes_with_multiple_assignments(self):
        class_code = """
class Foo:
    a = 1
    b = 2
    c = 3

    def __init__(self):
        self.d = 4
        self.e = 5
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]
        paths = FuncRunner(CachedCFGBuilder()).run(class_def)
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value
        self.assertEqual(result.value["a"], 1)
        self.assertEqual(result.value["b"], 2)
        self.assertEqual(result.value["c"], 3)
        self.assertEqual(result.value["d"], 4)
        self.assertEqual(result.value["e"], 5)

    def test_init_method_with_defaults(self):
        class_code = """
class Foo:
    a = 4
    def __init__(self, x: int, y: str = "default", z = 5):
        self.x = x
        self.y = y
        self.z = z
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(
            class_def,
            args=[3, "hello"],
        )
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["y"], "hello")
        self.assertEqual(result.value["z"], 5)
        self.assertEqual(result.value["a"], 4)
        self.assertEqual(result.value["x"], 3)

    def test_init_method_with_all_defaults(self):
        class_code = """
class Foo:
    a = 4
    def __init__(self, x=123, y: str = "default", z = 5):
        self.x = x
        self.y = y
        self.z = z
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(class_def)
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["y"], "default")
        self.assertEqual(result.value["z"], 5)
        self.assertEqual(result.value["a"], 4)
        self.assertEqual(result.value["x"], 123)

    def test_init_method_with_kwargs(self):
        class_code = """
class Foo:
    a = 4
    def __init__(self, x: int, y: str = "default", z = 5):
        self.x = x
        self.y = y
        self.z = z
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(
            class_def,
            kwargs={"x": 3, "y": "hello"},
        )
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["y"], "hello")
        self.assertEqual(result.value["z"], 5)
        self.assertEqual(result.value["a"], 4)
        self.assertEqual(result.value["x"], 3)

    def test_init_method_with_not_assign_kwargs(self):
        class_code = """
class Foo:
    def __init__(self, x: int):
        self.x = x
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(
            class_def,
            kwargs={
                "x": Value.from_constant(3),
                "y": Value.from_constant("hello"),
            },
        )

        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["x"].value, 3)
        self.assertNotIn("y", result.value)

    def test_init_method_with_extra_kwargs(self):
        class_code = """
class Foo:
    def __init__(self, x: int, **kwargs):
        self.x = x
        self.v = kwargs.get("v", 5)
        self.vv = kwargs["avv"]
        """
        tree = ast.parse(class_code)
        class_def = tree.body[0]

        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(
            class_def,
            kwargs={"x": 3, "va": "hello", "avv": 8394},
            env=ModuleInstanceValue(tree),
        )
        self.assertEqual(len(paths), 1)
        result = paths[0].frames[0].self_value

        self.assertEqual(result.value["x"], 3)
        self.assertEqual(result.value["v"], 5)
        self.assertEqual(result.value["vv"], 8394)

    def test_nn_linear(self):
        class_code = """
import torch.nn as nn

class Foo(nn.Module):
    def __init__(self):
        self.linear = nn.Linear(2, 5)
    
    def run(self):
        t = torch.Tensor([[1, 2], [3, 4]])
        return self.linear(t)
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "Foo")
        cached_cfg_builder = CachedCFGBuilder()
        paths = FuncRunner(cached_cfg_builder).run(class_def, env=mod)
        self_value = paths[0].frames[0].self_value
        run_def = get_func_from_cls(class_def, "run")
        paths = FuncRunner(cached_cfg_builder).run(
            run_def, self_value=self_value, env=mod
        )

        self.assertEqual(len(paths), 1)
        result = paths[0].return_value
        self.assertEqual(result.value["shape"], (2, 5))

    def test_tensor_to(self):
        class_code = """
import torch.nn as nn

class Foo:
        
    def run(self):
        t = torch.Tensor([[1, 2, 3], [3, 4, 5]])
        return t.to("cuda1")
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "Foo")
        paths = FuncRunner(CachedCFGBuilder()).run(class_def, env=mod)
        self_value = paths[0].frames[0].self_value
        run_def = get_func_from_cls(class_def, "run")
        paths = FuncRunner(CachedCFGBuilder()).run(
            run_def, self_value=self_value, env=mod
        )
        result = paths[0].return_value
        self.assertEqual(result.value["device"], "cuda1")
        self.assertEqual(result.value["shape"], (2, 3))

    def test_nn_embedding_single(self):
        class_code = """
import torch.nn as nn

class Foo(nn.Module):
    def __init__(self):
        self.embedding = nn.Embedding(299999, 512)
    
    def run(self):
        t = torch.Tensor([1,2,3])
        return self.embedding(t)
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "Foo")
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(class_def, env=mod)
        self_value = paths[0].frames[0].self_value
        run_def = get_func_from_cls(class_def, "run")
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(run_def, self_value=self_value, env=mod)
        result = paths[0].return_value
        self.assertEqual(result.value["shape"], (3, 512))

    def test_nn_embedding_batch(self):
        class_code = """
import torch.nn as nn

class Foo(nn.Module):
    def __init__(self):
        self.embedding = nn.Embedding(299999, 512)
    
    def run(self):
        t = torch.Tensor([[1,2,3], [4,5,6]])
        return self.embedding(t)
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "Foo")
        paths = FuncRunner(
            CachedCFGBuilder(),
        ).run(class_def, env=mod)
        self_value = paths[0].frames[0].self_value
        run_def = get_func_from_cls(class_def, "run")
        paths = FuncRunner(CachedCFGBuilder()).run(
            run_def, self_value=self_value, env=mod
        )
        result = paths[0].return_value
        self.assertEqual(result.value["shape"], (2, 3, 512))

    def test_tensor_shape(self):
        class_code = """
class A:
    def __init__(self):
        self.a = torch.Tensor([1,2,3])
        self.b = torch.Tensor([self.a, self.b])
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "A")
        paths = FuncRunner(CachedCFGBuilder()).run(class_def, env=mod)
        self_value = paths[0].frames[0].self_value
        self.assertEqual(self_value.value["a"].value["shape"], (3,))
        self.assertEqual(self_value.value["b"].value["shape"], (2, 3))

    def test_runner_fork(self):
        class_code = """
class A:
    def __init__(self, a):
        if a == 1:
            self.a = 1
        else:
            self.a = 2
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "A")
        paths = FuncRunner(CachedCFGBuilder()).run(class_def, env=mod)

        self.assertEqual(len(paths), 2)
        self.assertEqual(paths[0].frames[0].self_value.value["a"], 1)
        self.assertEqual(paths[1].frames[0].self_value.value["a"], 2)

    def test_runner_multiple_calls(self):
        class_code = """
class A:
    def __init__(self, a):
        self.a = a
        self.d = self._init()

    def _init(self):
        self.b = 2
        self.c = 3
        return self.b + self.c
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "A")
        paths = FuncRunner(CachedCFGBuilder()).run(class_def, env=mod, args=[1])

        self.assertEqual(len(paths), 1)
        self.assertEqual(paths[0].frames[0].self_value.value["a"], 1)
        self.assertEqual(paths[0].frames[0].self_value.value["b"], 2)
        self.assertEqual(paths[0].frames[0].self_value.value["c"], 3)
        self.assertEqual(paths[0].frames[0].self_value.value["d"], 5)

    def test_runner_multiple_class_calls(self):
        class_code = """
class A:
    def __init__(self, a):
        self.a = a
        self.d = self._init()
    
    def _init(self):
        a = B()
        c = a.run()
        return c
class B:
    def run(self):
        return 1
        """
        tree = ast.parse(class_code)
        mod = get_module_instance_value(tree)
        class_def = get_cls_from_mod(tree, "A")
        paths = FuncRunner(CachedCFGBuilder()).run(class_def, env=mod, args=[1])

        self.assertEqual(len(paths), 1)
        self.assertEqual(paths[0].frames[0].self_value.value["a"], 1)
        self.assertEqual(paths[0].frames[0].self_value.value["d"], 1)
