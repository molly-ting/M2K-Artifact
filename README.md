# M2K: Source Code, Scripts, and Data for SOSP 2026 Artifact Evaluation

**Version:** 1.0  
**Last updated:** July 13, 2026  
**Paper:** M2K: Making the Model-Kernel Interface Explicit for Reliable CUDA Kernel Verification

This document provides instructions for reproducing the experimental results reported in the M2K paper. We first describe the hardware and software requirements for running the artifact and explain how to install it. We then walk through the example in Figure 2 to demonstrate how the tool works. Finally, we explain how to reproduce the empirical study of kernel memory bugs (Section 2.3), the bug-detection results in the wild (Section 6.1), the coverage and advancement measurements (Section 6.2), and the ablation study on component rationality (Section 6.3).

## 1. System Requirements

- **OS:** XXX
- **CPU:** XXX
- **Memory (RAM):** XXX
- **Disk space:** XXX
- **GPU / CUDA:** XXX (for the ablation experiment)
- **Python:** XXX

## 2. Installation

## 3. Tool Demonstration 

This section walks through the example in Figure 2 to show the basic workflow of M2K.

**Steps:**

```bash
XXX
```

**Expected output:** XXX


## 4. Kernel Memory Bugs in Inference Systems (Section 2.3)


## 5. Bug Detection in the Wild (Section 6.1)



**Estimated time:** XXX


**Steps:**


```bash
XXX
```


**Expected output:** XXX


## 6. Coverage and Advancement (Section 6.2)



## 7. Rationality of Components (Section 6.3)





excels/exp1.xlsx results of section 6.1
excels/coverage.xlsx dataset and results of section 6.2
excels/ablation.xlsx results of section 6.3
excels/bug-memory.xlsx data of figure 5

compile one cuda file:
python3 scripts/compile_cuda.py --input-file <input_filepath> --out-dir <output_directory>

compile cuda files in one directory:
python3 scripts/compile_cuda.py --input-dir <input_dirpath> --out-dir <output_directory>
