import torch
import torch.fx

from .nn import (activation, conv, dropout, embedding, linear, normalization, functional, 
                 pooling)
from ._torch import matmul, functions
builtin_mocks = {
    **embedding.mock_dict,
    **pooling.mock_dict,
    **linear.mock_dict,
    **conv.mock_dict,
    **dropout.mock_dict,
    **normalization.mock_dict,
    **activation.mock_dict,
    **matmul.mock_dict,
    **functions.mock_dict,
    **functional.mock_dict,
}


def mock():
    to_explore = [torch]
    explored = set()
    while to_explore:
        obj = to_explore.pop()
        if obj in explored:
            continue
        explored.add(obj)
        for attr in dir(obj):
            # if attr.startswith("_"):
            #     continue
            attr_obj = getattr(obj, attr)
            # print(f"Exploring name={obj.__name__} attr={attr}")

            try:
                if isinstance(attr_obj, dict) \
                    or isinstance(attr_obj, set):
                    # print("Found a dict or set, skipping")
                    continue
                if attr_obj in builtin_mocks:
                    mock_class = builtin_mocks[attr_obj]
                    setattr(obj, attr, mock_class)
                    # print(f"Mocked {obj.__name__}.{attr} with {mock_class}")
                else:
                    if hasattr(attr_obj, "__name__") \
                        and attr_obj.__name__.startswith("torch") \
                            and attr_obj not in explored:
                        to_explore.append(attr_obj)
            except Exception as e:
                # print(f"Error while exploring {obj.__name__}.{attr}: {e}")
                continue
           


