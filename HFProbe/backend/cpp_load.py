# Mocking Torch C++ Extension for Logging
import unittest
import torch


class LoadedCppExtensionMock:
    def __init__(self, on_called=None):
        """
        Mock class to simulate a loaded C++ extension.
        :param on_called: Optional callback function to call when a method is invoked.
        This can be used for additional logging or assertions in tests.
        Example usage:
        def my_callback(method_name, args, kwargs):
            print(f"Method {method_name} called with args: {args}, kwargs: {kwargs}")
        loaded_extension = LoadedCppExtensionMock(on_called=my_callback)
        """
        self._on_called = on_called

    def __getattr__(self, item):
        def _mocked_method(*args, **kwargs):
            if self._on_called:
                self._on_called(item, args, kwargs) 
                
            if "vecquant8matmul_batched_faster_old" == item or "vecquant8matmul_batched_column_compression_faster_old" == item:
                return None
            
            if "vecquant2matmul" == item or "vecquant3matmul" == item or "vecquant4matmul" == item or "vecquant8matmul" == item:
                return None
            
            if item.startswith("vecquant") or item.startswith("lutgemm_"):
                return None
            
            if item.startswith("rspmm") and item.endswith("forward_cuda"):
                # num_row, dim = args[-1].shape
                num_row = args[-1].size(0)
                dim = args[-1].size(1)
                output = torch.zeros((num_row, dim), dtype=args[-1].dtype, device=args[-1].device)
                return output
            
            if item.startswith("rspmm") and item.endswith("backward_cuda"):
                weight_grad = torch.zeros_like(args[2])
                relation_grad = torch.zeros_like(args[3])
                input_grad = torch.zeros_like(args[4])
                return (weight_grad, relation_grad, input_grad)
            
            if item == "rpe_index_forward_gpu":
                B = args[0].size(0)
                H = args[0].size(1)
                L_query = args[1].size(0)
                L_key = args[1].size(1)
                return torch.zeros((B, H, L_query, L_key), dtype=args[0].dtype, device=args[0].device)
            
            if item == "rpe_index_backward_gpu":
                return None
            
            if item == "matmul":
                M = args[0].size(0)
                N = args[1].size(0)
                C = torch.zeros((M, N), dtype=torch.int32, device=args[0].device)
                return C
            
            if item == "sym_quant":
                rows = args[0].size(0)
                colsSrc = args[0].size(1)
                colsDst = (colsSrc + 8 - 1) // 8
                q = torch.zeros((rows, colsDst), dtype=torch.uint8, device=args[0].device)
                return q
            
            if item == "sym_dequant":
                q = torch.zeros_like(args[0])
                q.dtype = torch.half
                return q
            
            # always return the first argument if available, otherwise None
            if len(args) > 0:
                return args[0]
            return None
        return _mocked_method
    

def mock_torch_utils_cpp_extension(mocked_object):
    import torch.utils.cpp_extension

    def _mock(*args, **kwargs):
        return mocked_object
    
    # mock load 
    torch.utils.cpp_extension.load = _mock
    torch.utils.cpp_extension.CUDA_HOME = "/mock/cuda/home"  # Mock CUDA home path

    # mock subprocess.check_output to return a mock CUDA version
    import subprocess
    original_check_output = subprocess.check_output
    def _mock_check_output(*args, **kwargs):
        return_str = kwargs.get('text', kwargs.get('universal_newlines', False))
        if "nvcc" in args[0][0]:
            mock_return = "nvcc: NVIDIA (R) Cuda compiler driver\nrelease 11.7, V11.7.64\n" 
            if return_str:
                # Return a mock string output for nvcc version
                return mock_return
            else:
                # Return bytes output for nvcc version
                return mock_return.encode()
        # else return original output
        return original_check_output(*args, **kwargs)
    subprocess.check_output = _mock_check_output

    # mock importlib.import_module to return the mocked object
    import importlib
    original_import_module = importlib.import_module
    def _mock_import_module(*args, **kwargs):
        name = args[0]
        if name.find("_cuda") != -1 or name.find("_CUDA") != -1 or name.find("lutgemm") != -1 or name.find("rpe_index_cpp") != -1:
            # If the module name contains "_cuda", return the mocked object
            return mocked_object
        return original_import_module(*args, **kwargs)
    importlib.import_module = _mock_import_module
    


class MockCppExtensionTests(unittest.TestCase):
    def test_mock_cpp_extension(self):
        cpp_extension = LoadedCppExtensionMock()
        mock_torch_utils_cpp_extension(cpp_extension)
        import torch.utils.cpp_extension
        loaded_extension = torch.utils.cpp_extension.load(
            name="anc",
            sources=["def.cpp"],
            build_directory="somepath",
            extra_cflags=['-O3', ],
            extra_cuda_cflags=['-O3',
                            '-gencode', 'arch=compute_70,code=sm_70',
                            '--use_fast_math'],
            verbose=1
        )
        loaded_extension.some_method(1, 2, key='value')

