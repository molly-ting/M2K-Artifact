#!/usr/bin/env python3
import subprocess
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[2]

CLEAN_DIRS = [
    REPO_ROOT / "example",
    REPO_ROOT / "evaluation" / "section-6-2-coverage" / "benchmarks",
    REPO_ROOT / "evaluation" / "section-6-1-bug-detection" / "benchmarks",
]

EXAMPLE_COMPILE_COMMAND = [
    "python3",
    "cuKLEE/compile_cuda.py",
    "--cuda-source-dir=example/cuda_files",
    "--compiled-kernel-dir=example",
]

EXAMPLE_RENAMES = {
    "common.bc": "fp8_common.bc",
    "common-cuda-nvptx64-nvidia-cuda-sm_80.bc": "fp8_common-cuda-nvptx64-nvidia-cuda-sm_80.bc",
    "common_combined.bc": "fp8_common_combined.bc",
    "common_combined.ll": "fp8_common_combined.ll",
}

def remove_bitcode_and_ir_files() -> int:
    removed = 0
    for clean_dir in CLEAN_DIRS:
        if not clean_dir.exists():
            print(f"Skipping missing directory: {clean_dir.relative_to(REPO_ROOT)}")
            continue

        for path in clean_dir.rglob("*"):
            if path.is_file() and path.suffix in {".bc", ".ll"}:
                path.unlink()
                removed += 1

    return removed


def run_command(command: list[str]) -> None:
    print(f"Running: {' '.join(command)}", flush=True)
    subprocess.run(command, cwd=REPO_ROOT, check=True)


def rename_example_outputs() -> int:
    renamed = 0
    example_dir = REPO_ROOT / "example"
    for old_name, new_name in EXAMPLE_RENAMES.items():
        old_path = example_dir / old_name
        new_path = example_dir / new_name
        if not old_path.exists():
            continue

        if new_path.exists():
            new_path.unlink()

        old_path.rename(new_path)
        renamed += 1

    return renamed


def main() -> int:
    removed = remove_bitcode_and_ir_files()
    print(f"Removed {removed} .bc/.ll files")

    run_command(EXAMPLE_COMPILE_COMMAND)
    renamed = rename_example_outputs()
    print(f"Renamed {renamed} example outputs to fp8_common names")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
