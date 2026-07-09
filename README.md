# M2K: Source Code, Scripts, and Data for SOSP 2026 Artifact Evaluation

**Version:** 1.0  
**Last updated:** July 13, 2026  
**Paper:** M2K: Making the Model-Kernel Interface Explicit for Reliable CUDA Kernel Verification

This document provides instructions for reproducing the experimental results reported in the M2K paper. We first describe the hardware and software requirements for running the artifact and explain how to install it. We then walk through the example in Figure 2 to demonstrate how the tool works. Finally, we explain how to reproduce the empirical study of kernel memory bugs (Section 2.3), the bug-detection results in the wild (Section 6.1), the coverage and advancement measurements (Section 6.2), and the ablation study on component rationality (Section 6.3).

## 1. System Requirements

- **OS:** Ubuntu 18.04/20.04/22.04
- **CPU:** XXX
- **Memory (RAM):** >=256 GB
- **Disk space:** XXX
- **GPU:** V100/RTX 20xx/H100 (for the ablation experiment)
- **CUDA:** 12.1
- **Python:** 3.10

## 2. Installation
### option 1
```bash
./setup.sh
```
### option 2
```bash
docker build -t m2k-env .
docker run m2k-env
```

## 3. Tool Demonstration 

This section walks through the example in Figure 2 to show the basic workflow of M2K.
a. run cuKLEE alone
**Steps:**

```bash
cd example
./run_example_cuKLEE.sh
```

**Expected output:** XXX

b. run model Qwen/Qwen2-0.5B-Instruct


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



