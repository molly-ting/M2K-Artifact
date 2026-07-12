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
bash setup.sh
```
### Option-2: Containerized installation 
```bash
docker build --platform=linux/amd64 -t m2k-env .
docker run --platform=linux/amd64 -it m2k-env
```


## 3. Tool Demonstration 

This section walks through the example in Figure 2 to show the basic workflow of M2K.

### a. Using HFProbe to profile Qwen2ForCausalLM

**Step 1: Static call graph computation**

Command:

```bash
cd HFProbe/call-graph
bash x scan --vllm-model-arch=Qwen2ForCausalLM --kernel-info-out=opout
```
(take ~2min)

`bash x scan` accepts the following options:

- `--kernel-info-out=<dir>` — directory that stores information about the possibly-triggered kernels (default: `HFProbe/call-graph/opout`).
- `--vllm-dir=<dir>` — directory of the vLLM repository (ensure not to contain "." in the absolute path); if unset, copy the installed vLLM to HFProbe/vllm (ensure the absolute path of HFProbe does not contain ".").
- `--vllm-model-arch=<arch>` — model architecture of the target model; if unset, all vLLM model architectures are analyzed.

Output:
console output:
```text
Completed analysis for vllm model architecture Qwen2ForCausalLM!
Kernel information is stored in opout.
```
opout/Qwen2ForCausalLM.json
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
cd ../..
# apply on https://huggingface.co/settings/tokens
export HF_TOKEN=<Hugging Face Token>
# run from the repository root
python3 -m HFProbe.backend.config_agent_vllm --model-id=Qwen/Qwen2-0.5B-Instruct --profile-out-dir=HFProbe/results/vllm
# run with model config example/config/dynamic_scaled_fp8_quant.json
# python3 -m HFProbe.backend.config_agent_vllm --model-id=Qwen/Qwen2-0.5B-Instruct --profile-out-dir=HFProbe/results/vllm --config-file=example/config/dynamic_scaled_fp8_quant.json
# run all configs in <profile-out-dir>/config/<model_architecture>
# python3 -m HFProbe.backend.config_agent_vllm --model-id=Qwen/Qwen2-0.5B-Instruct --model-architecture=Qwen2ForCausalLM --profile-out-dir=HFProbe/results/vllm --mutate --use-existent-config
```

`HFProbe.backend.config_agent_vllm` accepts the following options:

- `--model-id=<modelID>` — the target model ID.
- `--model-architecture=<arch>` — the target model architecture from model config.
- `--seed-config-file=<file>` — the file path of model default config for mutation.
- `--profile-out-dir=<dir>` — the output directory (see the layout below).
- `--kernel-info-out=<dir>` — the output directory produced by the previous step.
- `--kernel-info-file=<file>` — the file containing kernel information produced by the previous step.
- `--mutate` — mutate the configs (without this, only run the model with default config).
- `--use-existent-config` — reuse existing ones.
- `--config-file=<file>` — the file path of model config to run, the file name should be the target kernel name.
- `--kernel-name` — the kernel name to mutate config for.


**Output:**
console output:
```text
INFO 07-11 10:53:59 [__init__.py:247] No platform detected, vLLM is running on UnspecifiedPlatform
patch current platform as cuda platform
Running model  Qwen/Qwen2-0.5B-Instruct ...
INFO 07-11 10:54:09 [__init__.py:31] Available plugins for group vllm.general_plugins:
...
INFO 07-11 10:54:42 [llm_engine.py:428] init engine (profile, create kv cache, warmup model) took 3.90 seconds
batch_size=1, seq_len=1 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00, 1198.72it/s]
Processed prompts: 100%|██████████████████████████████████████| 1/1 [00:00<00:00,  1.12it/s, est. speed input: 1.12 toks/s, output: 17.98 toks/s]
batch_size=1, seq_len=7 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00, 2149.82it/s]
Processed prompts: 100%|██████████████████████████████████████| 1/1 [00:00<00:00,  1.12it/s, est. speed input: 7.84 toks/s, output: 17.92 toks/s]
batch_size=1, seq_len=17 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00, 1475.83it/s]
Processed prompts: 100%|█████████████████████████████████████| 1/1 [00:00<00:00,  1.14it/s, est. speed input: 19.31 toks/s, output: 18.17 toks/s]
batch_size=3, seq_len=1 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 3/3 [00:00<00:00, 3491.37it/s]
Processed prompts: 100%|██████████████████████████████████████| 3/3 [00:00<00:00,  3.05it/s, est. speed input: 3.05 toks/s, output: 48.77 toks/s]
batch_size=3, seq_len=7 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 3/3 [00:00<00:00, 2478.90it/s]
Processed prompts: 100%|█████████████████████████████████████| 3/3 [00:01<00:00,  2.86it/s, est. speed input: 20.03 toks/s, output: 45.77 toks/s]
batch_size=3, seq_len=17 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 3/3 [00:00<00:00, 1852.61it/s]
Processed prompts: 100%|█████████████████████████████████████| 3/3 [00:01<00:00,  2.92it/s, est. speed input: 49.72 toks/s, output: 46.79 toks/s]
batch_size=5, seq_len=1 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 5/5 [00:00<00:00, 3082.69it/s]
Processed prompts: 100%|██████████████████████████████████████| 5/5 [00:01<00:00,  4.85it/s, est. speed input: 4.85 toks/s, output: 77.67 toks/s]
batch_size=5, seq_len=7 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 5/5 [00:00<00:00, 2637.93it/s]
Processed prompts: 100%|█████████████████████████████████████| 5/5 [00:01<00:00,  4.73it/s, est. speed input: 33.09 toks/s, output: 75.64 toks/s]
batch_size=5, seq_len=17 ...
Adding requests: 100%|███████████████████████████████████████████████████████████████████████████████████████████| 5/5 [00:00<00:00, 2071.26it/s]
Processed prompts: 100%|█████████████████████████████████████| 5/5 [00:01<00:00,  4.63it/s, est. speed input: 78.67 toks/s, output: 74.04 toks/s]
[Qwen/Qwen2-0.5B-Instruct] Cache removed: .cache/huggingface/hub/models--Qwen--Qwen2-0.5B-Instruct/snapshots/c540970f9e29518b1d8f06ab8b24cba66ad77b6d
```

output directory
```text
config/
├── <model_architecture>/
│   └── <kernel_name>.json  # Mutated config for the kernel
out/
├── <model_id>/
│   └── <kernel_name>.json  # Collected arguments using the mutated config
└── <model_id>.json         # Collected arguments using the default config
input/          # Generated input files for cuKLEE (in step 4)
└── <kernel_name>.json 
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
python3 -m HFProbe.backend.config_agent_vllm --model-architecture=Qwen2ForCausalLM --profile-out-dir=HFProbe/results/vllm --kernel-name=dynamic_scaled_fp8_quant --seed-config-file=example/Qwen2ForCausalLM_model_config.json --kernel-info-file=example/Qwen2ForCausalLM_kernel_info.json
# to mutate configs for all kernels and run profiling backend in one batch
# python3 -m HFProbe.backend.config_agent_vllm --model-id=Qwen/Qwen2-0.5B-Instruct --model-architecture=Qwen2ForCausalLM --profile-out-dir=HFProbe/results/vllm --kernel-info-file=example/Qwen2ForCausalLM_kernel_info.json --mutate --seed-config-file=example/Qwen2ForCausalLM_model_config.json
```

(take ~2min)

**Output:**
console output:
```text
prompt: For models using Qwen2ForCausalLM, analyze the python code in vllm. Generate model config to trigger ...
****************************************
GPT response:
{
    "architectures": [
        "Qwen2ForCausalLM"
    ],
    ...
}
Mutated config for kernel dynamic_scaled_fp8_quant is saved at HFProbe/results/vllm/config/Qwen2ForCausalLM/dynamic_scaled_fp8_quant.json.
```
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
python3 cuKLEE/compile_cuda.py --cuda-source-dir=evaluation/section-6-1-bug-detection/benchmarks/vllm/cuda_files --compiled-kernel-dir=cuKLEE/compiled/vllm
# some compiled files are large. you can skip the compilation and use existing compiled files (--compiled-kernel-dir=evaluation/section-6-1-bug-detection/benchmarks/vllm/compiled_files).
python3 HFProbe/input_generate.py --vllm --add-memory-max-num-tokens --profile-out-dir=HFProbe/results/vllm --compiled-kernel-dir=cuKLEE/compiled/vllm --cuda-source-dir=evaluation/section-6-1-bug-detection/benchmarks/vllm/cuda_files 
```

`compile_cuda.py` accepts the following options:
- `--cuda-source-dir=<dir>` — directory containing the CUDA files (the included header files should be put in this folder or cuKLEE/include).
- `--compiled-kernel-dir=<dir>` — the output directory, if not set, use the input-dir.

`input_generate.py` accepts the following options:

- `--profile-out-dir=<dir>` — the `--out-dir` from the previous step.
- `--compiled-kernel-dir=<dir>` — directory containing the compiled CUDA files.
- `--cuda-source-dir=<dir>` — directory containing the CUDA and C++ files (or the repository directory).
- `--vllm` — mark for vllm profiling.
- `--add-memory-max-num-tokens` - add num_tokens limit of 288GB GPU memory.

**Output:**
console output:
```
Compiling CUDA files...
Compiling common.cu...
Running command: clang++ -g -x cuda --cuda-gpu-arch=sm_80 ... common.cu

Running command: llvm-link-13 -o common_combined.bc common.bc common-cuda-nvptx64-nvidia-cuda-sm_80.bc

Running command: llvm-dis-13 common_combined.bc
...

Done!
The input files are stored in the directory: results/vllm/input
```
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
mkdir example/out
cuKLEE --timeout=3600 --cuklee-out-dir=example/out example/dynamic_scaled_fp8_quant.json
# to run multiple files in a batch
# python3 cuKLEE/run.py --input-dir=HFProbe/results/vllm/input --cuklee-out-dir=cuKLEE/results/out --log-dir=cuKLEE/results/log
```

`cuKLEE/run.py` accepts the following options:
- `--input-dir=<dir>` — directory containing the input json files.
- `--cuklee-out-dir=<dir>` — directory containing z3 constraints for each bug.
- `--log-dir=<dir>` — directory containing console output for each input file.

**Expected output:** XXX
console output:
```
running opt-13 -load-pass-plugin libSignednessPropagationPass.so -passes=signedness-prop example/fp8_common_combined.bc > example/fp8_common_combined_modified.bc
Pass applied. Modified file: example/fp8_common_combined_modified.bc
running klee --disable-verify --warnings-only-to-file --single-object-resolution=true --external-calls=over-approx --entry-point=_Z24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_ --cuda-type=caller --func-config=example/dynamic_scaled_fp8_quant.json --jindex=0 --output-dir=example/out example/fp8_common_combined_modified.bc
cuKLEE: output directory is "example/out/_Z24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_/klee-out-jindex-0-0"
cuKLEE: Using Z3 solver backend
...
cuKLEE: Bug Detected: vllm-0.9.0/csrc/quantization/fp8/common.cu:19: integer overflow
cuKLEE: Bug Detected: vllm-0.9.0/csrc/quantization/fp8/common.cuh:128: integer overflow

cuKLEE: done: total instructions = 13680
cuKLEE: done: completed paths = 5
cuKLEE: done: partially completed paths = 22
cuKLEE: done: generated tests = 0
```
example/out/_Z24dynamic_scaled_fp8_quantRN2at6TensorERKS0_S1_/klee-out-jinex-0-0:
19_18_119-asm-15118_4337_11163_io.txt:
```text
19 - source code line of the bug
18 - caller line
119 - caller line
15118 - assembly code line of the bug
4337 - caller line
11163 - caller line
io - integer overflow
```
```text
(set-info :status unknown)
(declare-fun |_arg_0.size[0]| () Int)
(declare-fun |_arg_1.size[0]| () Int)
(declare-fun batch_size () Int)
(declare-fun seq_len () Int)
(declare-fun blockIdx.x0 () Int)
(declare-fun blockIdx.y0 () Int)
...
(assert
 (<= seq_len 32768))
(assert
 (let ((?x37 (* batch_size seq_len)))
 (<= ?x37 2864606)))
(assert
 (let ((?x37 (* batch_size seq_len)))
 (= |_arg_0.size[0]| ?x37)))
...
(check-sat)
(get-model)
(reset)
```

**Step 5: validate reported bugs** 
```bash
# if you haven't run previous HFProbe steps, copy example/dynamic_scaled_fp8_quant.json to HFProbe/results/vllm/input 
python3 HFProbe/validation/run_vllm_validation.py --profile-out-dir=HFProbe/results/vllm --cuklee-out-dir=example/out --kernel-name=dynamic_scaled_fp8_quant --index=0 --model-id=Qwen/Qwen2-0.5B-Instruct --config-file=example/config/dynamic_scaled_fp8_quant.json
```
(take ~26min)

`run_vllm_validation.py` accepts the following options:
- `--profile-out-dir=<dir>` — out-dir of step 2.
- `--cuklee-out-dir=<dir>` — out-dir of the previous step.
- `--kernel-name=<name>` — the target kernel name.
- `--index=<int>` — the index in the input json file in the previous step (default value is 0).
- `--model-id=<modelID>` — the target model ID.
- `--config-file=<filepath>` — the model config file generated in step 3.

possible issue:
```text
AttributeError: module 'z3' has no attribute 'parse_smt2_string'
```
solution:
```bash
python3 -m pip uninstall z3
python3 -m pip install --force-reinstall z3-solver
```

**Expected output:** 
console output
```text
INFO 07-11 13:12:01 [__init__.py:247] No platform detected, vLLM is running on UnspecifiedPlatform
patch current platform as cuda platform
Running model Qwen/Qwen2-0.5B-Instruct with example/config/dynamic_scaled_fp8_quant.json, batch_size: 65 seq_len: 32264.
INFO 07-11 13:12:13 [__init__.py:31] Available plugins for group vllm.general_plugins:
...
INFO 07-11 13:18:45 [llm_engine.py:428] init engine (profile, create kv cache, warmup model) took 362.18 seconds
real_seq_len=32264 ...
Adding requests: 100%|█████████████████████████████████████| 65/65 [00:11<00:00,  5.56it/s]
Processed prompts: 100%|█| 65/65 [05:51<00:00,  5.41s/it, est. speed input: 5960.85 toks/s]
Running model Qwen/Qwen2-0.5B-Instruct with batch_size: 65 seq_len: 32264 config_file: example/config/dynamic_scaled_fp8_quant.json can trigger bug 19_18_119-asm-15118_4337_11163_io.txt for dynamic_scaled_fp8_quant.
Running model Qwen/Qwen2-0.5B-Instruct with example/config/dynamic_scaled_fp8_quant.json, batch_size: 64 seq_len: 32768.
INFO 07-11 13:25:01 [config.py:520] Overriding HF config with 
...
INFO 07-11 13:31:10 [llm_engine.py:428] init engine (profile, create kv cache, warmup model) took 364.53 seconds
real_seq_len=32768 ...
Adding requests: 100%|█████████████████████████████████████| 64/64 [00:11<00:00,  5.43it/s]
Processed prompts: 100%|█| 64/64 [06:07<00:00,  5.74s/it, est. speed input: 5704.52 toks/s, output: 0.17]
Running model Qwen/Qwen2-0.5B-Instruct with batch_size: 64 seq_len: 32768 config_file: example/config/dynamic_scaled_fp8_quant.json can trigger bug 128_24_18-asm-15242_15133_4337_io.txt for dynamic_scaled_fp8_quant.
```
validation/Qwen_Qwen2-0.5B-Instruct_dynamic_scaled_fp8_quant_0_validate_results.json
```json
{
  "19_18_119-asm-15118_4337_11163_io.txt": {
    "status": "success",
    "batch_size": 65,
    "seq_len": 32264,
    "config": "example/config/dynamic_scaled_fp8_quant.json"
  },
  "128_24_18-asm-15242_15133_4337_io.txt": {
    "status": "success",
    "batch_size": 64,
    "seq_len": 32768,
    "config": "example/config/dynamic_scaled_fp8_quant.json"
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

**Estimated time:** over one month


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
cd evaluation/section-6-2-coverage/gklee
./run.sh
```

#### GKLEE results

Results are stored in `evaluation/section-6-2-coverage/gklee/results/<input>/`:

- `compile.log` contains the `gklee-nvcc` output. Inspect this file if an input
  fails to compile.
- `gklee.log` contains the verification output. `KLEE: ERROR` reports a
  detected issue and includes its generated-source location and error type,
  such as `memory error: out of bound pointer`. `KLEE: done` reports the final
  instruction, path, and generated-test counts.
- The runner prints status `124` for a timeout and status `127` when a required
  command is unavailable. A timed-out log is incomplete and must not be
  interpreted as verification success.

```bash
grep -R -E "KLEE: ERROR|KLEE: done" \
  evaluation/section-6-2-coverage/gklee/results
```

(3) run Honeycomb
```bash
cd evaluation/section-6-2-coverage/honeycomb
./run.sh
```

#### Honeycomb results

Each result is stored in
`evaluation/section-6-2-coverage/honeycomb/results/<input>.log`. The last line
has the form `Generates N remarks`. `0 remarks` means Honeycomb did not report
a policy violation; a nonzero value means that the listed remarks require
inspection. Status `124` printed by the runner means the input timed out.

```bash
grep -R -E "Generates [0-9]+ remarks" \
  evaluation/section-6-2-coverage/honeycomb/results
```

(4) run ESBMC
```bash
cd evaluation/section-6-2-coverage/esbmc
./run.sh
```

#### ESBMC results

Each result is stored in
`evaluation/section-6-2-coverage/esbmc/results/<input>.log`.
`VERIFICATION FAILED` means ESBMC found a counterexample; the preceding
`Violated property` and state trace identify the property, source location,
and failing execution. `VERIFICATION SUCCESSFUL` means no violation was found
within the explored bounds. Status `124` printed by the runner means timeout;
the corresponding partial log must not be interpreted as verification success.

```bash
grep -R -E "Violated property|VERIFICATION (FAILED|SUCCESSFUL)" \
  evaluation/section-6-2-coverage/esbmc/results
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

(3) without configuration mutation
```bash
cd evaluation/section-6-3-rationality
python3 run.py --without=M
```

(4) without validation
```bash
cd evaluation/section-6-3-rationality
python3 run.py --without=V
```
