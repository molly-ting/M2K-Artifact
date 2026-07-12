cd "$(dirname "$0")/../.."
cd HFProbe/call-graph
bash x scan --kernel-info-out=opout 
cd ../..
python3 -m HFProbe.backend.config_agent_vllm --kernel-info-out=HFProbe/call-graph/opout --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/vllm
python3 -m HFProbe.backend.config_agent_hf --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/huggingface
python3 -m HFProbe.backend.config_agent_rs --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/papers

# skip compiling cuda files as they are already included in the benchmark folder and can be large in size.
# python3 cuKLEE/compile_cuda.py --compile-vllm
# python3 cuKLEE/compile_cuda.py --compile-hf
# python3 cuKLEE/compile_cuda.py --compile-paper

python3 HFProbe/input_generate.py --vllm-benchmark --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/vllm
python3 HFProbe/input_generate.py --hf-benchmark --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/huggingface
python3 HFProbe/input_generate.py --research-paper --profile-out-dir=evaluation/section-6-1-bug-detection/new_results/papers

python3 cuKLEE/run.py --input-dir=evaluation/section-6-1-bug-detection/new_results/vllm/input --out-dir=cuKLEE/results/vllm/out --log-dir=cuKLEE/results/vllm/log
python3 cuKLEE/run.py --input-dir=evaluation/section-6-1-bug-detection/new_results/huggingface/input --out-dir=cuKLEE/results/huggingface/out --log-dir=cuKLEE/results/huggingface/log
python3 cuKLEE/run.py --input-dir=evaluation/section-6-1-bug-detection/new_results/papers/input --out-dir=cuKLEE/results/papers/out --log-dir=cuKLEE/results/papers/log

python3 -m HFProbe.validation.run_vllm_validation --dir --klee-out-dir=cuKLEE/results/vllm/out --profile-dir=evaluation/section-6-1-bug-detection/new_results/vllm
python3 HFProbe/validation/run_hf_validation.py --dir --klee-out-dir=cuKLEE/results/huggingface/out --profile-dir=evaluation/section-6-1-bug-detection/new_results/huggingface
