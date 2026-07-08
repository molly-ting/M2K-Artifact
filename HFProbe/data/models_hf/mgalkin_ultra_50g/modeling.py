import os
import sys
from transformers import PretrainedConfig, PreTrainedModel
#sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from ultra.models import Ultra
from ultra.datasets import WN18RR, CoDExSmall, FB15k237, FB15k237Inductive
from ultra.eval import test


class UltraConfig(PretrainedConfig):

    model_type = "ultra"

    auto_map = {
        "AutoConfig": "modeling.UltraConfig",
        "AutoModel": "modeling.UltraForKnowledgeGraphReasoning",
    }

    def __init__(
            self,
            relation_model_layers: int = 6,
            relation_model_dim: int = 64,
            entity_model_layers: int = 6, 
            entity_model_dim: int = 64, 
            **kwargs):
        
        self.relation_model_cfg = dict(
            input_dim=relation_model_dim,
            hidden_dims=[relation_model_dim]*relation_model_layers,
            message_func="distmult",
            aggregate_func="sum",
            short_cut=True,
            layer_norm=True
        )

        self.entity_model_cfg = dict(
            input_dim=entity_model_dim,
            hidden_dims=[entity_model_dim]*entity_model_layers,
            message_func="distmult",
            aggregate_func="sum",
            short_cut=True,
            layer_norm=True
        )

        super().__init__(**kwargs)

class UltraForKnowledgeGraphReasoning(PreTrainedModel):

    config_class = UltraConfig

    def __init__(self, config):
        super().__init__(config)

        self.model = Ultra(
            rel_model_cfg=config.relation_model_cfg,
            entity_model_cfg=config.entity_model_cfg,
        )

    def forward(self, data, batch):
        # data: PyG data object 
        # batch shape: (bs, 1+num_negs, 3)
        return self.model.forward(data, batch)
    

if __name__ == "__main__":

    model = UltraForKnowledgeGraphReasoning.from_pretrained("mgalkin/ultra_50g")
    dataset = CoDExSmall(root="./datasets/")
    test(model, mode="test", dataset=dataset, gpus=None)
    # mrr:      0.497697
    # hits@10:  0.685175