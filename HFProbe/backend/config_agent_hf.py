from agents import Agent, Runner, ModelSettings, RunConfig, function_tool, set_default_openai_key, FileSearchTool, WebSearchTool
from agents.memory import Session
from agents.exceptions import MaxTurnsExceeded
from pydantic import BaseModel, Field
from openai import OpenAI
import json, os
from typing import Dict, Any, List, Optional
import run_graph
import run_transformers
import tiktoken
import traceback
import re
from datetime import datetime
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
        # Some agent frameworks return list of dicts (multi-part messages)
        # "content": [
        #     {"type": "text", "text": "Hello"},
        #     {"type": "tool_use", "tool_name": "WebSearchTool", "arguments": {...}}
        #     ]
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

structure_configs = []
resCon = {}
out_path = ""

@function_tool
def saveRes(config: str):
    """
    Save the result config into a json file.
    
    Args:
        config: The model config in JSON string format.
    """
    # global structure_configs
    global resCon
    global out_path
    with open(out_path, "w") as f:
        resCon = json.loads(config)
        json.dump(resCon, f)
        # if resCon not in structure_configs:
        #     structure_configs.append(resCon)
    
testAgent = Agent(
    name="LLMConfigAgent",
    instructions=(
        "You are a precise LLM analyzer. You can search on the web to retrieve the model code, framework code and config.json. Then you can analyze the code and config. You check all the conditions in the call chain and match with config fields. Your task is to find the config values that are need to invoke the custom kernel. If this operator cannot be trigger with any config, answer 'No, it cannot be triggered.' If no new config is needed, answer 'No, current config is enough.' Otherwise, you should answer the new config.json and invoke saveRes tool to store the new config.\n"
    ),
    model="gpt-5",
    # model_settings=ModelSettings(
    #     temperature=0,),
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
    # run_data = compute_agent_cost(prompt, result)
    print(f"input token: {session.token_usage['input']}, output token: {session.token_usage['output']}, cost: ${session.token_usage['cost']}")
    return result.final_output, session.token_usage

def generate_transformer(model_id, op_name):
    global out_path
    out_dir = f"./hf-exp/config/{model_id.replace('/', '_')}"
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, op_name+".json")
    if os.path.exists(out_path):
        return None, None
    
    model_repo = f"https://huggingface.co/{model_id}"
    prompt_huggingface = f"""
    For large language model {model_id} on huggingface, check its python code and config.json, generate configs to trigger its custom kernel {op_name}, so that I can use this config in transformers framework to test it. The repo url is {model_repo}. If this kernel cannot be trigger with any config values, answer "No, it cannot be triggered." Otherwise, answer the new config.json. 
    """
    return runAgent(prompt_huggingface)

def find_model_ops(model_id, repo_path):
    mapping_path = f"/home/mvh6224/CUDA-BOSolver/libanalyzer/hf_map/kernel_map_{model_id.replace('/', '_')}.json"
    if not os.path.exists(mapping_path):
        print("kernel map not exist!")
        return None, None
    with open(mapping_path, "r") as f:
        kernel_map = json.load(f)
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

def find_triggered_ops_hf(model_id, op_name=None):
    if "mgalkin/ultra" in model_id:
        return find_triggered_ops_graph(model_id, op_name)
    
    triggered_ops = set()
    outPath = "./hf-exp/out/"+model_id.replace('/', '_')
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

def find_triggered_ops_graph(model_id, op_name=None):
    triggered_ops = set()
    outPath = "./hf-exp/out/"+model_id.replace('/', '_')
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

def run_model(model_id, config_data, op_name):
    if "mgalkin/ultra" in model_id:
        run_graph.run_ultra_with_config(model_id, config_data,  output_dir="./hf-exp/out", op_name=op_name)
    else:
        if op_name:
            run_transformers.run(model_id, config_data,  op_name, output_dir="./hf-exp/out", data_dir="./hf-exp/data", is_op_suffix=True)
        else:
            run_transformers.run(model_id, None, output_dir="./hf-exp/out", data_dir="./hf-exp/data")

def handle_one_model_hf(model_id):
    print(f"Processing model: {model_id}")
    config_out_dir = f"./hf-exp/config/{model_id.replace('/', '_')}"
    cost_path = os.path.join(config_out_dir, "cost.json")
    cost_map = {}
    if os.path.exists(cost_path):
        return
            
    repo_path = f"/data/szx5097/hfplayground/_models/{model_id.replace('/', '_')}"
    all_ops, used_ops = find_model_ops(model_id, repo_path)
    print(f"used ops for model {model_id}: {used_ops}")
    if not all_ops:
        return 
    
    start_time = time.time()
    # if not "72B" in model_id:
    try:
        run_model(model_id, None, None)
    except:
        traceback.print_exc()
        if model_id in ["huskyhong/noname-ai-v2_5", "huskyhong/noname-ai-v2_5-light", "Xfgll/RuleGPT"]:
            pass
        else:
            return "error"

    triggered_ops = find_triggered_ops_hf(model_id)
    if triggered_ops is None:
        if not model_id in ["huskyhong/noname-ai-v2_5", "huskyhong/noname-ai-v2_5-light", "Xfgll/RuleGPT"]:
            return
    # else:
    #     triggered_ops = set()
   
    cannot_tri_path = os.path.join(config_out_dir, "no_trigger.json")   
    cannot_tri = []
    if os.path.exists(cannot_tri_path):
        with open(cannot_tri_path) as nf:
            cannot_tri = json.load(nf)
    print("ops cannot be triggered:", cannot_tri)
    
    final_res_path = os.path.join(config_out_dir, "result.json")   
    if not triggered_ops:
        triggered_ops = set()
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
        
        agg_path = f"./hf-exp/out/{model_id.replace('/', '_')}/{op_name}.json"
        if os.path.exists(agg_path):
            print(op_name, "has been handled.")
            continue

        # os.makedirs(config_out_dir, exist_ok=True)
        config_out_path = os.path.join(config_out_dir, op_name+".json")
        print(f"Generating config for model {model_id} to trigger op {op_name}")
        time0 = time.time()
        output, token_usage = generate_transformer(model_id, op_name)
        time1 = time.time()
        if token_usage:
            cost_map[op_name] = {"input_token": token_usage["input"], "output_token": token_usage["output"], "money_cost": token_usage["cost"], "gpt_time_cost": time1 - time0}
            print("cost record", cost_map[op_name])
        
        if output and (output.startswith("No") or output.startswith("no")):
            cannot_tri.append(op_name)
            continue
        
        config_data = {}
        if os.path.exists(config_out_path):
            with open(config_out_path) as cf:
                config_data = json.load(cf)
        
        if not config_data:
            continue
        
        time0 = time.time()
        try:
            run_model(model_id, config_data, op_name)
        except:
            traceback.print_exc()
            pass
        time1 = time.time()
        if op_name not in cost_map:
            cost_map[op_name] = {}
        cost_map[op_name]["execute_time"] = time1 - time0
        
        new_triggered = find_triggered_ops_hf(model_id, op_name)
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
    
    solved = len(triggered_ops) - len(initial_trigger)
    final_result = {"initial": list(initial_trigger), "initial_num": len(initial_trigger), "new": list(triggered_ops-initial_trigger), "inre_len": solved}
    with open(final_res_path, "w") as resf:
        json.dump(final_result, resf)
        
    print(f"Total ops: {len(target_ops)}, Solved: {solved}")
    print(f"total input token: {input_token_num}, total output token: {out_token_num}, total cost: ${money_cost}")

def main_transformers():
    # global out_path
    with open("./hfmodels0.json") as f:
        model_list = json.load(f)
    
    for item in model_list:
        if item == "Qwen_Qwen-1_8B-Chat":
            continue

        model_id = item.replace("_", "/", 1)
        if model_id in ["L1-m1ng/qwen-7b-inf", "leesws/RoadSafety-GPT-14b-chat", "yzsydlc/qwen2", "ishishow/ishishow_safetensors", "BechirTrabelsi1/Falcon_OPT", "minchul/cvlface_adaface_vit_base_kprpe_webface4m"]:
            continue

        if not "72B" in model_id:
            continue
        # config_out_dir = f"./hf-exp/config/{model_id.replace('/', '_')}"
        # cost_path = os.path.join(config_out_dir, "cost.json")
        # cost_map = {}
        # if not os.path.exists(cost_path):
        #     print(model_id)
        errorstr = handle_one_model_hf(model_id)
        if errorstr:
            print(model_id, "error!")
            break
 
# handle_one_model_hf("Qwen/Qwen-1_8B-Chat")
# main_transformers()    
# 
def fix():   
    for model_id in ["yzsydlc/qwen-primeai-int8"]:
        for config_file in os.listdir(f"/home/mvh6224/CUDA-BOSolver/pyanalyzer/hf-exp/config/{model_id.replace('/', '_')}"):
            if not config_file.endswith(".json"):
                continue
            if "cost" in config_file or "trigger" in config_file or "result" in config_file:
                continue
            op_name = config_file[:-5]
            config_out_path = f"/home/mvh6224/CUDA-BOSolver/pyanalyzer/hf-exp/config/{model_id.replace('/', '_')}/{config_file}"

            config_data = {}
            if os.path.exists(config_out_path):
                with open(config_out_path) as cf:
                    config_data = json.load(cf)
            
            if not config_data:
                continue
            
            time0 = time.time()
            try:
                run_model(model_id, config_data, op_name)
            except:
                traceback.print_exc()
                pass
            time1 = time.time()
            print("execute time:", time1 - time0)
            # break

fix()
