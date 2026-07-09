import os
import sys
import torch
from transformers import AutoTokenizer, TextStreamer, AutoModelForCausalLM
from huggingface_hub import snapshot_download
import logging
import time
from argparse import ArgumentParser

current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(current_path_string))
research_paper_dir = os.path.join(root_dir, "data", "research_paper")
any_precision_repo_dir = os.path.join(research_paper_dir, "any-precision-llm")
if any_precision_repo_dir not in sys.path:
    sys.path.insert(0, any_precision_repo_dir)

from any_precision import AnyPrecisionForCausalLM

# Logging with time sans date, level name, and message
logging.basicConfig(level=logging.INFO, format='[%(asctime)s | %(levelname)s] %(message)s', datefmt='%H:%M:%S')

DEFAULT_QUANTIZED_MODEL_PATH = os.path.join(
    any_precision_repo_dir,
    "cache",
    "packed",
    "anyprec-(Llama-2-7b-chat-hf)-w8_orig3-gc1-c4_s100_blk512",
)
DEFAULT_ORIGINAL_MODEL_PATH = "meta-llama/Llama-2-7b-chat-hf"

parser = ArgumentParser()
parser.add_argument('-p', '--precisions', nargs='+', type=int, default=None,
                    help="The precisions to benchmark. If not specified, all available precisions will be benchmarked."
                    )
parser.add_argument(
    "--model-path",
    default=os.getenv("ANYPREC_MODEL_PATH", DEFAULT_QUANTIZED_MODEL_PATH),
    help="Local path to the packed any-precision model.",
)
parser.add_argument(
    "--model-repo",
    default=os.getenv("ANYPREC_MODEL_REPO"),
    help="HuggingFace repo id to download the packed any-precision model when --model-path is missing.",
)
parser.add_argument(
    "--original-model-path",
    default=os.getenv("ANYPREC_ORIGINAL_MODEL_PATH", DEFAULT_ORIGINAL_MODEL_PATH),
    help="HuggingFace repo id or local path for the fp16 baseline model.",
)

args = parser.parse_args()

def resolve_quantized_model_path(model_path, model_repo=None):
    if os.path.exists(model_path):
        return model_path

    if not model_repo:
        raise FileNotFoundError(
            "Packed any-precision model not found at "
            f"{model_path}. Set --model-repo or ANYPREC_MODEL_REPO to a "
            "HuggingFace repo containing the packed quantized model."
        )

    logging.info("Packed model not found at %s; downloading %s", model_path, model_repo)
    snapshot_download(repo_id=model_repo, local_dir=model_path)
    return model_path

if __name__ == '__main__':
    model_path = resolve_quantized_model_path(args.model_path, args.model_repo)
    original_model_path = args.original_model_path

    # Configure the precisions to benchmark
    do_fp16 = True
    if args.precisions is not None:
        precisions = args.precisions
        if 16 in precisions:
            precisions.remove(16)
        else:
            do_fp16 = False
    else:
        precisions = None  # Benchmark all available precisions

    # Load model and tokenizer
    tokenizer = AutoTokenizer.from_pretrained(model_path)
    streamer = TextStreamer(tokenizer)

    model = AnyPrecisionForCausalLM.from_quantized(model_path, precisions=precisions)
    model = model.eval().cuda()

    # Warm up CUDA cache for stable performance
    print("~~~~~~~ Warming up CUDA cache ~~~~~~~")
    input_context = "A CUDA cache warm-up is needed to"
    input_ids = tokenizer.encode(input_context, return_tensors="pt").cuda()
    output = model.generate(
        input_ids,
        precision=min(model.precisions),
        max_new_tokens=32,
        pad_token_id=tokenizer.eos_token_id,
        streamer=streamer,
    )
    print("~~~~~~~ Warm up complete ~~~~~~~\n")

    # Now begin bit-width benchmarking
    input_context = input("Prompt/Context: ")
    input_ids = tokenizer.encode(input_context, return_tensors="pt").cuda()

    results = {}

    for precision in model.precisions:
        print(f"=============== generation with {precision}-bit precision ===============")
        torch.cuda.synchronize()
        start_time = time.time()
        output = model.generate(
            input_ids,
            precision=precision,
            max_new_tokens=256,
            pad_token_id=tokenizer.eos_token_id,
            streamer=streamer,
        )
        torch.cuda.synchronize()
        end_time = time.time()

        # Calculate generation speed
        token_count = len(output[0]) - len(input_ids[0])
        tokens_per_second = token_count / (end_time - start_time)
        ms_per_token = 1 / tokens_per_second * 1000

        results[precision] = (tokens_per_second, ms_per_token)

        print(f"\n( Generation speed: {tokens_per_second:.1f} tok/s | Latency: {ms_per_token:.2f} ms/tok )\n")

    # Clear memory
    del model
    torch.cuda.empty_cache()

    if do_fp16:
        # Benchmark the original model
        print(f"=============== generation with fp16 precision ===============")
        model = AutoModelForCausalLM.from_pretrained(original_model_path, torch_dtype=torch.float16).eval().cuda()
        torch.cuda.synchronize()
        start_time = time.time()
        output = model.generate(
            input_ids,
            max_length=256,
            pad_token_id=tokenizer.eos_token_id,
            streamer=streamer,
        )
        torch.cuda.synchronize()
        end_time = time.time()

        # Calculate generation speed
        token_count = len(output[0]) - len(input_ids[0])
        tokens_per_second = token_count / (end_time - start_time)
        ms_per_token = 1 / tokens_per_second * 1000

        results[16] = (tokens_per_second, ms_per_token)

        print(f"\n( Generation speed: {tokens_per_second:.1f} tok/s | Latency: {ms_per_token:.2f} ms/tok )\n")

    print("=============== Summary ===============")
    print(f"\nModel: {model_path}\n")

    for precision, (tokens_per_second, ms_per_token) in results.items():
        print(f"{precision}-bit: {tokens_per_second:.1f} tok/s | {ms_per_token:.2f} ms/tok")
