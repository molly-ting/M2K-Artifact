import json
from sympy import symbols, Eq, solve
import re, os
from pathlib import Path


# dimension sizes usually are mutiples of batch_size or seq_len or multiplication of both
def computeLinearRel(sizes, batches, seqLens): 
    is_blinear, is_sLinear, is_mulLinear = True, True, True
    a1, k1 = None, None
    a2, k2 = None, None
    a3, k3 = None, None
    # print(sizes, batches, seqLens)

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
            # print(i, batches[i], sizes[i], "not bLinear")
            is_blinear = False
        
        if is_sLinear and a2*seqLens[i] + k2 != sizes[i]:
            # print(i, seqLens[i], sizes[i], "not sLinear")
            is_sLinear = False
        
        if is_mulLinear and a3*batches[i]*seqLens[i] + k3 != sizes[i]:
            # print(i, batches[i], seqLens[i], sizes[i], "not mulLinear")
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
        
        # print("sizes min removed", new_sizes, new_batches, new_seqLens)
        expr = computeExpr(new_sizes, new_batches, new_seqLens)
    return expr

def computeExpr(sizes, batches, seqLens):
    # Define variables
    a, b, c, d = symbols('a b c d')

    # print("################")
    #data points (x, y, z) (batch, seqLen, size)
    points = []
    for i in range(len(sizes)):
        # print(batches[i], seqLens[i], sizes[i])
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
    
    # print(solution)
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

    # expr = ''
    # if a_val != 0:
    #     expr += str(a_val) + " * b "
    # if b_val != 0:
    #     if expr:
    #         expr += "+ "
    #     expr += str(b_val) + " * s "
    # if c_val != 0:
    #     if expr:
    #         expr += "+ "
    #     expr += str(c_val)
    # return expr

def computeSymRanges(vals, batches, seqLens):   
    # b0, s0, n0 = 1, 1, 1
    # b1, s1, n1 = 2, 2, 2
    # while True:
    #     if vals[-1] >= b0*batches[-1]:
    #         b0+=1
    #     else:
    #         b0-=1
    #         break 

    # while True:
    #     if vals[-1] <= b1*batches[-1]:
    #         b1-=1
    #     else:
    #         b1+=1
    #         break 
    
    # while True:
    #     if vals[-1] >= s0*seqLens[-1]:
    #         s0+=1
    #     else:
    #         s0-=1
    #         break 

    # while True:
    #     if vals[-1] <= s1*seqLens[-1]:
    #         s1-=1
    #     else:
    #         s1+=1
    #         break 
    
    # while True:
    #     if vals[-1] >= n0*seqLens[-1]*batches[-1]:
    #         n0+=1
    #     else:
    #         n0-=1
    #         break 

    # while True:
    #     if vals[-1] <= n1*seqLens[-1]*batches[-1]:
    #         n1-=1
    #     else:
    #         n1+=1
    #         break 
    
    # kb = b0 and b1
    # ks = s0 and s1
    # kn = n0 and n1
    
    # if kn:
    #     for i in range(len(vals)-1):
    #         if vals[i] < n0*batches[i]*seqLens[i] or vals[i] > n1*batches[i]*seqLens[i]:
    #             kn = False
    #             break
    
    # if ks:
    #     for i in range(len(vals)-1):
    #         if vals[i] < s0*batches[i]*seqLens[i] or vals[i] > s1*batches[i]*seqLens[i]:
    #             ks = False
    #             break
    
    # if kb:
    #     for i in range(len(vals)-1):
    #         if vals[i] < b0*batches[i] or vals[i] > b1*batches[i]:
    #             kb = False
    #             break

    # kb, ks, kn = True, True, True
    # for i in range(len(vals)):
    #     if vals[i] < 1*batches[i] or vals[i] > 2*batches[i]:
    #         kb = False
    #     if vals[i] < 1*seqLens[i] or vals[i] > 2*seqLens[i]:
    #         ks = False
    #     if vals[i] < 1*batches[i]*seqLens[i] or vals[i] > 2*batches[i]*seqLens[i]:
    #         kn = False
    
    # if kn:
    #     return ("1*b*s", "2*b*s")
    # if ks:
    #     return ("1*s", "2*s")
    # if kb:
    #     return ("1*b", "2*b")

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
            # print(i, batches[i], sizes[i], "not bLinear")
            is_blinear = False
        
        if is_sLinear and seqLens[i] + k2 != vals[i]:
            # print(i, seqLens[i], sizes[i], "not sLinear")
            is_sLinear = False
        
        if is_mulLinear and batches[i]*seqLens[i] + k3 != vals[i]:
            # print(i, batches[i], seqLens[i], sizes[i], "not mulLinear")
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
        # print(func_name)

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
                    # print(key, len(calls_map[func_name][call_stack][key]))
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
                        # final_shape = computeTensorShape(to_compared, item0, k, batches, seqLens, tmp_v, func_name)
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
                                    # if not expr:
                                    #     maxVals_tuple = tuple(maxVals)
                                    #     if maxVals_tuple in tmp_v:
                                    #         expr = tmp_v[maxVals_tuple]
                                    #     else:
                                    #         expr = "u" + str(symbol_index)
                                    #         symbol_index+=1
                                    #         tmp_v[maxVals_tuple] = expr
                                    #     print(func_name, "maxV else", maxVals, batches, seqLens)
                                    to_add["maxV"] = expr

                                if is_same_min:
                                    to_add["minV"] = minV
                                else:
                                    minVals_tuple = tuple(minVals)
                                    if minVals_tuple in tmp_v:
                                        expr = tmp_v[minVals_tuple]
                                    else:
                                        expr = computeMaxMin(minVals, batches, seqLens, False)
                                    # if not expr:
                                    #     minVals_tuple = tuple(minVals)
                                    #     if minVals_tuple in tmp_v:
                                    #         expr = tmp_v[minVals_tuple]
                                    #     else:
                                    #         expr = "u" + str(symbol_index)
                                    #         symbol_index+=1
                                    #         tmp_v[minVals_tuple] = expr
                                    #     print(func_name, "minV else", minVals, batches, seqLens)
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
                                            # if not expr:
                                            #     maxVals_tuple = tuple(maxVals)
                                            #     if maxVals_tuple in tmp_v:
                                            #         expr = tmp_v[maxVals_tuple]
                                            #     else:
                                            #         expr = "u" + str(symbol_index)
                                            #         symbol_index+=1
                                            #         tmp_v[maxVals_tuple] = expr
                                            #     print(func_name, "maxV else", maxVals, batches, seqLens)
                                            to_add["maxV"] = expr

                                        if is_same_min:
                                            to_add["minV"] = minV
                                        else:
                                            minVals_tuple = tuple(minVals)
                                            if minVals_tuple in tmp_v:
                                                expr = tmp_v[minVals_tuple]
                                            else:
                                                expr = computeMaxMin(minVals, batches, seqLens, False)
                                            # if not expr:
                                            #     minVals_tuple = tuple(minVals)
                                            #     if minVals_tuple in tmp_v:
                                            #         expr = tmp_v[minVals_tuple]
                                            #     else:
                                            #         expr = "u" + str(symbol_index)
                                            #         symbol_index+=1
                                            #         tmp_v[minVals_tuple] = expr
                                            #     print(func_name, "minV else", minVals, batches, seqLens)
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
                        # if base_value and not isinstance(base_value, int) and not isinstance(base_value, float):
                        #     print(func_name, "value not num", base_value)
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

# def computeFinalSymbolicArgs(modelId, callsList1, callsList2, batches, seqLens, outdir): # callsList1: different seq_len, same batch_size, callsList2: different batch_size, same seq_len
#     i = 0
#     num_list1 = len(callsList1)
#     while i < num_list1-1:
#         if len(callsList1[i]) != len(callsList1[i+1]):
#             print(modelId, i, len(callsList1[i]), i+1, len(callsList1[i+1]))
#             return
#         i+=1
    
#     final_cons = {}
#     i = 0
#     num_list2 = len(callsList2)
#     indexList = [0]*num_list2
#     while i < len(callsList1[0]):
#         j = 0
#         isDiff = False
#         while j < num_list1-1:
#             if callsList1[j][i]["name"] != callsList1[j+1][i]["name"]:    
#                 print(j, i, callsList1[j][i]["name"], callsList1[j+1][i]["name"])
#                 isDiff = True
#                 break
#             j+=1
        
#         if isDiff:
#             print("list1 diff", i)
#             i+=1
#             for j in range(num_list2):
#                 indexList[j]+=1
#             continue
        
#         for j in range(num_list2):
#             while callsList1[0][i]["name"] != callsList2[j][indexList[j]]["name"]:
#                 print("list2", j, indexList[j])
#                 indexList[j]+=1
        
#         final_args = []
#         # print(callsList1[0][i]["name"])
#         symbol_index = 0
#         tmp_v = {}
#         for k in range(len(callsList1[0][i]["args"])):
#             item0 = callsList1[0][i]["args"][k]
#             # print("*************")
#             # print(callsList1[0][i]["args"][k])
#             # print(callsList1[1][i]["args"][k])
#             # print(callsList1[2][i]["args"][k])
#             # print(callsList2[0][i]["args"][k])
#             # print(callsList2[1][i]["args"][k])
#             if item0["type"] == "torch.Tensor":
#                 final_shape = []
#                 for h in range(len(item0["shape"])):
#                     is_Same = True
#                     j = 0
#                     base = callsList1[0][i]["args"][k]["shape"][h]
#                     sizes = [base]
#                     while j < num_list1-1:
#                         sizes.append(callsList1[j+1][i]["args"][k]["shape"][h])
#                         if base != callsList1[j+1][i]["args"][k]["shape"][h]:
#                             is_Same = False
#                         j+=1
                    
#                     for j in range(num_list2):
#                         sizes.append(callsList2[j][indexList[j]]["args"][k]["shape"][h])
#                         if base != callsList2[j][indexList[j]]["args"][k]["shape"][h]:
#                             is_Same = False
                    
#                     if is_Same:
#                         final_shape.append(base)
#                     else:
#                         expr = computeLinearRel(sizes, batches, seqLens)
#                         if not expr:
#                             if sizes in tmp_v:
#                                 expr = tmp_v[sizes]
#                             else:
#                                 expr = "u" + str(symbol_index)
#                                 symbol_index+=1
#                                 tmp_v[sizes] = expr
#                             print(sizes)
#                         final_shape.append(expr)
                
#                 # print(final_shape)  
#                 final_args.append({"shape": final_shape, "dtype": item0["dtype"], "type": "torch.Tensor"})
#             else:
#                 is_Same = True
#                 j = 0
#                 base = callsList1[0][i]["args"][k]["value"]
#                 values = [base]
#                 while j < num_list1-1:
#                     values.append(callsList1[j+1][i]["args"][k]["value"])
#                     if base != callsList1[j+1][i]["args"][k]["value"]:
#                         is_Same = False
#                     j+=1
                
#                 for j in range(num_list2):
#                     values.append(callsList2[j][indexList[j]]["args"][k]["value"])
#                     if base != callsList2[j][indexList[j]]["args"][k]["value"]:
#                         is_Same = False
                
#                 if is_Same:
#                     final_args.append({"value": base, "type": item0["type"]})
#                 else:
#                     expr = computeLinearRel(values, batches, seqLens)
#                     if not expr:
#                         if values in tmp_v:
#                             expr = tmp_v[values]
#                         else:
#                             expr = "u" + str(symbol_index)
#                             symbol_index+=1
#                             tmp_v[values] = expr
#                         print(values)
#                     final_args.append({"value": expr, "type": item0["type"]})
        
#         final_cons[i] = {"name": callsList1[0][i]["name"], "args": final_args}
#         i+=1
#         for j in range(num_list2):
#             indexList[j]+=1
    
#     modelId = modelId.replace('/', '_') 
#     with open(outdir+"/"+modelId+".json", "w") as wf:
#         json.dump(final_cons, wf)
        

# def computeFinalArgs(modelId, calls1, calls2, calls3):
#     if len(calls1) != len(calls2):
#         print(modelId, len(calls1), len(calls2))
    
#     final_cons = {}
#     i,j = 0,0
#     while i < len(calls1):   
#         if calls1[i]["name"] != calls2[i]["name"]:    
#             print(i, calls1[i]["name"], calls2[i]["name"])
#             i+=1
#             j+=1
#             continue
        
#         if calls2[i]["name"] != calls3[j]["name"]:
#             j+=1
#         else:
#             final_args = []
#             symbol = 'a'
#             tmp_v = {}
#             for k in range(len(calls1[i]["args"])):
#                 item1 = calls1[i]["args"][k]
#                 item2 = calls2[i]["args"][k]
#                 item3 = calls3[j]["args"][k]
#                 if item1["type"] == "torch.Tensor":
#                     final_shape = []
#                     for h in range(len(item1["shape"])):
#                         shape1 = item1["shape"][h]
#                         shape2 = item2["shape"][h]
#                         shape3 = item3["shape"][h]
#                         if shape1 == shape2 == shape3:
#                             final_shape.append(shape1)
#                         else:
#                             if shape3 in tmp_v:
#                                 final_shape.append(tmp_v[shape3])
#                             else:
#                                 tmp_v[shape3] = symbol
#                                 final_shape.append(symbol)
#                                 symbol = chr(ord(symbol) + 1)
                            
#                     final_args.append({"shape": final_shape, "dtype": item1["dtype"], "type": "torch.Tensor"})
#                 else:
#                     if item1["value"] == item2["value"] == item3["value"]:
#                         final_args.append(item1)
#                     else:
#                         if item3["value"] in tmp_v:
#                             final_args.append({"value": tmp_v[item3["value"]], "type": item1["type"]})
#                         else:
#                             tmp_v[item3["value"]] = symbol
#                             final_args.append({"value": symbol, "type": item1["type"]})
#                             symbol = chr(ord(symbol) + 1)

#             final_cons[i] = {"name": calls1[i]["name"], "args": final_args}
#             i+=1
#             j+=1
    
#     res = {0: calls1, 1: calls2, 2: calls3, "final": final_cons}   
#     modelId = modelId.replace('/', '_')       
#     with open("./output0/"+modelId+".json", "w") as rf:
#         json.dump(res, rf)


def extractModels():
    if os.path.exists("./vllm_models.json"):
        with open("./vllm_models.json", "r") as rf:
            model_ids = json.load(rf)
            return model_ids
    
    file_path = Path("/home/mvh6224/vllm/tests/models/registry.py")

    with file_path.open("r", encoding="utf-8") as f:
        content = f.read()

    # Match strings like _HfExamplesInfo("BAAI/AquilaChat-7B"
    pattern = r'_HfExamplesInfo\(\s*["\']([^"\']+)["\']'

    model_ids = re.findall(pattern, content)
    
    with open("./vllm_models.json", "w") as wf:
        json.dump(model_ids, wf)

    return model_ids

# with open("/home/mvh6224/CUDA-BOSolver/pyanalyzer/data/hllj_mistral-instruct-v0.2-awq-marlin.json") as df:
#     data = json.load(df)

# total_calls_map = {}
# for item in data:
#     batch_size = item["batch_size"]
#     seq_len = item["seq_len"]
#     for call in item['calls']:
#         func_name = call["name"]
#         if func_name not in total_calls_map:
#             total_calls_map[func_name] = {}
#         if (batch_size, seq_len) not in total_calls_map[func_name]:
#             total_calls_map[func_name][(batch_size, seq_len)] = []
        
#         total_calls_map[func_name][(batch_size, seq_len)].append(call["args"])

# computeSymbolicArgsWithMap(total_calls_map, "test.json")

# with open("./test.json") as df:
#     data = json.load(df)

# computeSymbolicArgsWithMap(data, "test_out.json")