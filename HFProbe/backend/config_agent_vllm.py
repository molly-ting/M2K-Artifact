
import argparse

from agents import Agent, Runner, function_tool, WebSearchTool
from agents.memory import Session
from agents.exceptions import MaxTurnsExceeded
import json, os
from typing import Dict, List, Optional
import HFProbe.backend.run_vllm as run_vllm
import tiktoken
import traceback
import time


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
project_dir = os.path.dirname(root_dir)

structure_configs = []
resCon = {}
config_out_path = ""

@function_tool
def saveRes(config: str):
    """
    Save the result config into a json file.
    
    Args:
        config: The model config in JSON string format.
    """
    global resCon
    global config_out_path
    with open(config_out_path, "w") as f:
        resCon = json.loads(config)
        json.dump(resCon, f)
    
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
        else:
            print("No partial result captured.")

    print(result.final_output)
    return result.final_output, session.token_usage              

def generate_vllm(model_structure, op_name, config_example, framework_config=None, code_snippet=None, out_dir=None):
    global config_out_path
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm/config/{model_structure}")
    os.makedirs(out_dir, exist_ok=True)
    config_out_path = os.path.join(out_dir, f"{op_name}.json")
    if os.path.exists(config_out_path):
        return None, None
    
    prompt_vllm = f"For models using {model_structure}, analyze the python code in vllm. Generate model config to trigger operator {op_name}, so that I can use this config in vllm framework to test it. The repo url is https://github.com/vllm-project/vllm.git, use branch releases/v0.9.0."
    
    if framework_config:
        vllm_config = None
        if "vllmconfig" in framework_config:
            vllm_config = framework_config["vllmconfig"]
        envs_config = None
        if "envs" in framework_config:
            envs_config = framework_config["envs"]
        config_str = ""
        if vllm_config:
            config_str = f" The vllm config is set as: {vllm_config}."
        if envs_config:
            envs_str = ""
            for key in envs_config:
                envs_str += f"envs.{key}={envs_config[key]}, "
            envs_str = envs_str[:-2]
            config_str += f" The environment variables are set as: {envs_str}."
    
        if config_str:
            prompt_vllm += config_str
    
    prompt_vllm += f' Below is an example of config.json for the model config. If this operator cannot be trigger with any config values, answer "No, it cannot be triggered." If no new config is needed, answer "No, current config is enough." Otherwise, you should answer the new config.json.\n{config_example}'
    if code_snippet:
        prompt_vllm += f"\nrelated code in vllm:\n{code_snippet}"
        
    print("prompt:", prompt_vllm)
    print("****************************************")

    return runAgent(prompt_vllm)

vllm_path = None
def read_code_snippet(filePath, start_line, end_line):       
    code_snippet = ""
    if not filePath.startswith("/"):
        if not vllm_path:
            import importlib.util
            spec = importlib.util.find_spec("vllm")
            if spec.origin:
                vllm_path = os.path.dirname(spec.origin)
        if vllm_path:
            if filePath.startswith("vllm/"):
                filePath = os.path.join(vllm_path, filePath[5:])
            else:
                filePath = os.path.join(vllm_path, filePath)
    if not os.path.exists(filePath):
        return None

    with open(filePath) as f:
        lines = f.readlines()
        for i in range(start_line-1, end_line):
            code_snippet += lines[i]
    return code_snippet

def findTriggeredOps(model_id, op_name=None, out_dir=None, load_dir=None):
    triggered_ops = set()
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm/out")
    outPath = os.path.join(out_dir, model_id.replace('/', '_'))
    if op_name:
        outPath += f"/{op_name}"
    outPath += ".json"

    if not load_dir:
        load_dir = os.path.join(root_dir, f"results/vllm/load")
    loadPath = os.path.join(load_dir, model_id.replace('/', '_'))
    if op_name:
        loadPath += f"/{op_name}"
    loadPath += ".json"
    
    if os.path.exists(outPath):
        with open(outPath) as f:
            out_data = json.load(f)
        for key in out_data:
            triggered_ops.add(key.split(".")[-1])
            
    if os.path.exists(loadPath):        
        with open(loadPath) as f:
            load_data = json.load(f)        
        for item in load_data:
            triggered_ops.add(item["name"].split(".")[-1])
            
    return triggered_ops

def extract_diff_config(old, new):
    res = {}
    for key in new:
        if key in old:
            if new[key] != old[key]:
                res[key] = new[key]
        else:
            res[key] = new[key]
    return res

def save_diff_config(op, config, config_dir):
    if not config:
        return
    
    if not config_dir:
        config_dir = os.path.join(root_dir, f"results/vllm/config")
    outFilePath = os.path.join(config_dir, "diff.json")
    data = {}
    if os.path.exists(outFilePath):
        with open(outFilePath) as f:
            data = json.load(f)
    
    if op in data:
        if config not in data[op]:
            data[op].append(config)
    else:
        data[op] = [config]
    
    with open(outFilePath, "w") as wf:
        json.dump(data, wf)
        
def run_vllm_config(framework_config, model_config, model_id, op_name, out_dir):
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
        
    env_old = os.environ.copy()
    config = {}
    if framework_config:
        if "envs" in framework_config:
            for k in framework_config["envs"]:
                os.environ[k] = framework_config["envs"][k]
        
        if "vllmconfig" in framework_config:
            config = framework_config["vllmconfig"]
        if "batch_size" in framework_config:
            run_vllm.batch_size_configs = framework_config["batch_size"]
        if "seq_len" in framework_config:
            run_vllm.seq_lens_configs = framework_config["seq_len"]  
            
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
                run_vllm.batch_size_configs = [1, 3, 5]
                run_vllm.seq_lens_configs = [1, 7, 17]
                print(f"{op_name} config invalid.")
                os.environ.clear()
                os.environ.update(env_old)
                return False, None
    
    config["dtype"] = "float16"
    tmp_triggered_ops = None
    try:
        run_vllm.handleVLLMModel(model_id, config, op_name, f"{out_dir}/out", f"{out_dir}/load", f"{out_dir}/data", True)
        tmp_triggered_ops = findTriggeredOps(model_id, op_name, f"{out_dir}/out", f"{out_dir}/load")
    except:
        traceback.print_exc()
        pass
        
    if framework_config:
        os.environ = env_old
        run_vllm.batch_size_configs = [1, 3, 5]
        run_vllm.seq_lens_configs = [1, 7, 17]
    
    if tmp_triggered_ops and (op_name in tmp_triggered_ops or "vllm."+op_name in tmp_triggered_ops):
        return True, tmp_triggered_ops
    return False, tmp_triggered_ops

def main_vllm_benchmark(out_dir=None, use_exist_configs=False, callgraph_path=None):
    global structure_configs
    with open(f"{project_dir}/evaluation/section-6-1-bug-detection/vllm_models.json") as mf:
        structure_model_map = json.load(mf)
    
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")

    for model_id in structure_model_map:
        structure = structure_model_map[model_id]         
        structure_configs = []
        structure = structure_model_map[model_id]

        if not use_exist_configs:
            test_one(model_id, structure, os.path.join(callgraph_path, structure+".json"), out_dir)
        else:
            test_one_with_configs(model_id, structure, out_dir)
      
def test_one(model_id, structure, opout_path=None, out_dir=None, data_dir=None):
    global config_out_path
    global structure_configs

    if not data_dir:
        data_dir = os.path.join(project_dir, "evaluation/section-6-1-bug-detection/vllm-configs-examples")
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
    os.makedirs(out_dir, exist_ok=True)
    final_res_path = f"{out_dir}/config/{structure}/result.json"
    if os.path.exists(final_res_path):
        return
    
    start_time = time.time()
    tmp_config = {"dtype": "float16"}

    try:
        run_vllm.handleVLLMModel(model_id, tmp_config, None, f"{out_dir}/out", f"{out_dir}/load", f"{out_dir}/data")
    except:
        return
    
    triggered_ops = findTriggeredOps(model_id, None, f"{out_dir}/out", f"{out_dir}/load")
    if not triggered_ops:
        return
    print("triggered_ops", triggered_ops)
    
    if not opout_path or not os.path.exists(opout_path):
        return
    with open(opout_path) as opf:
        call_op_info = json.load(opf)    
    
    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff) 
    
    config_example_path = os.path.join(data_dir, structure+".json")
    if not os.path.exists(config_example_path):
        print(f"Config example for {structure} does not exist.")
        return
    
    with open(config_example_path, "r") as f:
        config_example = json.load(f)
    
    generated_configs_path = f"{out_dir}/config/diff.json"
    generated_configs = {}
    if os.path.exists(generated_configs_path):
        with open(generated_configs_path) as f:
            generated_configs = json.load(f)
    
    cost_path = f"{out_dir}/config/{structure}/cost.json"
    cost_map = {}
    if os.path.exists(cost_path):
        with open(cost_path) as f:
            cost_map = json.load(f)
    
    cannot_tri_path = f"{out_dir}/config/{structure}/no_trigger.json"
    cannot_tri = []
    if os.path.exists(cannot_tri_path):
        with open(cannot_tri_path) as nf:
            cannot_tri = json.load(nf)
        print("ops cannot be triggered:", cannot_tri)
    
    out_config_dir = f"{out_dir}/config/{structure}"
    os.makedirs(out_config_dir, exist_ok=True)
    
    targets_ops = {"advance_step_flashattn", "advance_step_flashinfer", "swap_blocks", "copy_blocks", "copy_blocks_mla"}
    targets_ops.update(set(call_op_info.keys()))
    initial_trigger = triggered_ops.copy()
    input_token_num, out_token_num, money_cost = 0, 0, 0.00

    for op_name in framework_configs:
        if op_name in triggered_ops:
            print(f"Op name: {op_name} has been triggered.")
            continue
        
        if op_name in cannot_tri:
            print(f"Op name: {op_name} can not be triggered.")
            continue

        if "envs" not in framework_configs[op_name] and "vllmconfig" not in framework_configs[op_name]:
            continue
        
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(execute_res_path):
            print(f"Op name: {op_name} already handled.")
            continue
 
        print(f"Processing operator {op_name}...")
        model_config_out_path = os.path.join(out_config_dir, f"{op_name}.json")
        fcon = framework_configs[op_name]  

        time0 = time.time()
        triggered, tmp_triggered_ops = run_vllm_config(fcon, None, model_id, op_name, out_dir)
        time1 = time.time()

        if triggered:
            cost_map[op_name] = {"execute_time": time1 - time0}
            with open(cost_path, "w") as nwf:
                json.dump(cost_map, nwf, indent=4)   

            new_config = config_example.copy()
            with open(model_config_out_path, "w") as wf:
                json.dump(new_config, wf, indent=4)
            print(f"Operator {op_name} is successfully triggered, execute_time: {time1 - time0}")

        if tmp_triggered_ops:
            triggered_ops.update(tmp_triggered_ops)
        else:
            cannot_tri.append(op_name)
            with open(cannot_tri_path, "w") as nwf:
                json.dump(cannot_tri, nwf, indent=4)   
            print(f"Op name: {op_name} cannot be triggered.")

    for op_name in targets_ops:
        if op_name in triggered_ops:
            print(f"Op name: {op_name} has been triggered.")
            continue
        
        if op_name in cannot_tri:
            print(f"Op name: {op_name} can not be triggered.")
            continue
        
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(execute_res_path):
            print(f"Op name: {op_name} already handled.")
            continue
        
        print(f"Processing operator {op_name}...")
        
        model_config_out_path = os.path.join(out_config_dir, f"{op_name}.json")
        fcon = None
        if op_name in framework_configs:
            fcon = framework_configs[op_name]
        
        if os.path.exists(model_config_out_path):
            with open(model_config_out_path) as of:
                model_config = json.load(of)
            time0 = time.time()
            triggered, tmp_triggered_ops = run_vllm_config(fcon, model_config, model_id, op_name, out_dir)
            time1 = time.time()
            if triggered:
                cost_map[op_name] = {"execute_time": time1 - time0}
                with open(cost_path, "w") as nwf:
                    json.dump(cost_map, nwf, indent=4)   
                print(f"Operator {op_name} is successfully triggered, execute_time: {time1 - time0}")

            if tmp_triggered_ops:
                triggered_ops.update(tmp_triggered_ops)
            continue
           
        if op_name in generated_configs:
            old_con = generated_configs[op_name][-1]
            time0 = time.time()
            triggered, tmp_triggered_ops = run_vllm_config(fcon, old_con, model_id, op_name, out_dir)
            time1 = time.time()
            if triggered:
                cost_map[op_name] = {"execute_time": time1 - time0}
                new_config = config_example.copy()
                new_config.update(old_con)
                with open(model_config_out_path, "w") as wf:
                    json.dump(new_config, wf)
                    
                print(f"Operator {op_name} is successfully triggered with old configs, execute_time: {time1 - time0}")
                triggered_ops.update(tmp_triggered_ops)
                continue
            else:
                if os.path.exists(execute_res_path):
                    os.remove(execute_res_path)
        
        elif fcon:
            if "vllmconfig" in fcon or "envs" in fcon:
                time0 = time.time()
                triggered, tmp_triggered_ops = run_vllm_config(fcon, {}, model_id, op_name, out_dir)
                time1 = time.time()
                if triggered:
                    cost_map[op_name] = {"execute_time": time1 - time0}
                    print(f"Operator {op_name} is successfully triggered with framework config, execute_time: {time1 - time0}")
                    triggered_ops.update(tmp_triggered_ops)
                    continue
                else:
                    if os.path.exists(execute_res_path):
                        os.remove(execute_res_path)
                    else:
                        continue

        if op_name not in call_op_info:
            continue
        
        filePath = call_op_info[op_name]["filePath"]
        start_line = call_op_info[op_name]["lines"][0]
        end_line = call_op_info[op_name]["lines"][1]
        code_sinppet = read_code_snippet(filePath, start_line, end_line)
        
        time0 = time.time()
        output, token_usage = generate_vllm(structure, op_name, config_example, fcon, code_sinppet, out_dir=out_config_dir) 
        time1 = time.time()
        if not output:
            continue
        
        time_cost = time1 - time0
        input_token_num += token_usage["input"]
        out_token_num += token_usage["output"]
        money_cost += token_usage["cost"]
        cost_map[op_name] = {"input_token": token_usage["input"], "output_token": token_usage["output"], "money_cost": token_usage["cost"], "gpt_time_cost": time_cost}
        with open(cost_path, "w") as nwf:
            json.dump(cost_map, nwf, indent=4)   
        
        if "No, it cannot be triggered.".lower() in output.lower():
            cannot_tri.append(op_name)
            with open(cannot_tri_path, "w") as nwf:
                json.dump(cannot_tri, nwf)   
            continue
        
        if not os.path.exists(model_config_out_path):
            continue

        with open(model_config_out_path) as cf:
            config_data = json.load(cf)
        
        if not config_data:
            continue

        if config_data in structure_configs:
            continue
        
        structure_configs.append(config_data)
        
        time0 = time.time()        
        triggered, tmp_triggered_ops = run_vllm_config(fcon, config_data, model_id, op_name, out_dir)
        time1 = time.time()
        cost_map[op_name]["execute_time"] = time1 - time0
        with open(cost_path, "w") as nwf:
            json.dump(cost_map, nwf, indent=4) 
        diff_con = extract_diff_config(config_example, config_data)
        if tmp_triggered_ops:
            for incre_op in tmp_triggered_ops:
                if incre_op not in triggered_ops:
                    triggered_ops.add(incre_op)
                    save_diff_config(incre_op, diff_con, out_config_dir)
       
        if triggered:
            print(f"Op name: {op_name} is successfully triggered.")
        # break
    
    end_time = time.time()
    with open(cannot_tri_path, "w") as nwf:
        json.dump(cannot_tri, nwf)    

    if "total" not in cost_map: 
        cost_map["total"] = {"input_token": input_token_num, "output_token": out_token_num, "money_cost": money_cost, "time_cost": end_time-start_time}
    else:
        cost_map["total"]["input_token"] += input_token_num
        cost_map["total"]["output_token"] += out_token_num
        cost_map["total"]["money_cost"] += money_cost
        cost_map["total"]["time_cost"] += end_time-start_time
            
    with open(cost_path, "w") as nwf:
        json.dump(cost_map, nwf)   
    
    final_result = {"initial": list(initial_trigger), "initial_num": len(initial_trigger), "final": list(triggered_ops), "final_num": len(triggered_ops)}
    with open(final_res_path, "w") as resf:
        json.dump(final_result, resf)

def test_one_without_mutate_config(model_id, out_dir=None):
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
    os.makedirs(out_dir, exist_ok=True)
    
    tmp_config = {"dtype": "float16"}

    try:
        run_vllm.handleVLLMModel(model_id, tmp_config, None, f"{out_dir}/out", f"{out_dir}/load", f"{out_dir}/data")
    except:
        return

def test_one_with_configs(model_id, structure, out_dir=None):
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
    os.makedirs(out_dir, exist_ok=True)
    final_res_path = f"{out_dir}/config/{structure}/result.json"
    if os.path.exists(final_res_path):
        return
    
    tmp_config = {"dtype": "float16"}

    try:
        run_vllm.handleVLLMModel(model_id, tmp_config, None, f"{out_dir}/out", f"{out_dir}/load", f"{out_dir}/data")
    except:
        return
    
    triggered_ops = findTriggeredOps(model_id, None, f"{out_dir}/out", f"{out_dir}/load")
    if not triggered_ops:
        return 
    
    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff) 
    
    out_config_dir = f"{out_dir}/config/{structure}"
    if not os.path.exists(out_config_dir):
        return
    
    initial_trigger = triggered_ops.copy()

    for op_name in framework_configs:
        if op_name in triggered_ops:
            print(f"Op name: {op_name} already handled.")
            continue

        if "envs" not in framework_configs[op_name] and "vllmconfig" not in framework_configs[op_name]:
            continue
        
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(execute_res_path):
            print(f"Op name: {op_name} already handled.")
            continue
 
        model_config_out_path = os.path.join(out_config_dir, f"{op_name}.json")
        fcon = framework_configs[op_name]  
        triggered, tmp_triggered_ops = run_vllm_config(fcon, None, model_id, op_name, out_dir)

        if triggered:
            print(f"Operator {op_name} is successfully triggered.")

        if tmp_triggered_ops:
            triggered_ops.update(tmp_triggered_ops)
    
    for config_file in os.listdir(out_config_dir):
        if not config_file.endswith(".json"):
            continue
        if "no_trigger" in config_file or "cost" in config_file or "result" in config_file:
            continue

        op_name = config_file[:-5]        
        execute_res_path = f"{out_dir}/out/{model_id.replace('/', '_')}/{config_file}"
        if os.path.exists(execute_res_path):
            print(f"{config_file} already executed.")
            continue
        
        model_config_out_path = os.path.join(out_config_dir, config_file)
        with open(model_config_out_path) as of:
            model_config = json.load(of)
            
        fcon = None
        if op_name in framework_configs:
            fcon = framework_configs[op_name]

        triggered, tmp_triggered_ops = run_vllm_config(fcon, model_config, model_id, op_name, out_dir)
        if triggered:
            print(f"Operator {op_name} is successfully triggered.")

        if tmp_triggered_ops:
            triggered_ops.update(tmp_triggered_ops)

    final_result = {"initial": list(initial_trigger), "initial_num": len(initial_trigger), "final": list(triggered_ops), "final_num": len(triggered_ops)}
    with open(final_res_path, "w") as resf:
        json.dump(final_result, resf)

def test_model_with_one_config(model_id, config_path, out_dir=None):
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
    os.makedirs(out_dir, exist_ok=True)
    
    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff)
    
    op_name = os.path.basename(config_path).replace(".json", "")
    fcon = None
    if op_name in framework_configs:
        fcon = framework_configs[op_name]
    
    if not os.path.exists(config_path):
        print(f"Config file {config_path} does not exist.")
        return
    
    model_config = None
    with open(config_path) as cf:
        model_config = json.load(cf)
        
    triggered, tmp_triggered_ops = run_vllm_config(fcon, model_config, model_id, op_name, out_dir)
    if triggered:
        print(f"Kernel {op_name} is successfully triggered with the provided config.")
    else:
        print(f"Kernel {op_name} could not be triggered with the provided config.")

def mutate_config_kernel(structure, op_name, seed_config_file, kernel_info_file,out_dir=None):
    global config_out_path
    
    if not out_dir:
        out_dir = os.path.join(root_dir, f"results/vllm")
    
    out_config_dir = os.path.join(out_dir, "config", structure)
    os.makedirs(out_config_dir, exist_ok=True)
    config_out_path = os.path.join(out_config_dir, f"{op_name}.json")
    if os.path.exists(config_out_path):
        return None, None
    
    call_op_info = {}
    with open(kernel_info_file) as kf:
        call_op_info = json.load(kf)
    
    filePath = call_op_info[op_name]["filePath"]
    start_line = call_op_info[op_name]["lines"][0]
    end_line = call_op_info[op_name]["lines"][1]
    code_sinppet = read_code_snippet(filePath, start_line, end_line)
    
    config_example = {}
    with open(seed_config_file) as sf:
        config_example = json.load(sf)
    
    with open(f"{root_dir}/backend/framework_config.json", "r") as ff:
        framework_configs = json.load(ff)
    
    fcon = None
    if op_name in framework_configs:
        fcon = framework_configs[op_name]
    
    output, token_usage = generate_vllm(structure, op_name, config_example, fcon, code_sinppet, out_dir=out_config_dir) 
    return output
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="run profiling backend on vLLM"
    )

    parser.add_argument(
        "--model-id", type=str, required=False, help="Model ID"
    )
    parser.add_argument(
        "--model-architecture", type=str, required=False, help="Model architecture"
    )
    parser.add_argument(
        "--seed-configs-dir", type=str, required=False, help="Data directory containing model config examples"
    )
    parser.add_argument(
        "--seed-config-file", type=str, required=False, help="model default config for mutation"
    )
    parser.add_argument(
        "--out-dir", type=str, required=False, help="Output directory"
    )
    parser.add_argument(
        "--kernel-info-dir", type=str, required=False, help="Directory containing kernel info"
    )
    parser.add_argument(
        "--kernel-info-file", type=str, required=False, help="File containing kernel info of the model"
    )
    parser.add_argument(
        "--mutate", action=argparse.BooleanOptionalAction, default=True, help="Whether to mutate model configs"
    )
    parser.add_argument(
        "--use-existent-config", action=argparse.BooleanOptionalAction, default=True, help="Whether to load exisiting configs or to use GPT to mutate model configs"
    )
    parser.add_argument(
        "--config-file", type=str, required=False, help="model config file to run profiling backend"
    )
    parser.add_argument(
        "--kernel-name", type=str, required=False, help="kernel name to mutate config for"
    )
    args = parser.parse_args()

    if args.model_id:
        if args.config_file:
            test_model_with_one_config(args.model_id, args.config_file, args.out_dir)
        elif args.mutate and not args.use_existent_config:
            test_one(args.model_id, args.model_architecture, args.kernel_info_dir, args.out_dir, args.seed_configs_dir)
        elif args.mutate and args.use_existent_config:
            test_one_with_configs(args.model_id, args.model_architecture, args.out_dir)
        else:
            test_one_without_mutate_config(args.model_id, args.out_dir)
    elif args.kernel_name and args.seed_config_file and args.model_architecture:
        mutate_config_kernel(args.model_architecture, args.kernel_name, args.seed_config_file, args.kernel_info_file, args.out_dir)
    else:
        main_vllm_benchmark(args.out_dir, use_exist_configs=args.use_existent_config, callgraph_path=args.kernel_info_dir)