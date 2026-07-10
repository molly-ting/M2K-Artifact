# M2K: Source Code, Scripts, and Data for SOSP 2026 Artifact Evaluation

**Version:** 1.0  
**Last updated:** July 13, 2026  
**Paper:** M2K: Making the Model-Kernel Interface Explicit for Reliable CUDA Kernel Verification

This document provides instructions for reproducing the experimental results reported in the M2K paper. We first describe the hardware and software requirements for running the artifact and explain how to install it. We then walk through the example in Figure 2 to demonstrate how the tool works. Finally, we explain how to reproduce the empirical study of kernel memory bugs (Section 2.3), the bug-detection results in the wild (Section 6.1), the coverage and advancement measurements (Section 6.2), and the ablation study on component rationality (Section 6.3).

## 1. System Requirements

- **OS:** Ubuntu 18.04/20.04/22.04
- **CPU:** XXX
- **Memory (RAM):** >=256 GB
- **Disk space:** >=155GB
- **GPU:** V100/RTX 20xx/H100 (for the ablation experiment)
- **CUDA:** 12.1
- **Python:** 3.10

## 2. Installation
### a. option 1
```bash
./setup.sh
```
### b. option 2
```bash
docker build -t m2k-env .
docker run m2k-env
```

## 3. Tool Demonstration 

This section walks through the example in Figure 2 to show the basic workflow of M2K.

### a. run cuKLEE alone

**Steps:**

```bash
cd example
./run_example_cuKLEE.sh
```

**Expected output:** XXX

### b. run model Qwen/Qwen2-0.5B-Instruct
**Steps:**

```bash
cd example
./run_example_model.sh
```

**Expected output:** XXX


## 4. Kernel Memory Bugs in Inference Systems (Section 2.3)
https://docs.google.com/spreadsheets/d/1S0CNDFlDF6ozVW3j8d6EB1u9S8y5tsS4NnDElRLK7NI/edit?gid=0#gid=0

## 5. Bug Detection in the Wild (Section 6.1)
raw data of Table 5:
https://docs.google.com/spreadsheets/d/1C2WeuZRo7ewz1nr3dsw7G8LmE-2AknD0vNDZIXwUWeI/edit?gid=0#gid=0

raw data of Figure 5:
https://docs.google.com/spreadsheets/d/1IRdEAv0c2zW3-gmKdjgTnS5jR-i-NBIRL9jC_7HIDqs/edit?gid=0#gid=0

**Estimated time:** XXX


**Steps:**


```bash
XXX
```


**Expected output:** XXX


## 6. Coverage and Advancement (Section 6.2)
raw data of Table 6:
https://docs.google.com/spreadsheets/d/1bEBw7nqtAynVWKP8SBGaxUnuvn8sWfEHX1ywD2VhMog/edit?gid=0#gid=0

(1) run cuKLEE
```bash
cd evaluation/section-6-2-coverage/cuKLEE
python3 run_cuKLEE.py
```

(2) run GKLEE
```bash
XXX
```

(3) run Honeycomb
```bash
XXX
```

(4) run ESBMC
```bash
XXX
```

## 7. Rationality of Components (Section 6.3)
raw data of Figure 7:
https://docs.google.com/spreadsheets/d/1U1pOweiJk0VcZwBj4QxeKP3aVPtgs8R0a0nLiU30i3E/edit?gid=0#gid=0

(1) without HFProbe
```bash
cd evaluation/section-6-3-rationality
python3 run.py --without=H
```

(2) without cuKLEE
```bash
cd evaluation/section-6-3-rationality
python3 run.py --without=C
```
