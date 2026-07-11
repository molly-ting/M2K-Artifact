import argparse
import os
import shutil
import time
from sxia.hf import vllm_test, indirect_fill, transformers_test, vllm_test_one
from sxia.op import collect_ops
from sxia.utils.vllm import _get_vllm_dir


def _collect_dirs_from_args(args):
    dirs = []
    if args.dir:
        dirs.append(args.dir)
    if args.dir_dir:
        # list all child directories in the directory
        if not os.path.isdir(args.dir_dir):
            return
        dirs.extend([os.path.join(args.dir_dir, d) for d in os.listdir(args.dir_dir)])
    return dirs


def _handle_flatten(dir: str):
    pass

def _iter_callgraph_files(callgraph_dir: str):
    for root, _, files in os.walk(callgraph_dir):
        for file in sorted(files):
            if file.endswith(".json"):
                yield os.path.join(root, file)


def _run_indirect_fill(vllm_dir: str, callgraph_dir: str):
    filled = set()
    while True:
        target_files = [
            target_file
            for target_file in _iter_callgraph_files(callgraph_dir)
            if target_file not in filled
        ]
        if not target_files:
            return

        for target_file in target_files:
            filled.add(target_file)
            indirect_fill(vllm_dir=vllm_dir, target_file=target_file, out_dir=callgraph_dir)

def _copy_vllm_to_hfprobe(vllm_dir: str, root_dir: str):
    hfprobe_dir = os.path.dirname(root_dir)
    target_dir = os.path.join(hfprobe_dir, "vllm")
    if os.path.abspath(vllm_dir) == os.path.abspath(target_dir):
        return target_dir
    if os.path.exists(target_dir):
        return target_dir
    shutil.copytree(vllm_dir, target_dir, dirs_exist_ok=True)
    return target_dir

def _handle_scan_args(args):
    if not args.dir and not args.dir_dir:
        return
    dirs = _collect_dirs_from_args(args)
    from sxia.hf import analyze, HfAnalysisConfig

    for dir in dirs:
        analyze(
            HfAnalysisConfig(
                path=dir,
                out=args.out,
                transformers_dir=args.transformers_dir,
                vllm_dir=args.vllm_dir,
            )
        )


def _handle_flatten_args(args):
    if not args.dir and not args.dir_dir:
        return
    dirs = _collect_dirs_from_args(args)
    for dir in dirs:
        _handle_flatten(dir)


def main():
    parser = argparse.ArgumentParser(prog="./x")
    subparsers = parser.add_subparsers(dest="command")
    scan_parser = subparsers.add_parser(
        "scan", help="Scan a directory for python files"
    )
    scan_parser.add_argument(
        "--dir", type=str, required=False, help="Directory to scan"
    )
    scan_parser.add_argument(
        "--dir-dir", type=str, required=False, help="Directory to scan for directories"
    )
    scan_parser.add_argument(
        "--out", type=str, required=False, help="Output directory for scan", default="."
    )
    scan_parser.add_argument(
        "--transformers-dir",
        type=str,
        required=False,
        help="Directory for transformers,  default is transformers installed by pip",
    )
    scan_parser.add_argument(
        "--vllm-dir",
        type=str,
        required=False,
        help="Directory for vllm, default is vllm installed by pip",
        # default=".venv/lib/python3.10/site-packages/vllm",
        default="/opt/anaconda3/envs/vllm-env/lib/python3.10/site-packages/vllm"
    )
    scan_parser.set_defaults(func=_handle_scan_args)
    flatten_parser = subparsers.add_parser("flatten", help="Flatten a directory")
    flatten_parser.add_argument(
        "--dir", type=str, required=False, help="Directory to flatten"
    )
    flatten_parser.add_argument(
        "--dir-dir",
        type=str,
        required=False,
        help="Directory to flatten for directories",
    )
    flatten_parser.set_defaults(func=_handle_flatten_args)

    args = parser.parse_args()

    if args.command is None:
        return
    args.func(args)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="./x")
    subparsers = parser.add_subparsers(dest="command")
    scan_parser = subparsers.add_parser("scan", help="Scan a directory for python files")
    scan_parser.add_argument(
        "--out", type=str, required=False, help="Output directory"
    )
    scan_parser.add_argument(
        "--vllm-dir",
        type=str,
        required=False,
        help="Directory for vllm"
    )
    scan_parser.add_argument(
        "--vllm-model-arch",
        type=str,
        required=False,
        help="vllm model architecture"
    )
    args = parser.parse_args()

    current_path_string = os.path.abspath(__file__)
    root_dir = os.path.dirname(os.path.dirname(os.path.dirname(current_path_string)))
    if args.command == "scan":
        if args.vllm_model_arch:
            start_time = time.time()
            callgraph_dir = os.path.join(root_dir, "cgout")
            vllm_dir = args.vllm_dir if args.vllm_dir else _get_vllm_dir()
            if "." in vllm_dir:
                vllm_dir = _copy_vllm_to_hfprobe(vllm_dir, root_dir)
            vllm_test_one(vllm_dir, args.vllm_model_arch, callgraph_dir)
            _run_indirect_fill(vllm_dir, callgraph_dir)
            collect_ops(input_dir=callgraph_dir, out_dir=args.out if args.out else os.path.join(root_dir, "opout"))
            end_time = time.time()
            # print(f"Total time: {end_time - start_time:.2f} seconds")

        elif args.vllm_dir:
            vllm_dir = args.vllm_dir
            if "." in vllm_dir:
                vllm_dir = _copy_vllm_to_hfprobe(vllm_dir, root_dir)
            start_time = time.time()
            callgraph_dir = os.path.join(root_dir, "cgout")
            vllm_test(vllm_dir, callgraph_dir)
            indirect_targets = [os.path.join(callgraph_dir, "Qwen3MoeForCausalLM_forward.json"), os.path.join(callgraph_dir, "LinearMethodBase", "AWQMarlinLinearMethod_apply.json"), os.path.join(callgraph_dir, "LinearMethodBase", "CompressedTensorsLinearMethod_apply.json"), os.path.join(callgraph_dir, "LinearMethodBase", "QuarkLinearMethod_apply.json"), os.path.join(callgraph_dir, "scheme", "QuarkW8A8Int8_apply_weights.json")]
            for target_file in indirect_targets:
                indirect_fill(target_file=target_file)
            collect_ops(input_dir=callgraph_dir, out_dir=args.out if args.out else os.path.join(root_dir, "opout"))
            end_time = time.time()
            # print(f"Total time: {end_time - start_time:.2f} seconds")