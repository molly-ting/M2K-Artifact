cd HFProbe/call-graph
./x --scan --vllm-model-arch Qwen2ForCausalLM
echo "call graph is stored in call-graph/cgout, kernel info is stored in call-graph/opout."
cd ..
mkdir -p results/vllm/config
cp -r ../evaluation/section-6-1-bug-detection/HFProbe_results/vllm/config/Qwen2ForCausalLM results/vllm/config/
python3 backend/config_agent_vllm.py --model-id Qwen/Qwen2-0.5B-Instruct --model-architecture Qwen2ForCausalLM  --out-dir results/vllm --call-graph-dir HFProbe/call-graph/opout --mutate=true --use-llm=false
python3 input_generate.py --vllm-result-dir results/vllm --vllm-compile-path ../evaluation/section-6-1-bug-detection/benchmark_compiled_files/vllm_0_9_0 --kernel-map-path ../evaluation/section-6-1-bug-detection/HFProbe_results/kernel_map/kernel_map_vllm.json
echo "the generated input files are stored in results/vllm/input and results/vllm/input-load."
cd ..
python3 cuKLEE/run.py --input-dir HFProbe/results/vllm/input --output-dir cuKLEE/results/out --log-dir cuKLEE/results/log
python3 cuKLEE/run.py --input-dir HFProbe/results/vllm/input-load --output-dir cuKLEE/results/out --log-dir cuKLEE/results/log
echo "the output is stored in cuKLEE/results/log, and the constraints are stored in cuKLEE/results/out."