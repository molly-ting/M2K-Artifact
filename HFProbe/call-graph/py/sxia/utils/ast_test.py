import unittest
import ast

from sxia.utils.ast import get_module_instance_value


class TestGetModuleInstanceValue(unittest.TestCase):
    def test_get_module_value(self):
        mod_code = """
import torch.nn as nn
import torch

a = 10000
class Foo:
    def __init__(self, config):
        self.a = 10
        self.b = "hello"
        self.config = config
        self.forward()
        """
        tree = ast.parse(mod_code)
        val = get_module_instance_value(tree)

        self.assertEqual(val.value["a"].value, 10000)
        self.assertEqual(val.value["torch"].value, "torch")
        self.assertEqual(val.value["nn"].value, "torch.nn")
        self.assertEqual(val.value["Foo"].parent, val)
