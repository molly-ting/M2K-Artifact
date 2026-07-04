import torch


class EmbeddingMock:
    def __init__(self, num_embeddings, embedding_dim, padding_idx=None, 
                 max_norm=None, norm_type=2.0, scale_grad_by_freq=False, 
                 sparse=False, _weight=None, _freeze=False, device=None, dtype=None):
        factory_kwargs = {"device": device, "dtype": dtype}
        self.num_embeddings = num_embeddings
        self.embedding_dim = embedding_dim
        self.padding_idx = padding_idx
        self.max_norm = max_norm
        self.norm_type = norm_type
        self.scale_grad_by_freq = scale_grad_by_freq
        self.sparse = sparse
        self.mock_gradient_sink = torch.ones(1, requires_grad=True)
        
        if _weight is None:
            self.weight = torch.nn.Parameter(
                torch.zeros((num_embeddings, embedding_dim), **factory_kwargs),
                requires_grad=not _freeze,
            )
            self.reset_parameters()
        else:
            self.weight = torch.nn.Parameter(_weight, requires_grad=not _freeze)


    def forward(self, x):
        new_shape = tuple(list(x.shape) + [self.embedding_dim])
        return self.mock_gradient_sink * torch.zeros(new_shape, device=x.device, dtype=x.dtype)
    
    def reset_parameters(self) -> None:
        self._fill_padding_idx_with_zero()

    def _fill_padding_idx_with_zero(self) -> None:
        pass
        # if self.padding_idx is not None:
        #     self.weight[self.padding_idx].fill_(0)
    
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)

def embedding_mock(input, weight, padding_idx=None, max_norm=None,
                   norm_type=2.0, scale_grad_by_freq=False, sparse=False):
    """
    Fake F.embedding that returns a tensor of correct shape, filled with zeros.
    """
    embedding_dim = weight.shape[1]
    output_shape = input.shape + (embedding_dim,)
    return torch.zeros(output_shape, dtype=weight.dtype, device=weight.device)

def embedding_bag_mock(input, weight, offsets, max_norm=None, norm_type=2.0,
                       scale_grad_by_freq=False, mode='mean', sparse=False,
                       per_sample_weights=None, include_last_offset=False,
                       padding_idx=None):
    embedding_dim = weight.shape[1]
    num_bags = offsets.shape[0] if not include_last_offset else offsets.shape[0] - 1
    return torch.zeros((num_bags, embedding_dim), dtype=weight.dtype, device=weight.device)


mock_dict = {
    torch.nn.modules.sparse.Embedding: EmbeddingMock,
    # torch.nn.modules.sparse.EmbeddingBag: None,
    torch.nn.functional.embedding: embedding_mock,
    torch.nn.functional.embedding_bag: embedding_bag_mock
}
