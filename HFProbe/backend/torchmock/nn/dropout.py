import torch


class DropoutMock:
    def __init__(self, p=0.5, inplace=False):
        """
        Mock implementation of Dropout layer.
        
        Args:
            p (float): probability of an element to be zeroed. Default: 0.5
            inplace (bool): If set to True, will do this operation in-place. Default: False
        """
        self.p = p
        self.inplace = inplace
        self.training = True
    
    def forward(self, input):
        """
        Forward pass - in mock implementation, we just return the input unchanged.
        In a real implementation, this would randomly zero elements during training.
        """
        return input
    
    def train(self, mode=True):
        """Set training mode."""
        self.training = mode
        return self
    
    def eval(self):
        """Set evaluation mode."""
        return self.train(False)
    
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)


class AlphaDropoutMock:
    def __init__(self, p=0.5, inplace=False):
        """
        Mock implementation of AlphaDropout layer.
        
        Args:
            p (float): probability of an element to be masked. Default: 0.5
            inplace (bool): If set to True, will do this operation in-place. Default: False
        """
        self.p = p
        self.inplace = inplace
        self.training = True
    
    def forward(self, input):
        """Forward pass - returns input unchanged in mock implementation."""
        return input
    
    def train(self, mode=True):
        """Set training mode."""
        self.training = mode
        return self
    
    def eval(self):
        """Set evaluation mode."""
        return self.train(False)
    
    def __call__(self, *args, **kwargs):
        return self.forward(*args, **kwargs)


# Functional dropout mock
def dropout_functional_mock(input, p=0.5, training=True, inplace=False):
    """
    Mock implementation of functional dropout.
    In mock implementation, just returns the input unchanged.
    """
    return input


mock_dict = {
    torch.nn.modules.dropout.Dropout: DropoutMock,
    torch.nn.modules.dropout.Dropout1d: DropoutMock,
    torch.nn.modules.dropout.Dropout2d: DropoutMock,
    torch.nn.modules.dropout.Dropout3d: DropoutMock,
    torch.nn.modules.dropout.AlphaDropout: AlphaDropoutMock,
    torch.nn.modules.dropout.FeatureAlphaDropout: AlphaDropoutMock,
    torch.nn.functional.dropout: dropout_functional_mock,
    torch.nn.functional.dropout1d: dropout_functional_mock,
    torch.nn.functional.dropout2d: dropout_functional_mock,
    torch.nn.functional.dropout3d: dropout_functional_mock,
    torch.nn.functional.alpha_dropout: dropout_functional_mock,
    torch.nn.functional.feature_alpha_dropout: dropout_functional_mock,
}
