# Aristo-v4
This knowledge base completion dataset is created from the 4-th version of [Aristo Tuple KB](https://allenai.org/data/tuple-kb), which has more than 1.6k predicates. We used the `COMBINED-KB.tsv` file and treated the columns `Arg1`, `Pred`, `Arg2` respectively as the head/relation/tail. Since Aristo-v4 has no standardised splits for KBC, we randomly sample 20k triples for
test and 20k for validation. In total, Aristo-v4 contains 44,950 entities and 1,605 predicates. The numbers of triples on training/validation/test sets are respectively 242,594/20,000/20,000. The main purpose of this dataset is to study how KBC models perform under a very large set of predicates.

## Format
Unzip `aristo-v4.zip` and you will find three files:
- `train`, `valid` and `test` are tab-separated with lines like the following
```
head    relation    tail
```

## Citation
If you find this dataset helpful to your research, please cite us
```
@inproceedings{
chen2021relation,
title={Relation Prediction as an Auxiliary Training Objective for Improving Multi-Relational Graph Representations},
author={Yihong Chen and Pasquale Minervini and Sebastian Riedel and Pontus Stenetorp},
booktitle={3rd Conference on Automated Knowledge Base Construction},
year={2021},
url={https://openreview.net/forum?id=Qa3uS3H7-Le}
}
```
