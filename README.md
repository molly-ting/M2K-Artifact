# M2K: Source Code, Scripts, and Data for SOSP 2026 Artifact Evaluation

**Version:** 1.0  
**Last updated:** July 13, 2026  
**Paper:** M2K: Making the Model-Kernel Interface Explicit for Reliable CUDA Kernel Verification

This document provides instructions for reproducing the experimental results reported in the M2K paper. We first describe the hardware and software requirements for running the artifact and explain how to install it. We then walk through the example in Figure 2 to demonstrate how the tool works. Finally, we explain how to reproduce the empirical study of kernel memory bugs (Section 2.3), the bug-detection results in the wild (Section 6.1), the coverage and advancement measurements (Section 6.2), and the ablation study on component rationality (Section 6.3).

## 1. System Requirements

- **OS:** Ubuntu 18.04/20.04/22.04
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
docker run -it m2k-env
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
**Step 1: compute call graph** 

```bash
cd HFProbe/call-graph
# usage: ./x --scan --out=<directory to store the possibly triggered kernel info, default=HFProbe/call-graph/opout> --vllm-dir=<directory of vLLM repository, retrieve the vLLM installed path if not set> --vllm-model-arch=<model architure of the target model, analyze all vLLM model architures if not set>
# HFProbe/call-graph/cgout stores the call graph. --out only stores the invoked kernel info.
./x --scan --vllm-model-arch=Qwen2ForCausalLM --out=opout
```

**Expected output:** XXX

**Step 2: run profiling backend and mutate configs** 
a. use exisiting configs
```bash
export HF_TOKEN=<Hugging Face Token>
cd ..
mkdir -p results/vllm/config
cp -r ../evaluation/section-6-1-bug-detection/HFProbe_results/vllm/config/Qwen2ForCausalLM results/vllm/config/
# out-dir contains folders: config (stores the mutated model configs files for each model), data (stores the recorded kernel arguments with concrete values during inference), load (stores the recorded kernel arguments with concrete values during model initialization), output (stores the inferred kernel arguments with symbolic expressions based on data folder), input (stores the input json files for cuKLEE generated from output), input-load (stores the input json files for cuKLEE generated from load folder)
# usage: python3 backend/config_agent_vllm.py --model-id=<modelID> --model-architecture=<model architecture> --out-dir=<output directory> --data-dir=<directory stores the seed model config> --call-graph-dir=<out dir of the previous step> --mutate=<bool, whether mutate configs> --use-llm=<bool, whether use gpt to mutate configs or use existing config>
python3 backend/config_agent_vllm.py --model-id=Qwen/Qwen2-0.5B-Instruct --model-architecture=Qwen2ForCausalLM --out-dir=results/vllm  --call-graph-dir=call-graph/opout --mutate=true --use-llm=false
```

b. use GPT to mutate configs
Due to the inherent randomness in GPT agent responses, different CUDA kernels may be executed in different runs, resulting in variations in bug detection.
```bash
export HF_TOKEN=<Hugging Face Token>
export OPENAI_API_KEY=<Openai API Key>
python3 backend/config_agent_vllm.py --model-id=Qwen/Qwen2-0.5B-Instruct --model-architecture=Qwen2ForCausalLM --out-dir=results/vllm --data-dir=../evaluation/section-6-1-bug-detection/benchmarks/vllm/configs-examples --call-graph-dir=call-graph/opout --mutate=true --use-llm=true
```

**Expected output:** XXX

**Step 3: generate input files for cuKLEE** 
```bash
# usage: python3 input_generate.py --vllm-result-dir=<out-dir of the previous step> --vllm-compile-path=<directory contains compiled cuda files> --vllm-repo-dir=<directory contains cuda files and cpp files or the repo directory>
# kernel_map folder stores the mapping between cuda functions and python functions
# the cuKLEE input files are stored in vllm-result-dir/input and vllm-result-dir/input-load
python3 input_generate.py --vllm-result-dir=results/vllm --vllm-compile-path=../evaluation/section-6-1-bug-detection/benchmark_compiled_files/vllm_0_9_0 --vllm-repo-dir=../evaluation/section-6-1-bug-detection/benchmarks/vllm/cuda_files
```

**Expected output:** XXX

**Step 4: run cuKLEE** 
```bash
cd ..
# usage: python3 cuKLEE/run.py --input-dir=<directory contains input json files> --output-dir=<directory to store the buggy z3 sontraints> --log-dir=<directory to store cuKLEE console outputs>
python3 cuKLEE/run.py --input-dir=HFProbe/results/vllm/input --output-dir=cuKLEE/results/out --log-dir=cuKLEE/results/log
python3 cuKLEE/run.py --input-dir=HFProbe/results/vllm/input-load --output-dir=cuKLEE/results/out --log-dir=cuKLEE/results/log
```

**Expected output:** XXX

**Step 5: validate reported bugs** 
```bash
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
