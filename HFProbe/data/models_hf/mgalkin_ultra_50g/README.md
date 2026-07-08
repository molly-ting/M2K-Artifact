---
license: mit
pipeline_tag: graph-ml
tags:
- graphs
- ultra
- knowledge graph
---
 
## Description
ULTRA is a foundation model for knowledge graph (KG) reasoning. A single pre-trained ULTRA model performs link prediction tasks on **any** multi-relational graph with any entity / relation vocabulary. Performance-wise averaged on 50+ KGs, a single pre-trained ULTRA model is better in the **0-shot** inference mode than many SOTA models trained specifically on each graph. Following the pretrain-finetune paradigm of foundation models, you can run a pre-trained ULTRA checkpoint **immediately in the zero-shot manner** on any graph as well as **use more fine-tuning**.

ULTRA provides **unified, learnable, transferable** representations for any KG. Under the hood, ULTRA employs graph neural networks and modified versions of NBFNet. ULTRA does not learn any entity and relation embeddings specific to a downstream graph but instead obtains relative relation representations based on interactions between relations.

arxiv:  https://arxiv.org/abs/2310.04562  
GitHub: https://github.com/DeepGraphLearning/ULTRA  


## Checkpoints
Here on HuggingFace, we provide 3 pre-trained ULTRA checkpoints (all ~169k params) varying by the amount of pre-training data.

| Model | Training KGs |
| ------| --------------|
| [ultra_3g](https://huggingface.co/mgalkin/ultra_3g) | 3 graphs |
| [ultra_4g](https://huggingface.co/mgalkin/ultra_4g) | 4 graphs |
| [ultra_50g](https://huggingface.co/mgalkin/ultra_50g) | 50 graphs |

* [ultra_3g](https://huggingface.co/mgalkin/ultra_3g) and [ultra_4g](https://huggingface.co/mgalkin/ultra_4g) are the PyG models reported in the github repo;  
* [ultra_50g](https://huggingface.co/mgalkin/ultra_50g) is a new ULTRA checkpoint pre-trained on 50 different KGs (transductive and inductive) for 1M steps to maximize the performance on any unseen downstream KG.

## ⚡️ Your Superpowers 

ULTRA performs **link prediction** (KG completion aka reasoning): given a query `(head, relation, ?)`, it ranks all nodes in the graph as potential `tails`. 


1. Install the dependencies as listed in the Installation instructions on the [GitHub repo](https://github.com/DeepGraphLearning/ULTRA#installation).
2. Clone this model repo to find the `UltraForKnowledgeGraphReasoning` class in `modeling.py` and load the checkpoint (all the necessary model code is in this model repo as well).

* Run **zero-shot inference** on any graph:

```python
from modeling import UltraForKnowledgeGraphReasoning
from ultra.datasets import CoDExSmall
from ultra.eval import test
model = UltraForKnowledgeGraphReasoning.from_pretrained("mgalkin/ultra_50g")
dataset = CoDExSmall(root="./datasets/")
test(model, mode="test", dataset=dataset, gpus=None)
# Expected results for ULTRA 50g
# mrr:      0.498
# hits@10:  0.685
```

Or with `AutoModel`:

```python
from transformers import AutoModel
from ultra.datasets import CoDExSmall
from ultra.eval import test
model = AutoModel.from_pretrained("mgalkin/ultra_50g", trust_remote_code=True)
dataset = CoDExSmall(root="./datasets/")
test(model, mode="test", dataset=dataset, gpus=None)
# Expected results for ULTRA 50g
# mrr:      0.498
# hits@10:  0.685
```

* You can also **fine-tune** ULTRA on each graph, please refer to the [github repo](https://github.com/DeepGraphLearning/ULTRA#run-inference-and-fine-tuning) for more details on training / fine-tuning   
* The model code contains 57 different KGs, please refer to the [github repo](https://github.com/DeepGraphLearning/ULTRA#datasets) for more details on what's available.   

## Performance

**Averaged zero-shot performance of ultra-3g and ultra-4g**
<table>
    <tr>
        <th rowspan=2 align="center">Model </th>
        <th colspan=2 align="center">Inductive (e) (18 graphs)</th>
        <th colspan=2 align="center">Inductive (e,r) (23 graphs)</th>
        <th colspan=2 align="center">Transductive (16 graphs)</th>
    </tr>
    <tr>
        <th align="center"> Avg MRR</th>
        <th align="center"> Avg Hits@10</th>
        <th align="center"> Avg MRR</th>
        <th align="center"> Avg Hits@10</th>
        <th align="center"> Avg MRR</th>
        <th align="center"> Avg Hits@10</th>
    </tr>
    <tr>
        <th>ULTRA (3g) PyG</th>
        <td align="center">0.420</td>
        <td align="center">0.562</td>
        <td align="center">0.344</td>
        <td align="center">0.511</td>
        <td align="center">0.329</td>
        <td align="center">0.479</td>
    </tr>
    <tr>
        <th>ULTRA (4g) PyG</th>
        <td align="center">0.444</td>
        <td align="center">0.588</td>
        <td align="center">0.344</td>
        <td align="center">0.513</td>
        <td align="center">WIP</td>
        <td align="center">WIP</td>
    </tr>
   <tr>
        <th>ULTRA (50g) PyG (pre-trained on 50 KGs)</th>
        <td align="center">0.444</td>
        <td align="center">0.580</td>
        <td align="center">0.395</td>
        <td align="center">0.554</td>
        <td align="center">0.389</td>
        <td align="center">0.549</td>
    </tr>
</table>
Fine-tuning ULTRA on specific graphs brings, on average, further 10% relative performance boost both in MRR and Hits@10. See the paper for more comparisons.

**ULTRA 50g Performance**

ULTRA 50g was pre-trained on 50 graphs, so we can't really apply the zero-shot evaluation protocol to the graphs. 
However, we can compare with Supervised SOTA models trained from scratch on each dataset:

| Model | Avg MRR, Transductive graphs (16)| Avg Hits@10, Transductive graphs (16)|
| ----- | ---------------------------------| -------------------------------------|
| Supervised SOTA models   | 0.371 | 0.511 |
| ULTRA 50g (single model) | **0.389** | **0.549** |

That is, instead of training a big KG embedding model on your graph, you might want to consider running ULTRA (any of the checkpoints) as its performance might already be higher 🚀

## Useful links

Please report the issues in the [official GitHub repo of ULTRA](https://github.com/DeepGraphLearning/ULTRA)