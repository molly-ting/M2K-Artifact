import torch
from torch.nn.parameter import Parameter
import collections
from itertools import repeat
from torch.nn.modules.utils import _ntuple
import math


_single = _ntuple(1, "_single")
_pair = _ntuple(2, "_pair")
_triple = _ntuple(3, "_triple")

# def build_mock_conv(transpose=False):
#     class MockConvFunction(torch.autograd.Function):
#         @staticmethod
#         def forward(ctx, x, weight, bias, kernel_size, dilation, padding, stride):
#             ctx.save_for_backward(
#                 torch.IntTensor(tuple(x.shape)),
#                 torch.IntTensor(tuple(weight.shape)),
#                 torch.IntTensor(tuple(bias.shape)) if bias is not None else None,
#             )

#             batch_size = x.shape[0]
#             in_channels = x.shape[1]
#             spacial_shape = x.shape[2:]
#             spacial_dim = len(spacial_shape)
#             if transpose:
#                 out_channels = weight.shape[1]
#                 new_spacial_shape = [
#                     (
#                         (spacial_shape[i] - 1) * stride[i]
#                         - 2 * padding[i]
#                         + (kernel_size[i] - 1)
#                         + 1
#                     )
#                     for i in range(spacial_dim)
#                 ]
#                 new_shape = tuple([batch_size, out_channels] + new_spacial_shape)

#             else:
#                 out_channels = weight.shape[0]
#                 new_spacial_shape = [
#                     (
#                         spacial_shape[i]
#                         + 2 * padding[i]
#                         - dilation[i] * (kernel_size[i] - 1)
#                         - 1
#                         + stride[i]
#                     )
#                     // stride[i]
#                     for i in range(spacial_dim)
#                 ]
#                 new_shape = tuple([batch_size, out_channels] + new_spacial_shape)
#             return torch.zeros(new_shape, device=x.device)

#         @staticmethod
#         def backward(ctx, grad_output):
#             x_shape, weight_shape, bias_shape = ctx.saved_tensors
#             x_shape = tuple(x_shape.tolist())
#             weight_shape = tuple(weight_shape.tolist())
#             bias_shape = tuple(bias_shape.tolist()) if bias_shape is not None else None

#             grad_input = grad_weight = grad_bias = None
#             if ctx.needs_input_grad[0]:
#                 grad_input = torch.zeros(x_shape, device=grad_output.device)
#             if ctx.needs_input_grad[1]:
#                 grad_weight = torch.zeros(weight_shape, device=grad_output.device)
#             if bias_shape is not None and ctx.needs_input_grad[2]:
#                 grad_bias = torch.zeros(bias_shape, device=grad_output.device)
#             return grad_input, grad_weight, grad_bias, None, None, None, None

#     class MockConvModule:
#         def __init__(self, obj):
#             super().__init__()
#             self.__class__ = type(
#                 obj.__class__.__name__, (self.__class__, obj.__class__), {}
#             )
#             self.__dict__ = obj.__dict__
#             self.weight = obj.weight
#             self.bias = obj.bias
#             self.in_channels = obj.in_channels
#             self.out_channels = obj.out_channels
#             self.kernel_size = obj.kernel_size
#             self.stride = obj.stride
#             self.padding = obj.padding
#             self.dilation = obj.dilation

#         def forward(self, x):
#             return MockConvFunction.apply(
#                 x,
#                 self.weight,
#                 self.bias,
#                 self.kernel_size,
#                 self.dilation,
#                 self.padding,
#                 self.stride,
#             )

#     return MockConvModule, MockConvFunction


# MockConvModule, MockConvFunction = build_mock_conv(transpose=False)
# MockTransposeConvModule, MockTransposeConvFunction = build_mock_conv(transpose=True)

# def conv_mock(x, weight, bias, stride, padding, dilation, groups):
#     return MockConvFunction.apply(x, weight, bias, stride, padding, dilation, groups)


class MockConvFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, x, weight, bias, stride, padding, dilation, groups):
        ctx.save_for_backward(
            torch.IntTensor(tuple(x.shape)),
            torch.IntTensor(tuple(weight.shape)),
            torch.IntTensor(tuple(bias.shape)) if bias is not None else None,
        )
        
        batch_size = x.shape[0]
        in_channels = x.shape[1]
        spacial_shape = x.shape[2:]
        spacial_dim = len(spacial_shape)
        out_channels = weight.shape[0]
        kernel_size = weight.shape[2:]

        stride = _ntuple(spacial_dim)(stride)
        dilation = _ntuple(spacial_dim)(dilation)
        kernel_size = _ntuple(spacial_dim)(kernel_size)

        if isinstance(padding, str):
            if padding.lower() == "same":
                # Compute padding so output shape = ceil(input / stride)
                new_spacial_shape = [
                    math.ceil(spacial_shape[i] / stride[i])
                    for i in range(spacial_dim)
                ]
            elif padding.lower() == "valid":
                # No padding
                new_spacial_shape = [
                    math.floor(
                        (spacial_shape[i] - dilation[i] * (kernel_size[i] - 1) - 1) / stride[i]
                    ) + 1
                    for i in range(spacial_dim)
                ]
            else:
                # Unknown padding string, treat as zero padding
                padding = (0,) * spacial_dim
        else:
            new_spacial_shape = [
                (
                    spacial_shape[i]
                    + 2 * padding[i]
                    - dilation[i] * (kernel_size[i] - 1)
                    - 1
                    + stride[i]
                )
                // stride[i]
                for i in range(spacial_dim)
            ]

        new_shape = tuple([batch_size, out_channels] + new_spacial_shape)
        return torch.zeros(new_shape, device=x.device, dtype=x.dtype)

    @staticmethod
    def backward(ctx, grad_output):
        x_shape, w_shape, b_shape = ctx.saved_tensors
        grad_input = torch.zeros(x_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if ctx.needs_input_grad[0] else None
        grad_weight = torch.zeros(w_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if ctx.needs_input_grad[1] else None
        grad_bias = torch.zeros(b_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if b_shape is not None and ctx.needs_input_grad[2] else None
        return grad_input, grad_weight, grad_bias, None, None, None, None

class MockTransposeConvFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, x, weight, bias, stride, padding, output_padding, groups, dilation):
        ctx.save_for_backward(
            torch.IntTensor(tuple(x.shape)),
            torch.IntTensor(tuple(weight.shape)),
            torch.IntTensor(tuple(bias.shape)) if bias is not None else None,
        )

        batch_size, in_channels, *spatial = x.shape
        out_channels = weight.shape[1]
        kernel_size = weight.shape[2:]
        output_shape = [
            (spatial[i] - 1) * stride[i] - 2 * padding[i] + dilation[i] * (kernel_size[i] - 1) + output_padding[i] + 1
            for i in range(len(spatial))
        ]
        return torch.zeros((batch_size, out_channels, *output_shape), device=x.device, dtype=x.dtype)

    @staticmethod
    def backward(ctx, grad_output):
        x_shape, w_shape, b_shape = ctx.saved_tensors
        grad_input = torch.zeros(x_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if ctx.needs_input_grad[0] else None
        grad_weight = torch.zeros(w_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if ctx.needs_input_grad[1] else None
        grad_bias = torch.zeros(b_shape.tolist(), device=grad_output.device, dtype=grad_output.dtype) if b_shape is not None and ctx.needs_input_grad[2] else None
        return grad_input, grad_weight, grad_bias, None, None, None, None, None

class MockConvBaseModule(torch.nn.Module):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size: tuple[int, ...],
        stride: tuple[int, ...],
        padding,
        dilation: tuple[int, ...],
        transposed: bool,
        output_padding: tuple[int, ...],
        groups: int,
        bias: bool,
        padding_mode: str,
        device=None,
        dtype=None,
    ) -> None:
        factory_kwargs = {"device": device, "dtype": dtype}
        super().__init__()
        # if groups <= 0:
        #     raise ValueError("groups must be a positive integer")
        # if in_channels % groups != 0:
        #     raise ValueError("in_channels must be divisible by groups")
        # if out_channels % groups != 0:
        #     raise ValueError("out_channels must be divisible by groups")
        # valid_padding_strings = {"same", "valid"}
        # if isinstance(padding, str):
        #     if padding not in valid_padding_strings:
        #         raise ValueError(
        #             f"Invalid padding string {padding!r}, should be one of {valid_padding_strings}"
        #         )
        #     if padding == "same" and any(s != 1 for s in stride):
        #         raise ValueError(
        #             "padding='same' is not supported for strided convolutions"
        #         )

        # valid_padding_modes = {"zeros", "reflect", "replicate", "circular"}
        # if padding_mode not in valid_padding_modes:
        #     raise ValueError(
        #         f"padding_mode must be one of {valid_padding_modes}, but got padding_mode='{padding_mode}'"
        #     )
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.transposed = transposed
        self.output_padding = output_padding
        self.groups = groups
        self.padding_mode = padding_mode
        # `_reversed_padding_repeated_twice` is the padding to be passed to
        # `F.pad` if needed (e.g., for non-zero padding types that are
        # implemented as two ops: padding + conv). `F.pad` accepts paddings in
        # reverse order than the dimension.
        # if isinstance(self.padding, str):
        #     self._reversed_padding_repeated_twice = [0, 0] * len(kernel_size)
        #     if padding == "same":
        #         for d, k, i in zip(
        #             dilation, kernel_size, range(len(kernel_size) - 1, -1, -1)
        #         ):
        #             total_padding = d * (k - 1)
        #             left_pad = total_padding // 2
        #             self._reversed_padding_repeated_twice[2 * i] = left_pad
        #             self._reversed_padding_repeated_twice[2 * i + 1] = (
        #                 total_padding - left_pad
        #             )
        # else:
        #     self._reversed_padding_repeated_twice = _reverse_repeat_tuple(
        #         self.padding, 2
        #     )

        if transposed:
            self.weight = Parameter(
                torch.zeros(
                    (in_channels, out_channels // groups, *kernel_size),
                    **factory_kwargs,
                )
            )
        else:
            self.weight = Parameter(
                torch.zeros(
                    (out_channels, in_channels // groups, *kernel_size),
                    **factory_kwargs,
                )
            )
        if bias:
            self.bias = Parameter(torch.zeros(out_channels, **factory_kwargs))
        else:
            self.bias = None
    
    def forward(self, x):
        if self.transposed:
            return MockTransposeConvFunction.apply(
                x, self.weight, self.bias, self.stride, self.padding,
                self.output_padding, self.groups, self.dilation
            )
        else:
            return MockConvFunction.apply(
                x, self.weight, self.bias, self.stride, self.padding, self.dilation, self.groups
            )
    
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)

class MockConv1Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        dilation = 1,
        groups: int = 1,
        bias: bool = True,
        padding_mode: str = "zeros", 
        device=None,
        dtype=None,
    ) -> None:
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size_ = _single(kernel_size)
        stride_ = _single(stride)
        padding_ = padding if isinstance(padding, str) else _single(padding)
        dilation_ = _single(dilation)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size_,
            stride_,
            padding_,
            dilation_,
            False,
            _single(0),
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        )

class MockConv2Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        dilation = 1,
        groups: int = 1,
        bias: bool = True,
        padding_mode: str = "zeros", 
        device=None,
        dtype=None,
    ) -> None:
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size_ = _pair(kernel_size)
        stride_ = _pair(stride)
        padding_ = padding if isinstance(padding, str) else _pair(padding)
        dilation_ = _pair(dilation)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size_,
            stride_,
            padding_,
            dilation_,
            False,
            _pair(0),
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        )

class MockConv3Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        dilation = 1,
        groups: int = 1,
        bias: bool = True,
        padding_mode: str = "zeros", 
        device=None,
        dtype=None,
    ) -> None:
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size_ = _triple(kernel_size)
        stride_ = _triple(stride)
        padding_ = padding if isinstance(padding, str) else _triple(padding)
        dilation_ = _triple(dilation)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size_,
            stride_,
            padding_,
            dilation_,
            False,
            _triple(0),
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        )

class MockTransposeConv1Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        output_padding = 0,
        groups: int = 1,
        bias: bool = True,
        dilation = 1,
        padding_mode: str = "zeros",
        device=None,
        dtype=None
    ):
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size = _single(kernel_size)
        stride = _single(stride)
        padding = _single(padding)
        dilation = _single(dilation)
        output_padding = _single(output_padding)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size,
            stride,
            padding,
            dilation,
            True,
            output_padding,
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        ) 

class MockTransposeConv2Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        output_padding = 0,
        groups: int = 1,
        bias: bool = True,
        dilation = 1,
        padding_mode: str = "zeros",
        device=None,
        dtype=None
    ):
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size = _pair(kernel_size)
        stride = _pair(stride)
        padding = _pair(padding)
        dilation = _pair(dilation)
        output_padding = _pair(output_padding)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size,
            stride,
            padding,
            dilation,
            True,
            output_padding,
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        )

class MockTransposeConv3Module(MockConvBaseModule):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        kernel_size,
        stride = 1,
        padding = 0,
        output_padding = 0,
        groups: int = 1,
        bias: bool = True,
        dilation = 1,
        padding_mode: str = "zeros",
        device=None,
        dtype=None
    ):
        factory_kwargs = {"device": device, "dtype": dtype}
        kernel_size = _triple(kernel_size)
        stride = _triple(stride)
        padding = _triple(padding)
        dilation = _triple(dilation)
        output_padding = _triple(output_padding)
        super().__init__(
            in_channels,
            out_channels,
            kernel_size,
            stride,
            padding,
            dilation,
            True,
            output_padding,
            groups,
            bias,
            padding_mode,
            **factory_kwargs,
        )


def conv_mock(x, weight, bias, stride, padding, dilation, groups):
    return MockConvFunction.apply(x, weight, bias, stride, padding, dilation, groups)

def conv_transpose_mock(x, weight, bias, stride, padding, output_padding, groups, dilation):
    return MockTransposeConvFunction.apply(x, weight, bias, stride, padding, output_padding, groups, dilation)


def pad_mock(input, pad, mode="constant", value=0.0):
    input_shape = list(input.shape)
    num_pad_dims = len(pad) // 2
    output_shape = input_shape.copy()

    for i in range(num_pad_dims):
        dim = -(i + 1)
        pad_left = pad[2 * i]
        pad_right = pad[2 * i + 1]
        output_shape[dim] += pad_left + pad_right

    return torch.zeros(output_shape, dtype=input.dtype, device=input.device)
 

mock_dict = {
    torch.nn.modules.conv.Conv1d: MockConv1Module,
    torch.nn.modules.conv.Conv2d: MockConv2Module,
    torch.nn.modules.conv.Conv3d: MockConv3Module,
    torch.nn.modules.conv.ConvTranspose1d: MockTransposeConv1Module,
    torch.nn.modules.conv.ConvTranspose2d: MockTransposeConv2Module,
    torch.nn.modules.conv.ConvTranspose3d: MockTransposeConv3Module,
    # torch.nn.modules.conv.LazyConv1d,
    # torch.nn.modules.conv.LazyConv2d,
    # torch.nn.modules.conv.LazyConv3d,
    # torch.nn.modules.conv.LazyConvTranspose1d,
    # torch.nn.modules.conv.LazyConvTranspose2d,
    # torch.nn.modules.conv.LazyConvTranspose3d,
    torch.nn.functional.conv1d: conv_mock,
    torch.nn.functional.conv2d: conv_mock,
    torch.nn.functional.conv3d: conv_mock,
    torch.nn.functional.conv_transpose1d: conv_transpose_mock,
    torch.nn.functional.conv_transpose2d: conv_transpose_mock,
    torch.nn.functional.conv_transpose3d: conv_transpose_mock,
    torch.nn.functional.pad: pad_mock
}
