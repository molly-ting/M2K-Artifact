import torch


def rsqrt_mock(input, *, out=None):
    """Mock implementation of torch.rsqrt."""
    result = torch.zeros_like(input)
    if out is not None:
        out.copy_(result)
        return out
    return result


def flatten_mock(input, start_dim=0, end_dim=-1):
    """Mock implementation of torch.flatten."""
    shape = list(input.shape)
    if end_dim == -1:
        end_dim = len(shape) - 1
    
    # Calculate flattened dimension
    flatten_size = 1
    for i in range(start_dim, end_dim + 1):
        flatten_size *= shape[i]
    
    # New shape: keep dims before start_dim, flatten middle, keep dims after end_dim
    new_shape = shape[:start_dim] + [flatten_size] + shape[end_dim + 1:]
    return torch.zeros(new_shape, device=input.device, dtype=input.dtype)


def amax_mock(input, dim=None, keepdim=False, *, out=None):
    """Mock implementation of torch.amax."""
    if dim is None:
        # Return scalar
        result = torch.tensor(0.0, device=input.device, dtype=input.dtype)
    else:
        shape = list(input.shape)
        if isinstance(dim, int):
            dim = [dim]
        
        # Remove dimensions or keep them as size 1
        for d in sorted(dim, reverse=True):
            if d < 0:
                d = len(shape) + d
            if keepdim:
                shape[d] = 1
            else:
                shape.pop(d)
        
        result = torch.zeros(shape, device=input.device, dtype=input.dtype)
    
    if out is not None:
        out.copy_(result)
        return out
    return result


def amin_mock(input, dim=None, keepdim=False, *, out=None):
    """Mock implementation of torch.amin."""
    if dim is None:
        # Return scalar
        result = torch.tensor(0.0, device=input.device, dtype=input.dtype)
    else:
        shape = list(input.shape)
        if isinstance(dim, int):
            dim = [dim]
        
        # Remove dimensions or keep them as size 1
        for d in sorted(dim, reverse=True):
            if d < 0:
                d = len(shape) + d
            if keepdim:
                shape[d] = 1
            else:
                shape.pop(d)
        
        result = torch.zeros(shape, device=input.device, dtype=input.dtype)
    
    if out is not None:
        out.copy_(result)
        return out
    return result

original_torch_clamp = torch.clamp

def clamp_mock(input, min=None, max=None, *, out=None):
    if input.dtype in (torch.int32, torch.int64, torch.int16, torch.int8):
        return original_torch_clamp(input, min=min, max=max, out=out)
    
    """Mock implementation of torch.clamp."""
    result = torch.zeros_like(input)
    if out is not None:
        out.copy_(result)
        return out
    return result

original_torch_cat = torch.cat

def cat_mock(tensors, dim=0, out=None):
    """
    Fake version of torch.cat:
    - Returns an empty tensor with the correct shape
    - Does NOT copy or compute anything
    """
    if not tensors:
        raise ValueError("cat_mock requires at least one tensor")

    is_int = True
    for t in tensors:
        if not t.dtype in (torch.int32, torch.int64, torch.int16, torch.int8):
            is_int = False
            break

    if is_int:
        return original_torch_cat(tensors, dim=dim, out=out)
    
    # Take shape of first tensor
    shape = list(tensors[0].shape)
    
    # Compute the concatenated size along the dim
    concat_dim = sum(t.shape[dim] for t in tensors)
    shape[dim] = concat_dim

    # Return an empty tensor of the correct shape and dtype/device
    return torch.zeros(shape, dtype=tensors[0].dtype, device=tensors[0].device)


# Mock dictionary for torch functions
mock_dict = {
    torch.rsqrt: rsqrt_mock,
    torch.flatten: flatten_mock,
    torch.amax: amax_mock,
    torch.amin: amin_mock,
    torch.clamp: clamp_mock,
    torch.cat: cat_mock,
}
