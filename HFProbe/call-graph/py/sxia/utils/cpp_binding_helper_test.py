import unittest
from sxia.utils.ast import get_cls_from_mod, get_func_from_cls
from sxia.utils.cpp_binding_helper import CppBindingHelper
import ast

from sxia.value import ClassInstanceValue, CppBindingValue


class TestCppBindingHelper(unittest.TestCase):
    def test_cpp_binding_helper(self):
        code = """
class Attention:
    def __init__(self):
        if config.use_cache_quantization and config.use_cache_kernel:
            module_root = pathlib.Path(__file__).parent
            src_files = ('cache_autogptq_cuda_256.cpp',
                'cache_autogptq_cuda_kernel_256.cu')
            if any(not (module_root / src).is_file() for src in src_files):
                warnings.warn(
                    'KV cache kernel source files (.cpp and .cu) not found.')
                self.cache_kernels = None
            else:
                try:
                    from .cpp_kernels import cache_autogptq_cuda_256
                    self.cache_kernels = cache_autogptq_cuda_256
                except ImportError:
                    warnings.warn('Failed to import KV cache kernels.')
                    self.cache_kernels = None
"""
        mod = ast.parse(code)
        cls_node = get_cls_from_mod(mod, "Attention")
        fn_node = get_func_from_cls(cls_node, "__init__")
        target_modules = ["cpp_kernels.cache_autogptq_cuda_256"]
        self_value = ClassInstanceValue(cls_node)
        visitor = CppBindingHelper(target_modules, self_value)
        visitor.visit(fn_node)
        self.assertIsInstance(self_value.value["cache_kernels"], CppBindingValue)
