# M2K: Source Code, Scripts, and Data for SOSP 2026 Artifact Evaluation

**Version:** 1.0  
**Last updated:** July 13, 2026  
**Paper:** M2K: Making the Model-Kernel Interface Explicit for Reliable CUDA Kernel Verification

This document provides instructions for reproducing the experimental results reported in the M2K paper. We first describe the hardware and software requirements for running the artifact and explain how to install it. We then walk through the example in Figure 2 to demonstrate how the tool works. Finally, we explain how to reproduce the empirical study of kernel memory bugs (Section 2.3), the bug-detection results in the wild (Section 6.1), the coverage and advancement measurements (Section 6.2), and the ablation study on component rationality (Section 6.3).

## 1. System Requirements

- **OS:** Ubuntu 22.04
- **Memory (RAM):** >=256 GB
- **Disk space:** >=155GB
- **GPU:** H200 (for the ablation experiment)
- **CUDA:** 12.1
- **Python:** 3.10

## 2. Installation

### Option-1: Native installation
```bash
./setup.sh
```
### Option-2: Containerized installation 
```bash
docker build -t m2k-env .
docker run -it m2k-env
```


## 3. Tool Demonstration 

This section walks through the example in Figure 2 to show the basic workflow of M2K.

### a. Using HFProbe to profile Qwen2ForCausalLM

**Step 1: Static call graph computation**

Command:

```bash
cd HFProbe/call-graph
bash x --scan --vllm-model-arch=Qwen2ForCausalLM --out=opout
```

`bash x --scan` accepts the following options:

- `--out=<dir>` — directory that stores information about the possibly-triggered kernels (default: `HFProbe/call-graph/opout`).
- `--vllm-dir=<dir>` — directory of the vLLM repository; if unset, the installed vLLM path is used.
- `--vllm-model-arch=<arch>` — model architecture of the target model; if unset, all vLLM model architectures are analyzed.

Output:
``` json
{
    "dynamic_scaled_int8_quant": {
        "filePath": "vllm/_custom_ops.py",
        "lines": [
            1258,
            1293
        ]
    },
}
```


#### Step 2: Running the profiling backend

**Command:**

```bash
# apply on https://huggingface.co/settings/tokens
export HF_TOKEN=<Hugging Face Token>
# enter HFProbe directory
cd ..
python3 backend/config_agent_vllm.py --model-id=Qwen/Qwen2-0.5B-Instruct --out-dir=results/vllm
# run with specific model config
# python3 backend/config_agent_vllm.py --model-id=Qwen/Qwen2-0.5B-Instruct --out-dir=results/vllm --config-file=../example/dynamic_scaled_fp8_quant_config.json
```

`config_agent_vllm.py` accepts the following options:

- `--model-id=<modelID>` — the target model ID.
- `--model-architecture=<arch>` — the target model architecture from model config.
- `--seed-configs-dir=<dir>` — the directory containing model config examples.
- `--seed-config-file=<file>` — the file path of model default config for mutation.
- `--out-dir=<dir>` — the output directory (see the layout below).
- `--kernel-info-dir=<dir>` — the output directory produced by the previous step.
- `--kernel-info-file=<file>` — the file containing kernel information produced by the previous step.
- `--mutate` — mutate the configs.
- `--no-mutate` — do not mutate the configs.
- `--use-existent-config` — reuse existing ones.
- `--config-file=<file>` — the file path of model config to run.
- `--kernel-name` — the kernel name to mutate config for.

**Output:**

output directory
```text
config/
├── model_architecture/
│   └── kernel_name.json  # Mutated config for the kernel
out/
├── model_id/
│   └── kernel_name.json  # Collected arguments using the mutated config
└── model_id.json         # Collected arguments using the default config
input/          # Generated input files for cuKLEE (in step 4)
└── kernel_name.json 
```
results/vllm/out/Qwen_Qwen2-0.5B-Instruct.json
```json
{
    "vllm.rms_norm": [
        [
            {
                "shape": [
                    "1.0*s*b",
                    896
                ],
                "dtype": "torch.float16",
                "type": "torch.Tensor"
            },
            {
                "shape": [
                    "1.0*s*b",
                    896
                ],
                "dtype": "torch.float16",
                "type": "torch.Tensor"
            },
            {
                "shape": [
                    896
                ],
                "dtype": "torch.float16",
                "type": "torch.Tensor"
            },
            {
                "value": 1e-06,
                "type": "float"
            }
        ]
    ],
}
```

#### Step 3: Mutating Model Configuration

**Command:**

```bash
export OPENAI_API_KEY=<Openai API Key>
python3 backend/config_agent_vllm.py --model-architecture=Qwen2ForCausalLM --out-dir=results/vllm --kernel-name=dynamic_scaled_fp8_quant --seed-config-file=../example/Qwen2ForCausalLM_model_config.json --kernel-info-file=../example/Qwen2ForCausalLM_kernel_info.json
# to mutate configs for all kernels and run profiling backend in one batch
# python3 backend/config_agent_vllm.py --model-id=Qwen/Qwen2-0.5B-Instruct --model-architecture=Qwen2ForCausalLM --out-dir=results/vllm --kernel-info-dir=call-graph/opout --mutate 
```

**Output:**
results/vllm/config/Qwen2ForCausalLM/dynamic_scaled_fp8_quant.json
```json
{
    "architectures": [
        "Qwen2ForCausalLM"
    ],
    "attention_dropout": 0.0,
    "bos_token_id": 151643,
    "eos_token_id": 151645,
    "hidden_act": "silu",
    "hidden_size": 896,
    "initializer_range": 0.02,
    "intermediate_size": 4864,
    "max_position_embeddings": 32768,
    "max_window_layers": 24,
    "model_type": "qwen2",
    "num_attention_heads": 14,
    "num_hidden_layers": 24,
    "num_key_value_heads": 2,
    "rms_norm_eps": 1e-06,
    "rope_theta": 1000000.0,
    "sliding_window": 32768,
    "tie_word_embeddings": true,
    "torch_dtype": "bfloat16",
    "transformers_version": "4.40.1",
    "use_cache": true,
    "use_sliding_window": false,
    "vocab_size": 151936,
    "quantization_config": {
        "quant_method": "fp8",
        "activation_scheme": "dynamic"
    }
}
```

#### Step 4: Generating Interface Constraints


**Command:**

```bash
# compile cuda files to LLVM bitcode
# running profiling backend will trigger multiple kernels. we have to compile all cuda files in vLLM.
python3 ../cuKLEE/compile_cuda.py --input-dir=../evaluation/section-6-1-bug-detection/benchmarks/vllm/cuda_files --out-dir=../cuKLEE/compiled/vllm
# some compiled files are large. you can skip the compilation and use existing compiled files (--compiled-kernels-dir=../evaluation/section-6-1-bug-detection/benchmarks/vllm/compiled_files).
python3 input_generate.py --vllm --add-memory-max-num-tokens --profile-out-dir=results/vllm --compiled-kernels-dir=../cuKLEE/compiled/vllm --cuda_source_dir=../evaluation/section-6-1-bug-detection/benchmarks/vllm/cuda_files 
```

`compile_cuda.py` accepts the following options:
- `--input-dir=<dir>` — directory containing the CUDA files (the included header files should be put in this folder or cuKLEE/include).
- `--out-dir=<dir>` — the output directory, if not set, use the input-dir.

`input_generate.py` accepts the following options:

- `--profile-out-dir=<dir>` — the `--out-dir` from the previous step.
- `--compiled-kernels-dir=<dir>` — directory containing the compiled CUDA files.
- `--cuda-source-dir=<dir>` — directory containing the CUDA and C++ files (or the repository directory).
- `--vllm` — mark for vllm profiling.
- `--add-memory-max-num-tokens` - add num_tokens limit of 288GB GPU memory.

**Output:**
results/vllm/input/dynamic_scaled_fp8_quant.json
```json
[
    {
        "py_function": "dynamic_scaled_fp8_quant",
        "cuda_function": "dynamic_scaled_fp8_quant",
        "input_file_path": "example/fp8_common_combined.bc",
        "args": [
            {
                "shape": [
                    "1*b*s",
                    896
                ],
                "dtype": "torch.float8_e4m3fn",
                "type": "torch.Tensor"
            },
            {
                "shape": [
                    "1.0*s*b",
                    896
                ],
                "dtype": "torch.float16",
                "type": "torch.Tensor"
            },
            {
                "shape": [
                    1
                ],
                "dtype": "torch.float32",
                "type": "torch.Tensor"
            }
        ],
        "seq_len": 32768,
        "num_tokens": 2864606
    }
]
```

### b. Using cuKLEE to perform symbolic execution on the dynamic_scaled_fp8_quant kernel 


**Step 4: run cuKLEE** 
```bash
cd ..
cuKLEE --timeout=3600 --out-dir=example/out example/dynamic_scaled_fp8_quant.json
# to run multiple files in a batch
# python3 cuKLEE/run.py --input-dir=HFProbe/results/vllm/input --out-dir=cuKLEE/results/out --log-dir=cuKLEE/results/log
```

`cuKLEE/run.py` accepts the following options:
- `--input-dir=<dir>` — directory containing the input json files.
- `--out-dir=<dir>` — directory containing z3 constraints for each bug.
- `--log-dir=<dir>` — directory containing console output for each input file.

**Expected output:** XXX
console output:
```

```
example/out:
```text
```
xxx-io.txt:
```text
```

**Step 5: validate reported bugs** 
```bash
# if you haven't run previous HFProbe steps, copy example/dynamic_scaled_fp8_quant.json to HFProbee/results/vllm/input 
python3 HFProbe/validation/run_vllm_validation.py --profile-out-dir=HFProbe/results/vllm --cuklee-out-dir=example/out --kernel-name=dynamic_scaled_fp8_quant --index=0 --model-id=Qwen/Qwen2-0.5B-Instruct --config-file=example/dynamic_scaled_fp8_quant_config.json
```

`run_vllm_validation.py` accepts the following options:
- `--profile-out-dir=<dir>` — out-dir of step 2.
- `--cuklee-out-dir=<dir>` — out-dir of the previous step.
- `--kernel-name=<name>` — the target kernel name.
- `--index=<int>` — the index in the input json file in the previous step (default value is 0).
- `--model-id=<modelID>` — the target model ID.
- `--config-file=<filepath>` — the model config file generated in step 3.

**Expected output:** 
console output
```text
```
validation/Qwen_Qwen2-0.5B-Instruct_dynamic_scaled_fp8_quant_config_0__validate_results.json
```json
{
    "": {
        "status": "success", 
        "batch_size": , 
        "seq_len": , 
        "config": "example/dynamic_scaled_fp8_quant_config.json"
    }
}
```

## 4. Kernel Memory Bugs in Inference Systems (Section 2.3)
https://docs.google.com/spreadsheets/d/1Q_6QZbl2I0xCotst-8ei2ZysvldA6D2HHegWKmv9y1o/edit?gid=0#gid=0

## 5. Bug Detection in the Wild (Section 6.1)
raw data of Table 5:
https://docs.google.com/spreadsheets/d/1C2WeuZRo7ewz1nr3dsw7G8LmE-2AknD0vNDZIXwUWeI/edit?gid=0#gid=0

raw data of Figure 5:
https://docs.google.com/spreadsheets/d/1Q_6QZbl2I0xCotst-8ei2ZysvldA6D2HHegWKmv9y1o/edit?gid=292022127#gid=292022127

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
