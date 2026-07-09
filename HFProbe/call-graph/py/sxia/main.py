import logging
import argparse
import os
from time import time
from sxia.hf import vllm_test, indirect_fill, transformers_test, vllm_test_one
from sxia.op import collect_ops
from sxia.utils.vllm import _get_vllm_dir

logger = logging.getLogger(__name__)



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

    log_file = "analyze.log"
    if os.path.exists(log_file):
        os.remove(log_file)

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
            vllm_test_one(vllm_dir, args.vllm_model_arch, callgraph_dir)
            collect_ops(input_dir=callgraph_dir, out_dir=args.out if args.out else os.path.join(root_dir, "opout"))
            end_time = time.time()

        if args.vllm_dir:
            start_time = time.time()
            callgraph_dir = os.path.join(root_dir, "cgout")
            vllm_test(args.vllm_dir, callgraph_dir)
            indirect_targets = [os.path.join(callgraph_dir, "Qwen3MoeForCausalLM_forward.json"), os.path.join(callgraph_dir, "LinearMethodBase", "AWQMarlinLinearMethod_apply.json"), os.path.join(callgraph_dir, "LinearMethodBase", "CompressedTensorsLinearMethod_apply.json"), os.path.join(callgraph_dir, "LinearMethodBase", "QuarkLinearMethod_apply.json"), os.path.join(callgraph_dir, "scheme", "QuarkW8A8Int8_apply_weights.json")]
            for target_file in indirect_targets:
                indirect_fill(target_file=target_file)
            collect_ops(input_dir=callgraph_dir, out_dir=args.out if args.out else os.path.join(root_dir, "opout"))
            end_time = time.time()
