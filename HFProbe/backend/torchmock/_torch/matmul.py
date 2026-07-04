import torch


def matmul_mock(input, other, *, out=None):
    """Mock implementation of torch.matmul."""
    input_shape = list(input.shape)
    other_shape = list(other.shape)
    
    if len(input_shape) == 1 and len(other_shape) == 1:
        # Vector dot product: (n,) x (n,) -> scalar
        result = torch.tensor(0.0, device=input.device, dtype=input.dtype)
    elif len(input_shape) == 2 and len(other_shape) == 1:
        # Matrix-vector: (m,n) x (n,) -> (m,)
        result = torch.zeros([input_shape[0]], device=input.device, dtype=input.dtype)
    elif len(input_shape) == 1 and len(other_shape) == 2:
        # Vector-matrix: (n,) x (n,m) -> (m,)
        result = torch.zeros([other_shape[1]], device=input.device, dtype=input.dtype)
    elif len(input_shape) == 2 and len(other_shape) == 2:
        # Matrix-matrix: (m,k) x (k,n) -> (m,n)
        result = torch.zeros([input_shape[0], other_shape[1]], device=input.device, dtype=input.dtype)
    else:
        # Batched matrix multiplication
        input_batch_dims = input_shape[:-2]
        other_batch_dims = other_shape[:-2]
        
        # Simple broadcasting
        max_batch_len = max(len(input_batch_dims), len(other_batch_dims))
        input_batch_dims = [1] * (max_batch_len - len(input_batch_dims)) + input_batch_dims
        other_batch_dims = [1] * (max_batch_len - len(other_batch_dims)) + other_batch_dims
        
        output_batch_dims = [max(input_batch_dims[i], other_batch_dims[i]) for i in range(max_batch_len)]
        output_shape = output_batch_dims + [input_shape[-2], other_shape[-1]]
        result = torch.zeros(output_shape, device=input.device, dtype=input.dtype)
    
    if out is not None:
        out.copy_(result)
        return out
    return result


def mm_mock(input, mat2, *, out=None):
    """Mock implementation of torch.mm."""
    result = torch.zeros([input.shape[0], mat2.shape[1]], device=input.device, dtype=input.dtype)
    if out is not None:
        out.copy_(result)
        return out
    return result


def bmm_mock(input, mat2, *, out=None):
    """Mock implementation of torch.bmm."""
    result = torch.zeros([input.shape[0], input.shape[1], mat2.shape[2]], device=input.device, dtype=input.dtype)
    if out is not None:
        out.copy_(result)
        return out
    return result


def dot_mock(input, other):
    """Mock implementation of torch.dot."""
    return torch.tensor(0.0, device=input.device, dtype=input.dtype)


def addmm_mock(bias, input, mat2, *, beta=1, alpha=1, out=None):
    """Mock implementation of torch.addmm."""
    result = torch.zeros([input.shape[0], mat2.shape[1]], device=input.device, dtype=input.dtype)
    if out is not None:
        out.copy_(result)
        return out
    return result


def baddbmm_mock(bias, input, mat2, *, beta=1, alpha=1, out=None):
    """Mock implementation of torch.baddbmm."""
    result = torch.zeros([input.shape[0], input.shape[1], mat2.shape[2]], device=input.device, dtype=input.dtype)
    if out is not None:
        out.copy_(result)
        return out
    return result

def multinomial_mock(input, num_samples, replacement=False, *, generator=None, out=None):
    input_shape = input.shape

    if input.dim() == 1:
        # input shape: (num_classes,)
        shape = (num_samples,)
    elif input.dim() == 2:
        # input shape: (batch_size, num_classes)
        shape = (input_shape[0], num_samples)
    else:
        raise ValueError("Only 1D or 2D input supported in fake_multinomial.")

    return torch.zeros(shape, dtype=torch.long, device=input.device)

def _scaled_mm_mock(qinput: torch.Tensor,
                   weight: torch.Tensor,
                   out_dtype: torch.dtype,
                   scale_a: torch.Tensor = None,
                   scale_b: torch.Tensor = None,
                   bias: torch.Tensor = None) -> torch.Tensor:
    m, k1 = qinput.shape
    k2, n = weight.shape
    
    out_shape = (m, n)
    return torch.zeros(out_shape, dtype=out_dtype, device=qinput.device)

# Mock dictionary for torch matrix operations
mock_dict = {
    torch.matmul: matmul_mock,
    torch.mm: mm_mock,
    torch.bmm: bmm_mock,
    torch.dot: dot_mock,
    torch.addmm: addmm_mock,
    torch.baddbmm: baddbmm_mock,
    torch.multinomial: multinomial_mock,
    torch._scaled_mm: _scaled_mm_mock
}
