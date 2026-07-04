import torch


class BatchNormMock(torch.nn.Module):
    def __init__(self, num_features, eps=1e-5, momentum=0.1, affine=True, 
                 track_running_stats=True, device=None, dtype=None):
        super().__init__()
        self.num_features = num_features
        self.eps = eps
        self.momentum = momentum
        self.affine = affine
        self.track_running_stats = track_running_stats
        self.training = True

    def forward(self, x):
        in_channels = x.shape[1]
        assert self.num_features == in_channels
        return x
    
    def train(self, mode=True):
        """Set training mode."""
        self.training = mode
        return self
    
    def eval(self):
        """Set evaluation mode."""
        return self.train(False)
    
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)

def batch_norm_mock(input, running_mean, running_var, weight=None, bias=None,
                    training=False, momentum=0.1, eps=1e-5):
    return input

mock_dict = {
    torch.nn.modules.batchnorm.BatchNorm1d: BatchNormMock,
    torch.nn.modules.batchnorm.BatchNorm2d: BatchNormMock,
    torch.nn.modules.batchnorm.BatchNorm3d: BatchNormMock,
    # torch.nn.modules.batchnorm.SyncBatchNorm,
    # torch.nn.modules.batchnorm.LazyBatchNorm1d,
    # torch.nn.modules.batchnorm.LazyBatchNorm2d,
    # torch.nn.modules.batchnorm.LazyBatchNorm3d,
    # torch.nn.modules.instancenorm.InstanceNorm1d,
    # torch.nn.modules.instancenorm.InstanceNorm2d,
    # torch.nn.modules.instancenorm.InstanceNorm3d,
    # torch.nn.modules.instancenorm.LazyInstanceNorm1d,
    # torch.nn.modules.instancenorm.LazyInstanceNorm2d,
    # torch.nn.modules.instancenorm.LazyInstanceNorm3d,
    # torch.nn.modules.normalization.LocalResponseNorm,
    # torch.nn.modules.normalization.CrossMapLRN2d,
    # torch.nn.modules.normalization.LayerNorm,
    # torch.nn.modules.normalization.GroupNorm,
    torch.nn.functional.batch_norm: batch_norm_mock
}
