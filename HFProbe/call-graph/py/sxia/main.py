import logging
import argparse
import os


logger = logging.getLogger(__name__)


def _collect_dirs_from_args(args):
    dirs = []
    if args.dir:
        dirs.append(args.dir)
    if args.dir_dir:
        # list all child directories in the directory
        if not os.path.isdir(args.dir_dir):
            logger.error(f"{args.dir_dir} is not a directory")
            return
        dirs.extend([os.path.join(args.dir_dir, d) for d in os.listdir(args.dir_dir)])
    return dirs


def _handle_flatten(dir: str):
    pass


def _handle_scan_args(args):
    if not args.dir and not args.dir_dir:
        logger.error("--dir or --dir-dir must be provided for scan hf")
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
        logger.error("--dir or --dir-dir must be provided for flatten")
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

    log_file = "analyze.log"
    if os.path.exists(log_file):
        os.remove(log_file)

    logging.basicConfig(
        level=logging.DEBUG,
        format="%(filename)s:%(lineno)s %(levelname)s %(message)s",
        handlers=[logging.FileHandler(log_file), logging.StreamHandler()],
    )

    if args.command is None:
        parser.print_help()
        return
    args.func(args)


if __name__ == "__main__":
    # main()
    from sxia.hf import vllm_test, indirect_fill, transformers_test
    # transformers_test("/Users/molly/Projects/CUDA/_models/chinoll_chatsakura-3b-int4")
    # transformers_test("/Users/molly/Projects/CUDA/_models/Qwen_Qwen-7B")
    vllm_test()
    indirect_targers = ["/Users/molly/Workspace/pyanalyzer/cgout/Qwen3MoeForCausalLM_forward.json", "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/AWQMarlinLinearMethod_apply.json", "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/CompressedTensorsLinearMethod_apply.json", "/Users/molly/Workspace/pyanalyzer/cgout/LinearMethodBase/QuarkLinearMethod_apply.json", "/Users/molly/Workspace/pyanalyzer/cgout/scheme/QuarkW8A8Int8_apply_weights.json"]
    for target_file in indirect_targers:
        indirect_fill(target_file=target_file)
