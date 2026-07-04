import torch
import math


# class MockPoolFunction(torch.autograd.Function):
#     @staticmethod
#     def forward(ctx, x, kernel_size, dilation, padding, stride):
#         ctx.save_for_backward(torch.IntTensor(tuple(x.shape)))

#         batch_size = x.shape[0]
#         in_channels = x.shape[1]
#         spacial_shape = x.shape[2:]
#         spacial_dim = len(spacial_shape)
#         out_channels = in_channels
#         new_spacial_shape = [
#             (
#                 spacial_shape[i]
#                 + 2 * padding[i]
#                 - dilation[i] * (kernel_size[i] - 1)
#                 - 1
#                 + stride[i]
#             )
#             // stride[i]
#             for i in range(spacial_dim)
#         ]
#         new_shape = tuple([batch_size, out_channels] + new_spacial_shape)
#         return torch.zeros(new_shape, device=x.device, dtype=x.dtype)

#     @staticmethod
#     def backward(ctx, grad_output):
#         x_shape = tuple(ctx.saved_tensors[0])
#         return torch.zeros(x_shape, device=grad_output.device, dtype=grad_output.dtype), None, None, None, None


# def tupleize(d, dim=2):
#     if isinstance(d, int):
#         return tuple([d] * dim)
#     elif isinstance(d, tuple):
#         if len(d) == 1:
#             return tupleize(d[0])
#         assert len(d) == dim
#         return d
#     else:
#         raise ValueError


# class MockPoolModule:
#     def __init__(self, obj):
#         super().__init__()
#         self.__class__ = type(
#             obj.__class__.__name__, (self.__class__, obj.__class__), {}
#         )
#         self.__dict__ = obj.__dict__
#         self.kernel_size = obj.kernel_size
#         self.dilation = getattr(obj, "dilation", 1)
#         self.padding = obj.padding
#         self.stride = obj.stride
#         self.ceil_mode = obj.ceil_mode
#         self.count_include_pad = obj.count_include_pad

#     def forward(self, x):
#         spacial_dim = len(x.shape) - 2
#         return MockPoolFunction.apply(
#             x,
#             tupleize(self.kernel_size, spacial_dim),
#             tupleize(self.dilation, spacial_dim),
#             tupleize(self.padding, spacial_dim),
#             tupleize(self.stride, spacial_dim),
#         )
        
#     def __call__(self, *args, **kwargs):
#         return self.forward(*args, **kwargs)


# def pool_mock(input, kernel_size, stride=None, padding=0, dilation=1, ceil_mode=False, return_indices=False):
#     spacial_dim = len(input.shape) - 2
#     return MockPoolFunction.apply(
#         input,
#         tupleize(kernel_size, spacial_dim),
#         tupleize(dilation, spacial_dim),
#         tupleize(padding, spacial_dim),
#         tupleize(stride, spacial_dim),
#     )


from torch.nn.modules.utils import _ntuple

class MockAvgPool1dFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, x, kernel_size, stride, padding, ceil_mode, count_include_pad):
        ctx.save_for_backward(x)
        ctx.kernel_size = kernel_size
        ctx.stride = stride
        ctx.padding = padding
        ctx.ceil_mode = ceil_mode
        ctx.count_include_pad = count_include_pad

        spatial_dim = 1
        kernel_size = _ntuple(spatial_dim)(kernel_size)
        stride = _ntuple(spatial_dim)(stride if stride is not None else kernel_size)
        padding = _ntuple(spatial_dim)(padding)

        batch_size, channels, length = x.shape

        def calc_out_dim(in_size, k, p, s, ceil_mode):
            numerator = in_size + 2 * p - k
            if ceil_mode:
                return (numerator + s - 1) // s + 1
            else:
                return numerator // s + 1

        out_length = calc_out_dim(length, kernel_size[0], padding[0], stride[0], ceil_mode)
        out_shape = (batch_size, channels, out_length)
        return x.new_zeros(out_shape)

    @staticmethod
    def backward(ctx, grad_output):
        x, = ctx.saved_tensors
        return grad_output.new_zeros(x.shape), None, None, None, None

class MockAvgPool1d(torch.nn.Module):
    def __init__(self, kernel_size, stride=None, padding=0, ceil_mode=False, count_include_pad=True):
        super().__init__()
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.ceil_mode = ceil_mode
        self.count_include_pad = count_include_pad

    def forward(self, x):
        stride = self.stride if self.stride is not None else self.kernel_size
        return MockAvgPool1dFunction.apply(x, self.kernel_size, stride, self.padding, self.ceil_mode, self.count_include_pad)

def avg1dpool_mock(input, kernel_size, stride, padding=0, ceil_mode=False, count_include_pad=True):
    return MockAvgPool1dFunction.apply(input, kernel_size, stride, padding, ceil_mode, count_include_pad)


class MockAvgPoolFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, x, kernel_size, stride, padding, ceil_mode, count_include_pad, divisor_override):
        ctx.save_for_backward(x)
        ctx.kernel_size = kernel_size
        ctx.stride = stride
        ctx.padding = padding
        ctx.ceil_mode = ceil_mode
        ctx.count_include_pad = count_include_pad
        ctx.divisor_override = divisor_override

        # Normalize params to tuple matching spatial dims
        spatial_dim = x.dim() - 2  # exclude batch & channel dims
        kernel_size = _ntuple(spatial_dim)(kernel_size)
        stride = _ntuple(spatial_dim)(stride if stride is not None else kernel_size)
        padding = _ntuple(spatial_dim)(padding)

        input_shape = x.shape
        batch_size, channels = input_shape[0], input_shape[1]
        spatial_shape = input_shape[2:]

        def calc_out_dim(in_size, k, p, s, ceil_mode):
            numerator = in_size + 2 * p - k
            if ceil_mode:
                return (numerator + s - 1) // s + 1
            else:
                return numerator // s + 1

        out_spatial = [
            calc_out_dim(spatial_shape[i], kernel_size[i], padding[i], stride[i], ceil_mode)
            for i in range(spatial_dim)
        ]

        out_shape = (batch_size, channels, *out_spatial)
        return x.new_zeros(out_shape)

    @staticmethod
    def backward(ctx, grad_output):
        x, = ctx.saved_tensors
        return (
            grad_output.new_zeros(x.shape),  # grad for input
            None,  # kernel_size no grad
            None,  # stride no grad
            None,  # padding no grad
            None,  # ceil_mode no grad
            None,  # count_include_pad no grad
            None,  # divisor_override no grad
        )

class MockAvgPoolModule(torch.nn.Module):
    def __init__(
        self,
        kernel_size,
        stride=None,
        padding=0,
        ceil_mode=False,
        count_include_pad=True,
        divisor_override=None,
    ):
        super().__init__()
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.ceil_mode = ceil_mode
        self.count_include_pad = count_include_pad
        self.divisor_override = divisor_override

    def forward(self, x):
        stride = self.stride if self.stride is not None else self.kernel_size
        return MockAvgPoolFunction.apply(
            x,
            self.kernel_size,
            stride,
            self.padding,
            self.ceil_mode,
            self.count_include_pad,
            self.divisor_override,
        )

def avgpool_mock(input, kernel_size, stride, padding=0, ceil_mode=False, count_include_pad=True, divisor_override=None):
    return MockAvgPoolFunction.apply(input, kernel_size, stride, padding, ceil_mode, count_include_pad, divisor_override)


class MockMaxPoolFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, x, kernel_size, stride, padding, dilation, ceil_mode, return_indices):
        ctx.save_for_backward(x)
        ctx.kernel_size = kernel_size
        ctx.stride = stride
        ctx.padding = padding
        ctx.dilation = dilation
        ctx.ceil_mode = ceil_mode
        ctx.return_indices = return_indices

        spatial_dim = x.dim() - 2  # exclude batch & channel dims

        kernel_size = _ntuple(spatial_dim)(kernel_size)
        stride = _ntuple(spatial_dim)(stride if stride is not None else kernel_size)
        padding = _ntuple(spatial_dim)(padding)
        dilation = _ntuple(spatial_dim)(dilation)

        batch_size, channels = x.shape[:2]
        spatial_shape = x.shape[2:]

        def calc_out_dim(in_size, k, p, d, s, ceil_mode):
            numerator = in_size + 2 * p - d * (k - 1) - 1
            if ceil_mode:
                return (numerator + s) // s
            else:
                return numerator // s + 1

        out_spatial = [
            calc_out_dim(spatial_shape[i], kernel_size[i], padding[i], dilation[i], stride[i], ceil_mode)
            for i in range(spatial_dim)
        ]

        out_shape = (batch_size, channels, *out_spatial)
        output = x.new_zeros(out_shape)
        indices = torch.zeros(out_shape, dtype=torch.int64, device=x.device)

        if return_indices:
            return output, indices
        else:
            return output

    @staticmethod
    def backward(ctx, *grad_outputs):
        x, = ctx.saved_tensors
        grad_output = grad_outputs[0]
        # If return_indices=True, grad_outputs = (grad_output, grad_indices)
        # We ignore grad_indices since it's dummy
        return (
            grad_output.new_zeros(x.shape),  # grad input
            None,  # kernel_size
            None,  # stride
            None,  # padding
            None,  # dilation
            None,  # ceil_mode
            None,  # return_indices
        )

class MockMaxPoolModule(torch.nn.Module):
    def __init__(
        self,
        kernel_size,
        stride=None,
        padding=0,
        dilation=1,
        ceil_mode=False,
        return_indices=False,
    ):
        super().__init__()
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.ceil_mode = ceil_mode
        self.return_indices = return_indices

    def forward(self, x):
        stride = self.stride if self.stride is not None else self.kernel_size
        return MockMaxPoolFunction.apply(
            x,
            self.kernel_size,
            stride,
            self.padding,
            self.dilation,
            self.ceil_mode,
            self.return_indices,
        )

def maxpool_mock(input, kernel_size, stride, padding, dilation, ceil_mode, return_indices):
    return MockMaxPoolFunction.apply(input, kernel_size, stride, padding, dilation, ceil_mode, return_indices)

    
mock_dict = {
    torch.nn.modules.pooling.AvgPool1d: MockAvgPool1d,
    torch.nn.modules.pooling.AvgPool2d: MockAvgPoolModule,
    torch.nn.modules.pooling.AvgPool3d: MockAvgPoolModule,
    torch.nn.modules.pooling.MaxPool1d: MockMaxPoolModule,
    torch.nn.modules.pooling.MaxPool2d: MockMaxPoolModule,
    torch.nn.modules.pooling.MaxPool3d: MockMaxPoolModule,
    # torch.nn.modules.pooling.MaxUnpool1d,
    # torch.nn.modules.pooling.MaxUnpool2d,
    # torch.nn.modules.pooling.MaxUnpool3d,
    # torch.nn.modules.pooling.FractionalMaxPool2d,
    # torch.nn.modules.pooling.FractionalMaxPool3d,
    # torch.nn.modules.pooling.LPPool1d,
    # torch.nn.modules.pooling.LPPool2d,
    # torch.nn.modules.pooling.AdaptiveMaxPool1d,
    # torch.nn.modules.pooling.AdaptiveMaxPool2d,
    # torch.nn.modules.pooling.AdaptiveMaxPool3d,
    # torch.nn.modules.pooling.AdaptiveAvgPool1d,
    # torch.nn.modules.pooling.AdaptiveAvgPool2d,
    # torch.nn.modules.pooling.AdaptiveAvgPool3d,
    torch.nn.functional.avg_pool1d: avg1dpool_mock,
    torch.nn.functional.avg_pool2d: avgpool_mock,
    torch.nn.functional.avg_pool3d: avgpool_mock,
    torch.nn.functional.max_pool1d: maxpool_mock,
    torch.nn.functional.max_pool2d: maxpool_mock,
    torch.nn.functional.max_pool3d: maxpool_mock,
}
