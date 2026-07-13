import json
import os
import shutil
import subprocess


CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(os.path.dirname(CURRENT_DIR))
PROFILE_DIR = "evaluation/section-6-1-bug-detection/small_dataset_results/vllm"
RESULTS_DIR = "evaluation/section-6-1-bug-detection/small_dataset_results"
DATASET_PATH = "evaluation/section-6-1-bug-detection/small_dataset.json"
INTERMEDIATE_VLLM_DIR = "evaluation/section-6-1-bug-detection/intermediate_results/vllm"


def collect_model_config_pairs(dataset):
    seen = set()
    pairs = []

    for entries in dataset.values():
        if isinstance(entries, dict):
            entries = entries.values()
        elif not isinstance(entries, list):
            continue

        for entry in entries:
            if not isinstance(entry, dict):
                continue

            model = entry.get("model")
            if model is None:
                continue

            config = entry.get("config")
            key = (model, config)
            if key in seen:
                continue

            seen.add(key)
            pairs.append((model, config))

    return pairs


def config_path_from_dataset_value(config):
    return os.path.join(INTERMEDIATE_VLLM_DIR, config)


def command_for_pair(model, config):
    command = [
        "python3",
        "-m",
        "HFProbe.backend.config_agent_vllm",
        "--no-print-result",
        f"--model-id={model}",
        f"--profile-out-dir={PROFILE_DIR}",
    ]

    if config is not None:
        command.append(f"--config-file={config_path_from_dataset_value(config)}")

    return command


def main():
    with open(os.path.join(PROJECT_DIR, DATASET_PATH)) as f:
        dataset = json.load(f)

    profile_dir_path = os.path.join(PROJECT_DIR, PROFILE_DIR)
    results_dir_path = os.path.join(PROJECT_DIR, RESULTS_DIR)
    os.makedirs(profile_dir_path, exist_ok=True)
    pairs = collect_model_config_pairs(dataset)

    for model, config in pairs:
        if "/" not in model:
            model = model.replace("_", "/", 1)
        command = command_for_pair(model, config)
        print("Running:", " ".join(command))
        subprocess.run(command, cwd=PROJECT_DIR, check=True)

    hf_config_dir = os.path.join(results_dir_path, "huggingface", "config")
    shutil.copytree(
        os.path.join(
            PROJECT_DIR,
            "evaluation/section-6-1-bug-detection/intermediate_results/huggingface/config",
        ),
        hf_config_dir,
        dirs_exist_ok=True,
    )
    for name in os.listdir(hf_config_dir):
        if not name.startswith("mgalkin_"):
            continue

        path = os.path.join(hf_config_dir, name)
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            os.remove(path)


if __name__ == "__main__":
    main()
