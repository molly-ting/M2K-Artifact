import torch
from typing import Optional


def relu_mock(input, inplace=False):
    """Mock implementation of torch.nn.functional.relu."""
    if inplace:
        return input
    return torch.zeros_like(input)


def softmax_mock(input, dim=None, dtype=None):
    """Mock implementation of torch.nn.functional.softmax."""
    if dtype is not None:
        return torch.zeros_like(input, dtype=dtype)
    return torch.zeros_like(input)


def silu_mock(input, inplace=False):
    """Mock implementation of torch.nn.functional.silu."""
    if inplace:
        return input
    return torch.zeros_like(input)


def gelu_mock(input, approximate='none'):
    """Mock implementation of torch.nn.functional.gelu."""
    return torch.zeros_like(input)


def leaky_relu_mock(input, negative_slope=0.01, inplace=False):
    """Mock implementation of torch.nn.functional.leaky_relu."""
    if inplace:
        return input
    return torch.zeros_like(input)


def tanh_mock(input):
    """Mock implementation of torch.nn.functional.tanh."""
    return torch.zeros_like(input)


def sigmoid_mock(input):
    """Mock implementation of torch.nn.functional.sigmoid."""
    return torch.zeros_like(input)


def elu_mock(input, alpha=1.0, inplace=False):
    """Mock implementation of torch.nn.functional.elu."""
    if inplace:
        return input
    return torch.zeros_like(input)


def swish_mock(input):
    """Mock implementation of swish activation (same as silu)."""
    return torch.zeros_like(input)


def has_torch_function_unary_mock(input):
    """Mock implementation of torch.nn.functional.has_torch_function_unary."""
    return False

def layer_norm_mock(
    input,
    normalized_shape: list[int],
    weight = None,
    bias = None,
    eps: float = 1e-5,
):
    return torch.zeros_like(input)


# Mock dictionary for torch.nn.functional activations
mock_dict = {
    torch.nn.functional.relu: relu_mock,
    torch.nn.functional.softmax: softmax_mock,
    torch.nn.functional.silu: silu_mock,
    torch.nn.functional.gelu: gelu_mock,
    torch.nn.functional.leaky_relu: leaky_relu_mock,
    torch.nn.functional.tanh: tanh_mock,
    torch.nn.functional.sigmoid: sigmoid_mock,
    torch.nn.functional.elu: elu_mock,
    torch.nn.functional.has_torch_function_unary: has_torch_function_unary_mock,
    torch.nn.functional.layer_norm: layer_norm_mock
}
