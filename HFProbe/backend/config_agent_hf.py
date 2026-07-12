import argparse
import shutil

from agents import Agent, Runner, function_tool,WebSearchTool
from agents.memory import Session
from agents.exceptions import MaxTurnsExceeded
from huggingface_hub.errors import HfHubHTTPError, RepositoryNotFoundError
import json, os
from typing import Dict, List, Optional
from . import run_graph
from . import run_transformers
import tiktoken
import traceback
import time
from ..wrapper import find_kernel_rel


MODEL_PRICING = {
    "gpt-4o":       {"input": 0.0025,  "output": 0.01},   # per 1K tokens
    "gpt-5":        {"input": 0.00125,   "output": 0.01},     
    "gpt-5.1":        {"input": 0.00125,   "output": 0.01},     
}

def count_tokens(model: str, text: str) -> int:
    """Safely count tokens for any GPT model; handles lists/dicts."""
    # --- Normalize text ---
    if text is None:
        normalized = ""
    elif isinstance(text, str):
        normalized = text
    elif isinstance(text, list):
        parts = []
        for sub in text:
            if isinstance(sub, dict):
                ttype = sub.get("type")
                if ttype == "text":
                    parts.append(sub.get("text", ""))
                else:
                    # Skip tool_use, tool_result, images, etc.
                    continue
            else:
                parts.append(str(sub))
        normalized = " ".join(parts)
    elif isinstance(text, dict):
        # Flatten key-value dict content
        # Only count textual dicts (rare case)
        if text.get("type") == "text":
            normalized = text.get("text", "")
        else:
            normalized = ""
    else:
        normalized = str(text)
        
    try:
        enc = tiktoken.encoding_for_model(model)
    except KeyError:
        # Fallback to cl100k_base (used by GPT-4/5-class models)
        enc = tiktoken.get_encoding("cl100k_base")
    return len(enc.encode(normalized))

class MyCustomSession(Session):
    def __init__(self, session_id: str, model: str = "gpt-5"):
        self.session_id = session_id
        self.model = model
        self.items: List[Dict[str, str]] = []  # conversation history
        self.prices = MODEL_PRICING.get(model)
        self.token_usage = {"input": 0, "output": 0, "cost": 0.0}

    async def get_items(self, limit: Optional[int] = None) -> List[Dict]:
        """Return the current conversation items (or last N if limit given)."""
        if limit is not None:
            return self.items[-limit:]
        return list(self.items)
    
    async def add_items(self, items: List[Dict]) -> None:
        """Add new conversation turns."""
        for item in items:
            role = item.get("role")
            content = item.get("content", "")
            self.items.append({"role": role, "content": content})

            # Token & cost accounting
            tokens = count_tokens(self.model, content)
            if role in ("system", "user"):
                self.token_usage["input"] += tokens
                self.token_usage["cost"] += tokens / 1000 * self.prices["input"]
            elif role == "assistant":
                self.token_usage["output"] += tokens
                self.token_usage["cost"] += tokens / 1000 * self.prices["output"]
                
    async def pop_item(self) -> Optional[Dict]:
        """Remove and return the most recent conversation item."""
        return self.items.pop() if self.items else None

    async def clear_session(self) -> None:
        """Clear session history and token counters."""
        self.items.clear()
        self.token_usage = {"input": 0, "output": 0, "cost": 0.0}


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
current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(current_path_string))

def _handle_repository_not_found(model_id):
    print(f"Repository not found for model {model_id}.")

def _handle_repository_access_error(model_id, exc):
    response = getattr(exc, "response", None)
    status_code = getattr(response, "status_code", None)
    if status_code in (401, 403):
        print(f"No access to repository for model {model_id} (HTTP {status_code}).")

structure_configs = []
resCon = {}
model_config_out_path = ""

@function_tool
def saveRes(config: str):
    """
    Save the result config into a json file.
    
    Args:
        config: The model config in JSON string format.
    """
    # global structure_configs
    global resCon
    global model_config_out_path
    with open(model_config_out_path, "w") as f:
        resCon = json.loads(config)
        json.dump(resCon, f, indent=4)
    
testAgent = Agent(
    name="LLMConfigAgent",
    instructions=(
        "You are a precise LLM analyzer. You can search on the web to retrieve the model code, framework code and config.json. Then you can analyze the code and config. You check all the conditions in the call chain and match with config fields. Your task is to find the config values that are need to invoke the custom kernel. If this operator cannot be trigger with any config, answer 'No, it cannot be triggered.' If no new config is needed, answer 'No, current config is enough.' Otherwise, you should answer the new config.json and invoke saveRes tool to store the new config.\n"
    ),
    model="gpt-5",
    tools=[WebSearchTool(), saveRes],
)

def runAgent(prompt):
    try:
        session = MyCustomSession("my_session")
        result = Runner.run_sync(
            testAgent,
            prompt,
            max_turns=30,
            session=session
        )
    except MaxTurnsExceeded as e:
        print(f"[⚠️ Warning] Agent exceeded max_turns ({e}).")

        # Access partial run data from e.partial_result if available
        if hasattr(e, "partial_result") and e.partial_result:
            result = e.partial_result
            print("=== Partial Result Before Abort ===")
            print(result.final_output or "No final message yet.")
            print("\nTrace of completed tool calls:")
            for t in result.traces:
                print(f"{t.tool_name}: {t.output[:200]}")

    print("GPT response:")
    print(result.final_output)
    return result.final_output, session.token_usage

def generate_transformer(model_id, op_name, out_dir=None):
    global model_config_out_path
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/huggingface/config/{model_id.replace('/', '_')}")
    os.makedirs(out_dir, exist_ok=True)
    model_config_out_path = os.path.join(out_dir, op_name+".json")
    if os.path.exists(model_config_out_path):
        return None, None
    
    model_repo = f"https://huggingface.co/{model_id}"
    prompt_huggingface = f"""
    For large language model {model_id} on huggingface, check its python code and config.json, generate configs to trigger its custom kernel {op_name}, so that I can use this config in transformers framework to test it. The repo url is {model_repo}. If this kernel cannot be trigger with any config values, answer "No, it cannot be triggered." Otherwise, answer the new config.json. 
    """
    print("prompt:", prompt_huggingface)
    print("****************************************")
    return runAgent(prompt_huggingface)

def find_model_ops(repo_path, kernel_map):
    if not kernel_map:
        all_ops = set()
    else:
        all_ops = set(kernel_map.keys())
    used_ops = set()
    
    for file in os.listdir(repo_path):
        if file.endswith(".py"):
            file_path = os.path.join(repo_path, file)
            with open(file_path, "r") as f:
                code = f.read()
            for op in all_ops:
                if op+"(" in code or "= "+op+"\n" in code:
                    used_ops.add(op)
    return all_ops, used_ops

def find_triggered_ops_hf(model_id, op_name=None, out_dir=None):
    if "mgalkin/ultra" in model_id:
        return find_triggered_ops_graph(model_id, op_name, out_dir)
    
    triggered_ops = set()
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface/out"
    outPath = f"{out_dir}/{model_id.replace('/', '_')}"
    if op_name:
        outPath += "/" + op_name
    outPath+=".json"
    
    if not os.path.exists(outPath):
        return None
    
    with open(outPath) as f:
        out_data = json.load(f)
        
    for key in out_data:
        if key.startswith("torch."):
            continue
        triggered_ops.add(key.split(".")[-1])
    return triggered_ops

def find_triggered_ops_graph(model_id, op_name=None, out_dir=None):
    triggered_ops = set()
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface/out"
    outPath = f"{out_dir}/{model_id.replace('/', '_')}"

    if op_name:
        outPath += "/" + op_name
    outPath+=".json"
    
    if not os.path.exists(outPath):
        return None
    
    with open(outPath) as f:
        out_data = json.load(f)
        
    for item in out_data:
        for call in item["calls"]:
            name = call["name"]
            if name.startswith("torch."):
                continue
            triggered_ops.add(name.split(".")[-1])
    return triggered_ops

def run_model(model_id, config_data, op_name, out_dir=None):
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface"

    if "mgalkin/ultra" in model_id:
        run_graph.run_ultra_with_config(model_id, config_data,  output_dir=f"{out_dir}/out", op_name=op_name)
    else:
        if op_name:
            run_transformers.run(model_id, config_data,  op_name, output_dir=f"{out_dir}/out", data_dir=f"{out_dir}/data", is_op_suffix=True)
        else:
            run_transformers.run(model_id, None, output_dir=f"{out_dir}/out", data_dir=f"{out_dir}/data")

def handle_one_model_hf(model_id, out_dir=None):
    print(f"Processing model: {model_id}")
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface"
    os.makedirs(out_dir, exist_ok=True)

    final_res_path = f"{out_dir}/config/{model_id.replace('/', '_')}/result.json"
    if os.path.exists(final_res_path):
        return
    
    model_cache_dir = run_transformers.snapshot_download(model_id, local_files_only=False, ignore_patterns=["*.bin", "**/*.bin", "*.safetensors", "**/*.safetensors"])
    config_out_dir = f"{out_dir}/config/{model_id.replace('/', '_')}"
    os.makedirs(config_out_dir, exist_ok=True)
    cost_path = os.path.join(config_out_dir, "cost.json")
    cost_map = {}
    if os.path.exists(cost_path):
        with open(cost_path) as f:
            cost_map = json.load(f)
    
    start_time = time.time()
    try:
        run_model(model_id, None, None, out_dir)
    except RepositoryNotFoundError as e:
        _handle_repository_not_found(model_id)
        return
    except HfHubHTTPError as e:
        _handle_repository_access_error(model_id, e)
        return
    except:
        return
    
    kernel_map_path = os.path.join(os.path.dirname(root_dir), "evaluation/section-6-1-bug-detection/intermediate_results", "kernel_map", f"kernel_map_{model_id.replace('/', '_')}.json")
    if os.path.exists(kernel_map_path):
        with open(kernel_map_path) as kf:
            kernel_map = json.load(kf)
    else:
        kernel_map = find_kernel_rel(model_cache_dir, None, False)

    all_ops, used_ops = find_model_ops(model_cache_dir, kernel_map)
    if not all_ops:
        return 

    triggered_ops = find_triggered_ops_hf(model_id, out_dir=out_dir+"/out")
    if not triggered_ops:
        triggered_ops = set()
   
    cannot_tri_path = os.path.join(config_out_dir, "no_trigger.json")   
    cannot_tri = []
    if os.path.exists(cannot_tri_path):
        with open(cannot_tri_path) as nf:
            cannot_tri = json.load(nf)
        print("ops cannot be triggered:", cannot_tri)
    
    initial_trigger = triggered_ops.copy()
    if used_ops:
        target_ops = used_ops
    else:
        target_ops = all_ops
    
    input_token_num, out_token_num, money_cost = 0, 0, 0.00    
    for op_name in target_ops:
        if op_name in triggered_ops:
            print(op_name, "has been triggered.")
            continue
        
        if op_name in cannot_tri:
            print(op_name, "can not be triggered.")
            continue
        
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(execute_res_path):
            print(op_name, "has been handled.")
            continue

        config_out_path = os.path.join(config_out_dir, op_name+".json")
        if not os.path.exists(config_out_path):
            time0 = time.time()
            output, token_usage = generate_transformer(model_id, op_name, config_out_dir)
            time1 = time.time()
            if token_usage:
                cost_map[op_name] = {"input_token": token_usage["input"], "output_token": token_usage["output"], "money_cost": token_usage["cost"], "gpt_time_cost": time1 - time0}
                with open(cost_path, "w") as nwf:
                    json.dump(cost_map, nwf, indent=4)   
            
            if output and (output.startswith("No") or output.startswith("no")):
                cannot_tri.append(op_name)
                with open(cannot_tri_path, "w") as nwf:
                    json.dump(cannot_tri, nwf, indent=4)   
                continue
        
        config_data = {}
        if os.path.exists(config_out_path):
            with open(config_out_path) as cf:
                config_data = json.load(cf)
        
        if not config_data:
            continue
        
        time0 = time.time()
        try:
            run_model(model_id, config_data, op_name, out_dir)
        except RepositoryNotFoundError as e:
            _handle_repository_not_found(model_id)
            pass
        except HfHubHTTPError as e:
            _handle_repository_access_error(model_id, e)
            pass
        except:
            pass

        time1 = time.time()
        if op_name not in cost_map:
            cost_map[op_name] = {}
        cost_map[op_name]["execute_time"] = time1 - time0
        with open(cost_path, "w") as nwf:
            json.dump(cost_map, nwf, indent=4)   
        
        new_triggered = find_triggered_ops_hf(model_id, op_name, out_dir=out_dir+"/out")
        if new_triggered:
            triggered_ops.update(new_triggered)
            if op_name in new_triggered:
                print(f"{op_name} is succesfully triggered!")

    end_time = time.time()
    with open(cannot_tri_path, "w") as nwf:
        json.dump(cannot_tri, nwf)  
        
    cost_map["total"] = {"input_token": input_token_num, "output_token": out_token_num, "money_cost": money_cost, "time_cost": end_time-start_time}
    with open(cost_path, "w") as nwf:
        json.dump(cost_map, nwf)   
    
    final_result = {"initial": list(initial_trigger), "initial_num": len(initial_trigger), "final": list(triggered_ops), "final_num": len(triggered_ops)}
    with open(final_res_path, "w") as resf:
        json.dump(final_result, resf)
    shutil.rmtree(model_cache_dir)

def main_transformers_benchmark(out_dir=None, use_exist_configs=False, run_small=False):
    model_list_path = os.path.join(os.path.dirname(root_dir), "evaluation/section-6-1-bug-detection/benchmarks/huggingface/hfmodels.json")
    with open(model_list_path) as f:
        model_list = json.load(f)
    
    if not out_dir:
        out_dir = os.path.join(root_dir, "results/huggingface")
    
    for item in model_list:
        model_id = item.replace("_", "/", 1)
        if run_small and model_id.startswith("mgalkin"):
            continue
        
        if use_exist_configs:
            test_one_with_configs(model_id, out_dir)
        else:
            handle_one_model_hf(model_id, out_dir=out_dir)  

def test_one_without_mutate_config(model_id, out_dir=None):
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface"
    os.makedirs(out_dir, exist_ok=True)
    
    try:
        run_model(model_id, None, None, out_dir)
    except RepositoryNotFoundError as e:
        _handle_repository_not_found(model_id)
        return
    except HfHubHTTPError as e:
        _handle_repository_access_error(model_id, e)
        return
    except:
        return

def test_one_with_configs(model_id, out_dir=None):
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface"
    os.makedirs(out_dir, exist_ok=True)

    final_res_path = f"{out_dir}/config/{model_id.replace('/', '_')}/result.json"
    # if os.path.exists(final_res_path):
    #     return
    
    start_time = time.time()
    try:
        run_model(model_id, None, None, out_dir)
    except RepositoryNotFoundError as e:
        _handle_repository_not_found(model_id)
        return
    except HfHubHTTPError as e:
        _handle_repository_access_error(model_id, e)
        return
    except:
        return
    
    config_out_dir = f"{out_dir}/config/{model_id.replace('/', '_')}"
    if not os.path.exists(config_out_dir):
        return

    triggered_ops = find_triggered_ops_hf(model_id, out_dir=out_dir+"/out")
    if not triggered_ops:
        triggered_ops = set()
    
    initial_trigger = triggered_ops.copy()
    for config_file in os.listdir(config_out_dir):
        if not config_file.endswith(".json"):
            continue
        if "no_trigger" in config_file or "cost" in config_file or "result" in config_file:
            continue

        op_name = config_file[:-5]
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(execute_res_path):
            print(f"{config_file} already executed.")
            continue

        config_out_path = os.path.join(config_out_dir, config_file)
        config_data = None
        with open(config_out_path) as cf:
            config_data = json.load(cf)
        
        if not config_data:
            continue
        
        try:
            run_model(model_id, config_data, op_name, out_dir)
        except RepositoryNotFoundError as e:
            _handle_repository_not_found(model_id)
            pass
        except HfHubHTTPError as e:
            _handle_repository_access_error(model_id, e)
            pass
        except:
            pass
        
        new_triggered = find_triggered_ops_hf(model_id, op_name, out_dir=out_dir+"/out")
        if new_triggered:
            triggered_ops.update(new_triggered)
            if op_name in new_triggered:
                print(f"{op_name} is succesfully triggered!") 
    
    final_result = {"initial": list(initial_trigger), "initial_num": len(initial_trigger), "final": list(triggered_ops), "final_num": len(triggered_ops)}
    with open(final_res_path, "w") as resf:
        json.dump(final_result, resf)

def test_model_with_one_config(model_id, config_path, out_dir=None):
    if not out_dir:
        out_dir = f"{root_dir}/results/huggingface"
    os.makedirs(out_dir, exist_ok=True)
    
    op_name = os.path.basename(config_path).replace(".json", "")
    if not os.path.exists(config_path):
        print(f"Config file {config_path} does not exist.")
        return
    
    model_config = None
    with open(config_path) as cf:
        model_config = json.load(cf)
        
    try:
        run_model(model_id, model_config, op_name, out_dir)
    except RepositoryNotFoundError as e:
        _handle_repository_not_found(model_id)
        pass
    except HfHubHTTPError as e:
        _handle_repository_access_error(model_id, e)
        pass
    except:
        pass
        
    new_triggered = find_triggered_ops_hf(model_id, op_name, out_dir=out_dir+"/out")
    if new_triggered and op_name in new_triggered:
        print(f"Kernel {op_name} is successfully triggered with the provided config.")
    else:
        print(f"Kernel {op_name} could not be triggered with the provided config.")

def mutate_config_kernel(model_id, op_name, out_dir=None):
    global model_config_out_path
    
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/huggingface")
    
    out_config_dir = os.path.join(out_dir, "config", model_id.replace('/', '_'))
    os.makedirs(out_config_dir, exist_ok=True)
    model_config_out_path = os.path.join(out_config_dir, f"{op_name}.json")
    if os.path.exists(model_config_out_path):
        return None
    
    output, token_usage = generate_transformer(model_id, op_name, out_config_dir)
    if os.path.exists(model_config_out_path):
        print(f"Mutated config for kernel {op_name} is saved at {model_config_out_path}.")
    return output

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="run profiling backend on Huggingface models with Transformers."
    )

    parser.add_argument(
        "--model-id", type=str, required=False, help="Model ID"
    )
    parser.add_argument(
        "--profile-out-dir", type=str, required=False, help="Output directory"
    )
    parser.add_argument(
        "--mutate", action=argparse.BooleanOptionalAction, default=False, help="Whether to mutate model configs"
    )
    parser.add_argument(
        "--use-existent-config", action=argparse.BooleanOptionalAction, default=False, help="Whether to load exisiting configs or to use GPT to mutate model configs"
    )
    parser.add_argument(
        "--config-file", type=str, required=False, help="model config file to run profiling backend"
    )
    parser.add_argument(
        "--kernel-name", type=str, required=False, help="kernel name to mutate config for"
    )
    parser.add_argument(
        "--run-small", action=argparse.BooleanOptionalAction, default=False, help="run the small dataset"
    )
    args = parser.parse_args()

    if args.model_id:
        if args.kernel_name:
            mutate_config_kernel(args.model_id, args.kernel_name, args.profile_out_dir)
        elif args.mutate and args.use_existent_config:
            test_one_with_configs(args.model_id, args.profile_out_dir)
        elif args.mutate:
            handle_one_model_hf(args.model_id, args.profile_out_dir)
        elif args.config_file:
            test_model_with_one_config(args.model_id, args.config_file, args.profile_out_dir)
        else:
            test_one_without_mutate_config(args.model_id, args.profile_out_dir)
    else:
        main_transformers_benchmark(args.profile_out_dir, args.use_existent_config, args.run_small)
