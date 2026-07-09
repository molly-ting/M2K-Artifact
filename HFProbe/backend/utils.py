import json
from sympy import symbols, Eq, solve
import re, os
from pathlib import Path

current_path_string = os.path.abspath(__file__)
root_dir = os.path.dirname(os.path.dirname(current_path_string))

# dimension sizes usually are mutiples of batch_size or seq_len or multiplication of both
def computeLinearRel(sizes, batches, seqLens): 
    is_blinear, is_sLinear, is_mulLinear = True, True, True
    a1, k1 = None, None
    a2, k2 = None, None
    a3, k3 = None, None

    for i in range(len(sizes)-1):
        if not isinstance(sizes[i], int) and not isinstance(sizes[i], float):
            return None
        
        if a1 is None and k1 is None:
            if batches[i] != batches[i+1]:
                a1 = (sizes[i+1]-sizes[i])/(batches[i+1]-batches[i])
                k1 = sizes[i]-(a1*batches[i])
        
        if a2 is None and k2 is None:
            if seqLens[i] != seqLens[i+1]:
                a2 = (sizes[i+1]-sizes[i])/(seqLens[i+1]-seqLens[i])
                k2 = sizes[i]-(a2*seqLens[i])
        
        if a3 is None and k3 is None:
            if batches[i]*seqLens[i] != batches[i+1]*seqLens[i+1]:
                a3 = (sizes[i+1]-sizes[i]) / ((batches[i+1]*seqLens[i+1]) - (batches[i]*seqLens[i]))
                k3 = sizes[i]-(a3*batches[i]*seqLens[i])
        
        if not (a1 is None or k1 is None or a2 is None or k2 is None or a3 is None or k3 is None):
            break
    
    if a1 is None or k1 is None:
        is_blinear = False
    
    if a2 is None or k2 is None:
        is_sLinear = False
    
    if a3 is None or k3 is None:
        is_mulLinear = False
    
    for i in range(len(sizes)):
        if not is_blinear and not is_sLinear and not is_mulLinear:
            break
        
        if is_blinear and a1*batches[i] + k1 != sizes[i]:
            is_blinear = False
        
        if is_sLinear and a2*seqLens[i] + k2 != sizes[i]:
            is_sLinear = False
        
        if is_mulLinear and a3*batches[i]*seqLens[i] + k3 != sizes[i]:
            is_mulLinear = False
    
    expr = ''
    if is_mulLinear:
        expr = str(a3)+'*s*b'
        if k3:
            expr += "+"+str(k3)
    
    elif is_sLinear:
        expr = str(a2)+'*s'
        if k2:
            expr += "+"+str(k2)

    elif is_blinear:
        expr = str(a1)+'*b'
        if k1:
            expr += "+"+str(k1)
    
    if not expr:
        expr = computeExpr(sizes, batches, seqLens)
    
    if not expr:
        minSize = min(sizes)
        indices = [i for i, v in enumerate(sizes) if v == minSize]
        new_sizes = []
        new_batches = []
        new_seqLens = []
        for i in range(len(sizes)):
            if i not in indices:
                new_sizes.append(sizes[i])
                new_batches.append(batches[i])
                new_seqLens.append(seqLens[i])

        expr = computeExpr(new_sizes, new_batches, new_seqLens)
    return expr

def computeExpr(sizes, batches, seqLens):
    # Define variables
    a, b, c, d = symbols('a b c d')

    #data points (x, y, z) (batch, seqLen, size)
    points = []
    for i in range(len(sizes)):
        points.append((batches[i], seqLens[i], sizes[i]))

    # Create equations: z = axy + bx + cy + d, size = a*batch*seqLen + b*batch + c*seqLen + d
    equations = [Eq(a*x*y + b*x + c*y + d, z) for x, y, z in points]

    # Solve system
    solution = solve(equations, (a, b, c, d))
    
    if not solution:
        print("no solution")
        return None
    
    for sym in (a, b, c, d):
        if sym not in solution:
            equations.append(Eq(sym, 0))
            solution = solve(equations, (a, b, c, d))

    a_val = float(solution[a])
    b_val = float(solution[b])
    c_val = float(solution[c])
    d_val = float(solution[d])
    
    if int(a_val) != a_val or int(b_val) != b_val or int(c_val) != c_val or int(d_val) != d_val:
        return None
    
    a_val = int(a_val)
    b_val = int(b_val)
    c_val = int(c_val)
    d_val = int(d_val)
    
    expr = ''
    if a_val != 0:
        expr += str(a_val) + "*b*s"
        
    if b_val != 0:
        if expr:
            expr += "+"
        expr += str(b_val) + "*b"
        
    if c_val != 0:
        if expr:
            expr += "+"
        expr += str(c_val) + "*s"
        
    if d_val != 0:
        if expr:
            expr += "+"
        expr += str(d_val)
    print(expr)
    return expr

def computeSymRanges(vals, batches, seqLens):   
    minV = min(vals)
    maxV = max(vals)
    return (minV, maxV)

def computeMaxMin(vals, batches, seqLens, isMax):
    is_blinear, is_sLinear, is_mulLinear = True, True, True
    k1 = vals[0] - batches[0]
    k2 = vals[0] - seqLens[0]
    k3 = vals[0] - batches[0] * seqLens[0]
    
    for i in range(len(vals)):
        if not is_blinear and not is_sLinear and not is_mulLinear:
            break
        
        if is_blinear and batches[i] + k1 != vals[i]:
            is_blinear = False
        
        if is_sLinear and seqLens[i] + k2 != vals[i]:
            is_sLinear = False
        
        if is_mulLinear and batches[i]*seqLens[i] + k3 != vals[i]:
            is_mulLinear = False
    
    expr = ''
    if is_blinear:
        expr = '1*b'
        if k1:
            expr += "+"+str(k1)
    
    if is_sLinear:
        if expr:
            print(expr, '1*s', "error")
        else:
            expr = '1*s'
            if k2:
                expr += "+"+str(k2)
    
    if is_mulLinear:
        if expr:
            print(expr, '1*s*b', "error")
        else:
            expr = '1*s*b'
            if k3:
                expr += "+"+str(k3)
    
    if expr:
        return expr
    
    if isMax:
        return max(vals)
    else:
        return min(vals)


def computeTensorShape(to_compared, item0, k, batches, seqLens, tmp_v, func_name):
    for j in range(len(to_compared)):
        if len(item0["shape"]) != len(to_compared[j][k]["shape"]):
            print(func_name, j, k, item0["shape"], len(to_compared[j][k]["shape"]))
            return None
    
    final_shape = []
    for h in range(len(item0["shape"])):
        is_Same = True
        j = 0
        base_size = item0["shape"][h]
        sizes = [base_size]
        while j < len(to_compared):
            sizes.append(to_compared[j][k]["shape"][h])
            if base_size != to_compared[j][k]["shape"][h]:
                is_Same = False
            j+=1
        
        if is_Same:
            final_shape.append(base_size)
        else:
            expr = computeLinearRel(sizes, batches, seqLens)
            if not expr:
                sizes_tuple = tuple(sizes)
                if sizes_tuple in tmp_v:
                    expr = tmp_v[sizes_tuple]
                else:
                    expr = "u" + str(symbol_index)
                    symbol_index+=1
                    tmp_v[sizes_tuple] = expr
                print(func_name, "shape else", sizes, batches, seqLens)
            final_shape.append(expr)
    return final_shape

import ast

def computeSymbolicArgsWithMap(calls_map, outPath): # calls_map: func_name: call_stack: (batch_size, seq_len): argCons
    final_cons = {}
    for func_name in calls_map:
        if func_name == "torch.zeros_like" or func_name == "torch.empty_like":
            continue
        final_cons[func_name] = []

        for call_stack in calls_map[func_name]:
            i = 0
            while True:
                exceed_bound = False
                base_args = None
                to_compared = []
                batches, seqLens = [], []
                for key in calls_map[func_name][call_stack]:
                    if isinstance(key, str):
                        batch_size, seq_len = ast.literal_eval(key)
                    else:
                        batch_size, seq_len = key
                    if i >= len(calls_map[func_name][call_stack][key]):
                        exceed_bound = True
                        break
                    if not base_args:
                        base_args = calls_map[func_name][call_stack][key][i]
                        batches.append(batch_size)
                        seqLens.append(seq_len)
                    else:
                        to_compared.append(calls_map[func_name][call_stack][key][i])
                        batches.append(batch_size)
                        seqLens.append(seq_len)
                
                if exceed_bound:
                    break
                
                final_args = []
                symbol_index = 0
                tmp_v = {}
                for k in range(len(base_args)):
                    item0 = base_args[k]
                    if item0["type"] == "torch.Tensor":
                        different_dim = False
                        for j in range(len(to_compared)):
                            if "shape" not in to_compared[j][k] and func_name == "vllm.varlen_fwd" and item0["dtype"]=="torch.bool" and not item0["shape"]:
                                base_args[k]=to_compared[j][k]
                                continue
                            if len(item0["shape"]) != len(to_compared[j][k]["shape"]):
                                print(func_name, j, k, item0["shape"], len(to_compared[j][k]["shape"]))
                                different_dim = True
                                break
                        if different_dim:
                            break
                        
                        final_shape = []
                        symRanges = {}
                        for h in range(len(item0["shape"])):
                            is_Same = True
                            j = 0
                            base_size = item0["shape"][h]
                            sizes = [base_size]
                            while j < len(to_compared):
                                sizes.append(to_compared[j][k]["shape"][h])
                                if base_size != to_compared[j][k]["shape"][h]:
                                    is_Same = False
                                j+=1
                            
                            if is_Same:
                                final_shape.append(base_size)
                            else:
                                expr = computeLinearRel(sizes, batches, seqLens)
                                if not expr:
                                    noSolution = True
                                    sizes_tuple = tuple(sizes)
                                    if sizes_tuple in tmp_v:
                                        expr = tmp_v[sizes_tuple]
                                    else:
                                        expr = "u" + str(symbol_index)
                                        symbol_index+=1
                                        tmp_v[sizes_tuple] = expr
                                        
                                    symRanges[expr] = computeSymRanges(sizes, batches, seqLens)
                                    print(func_name, "shape else", sizes, batches, seqLens)
                                final_shape.append(expr)
                        if symRanges:
                            to_add = {"shape": final_shape, "dtype": item0["dtype"], "type": "torch.Tensor", "symRanges": symRanges}
                        else:
                            to_add = {"shape": final_shape, "dtype": item0["dtype"], "type": "torch.Tensor"}

                        if "maxV" in item0:
                            maxV = item0["maxV"]
                            minV = item0["minV"]
                            dupV = item0["dupV"]
                            is_same_max = True
                            is_same_min = True

                            j = 0
                            maxVals = [maxV]
                            minVals = [minV]
                            existsM = True
                            while j < len(to_compared):
                                if "maxV" not in to_compared[j][k] or "minV" not in to_compared[j][k] or "dupV" not in to_compared[j][k]:
                                    print(func_name, "max not exist")
                                    existsM = False
                                    break
                                maxVals.append(to_compared[j][k]["maxV"])
                                minVals.append(to_compared[j][k]["minV"])
                                if maxV != to_compared[j][k]["maxV"]:
                                    is_same_max = False
                                if minV != to_compared[j][k]["minV"]:
                                    is_same_min = False
                                if dupV != to_compared[j][k]["dupV"]:
                                    dupV = True
                                j+=1
                            
                            if existsM:
                                if is_same_max:
                                    to_add["maxV"] = maxV
                                else:
                                    maxVals_tuple = tuple(maxVals)
                                    if maxVals_tuple in tmp_v:
                                        expr = tmp_v[maxVals_tuple]
                                    else:
                                        expr = computeMaxMin(maxVals, batches, seqLens, True)
                                    to_add["maxV"] = expr

                                if is_same_min:
                                    to_add["minV"] = minV
                                else:
                                    minVals_tuple = tuple(minVals)
                                    if minVals_tuple in tmp_v:
                                        expr = tmp_v[minVals_tuple]
                                    else:
                                        expr = computeMaxMin(minVals, batches, seqLens, False)
                                    to_add["minV"] = expr

                                to_add["dupV"] = dupV
                        final_args.append(to_add)
                        
                    elif item0["type"] == "list":
                        if item0["dtype"] == "torch.Tensor":
                            different_dim = False
                            for j in range(len(to_compared)):
                                if item0["shape"][0] != to_compared[j][k]["shape"][0]:
                                    print(func_name, j, k, item0["shape"], to_compared[j][k]["shape"])
                                    different_dim = True
                                    break
                            if different_dim:
                                break
                            
                            final_values = []
                            for t in range(len(item0["value"])):
                                b_val = item0["value"][t]
                                
                                for j in range(len(to_compared)):
                                    if len(b_val["shape"]) != len(to_compared[j][k]["value"][t]["shape"]):
                                        print(func_name, j, k, "value", t, b_val["shape"], len(to_compared[j][k]["value"][t]["shape"]))
                                        different_dim = True
                                        break
                                if different_dim:
                                    break
                                
                                final_shape = []
                                symRanges = {}
                                for h in range(len(b_val["shape"])):
                                    is_Same = True
                                    j = 0
                                    base_size = b_val["shape"][h]
                                    sizes = [base_size]
                                    while j < len(to_compared):
                                        sizes.append(to_compared[j][k]["value"][t]["shape"][h])
                                        if base_size != to_compared[j][k]["value"][t]["shape"][h]:
                                            is_Same = False
                                        j+=1
                                    
                                    if is_Same:
                                        final_shape.append(base_size)
                                    else:
                                        expr = computeLinearRel(sizes, batches, seqLens)
                                        if not expr:
                                            sizes_tuple = tuple(sizes)
                                            if sizes_tuple in tmp_v:
                                                expr = tmp_v[sizes_tuple]
                                            else:
                                                expr = "u" + str(symbol_index)
                                                symbol_index+=1
                                                tmp_v[sizes_tuple] = expr
                                            
                                            symRanges[expr] = computeSymRanges(sizes, batches, seqLens)
                                            print(func_name, "list shape else", sizes, batches, seqLens)
                                        final_shape.append(expr)
                                
                                to_add = {"shape": final_shape, "dtype": b_val["dtype"], "type": "torch.Tensor"}
                                if symRanges:
                                    to_add["symRanges"] = symRanges

                                if "maxV" in b_val:
                                    maxV = b_val["maxV"]
                                    minV = b_val["minV"]
                                    dupV = b_val["dupV"]
                                    is_same_max = True
                                    is_same_min = True

                                    j = 0
                                    maxVals = [maxV]
                                    minVals = [minV]
                                    existsM = True
                                    while j < len(to_compared):
                                        if "maxV" not in to_compared[j][k]["value"][t] or "minV" not in to_compared[j][k]["value"][t] or "dupV" not in to_compared[j][k]["value"][t]:
                                            print(func_name, "max not exist")
                                            existsM = False
                                            break
                                        maxVals.append(to_compared[j][k]["value"][t]["maxV"])
                                        minVals.append(to_compared[j][k]["value"][t]["minV"])
                                        if maxV != to_compared[j][k]["value"][t]["maxV"]:
                                            is_same_max = False
                                        if minV != to_compared[j][k]["value"][t]["minV"]:
                                            is_same_min = False
                                        if dupV != to_compared[j][k]["value"][t]["dupV"]:
                                            dupV = True
                                        j+=1
                                    
                                    if existsM:
                                        if is_same_max:
                                            to_add["maxV"] = maxV
                                        else:
                                            maxVals_tuple = tuple(maxVals)
                                            if maxVals_tuple in tmp_v:
                                                expr = tmp_v[maxVals_tuple]
                                            else:
                                                expr = computeMaxMin(maxVals, batches, seqLens, True)
                                            to_add["maxV"] = expr

                                        if is_same_min:
                                            to_add["minV"] = minV
                                        else:
                                            minVals_tuple = tuple(minVals)
                                            if minVals_tuple in tmp_v:
                                                expr = tmp_v[minVals_tuple]
                                            else:
                                                expr = computeMaxMin(minVals, batches, seqLens, False)
                                            to_add["minV"] = expr

                                        to_add["dupV"] = dupV
                                final_values.append(to_add)
                            
                            if different_dim:
                                break
                            
                            final_args.append({"value": final_values, "shape": item0["shape"], "dtype": "torch.Tensor", "type": "list"})
                        else:
                            is_Same = True
                            j = 0
                            base_value = item0["shape"][0]
                            values = [base_value]
                            while j < len(to_compared):
                                values.append(to_compared[j][k]["shape"][0])
                                if base_value != to_compared[j][k]["shape"][0]:
                                    is_Same = False
                                j+=1
                            
                            symRanges = {}
                            if is_Same:
                                to_add = {"shape": [base_value], "dtype": item0["dtype"], "type": "list"}
                            else:
                                expr = computeLinearRel(values, batches, seqLens)
                                if not expr:
                                    values_tuple = tuple(values)
                                    if values_tuple in tmp_v:
                                        expr = tmp_v[values_tuple]
                                    else:
                                        expr = "u" + str(symbol_index)
                                        symbol_index+=1
                                        tmp_v[values_tuple] = expr
                                    
                                    symRanges[expr] = computeSymRanges(values, batches, seqLens)
                                    print(func_name, "list else", values, batches, seqLens)
                                    
                                to_add = {"shape": [expr], "dtype": item0["dtype"], "type": "list"}
                                if symRanges:
                                    to_add["symRanges"] = symRanges
                            
                            if "maxV" in item0:
                                maxV = item0["maxV"]
                                minV = item0["minV"]
                                dupV = item0["dupV"]
                                is_same_max = True
                                is_same_min = True

                                j = 0
                                maxVals = [maxV]
                                minVals = [minV]
                                existsM = True
                                while j < len(to_compared):
                                    if "maxV" not in to_compared[j][k] or "minV" not in to_compared[j][k] or "dupV" not in to_compared[j][k]:
                                        print(func_name, "max not exist")
                                        existsM = False
                                        break
                                    maxVals.append(to_compared[j][k]["maxV"])
                                    minVals.append(to_compared[j][k]["minV"])
                                    if maxV != to_compared[j][k]["maxV"]:
                                        is_same_max = False
                                    if minV != to_compared[j][k]["minV"]:
                                        is_same_min = False
                                    if dupV != to_compared[j][k]["dupV"]:
                                        dupV = True
                                    j+=1
                                
                                if existsM:
                                    if is_same_max:
                                        to_add["maxV"] = maxV
                                    else:
                                        maxVals_tuple = tuple(maxVals)
                                        if maxVals_tuple in tmp_v:
                                            expr = tmp_v[maxVals_tuple]
                                        else:
                                            expr = computeMaxMin(maxVals, batches, seqLens, True)
                                        to_add["maxV"] = expr

                                    if is_same_min:
                                        to_add["minV"] = minV
                                    else:
                                        minVals_tuple = tuple(minVals)
                                        if minVals_tuple in tmp_v:
                                            expr = tmp_v[minVals_tuple]
                                        else:
                                            expr = computeMaxMin(minVals, batches, seqLens, False)
                                        to_add["minV"] = expr

                                    to_add["dupV"] = dupV
                            final_args.append(to_add)
                    else:
                        is_Same = True
                        j = 0
                        base_value = item0["value"]
                        values = [base_value]
                        while j < len(to_compared):
                            values.append(to_compared[j][k]["value"])
                            if base_value != to_compared[j][k]["value"]:
                                is_Same = False
                            j+=1
                        
                        symRanges = {}
                        if is_Same:
                            final_args.append({"value": base_value, "type": item0["type"]})
                        else:
                            expr = computeLinearRel(values, batches, seqLens)
                            if not expr:
                                values_tuple = tuple(values)
                                if values_tuple in tmp_v:
                                    expr = tmp_v[values_tuple]
                                else:
                                    expr = "u" + str(symbol_index)
                                    symbol_index+=1
                                    tmp_v[values_tuple] = expr
                                
                                if isinstance(base_value, int):
                                    symRanges[expr] = computeSymRanges(values, batches, seqLens)
                                print(func_name, "value else", values, batches, seqLens)
                            if symRanges:
                                final_args.append({"value": expr, "type": item0["type"], "symRanges": symRanges})
                            else:
                                final_args.append({"value": expr, "type": item0["type"]})
                            
                if final_args and final_args not in final_cons[func_name]:        
                    final_cons[func_name].append(final_args)
                i+=1

    with open(outPath, "w") as wf:
        json.dump(final_cons, wf, indent=4)

def extractModels():
    model_ids_path = os.path.join(root_dir, "data", "vllm_models.json")
    if os.path.exists(model_ids_path):
        with open(model_ids_path, "r") as rf:
            model_ids = json.load(rf)
            return model_ids
    
    file_path = Path(
        os.getenv(
            "VLLM_REGISTRY_PATH",
            os.path.join(root_dir, "data", "vllm", "tests", "models", "registry.py"),
        )
    )

    with file_path.open("r", encoding="utf-8") as f:
        content = f.read()

    # Match strings like _HfExamplesInfo("BAAI/AquilaChat-7B"
    pattern = r'_HfExamplesInfo\(\s*["\']([^"\']+)["\']'

    model_ids = re.findall(pattern, content)
    
    with open(model_ids_path, "w") as wf:
        json.dump(model_ids, wf)

    return model_ids
