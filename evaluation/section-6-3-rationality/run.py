
import argparse
import enum

from vllm import LLM, SamplingParams
import os, json
import traceback
import torch

import os
import subprocess
import logging
from concurrent.futures import ProcessPoolExecutor, as_completed

project_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def run_klee_on_bc_file(bc_file, logDir, outputdir):
    one_timeout = 3600
    try:
        os.makedirs(logDir, exist_ok=True)

        log_file = os.path.join(logDir, os.path.splitext(os.path.basename(bc_file))[0] + '_klee_output.log')
        if os.path.exists(log_file):
            return True         

        outputdir = os.path.join(outputdir, os.path.splitext(os.path.basename(bc_file))[0])
        os.makedirs(outputdir, exist_ok=True)
        
        # Run KLEE and capture its output and error in the log file
        with open(log_file, 'w') as output_file:
            subprocess.run(['cuKLEE', f"--timeout={one_timeout}", f"--out-dir={outputdir}", bc_file], stdout=output_file, stderr=output_file, check=True) 
        
        print(f"Output saved to {log_file}")
    
    except Exception as e:
        pass
    except subprocess.TimeoutExpired:
        pass
    except subprocess.CalledProcessError as e:
        pass
    return True

def run_wo_H():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    eval_dir = os.path.dirname(current_dir)
    input_dirpath = os.path.join(eval_dir, "evaluation/section-6-1-bug-detection/benchmark_compiled_files/vllm_0_9_0")
    output_directory = os.path.join(current_dir, "vllm_0_9_0_output")
    log_directory = os.path.join(current_dir, "vllm_0_9_0_log")
    os.makedirs(output_directory, exist_ok=True)
    os.makedirs(log_directory, exist_ok=True)
    input_files = [os.path.join(input_dirpath, filename) for filename in os.listdir(input_dirpath) if filename.endswith('_combined.bc')]
    
    with ProcessPoolExecutor(5) as executor:
        future_to_file = {executor.submit(run_klee_on_bc_file, bc_file, log_directory, output_directory): bc_file for bc_file in input_files}
        
        for future in as_completed(future_to_file):
            bc_file = future_to_file[future]
            try:
                success = future.result()
            except Exception as e:
                logging.error(f"Exception occurred while processing {bc_file}: {str(e)}")


batch_size_configs = [1, 3, 5]
seq_lens_configs = [1, 7, 17]
HF_TOKEN = os.getenv("HF_TOKEN")
bug_res = []

possible_len_keys = [
    # OPT
    "max_position_embeddings",
    # GPT-2
    "n_positions",
    # MPT
    "max_seq_len",
    # ChatGLM2
    "seq_length",
    # Command-R
    "model_max_length",
    # Whisper
    "max_target_positions",
    # Others
    "max_sequence_length",
    "max_seq_length",
    "seq_len",
]

def runVllm(modelId, framework_config, model_config, op_name):
    global batch_size_configs
    global seq_lens_configs
    global bug_res
    env_old = os.environ.copy()

    configs = {}
    if framework_config:
        if "envs" in framework_config:
            for k in framework_config["envs"]:
                os.environ[k] = framework_config["envs"][k]
        
        if "vllmconfig" in framework_config:
            config = framework_config["vllmconfig"]
        if "batch_size" in framework_config:
            batch_size_configs = framework_config["batch_size"]
        if "seq_len" in framework_config:
            seq_lens_configs = framework_config["seq_len"]  
            
    if model_config:
        if "architectures" in model_config:
            model_config.pop("architectures")
        if "rope_scaling" in model_config:
            if "rope_type" not in model_config["rope_scaling"] and "type" in model_config["rope_scaling"]:
                model_config["rope_scaling"]["rope_type"] = model_config["rope_scaling"]["type"]

        for key in possible_len_keys:
            if key in model_config:
                model_config.pop(key)

        config["hf_overrides"] = model_config
        if "quantization_config" in model_config:
            if "quant_method" in model_config["quantization_config"] and "quantization" not in config:
                quant_method = model_config["quantization_config"]["quant_method"]
                config["quantization"] = quant_method
                if op_name == "moe_wna16_gemm":
                    config["quantization"] = "moe_wna16"
            else:
                batch_size_configs = [1, 3, 5]
                seq_lens_configs = [1, 7, 17]
                print(f"{op_name} config invalid.")
                os.environ.clear()
                os.environ.update(env_old)
                return False, None
    
    config["dtype"] = "float16"

    print("Running model ", modelId, "...")
    if "max_num_seqs" not in configs:
        configs["max_num_seqs"] = 5
    if "num_gpu_blocks_override" not in configs:
        configs["num_gpu_blocks_override"] = 300
    if os.environ.get("VLLM_USE_V1", "0") != "1":
        configs["preemption_mode"] = "swap"
    if "compilation_config" not in configs:
        configs["enforce_eager"] = True
    if "enable_chunked_prefill" not in configs:
        configs["enable_chunked_prefill"] = False
    
    try:
        llm = LLM(model=modelId, device="cuda", gpu_memory_utilization=1.0, trust_remote_code=True, hf_token=HF_TOKEN, **configs)
        sampling_params = SamplingParams(
            temperature=0
        )
        tokenizer = llm.get_tokenizer()

        for batch_size in batch_size_configs:
            for seq_len in seq_lens_configs:
                single_prompt = "word " * seq_len
                single_prompt = single_prompt.strip() 
                tokens = tokenizer(single_prompt)["input_ids"]
                seq_len_real = len(tokens)
                print(f"batch_size={batch_size}, seq_len={seq_len_real} ...")

                out = llm.generate([single_prompt]*batch_size, sampling_params)
        
        # Force GPU synchronization to catch any latent kernel errors
        if torch.cuda.is_available():
            torch.cuda.synchronize()
        
    except RuntimeError as e:
        err_str = str(e).lower()
        if "illegal memory access" in err_str:
            bug_res.append((modelId, op_name, batch_size, seq_len))
            print("Caught CUDA illegal memory access!")
        pass
    except:
        pass
    
    if framework_config:
        os.environ = env_old
        batch_size_configs = [1, 3, 5]
        seq_lens_configs = [1, 7, 17]


def run_wo_c():
    global bug_res
    current_dir = os.path.dirname(os.path.abspath(__file__))
    eval_dir = os.path.dirname(current_dir)
    config_path = f"{eval_dir}/evaluation/section-6-1-bug-detection/HFProbe_results/vllm/config"

    with open(f"{current_dir}/vllm_models.json") as mf:
        structure_model_map = json.load(mf)
        
    with open(f"{current_dir}/framework_config.json", "r") as ff:
        framework_configs = json.load(ff)

    processed_models = set()
    if os.path.exists(f"{current_dir}/processed_models.json"):
        with open(f"{current_dir}/processed_models.json") as mf:
            processed_models = set(json.load(mf))

    for model_id in structure_model_map:     
        structure = structure_model_map[model_id]

        if not os.path.exists(os.path.join(config_path, structure)):
            continue

        if model_id in processed_models:
            continue

        triggered_ops = set()
        trigger_res_file = os.path.join(config_path, structure, "result.json") 
        if os.path.exists(trigger_res_file):
            with open(trigger_res_file, "r") as rf:
                trigger_data = json.load(rf)
                if "initial" in trigger_data:
                    triggered_ops.update(set(trigger_data["initial"]))
                if "new" in trigger_data:
                    triggered_ops.update(set(trigger_data["new"]))
        else:
            triggered_ops = set(framework_configs.keys())
        
        for op_name in triggered_ops:
            if not op_name in framework_configs:
                continue
            runVllm(model_id, framework_configs[op_name], None, op_name)

        for op_config in os.listdir(os.path.join(config_path, structure)):
            if op_config.startswith("cost") or op_config.startswith("no_tri") or op_config.startswith("result"):
                continue
            config_file_path = os.path.join(config_path, structure, op_config)
            op_name = op_config.replace(".json", "")

            with open(config_file_path, "r") as cf:
                mconfigs = json.load(cf)
                fcon = None
                if op_name in framework_configs:
                    fcon = framework_configs[op_name]
                runVllm(model_id, fcon, mconfigs, op_name)

        processed_models.add(model_id)
        with open(f"{current_dir}/processed_models.json", "w") as pf:
            json.dump(list(processed_models), pf)
        
        with open(f"{current_dir}/bug_results.json", "w") as bf:
            json.dump(bug_res, bf)

def run_wo_m():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    profile_dir = os.path.join(current_dir, "wo_m", "profile")
    cuklee_out_dir = os.path.join(current_dir, "wo_m", "cuklee", "out")
    cuklee_log_dir = os.path.join(current_dir, "wo_m", "cuklee", "log")

    model_path = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "benchmarks",
        "vllm",
        "vllm_models.json",
    )
    compiled_kernels_dir = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "benchmarks",
        "vllm",
        "compiled_files",
    )
    cuda_source_dir = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "benchmarks",
        "vllm",
        "cuda_files",
    )

    os.makedirs(profile_dir, exist_ok=True)
    os.makedirs(cuklee_out_dir, exist_ok=True)
    os.makedirs(cuklee_log_dir, exist_ok=True)

    with open(model_path, "r") as mf:
        model_architectures = json.load(mf)

    def run_command(command):
        print("Running:", " ".join(command))
        subprocess.run(command, cwd=project_dir, check=True)

    for model_id, architecture in model_architectures.items():
        run_command([
            "python3",
            "-m",
            "HFProbe.backend.config_agent_vllm",
            f"--model-id={model_id}",
            f"--model-architecture={architecture}",
            f"--out-dir={profile_dir}",
        ])

    run_command([
        "python3",
        "HFProbe/input_generate.py",
        "--vllm",
        f"--profile-out-dir={profile_dir}",
        f"--compiled-kernel-dir={compiled_kernels_dir}",
        f"--cuda-source-dir={cuda_source_dir}",
    ])

    run_command([
        "python3",
        "cuKLEE/run.py",
        f"--input-dir={os.path.join(profile_dir, 'input')}",
        f"--out-dir={cuklee_out_dir}",
        f"--log-dir={cuklee_log_dir}",
    ])

    run_command([
        "python3",
        "-m",
        "HFProbe.validation.run_vllm_validation",
        "--dir",
        f"--klee-out-dir={cuklee_out_dir}",
        f"--profile-dir={profile_dir}",
    ])
    
def run_wo_v():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    profile_dir = os.path.join(current_dir, "wo_v", "profile")
    cuklee_out_dir = os.path.join(current_dir, "wo_v", "cuklee", "out")
    cuklee_log_dir = os.path.join(current_dir, "wo_v", "cuklee", "log")

    compiled_kernels_dir = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "benchmarks",
        "vllm",
        "compiled_files",
    )
    cuda_source_dir = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "benchmarks",
        "vllm",
        "cuda_files",
    )
    kernel_info_dir = os.path.join(
        project_dir,
        "evaluation",
        "section-6-1-bug-detection",
        "intermediate_results",
        "call-graph_results",
        "kernels_vllm_0.9.0"
    )

    os.makedirs(profile_dir, exist_ok=True)
    os.makedirs(cuklee_out_dir, exist_ok=True)
    os.makedirs(cuklee_log_dir, exist_ok=True)


    def run_command(command):
        print("Running:", " ".join(command))
        subprocess.run(command, cwd=project_dir, check=True)

    run_command([
        "python3",
        "-m",
        "HFProbe.backend.config_agent_vllm",
        f"----kernel-info-dir={kernel_info_dir}",
        f"--out-dir={profile_dir}",
    ])

    run_command([
        "python3",
        "HFProbe/input_generate.py",
        "--vllm",
        f"--profile-out-dir={profile_dir}",
        f"--compiled-kernel-dir={compiled_kernels_dir}",
        f"--cuda-source-dir={cuda_source_dir}",
    ])

    run_command([
        "python3",
        "cuKLEE/run.py",
        f"--input-dir={os.path.join(profile_dir, 'input')}",
        f"--out-dir={cuklee_out_dir}",
        f"--log-dir={cuklee_log_dir}",
    ])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="run cuKLEE"
    )

    parser.add_argument(
        "--without", type=enum, required=True, choices=["H", "C", "M", "V"], help="Run without H, C, M, or V"
    )

    args = parser.parse_args()
    if args.without == "H":
        run_wo_H()
    elif args.without == "C":
        run_wo_c()
    elif args.without == "M":
        run_wo_m()
    elif args.without == "V":
        run_wo_v()
