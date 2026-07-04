import torch
from typing import Optional
import math
# from utils import tensor_calls

# Define a mock function with the same signature (args, kwargs)
def get_cuda_view_from_cpu_tensor_mock(cpu_tensor):
    # tensor_calls.append({"name": "vllm.get_cuda_view_from_cpu_tensor", "args": {"shape": cpu_tensor.shape, "dtype": str(cpu_tensor.dtype), "type": "torch.Tensor"}})
    return torch.zeros_like(cpu_tensor, dtype=cpu_tensor.dtype, device=cpu_tensor.device)
    
# Patch the CUDA kernel with your mock
# torch.ops._C.get_cuda_view_from_cpu_tensor = get_cuda_view_from_cpu_tensor_mock

def aqlm_gemm_mock(input: torch.Tensor, codes: torch.Tensor,
              codebooks: torch.Tensor, scales: torch.Tensor,
              codebook_partition_sizes: list[int],
              bias: Optional[torch.Tensor]):
#     argCons = []
#     argCons.append({"shape": input.shape, "dtype": str(input.dtype), "type": "torch.Tensor"})
#     argCons.append({"shape": codes.shape, "dtype": str(codes.dtype), "type": "torch.Tensor"})
#     argCons.append({"shape": codebooks.shape, "dtype": str(codebooks.dtype), "type": "torch.Tensor"})
#     argCons.append({"shape": scales.shape, "dtype": str(scales.dtype), "type": "torch.Tensor"})
#     argCons.append({"shape": scales.shape, "dtype": str(scales.dtype), "type": "torch.Tensor"})
#     argCons.append({"shape": len(codebook_partition_sizes), "dtype": "int", "type": "list"})
#     if bias:
#         argCons.append({"shape": bias.shape, "dtype": str(bias.dtype), "type": "torch.Tensor"})
#     tensor_calls.append({"name": "vllm.aqlm_gemm", "args": argCons})
#     output_sizes = input.sizes()
#     output_sizes[-1] = sum(codebook_partition_sizes)
    out_features = codes.size(0) * codebooks.size(2)
    flat_input = input.reshape((-1, input.size(-1)))
    flat_output = torch.zeros((flat_input.size(0), out_features),
                                dtype=input.dtype,
                                device=input.device)

    output_sizes = list(input.shape)
    output_sizes.pop()
    output_sizes.append(-1)
    return flat_output.reshape(tuple(output_sizes))
    
# torch.ops._C.aqlm_gemm = aqlm_gemm_mock


def awq_dequantize_mock(qweight: torch.Tensor, scales: torch.Tensor,
                   zeros: torch.Tensor, split_k_iters: int, thx: int,
                   thy: int):
    # argCons = []
    # argCons.append({"shape": qweight.shape, "dtype": str(qweight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": scales.shape, "dtype": str(scales.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": zeros.shape, "dtype": str(zeros.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": split_k_iters, "type": "int"})
    # argCons.append({"value": thx, "type": "int"})
    # argCons.append({"value": thy, "type": "int"})
    # tensor_calls.append({"name": "vllm.awq_dequantize", "args": argCons})
    return torch.zeros((qweight.size(0), qweight.size(1)*8), dtype=scales.dtype, device=scales.device)

# torch.ops._C.awq_dequantize = awq_dequantize_mock


def awq_gemm_mock(input: torch.Tensor, qweight: torch.Tensor, qzeros: torch.Tensor,
             scales: torch.Tensor, split_k_iters: int):
    # argCons = []
    # argCons.append({"shape": input.shape, "dtype": str(input.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": qweight.shape, "dtype": str(qweight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": qzeros.shape, "dtype": str(qzeros.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": scales.shape, "dtype": str(scales.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": split_k_iters, "type": "int"})
    # tensor_calls.append({"name": "vllm.awq_gemm", "args": argCons})
    return torch.zeros((input.size(0), qweight.size(1)*8), dtype=input.dtype, device=input.device)

# torch.ops._C.awq_gemm = awq_gemm_mock


def gptq_gemm_mock(a: torch.Tensor, b_q_weight: torch.Tensor,
                    b_gptq_qzeros: torch.Tensor,
                    b_gptq_scales: torch.Tensor, b_g_idx: torch.Tensor,
                    use_exllama: bool, bit: int) -> torch.Tensor:
    # argCons = []
    # argCons.append({"shape": a.shape, "dtype": str(a.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_q_weight.shape, "dtype": str(b_q_weight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_gptq_qzeros.shape, "dtype": str(b_gptq_qzeros.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_gptq_scales.shape, "dtype": str(b_gptq_scales.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_g_idx.shape, "dtype": str(b_g_idx.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": use_exllama, "type": "bool"})
    # argCons.append({"value": bit, "type": "int"})
    # tensor_calls.append({"name": "vllm.ggml_dequantize", "args": argCons})
    
    return torch.zeros((a.size(0), b_q_weight.size(1)),
                        dtype=a.dtype,
                        device=a.device)

# torch.ops._C.gptq_gemm = gptq_gemm_mock

    
def marlin_gemm_mock(a: torch.Tensor, b_q_weight: torch.Tensor,
                b_scales: torch.Tensor, workspace: torch.Tensor, size_m: int,
                size_n: int, size_k: int):
    # argCons = []
    # argCons.append({"shape": a.shape, "dtype": str(a.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_q_weight.shape, "dtype": str(b_q_weight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_scales.shape, "dtype": str(b_scales.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": workspace.shape, "dtype": str(workspace.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": size_m, "type": "int"})
    # argCons.append({"value": size_n, "type": "int"})
    # argCons.append({"value": size_k, "type": "int"})
    # tensor_calls.append({"name": "vllm.gptq_gemm", "args": argCons})
    return torch.zeros((size_m, size_n), dtype=a.dtype, device=a.device)

# torch.ops._C.marlin_gemm = marlin_gemm_mock


def gptq_marlin_24_gemm_mock(a: torch.Tensor, b_q_weight: torch.Tensor,
                        b_meta: torch.Tensor, b_scales: torch.Tensor,
                        workspace: torch.Tensor, b_q_type,
                        size_m: int, size_n: int, size_k: int):
    # argCons = []
    # argCons.append({"shape": a.shape, "dtype": str(a.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_q_weight.shape, "dtype": str(b_q_weight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_meta.shape, "dtype": str(b_meta.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_scales.shape, "dtype": str(b_scales.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": workspace.shape, "dtype": str(workspace.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": b_q_type, "type": "vllm.scalar_type.ScalarType"})
    # argCons.append({"value": size_m, "type": "int"})
    # argCons.append({"value": size_n, "type": "int"})
    # argCons.append({"value": size_k, "type": "int"})
    # tensor_calls.append({"name": "vllm.gptq_marlin_24_gemm", "args": argCons})
    
    return torch.zeros((size_m, size_n), device=a.device, dtype=a.dtype)

def gptq_marlin_gemm_mock(a: torch.Tensor,
                     c: Optional[torch.Tensor],
                     b_q_weight: torch.Tensor,
                     b_scales: torch.Tensor,
                     global_scale: Optional[torch.Tensor],
                     b_zeros: Optional[torch.Tensor],
                     g_idx: Optional[torch.Tensor],
                     perm: Optional[torch.Tensor],
                     workspace: torch.Tensor,
                     b_q_type,
                     size_m: int,
                     size_n: int,
                     size_k: int,
                     is_k_full: bool = True,
                     use_atomic_add: bool = False,
                     use_fp32_reduce: bool = False,
                     is_zp_float: bool = False):
    # argCons = []
    # argCons.append({"shape": a.shape, "dtype": str(a.dtype), "type": "torch.Tensor"})
    # if c:
    #     argCons.append({"shape": c.shape, "dtype": str(c.dtype), "type": "torch.Tensor"})
    # else:
    #     argCons.append({"value": None, "type": "Optional[torch.Tensor]"})
    # argCons.append({"shape": b_q_weight.shape, "dtype": str(b_q_weight.dtype), "type": "torch.Tensor"})
    # argCons.append({"shape": b_scales.shape, "dtype": str(b_scales.dtype), "type": "torch.Tensor"})
    # if global_scale:
    #     argCons.append({"shape": global_scale.shape, "dtype": str(global_scale.dtype), "type": "torch.Tensor"})
    # else:
    #     argCons.append({"value": None, "type": "Optional[torch.Tensor]"})
    # if b_zeros:
    #     argCons.append({"shape": b_zeros.shape, "dtype": str(b_zeros.dtype), "type": "torch.Tensor"})
    # else:
    #     argCons.append({"value": None, "type": "Optional[torch.Tensor]"})
    # if g_idx:
    #     argCons.append({"shape": g_idx.shape, "dtype": str(g_idx.dtype), "type": "torch.Tensor"})
    # else:
    #     argCons.append({"value": None, "type": "Optional[torch.Tensor]"})
    # if perm:
    #     argCons.append({"shape": perm.shape, "dtype": str(perm.dtype), "type": "torch.Tensor"})
    # else:
    #     argCons.append({"value": None, "type": "Optional[torch.Tensor]"})
    # argCons.append({"shape": workspace.shape, "dtype": str(workspace.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": b_q_type, "type": "vllm.scalar_type.ScalarType"})
    # argCons.append({"value": size_m, "type": "int"})
    # argCons.append({"value": size_n, "type": "int"})
    # argCons.append({"value": size_k, "type": "int"})
    # argCons.append({"value": is_k_full, "type": "bool"})
    # argCons.append({"value": use_atomic_add, "type": "bool"})
    # argCons.append({"value": use_fp32_reduce, "type": "bool"})
    # argCons.append({"value": is_zp_float, "type": "bool"})
    # tensor_calls.append({"name": "vllm.gptq_marlin_gemm", "args": argCons})
    return torch.zeros((size_m, size_n), device=a.device, dtype=a.dtype)

def marlin_qqq_gemm_mock(a: torch.Tensor, b_q_weight: torch.Tensor,
                    s_tok: torch.Tensor, s_ch: torch.Tensor,
                    s_group: torch.Tensor, workspace: torch.Tensor,
                    size_m: int, size_n: int, size_k: int):
    return torch.zeros((size_m, size_n), dtype=torch.float16, device=a.device)

def aqlm_dequant_mock(codes: torch.Tensor, codebooks: torch.Tensor,
                 codebook_partition_sizes: list[int]):
    in_features = codes.size(1) * 8
    out_features = codes.size(0)
    return torch.zeros((out_features, in_features),
                        dtype=codebooks.dtype,
                        device=codebooks.device)

def machete_mm_mock(
        a: torch.Tensor,
        # b_q Should be the tensor returned by machete_prepack_B
        b_q: torch.Tensor,
        b_type,
        out_type: Optional[torch.dtype] = None,
        b_group_scales: Optional[torch.Tensor] = None,
        b_group_zeros: Optional[torch.Tensor] = None,
        b_group_size: Optional[int] = None,
        b_channel_scales: Optional[torch.Tensor] = None,
        a_token_scales: Optional[torch.Tensor] = None,
        schedule: Optional[str] = None):
    m = a.size(0)
    n = b_q.size(1)
    return torch.zeros((m, n), device=a.device, dtype=a.dtype)

def machete_prepack_B_mock(
        b_q_weight: torch.Tensor, a_type: torch.dtype, b_type,
        group_scales_type: Optional[torch.dtype]):
    return torch.zeros_like(b_q_weight,
                                memory_format=torch.contiguous_format)

def allspark_w8a16_gemm_mock(a: torch.Tensor, b_qweight: torch.Tensor,
                        b_scales: torch.Tensor,
                        b_qzeros: Optional[torch.Tensor], n: int,
                        group_size: int, sm_count: int, sm_version: int,
                        CUBLAS_M_THRESHOLD: int, has_zp: bool,
                        n32k16_reorder: bool):
    m = a.size(0)
    return torch.zeros((m, n), device=a.device, dtype=a.dtype)

def ggml_dequantize_mock(W: torch.Tensor, quant_type: int, m: int, n: int, dtype: Optional[torch.dtype]):
    # argCons = []
    # argCons.append({"shape": W.shape, "dtype": str(W.dtype), "type": "torch.Tensor"})
    # argCons.append({"value": quant_type, "type": "int"})
    # argCons.append({"value": m, "type": "int"})
    # argCons.append({"value": n, "type": "int"})
    # tensor_calls.append({"name": "vllm.ggml_dequantize", "args": argCons})
    
    # if dtype:
    #     argCons.append({"value": dtype, "type": "torch.dtype"})
    return torch.zeros((m, n), dtype=torch.float16, device=W.device)

# torch.ops._C.ggml_dequantize = ggml_dequantize_mock

def ggml_mul_mat_vec_a8_mock(
    W: torch.Tensor,
    X: torch.Tensor,
    quant_type: int,
    row: int,
):
    return torch.zeros((1, row), dtype=X.dtype, device=W.device)

def ggml_mul_mat_a8_mock(
    W: torch.Tensor,
    X: torch.Tensor,
    quant_type: int,
    row: int,
):
    batch = X.size(0)
    return torch.zeros((batch, row), dtype=X.dtype, device=W.device)

def ggml_moe_a8_mock(
    X: torch.Tensor,
    W: torch.Tensor,
    sorted_token_ids: torch.Tensor,
    expert_ids: torch.Tensor,
    num_tokens_post_padded: torch.Tensor,
    quant_type: int,
    row: int,
    top_k: int,
    tokens: int,
):
    tokens = X.size(0)
    return torch.zeros((tokens * top_k, row),
                        dtype=torch.float16,
                        device=W.device)

def ggml_moe_a8_vec_mock(
    X: torch.Tensor,
    W: torch.Tensor,
    topk_ids: torch.Tensor,
    top_k: int,
    quant_type: int,
    row: torch.SymInt,
    tokens: torch.SymInt,
):
    tokens = X.size(0)
    return torch.zeros((tokens * top_k, row),
                        dtype=X.dtype,
                        device=W.device)

def cutlass_scaled_mm_supports_fp4_mock(cuda_device_capability: int):
    return True

def cutlass_scaled_mm_supports_fp8_mock(cuda_device_capability: int):
    # return True
    return False

def cutlass_scaled_mm_supports_block_fp8_mock(cuda_device_capability: int):
    return True

def cutlass_sparse_scaled_mm_supported_mock(cuda_device_capability: int):
    return True

def cutlass_group_gemm_supported_mock(cuda_device_capability: int):
    return True

def cutlass_sparse_compress_mock(a: torch.Tensor):
    m = a.size(0)
    k = a.size(1)
    a_nzs = torch.zeros((m, k // 2), dtype=a.dtype, device=a.device)
    a_meta = torch.zeros((m, k // 2 // 4), dtype=a.dtype, device=a.device)
    return (a_nzs, a_meta)

def gptq_marlin_repack_mock(b_q_weight: torch.Tensor, perm: torch.Tensor,
                       size_k: int, size_n: int,
                       num_bits: int):
    pack_factor = int(32 / num_bits)
    return torch.zeros((size_k // 16, int(size_n * 16 / pack_factor)), dtype=b_q_weight.dtype, device=b_q_weight.device)

def awq_marlin_repack_mock(b_q_weight: torch.Tensor, size_k: int, size_n: int,
                      num_bits: int):
    pack_factor = int(32 / num_bits)
    return torch.zeros((size_k // 16, int(size_n * 16 / pack_factor)), dtype=b_q_weight.dtype, device=b_q_weight.device)

def machete_supported_schedules_mock(
        a_type: torch.dtype,
        b_type,
        group_scales_type: Optional[torch.dtype],
        group_zeros_type: Optional[torch.dtype] = None,
        channel_scales_type: Optional[torch.dtype] = None,
        token_scales_type: Optional[torch.dtype] = None,
        out_type: Optional[torch.dtype] = None):
    return []

def permute_cols_mock(a: torch.Tensor,
                           perm: torch.Tensor) -> torch.Tensor:
    return torch.zeros_like(a)

def ggml_moe_get_block_size_mock(quant_type: int):
    return 0

def LLMM1_mock(a: torch.Tensor, b: torch.Tensor,
          rows_per_block: int):
    return torch.zeros((b.size(0), a.size(0)), dtype=b.dtype, device=b.device)

def wvSplitK_mock(a: torch.Tensor, b: torch.Tensor, cu_count: int):
    return torch.zeros((b.size(0), a.size(0)), dtype=b.dtype, device=b.device)

def moe_wna16_marlin_gemm_mock(input: torch.Tensor,
                                   output: Optional[torch.Tensor],
                                   b_qweight: torch.Tensor,
                                   b_scales: torch.Tensor,
                                   global_scale: Optional[torch.Tensor],
                                   b_qzeros: Optional[torch.Tensor],
                                   g_idx: Optional[torch.Tensor],
                                   perm: Optional[torch.Tensor],
                                   workspace: torch.Tensor,
                                   sorted_token_ids: torch.Tensor,
                                   expert_ids: torch.Tensor,
                                   num_tokens_past_padded: torch.Tensor,
                                   topk_weights: torch.Tensor,
                                   moe_block_size: int, top_k: int,
                                   mul_topk_weights: bool, is_ep: bool,
                                   b_q_type, size_m: int,
                                   size_n: int, size_k: int, is_k_full: bool,
                                   use_atomic_add: bool, use_fp32_reduce: bool,
                                   is_zp_float: bool):
    return torch.zeros((size_m * top_k, size_n), dtype=input.dtype, device=input.device)

def marlin_gemm_moe_mock(a: torch.Tensor, b_q_weights: torch.Tensor,
                             sorted_ids: torch.Tensor,
                             topk_weights: torch.Tensor,
                             topk_ids: torch.Tensor, b_scales: torch.Tensor,
                             b_zero_points: torch.Tensor, g_idx: torch.Tensor,
                             perm: torch.Tensor, workspace: torch.Tensor,
                             b_q_type, size_m: torch.SymInt,
                             size_n: torch.SymInt, size_k: torch.SymInt,
                             is_k_full: bool, num_experts: int, topk: int,
                             moe_block_size: int, replicate_input: bool,
                             apply_weights: bool):
    return torch.zeros((size_m, topk, size_n), dtype=a.dtype, device=a.device)

def get_device_attribute_mock(attribute: int, device: int):
    return 0

def get_max_shared_memory_per_block_device_attribute_mock(device: int):
    return 0

def init_custom_ar_mock(ipc_tensors: list[torch.Tensor], rank_data: torch.Tensor,
                   rank: int, fully_connected: bool):
    return 0

def meta_size_mock():
    return 4352

def get_graph_buffer_ipc_meta_mock(fa: int):
    return ([], [])

def allocate_shared_buffer_and_handle_mock(size: int) :
    return (0, torch.zeros((64), dtype=torch.int8, device=torch.cpu))

def open_mem_handle_mock(mem_handle: torch.Tensor):
    return 0


# def unified_attention_mock(
#     query: torch.Tensor,
#     key: torch.Tensor,
#     value: torch.Tensor,
#     layer_name: str,
# ) -> torch.Tensor:
#     return torch.zeros_like(query).contiguous()

# def apply_w8a8_block_fp8_linear_mock(
#     input: torch.Tensor,
#     weight: torch.Tensor,
#     block_size: list[int],
#     weight_scale: torch.Tensor,
#     input_scale: Optional[torch.Tensor] = None,
#     bias: Optional[torch.Tensor] = None,
#     cutlass_block_fp8_supported: bool = True,
#     use_aiter_and_is_supported: bool = False,
# ):
#     output_shape = [*input.shape[:-1], weight.shape[0]]
#     return torch.zeros(output_shape, dtype=input.dtype, device=input.device)

def per_token_group_quant_fp8_mock(
    x: torch.Tensor,
    group_size: int,
    eps: float = 1e-10,
    dtype: Optional[torch.dtype] = None,
    column_major_scales: bool = False,
) -> tuple[torch.Tensor, torch.Tensor]:
    x_q = torch.zeros_like(x, device=x.device, dtype=dtype)
    M = x.numel() // group_size
    N = group_size
    if column_major_scales:
        shape = (x.shape[-1] // group_size, ) + x.shape[:-1]
        x_s = torch.zeros(shape, device=x.device,
                          dtype=torch.float32).permute(-1, -2)
    else:
        shape = x.shape[:-1] + (x.shape[-1] // group_size, )
        x_s = torch.zeros(shape, device=x.device, dtype=torch.float32)
    
    return x_q, x_s

def w8a8_block_fp8_matmul_mock(
    A: torch.Tensor,
    B: torch.Tensor,
    As: torch.Tensor,
    Bs: torch.Tensor,
    block_size: list[int],
    output_dtype: torch.dtype = torch.float16,
) -> torch.Tensor:
    N, K = B.shape
    C_shape = A.shape[:-1] + (N, )
    C = A.new_empty(C_shape, dtype=output_dtype)
    return C

def triton_attention_rocm_mock(q, k, v, o, metadata):
    if o is None:
        if metadata.eight_bit:
            o = torch.zeros_like(
                q,
                dtype=metadata.output_dtype if metadata.output_dtype
                is not None else metadata.eight_bit_dtype_torch)
        else:
            o = torch.zeros_like(q, dtype=q.dtype)
    
    if metadata.return_encoded_softmax:
        encoded_softmax = torch.zeros(
            (q.shape[0], q.shape[1], q.shape[2], k.shape[2]),
            device=q.device,
            dtype=torch.float32)
    else:
        encoded_softmax = None
    return o, encoded_softmax

def blocksparse_flash_attn_varlen_fwd_mock(
        q,
        k,
        v,  # (#tokens, n_heads, head_size)
        cu_seqlens_k,
        cu_seqlens_q,
        sm_scale,
        sparse_layout,
        *,
        block_size=64,
        q_block_size=None,
        max_seqlen=None):
    out = q.new_empty(q.shape)
    return out

from einops import rearrange
def linear_decode_forward_triton_mock(
    q: torch.Tensor,
    k: torch.Tensor,
    v: torch.Tensor,
    kv_caches: torch.Tensor,
    slope_rate: torch.Tensor,
    slot_idx: torch.Tensor,
    BLOCK_SIZE: int = 32,
):
    output = torch.zeros_like(q)
    output = rearrange(output, "b h n d -> b n (h d)")
    return output.squeeze(1).contiguous()

def lightning_attention_mock(q, k, v, s, kv_history):
    b, h, n, d = q.shape
    e = v.shape[-1]
    o = torch.zeros((b, h, n, e), dtype=q.dtype, device=q.device)

    BLOCK = 256
    NUM_BLOCK = (n + BLOCK - 1) // BLOCK
    kv = torch.zeros((b, h, NUM_BLOCK, d, e),
                         dtype=torch.float32,
                         device=q.device)
    return o, torch.cat([kv, kv_history.unsqueeze(2)], dim=2)

def selective_state_update_mock(state,
                           x,
                           dt,
                           A,
                           B,
                           C,
                           D=None,
                           z=None,
                           dt_bias=None,
                           dt_softplus=False,
                           state_batch_indices=None,
                           pad_slot_id=-1):
    has_heads = state.dim() > 3
    out = torch.zeros_like(x)
    if not has_heads:
        out = out.squeeze(1)
    return out

def bmm_chunk_fwd_mock(a,
                   b,
                   chunk_size,
                   seq_idx=None,
                   causal=False,
                   output_dtype=None):
    has_groups = a.dim() == 4
    if not has_groups:
        batch, seqlen, k = a.shape
    else:
        batch, seqlen, ngroups, k = a.shape
    
    if a.stride(-1) != 1 and a.stride(1) != 1:
        a = a.contiguous()
    if b.stride(-1) != 1 and b.stride(1) != 1:
        b = b.contiguous()
    nchunks = math.ceil(seqlen / chunk_size)
    # Allocates output.
    out_dtype = a.dtype if output_dtype is None else output_dtype
    out = torch.zeros(
        (batch, nchunks, chunk_size, chunk_size) if not has_groups else
        (batch, nchunks, ngroups, chunk_size, chunk_size),
        device=a.device,
        dtype=out_dtype)
    return out

def chunk_scan_fwd_mock(
    cb,
    x,
    dt,
    dA_cumsum,
    C,
    states,
    D=None,
    z=None,
    seq_idx=None,
    chunk_indices=None,
    chunk_offsets=None,
    initial_states=None,
):
    batch, seqlen, nheads, headdim = x.shape
    out = torch.zeros(batch,
                      seqlen,
                      nheads,
                      headdim,
                      device=x.device,
                      dtype=x.dtype)
    if z is not None:
        out_x = torch.zeros(batch,
                            seqlen,
                            nheads,
                            headdim,
                            device=x.device,
                            dtype=x.dtype)
    else:
        out_x = None
    return out, out_x
    
def chunk_cumsum_fwd_mock(dt,
                      A,
                      chunk_size,
                      dt_bias=None,
                      dt_softplus=False,
                      dt_limit=(0.0, float("inf"))):
    batch, seqlen, nheads = dt.shape
    nchunks = math.ceil(seqlen / chunk_size)
    dt_out = torch.zeros(batch,
                         nheads,
                         nchunks,
                         chunk_size,
                         device=dt.device,
                         dtype=torch.float32)
    dA_cumsum = torch.zeros(batch,
                            nheads,
                            nchunks,
                            chunk_size,
                            device=dt.device,
                            dtype=torch.float32)
    return dA_cumsum, dt_out

def chunk_state_fwd_mock(B,
                     x,
                     dt,
                     dA_cumsum,
                     seq_idx=None,
                     states=None,
                     states_in_fp32=True):
    batch, seqlen, nheads, headdim = x.shape
    _, _, nchunks, chunk_size = dt.shape
    _, _, ngroups, dstate = B.shape
    if states is None:
        states_dtype = torch.float32 if states_in_fp32 else B.dtype
        states = torch.zeros((batch, nchunks, nheads, headdim, dstate),
                             device=x.device,
                             dtype=states_dtype)
    return states

def chunk_state_varlen_mock(B,
                       x,
                       dt,
                       dA_cumsum,
                       cu_seqlens,
                       chunk_states,
                       initial_states=None):
    total_seqlen, nheads, headdim = x.shape
    _, ngroups, dstate = B.shape
    batch = cu_seqlens.shape[0] - 1

    states = torch.zeros(batch,
                         nheads,
                         headdim,
                         dstate,
                         dtype=chunk_states.dtype,
                         device=chunk_states.device)
    return states

def state_passing_fwd_mock(
    states,
    dA_chunk_cumsum,
    initial_states=None,
    seq_idx=None,
    chunk_size=None,
    out_dtype=None,
    is_cont_batched=False,
):
    batch, nchunks, nheads, dim = states.shape
    out_dtype = states.dtype if out_dtype is None else out_dtype
    out = torch.zeros((batch, nchunks, nheads, dim),
                      device=states.device,
                      dtype=out_dtype)
    final_states = torch.zeros((batch, nheads, dim),
                               device=states.device,
                               dtype=torch.float32)
    return out, final_states

def triton_scaled_mm_mock(input: torch.Tensor,
                     weight: torch.Tensor,
                     scale_a: torch.Tensor,
                     scale_b: torch.Tensor,
                     out_dtype: type[torch.dtype],
                     bias: Optional[torch.Tensor] = None,
                     block_size_m: int = 32,
                     block_size_n: int = 32,
                     block_size_k: int = 32,
                     use_heuristic=True):
    M, K = input.shape
    N = weight.shape[1]
    result = torch.zeros((M, N), dtype=out_dtype, device=input.device)
    return result.to(out_dtype)

def per_token_quant_int8_mock(x):
    x_q = torch.zeros_like(x, device=x.device, dtype=torch.int8)
    scales = torch.zeros(x.shape[:-1] + (1, ),
                         device=x.device,
                         dtype=torch.float32)
    return x_q, scales

def per_token_group_quant_int8_mock(
    x: torch.Tensor,
    group_size: int,
    eps: float = 1e-10,
    dtype: torch.dtype = torch.int8,
):
    x_q = torch.zeros_like(x, device=x.device, dtype=dtype)
    x_s = torch.zeros(
        x.shape[:-1] + (x.shape[-1] // group_size, ),
        device=x.device,
        dtype=torch.float32,
    )
    return x_q, x_s

def w8a8_block_int8_matmul_mock(
    A: torch.Tensor,
    B: torch.Tensor,
    As: torch.Tensor,
    Bs: torch.Tensor,
    block_size: list[int],
    output_dtype: torch.dtype = torch.float16,
):
    N, K = B.shape
    C_shape = A.shape[:-1] + (N, )
    C = A.new_empty(C_shape, dtype=output_dtype)
    return C


def varlen_fwd_mock(q, k, v, out, cu_seqlens_q, cu_seqlens_k, seqused_k,
                    _unused1, block_table, alibi_slopes, max_seqlen_q,
                    max_seqlen_k, dropout_p, softmax_scale, _unused2,
                    causal, real_window_size_0, real_window_size_1,
                    softcap, return_softmax_lse, _unused3):
    """dropout_p should be set to 0.0 during evaluation
    Supports multi-query and grouped-query attention (MQA/GQA) by passing in K, V with fewer heads
    than Q. Note that the number of heads in Q must be divisible by the number of heads in KV.
    For example, if Q has 6 heads and K, V have 2 heads, head 0, 1, 2 of Q will attention to head
    0 of K, V, and head 3, 4, 5 of Q will attention to head 1 of K, V.

    If causal=True, the causal mask is aligned to the bottom right corner of the attention matrix.
    For example, if seqlen_q = 2 and seqlen_k = 5, the causal mask (1 = keep, 0 = masked out) is:
        1 1 1 1 0
        1 1 1 1 1
    If seqlen_q = 5 and seqlen_k = 2, the causal mask is:
        0 0
        0 0
        0 0
        1 0
        1 1
    If the row of the mask is all zero, the output will be zero.

    If window_size != (-1, -1), implements sliding window local attention. Query at position i
    will only attend to keys between
    [i + seqlen_k - seqlen_q - window_size[0], i + seqlen_k - seqlen_q + window_size[1]] inclusive.

    Arguments:
        q: (total_q, nheads, headdim), where total_q = total number of query tokens in the batch.
        k: (total_k, nheads_k, headdim), where total_k = total number of key tokens in the batch.
        v: (total_k, nheads_k, headdim), where total_k = total number of key tokens in the batch.
        cu_seqlens_q: (batch_size + 1,), dtype torch.int32. The cumulative sequence lengths
           of the sequences in the batch, used to index into q.
        cu_seqlens_k: (batch_size + 1,), dtype torch.int32. The cumulative sequence lengths
           of the sequences in the batch, used to index into kv.
        max_seqlen_q: int. Maximum query sequence length in the batch.
        max_seqlen_k: int. Maximum key sequence length in the batch.
        dropout_p: float. Dropout probability.
        softmax_scale: float. The scaling of QK^T before applying softmax.
            Default to 1 / sqrt(headdim).
        causal: bool. Whether to apply causal attention mask (e.g., for auto-regressive modeling).
        window_size: (left, right). If not (-1, -1), implements sliding window local attention.
        softcap: float. Anything > 0 activates softcapping attention.
        alibi_slopes: (nheads,) or (batch_size, nheads), fp32. A bias of
            (-alibi_slope * |i + seqlen_k - seqlen_q - j|)
            is added to the attention score of query i and key j.
        deterministic: bool. Whether to use the deterministic implementation of the backward pass,
            which is slightly slower and uses more memory. The forward pass is always deterministic.
        return_attn_probs: bool. Whether to return the attention probabilities. This option is for
           testing only. The returned probabilities are not guaranteed to be correct
           (they might not have the right scaling).
    Return:
        out: (total, nheads, headdim).
        softmax_lse [optional, if return_softmax_lse=True]: (nheads, total_q_seqlen). The
            logsumexp of each row of the matrix QK^T * scaling (e.g., log of the softmax
            normalization factor).
    """
    total_q, nheads, headdim = q.shape
    if out is None:
        out = torch.zeros_like(q)

    # if return_softmax_lse:
    #     # total_q_seqlen = cu_seqlens_q[-1].item() if cu_seqlens_q.numel() > 0 else 0
    #     # softmax_lse = torch.zeros((nheads, total_q_seqlen), dtype=q.dtype, device=q.device)
    #     softmax_lse = torch.zeros((nheads, total_q), dtype=q.dtype, device=q.device)
    # else:
    #     softmax_lse = None
    
    softmax_lse = torch.zeros((nheads, total_q), dtype=q.dtype, device=q.device)
    
    return out, softmax_lse

def fa3_fwd_mock(q, k, v,
                 k_new, v_new,
                 q_v,
                 out,
                 cu_seqlens_q,
                 cu_seqlens_k,
                 cu_seqlens_k_new,
                 seqused_q, seqused_k,
                 max_seqlen_q, max_seqlen_k,
                 block_table,
                 kv_batch_idx,
                 leftpad_k,
                 rotary_cos, rotary_sin, seqlens_rotary,
                 q_descale, k_descale, v_descale,
                 softmax_scale,
                 causal,
                 real_window_size_0, real_window_size_1,
                 softcap,
                 rotary_interleaved,
                 scheduler_metadata,
                 num_splits,
                 pack_gqa,
                 sm_margin):
    if out is None:
        out = torch.zeros_like(q)

    batch_size, seqlen_q, num_heads, head_size = q.shape
    softmax_lse = torch.zeros((batch_size, num_heads, seqlen_q), dtype=q.dtype, device=q.device)

    return out, softmax_lse, None, None

def fwd_kvcache_mock(q, k_cache, v_cache,
                    k_new, v_new,
                    cache_seqlens,
                    rotary_cos,
                    rotary_sin,
                    cache_batch_idx,
                    cache_leftpad,
                    block_table,
                    alibi_slopes,
                    out,
                    softmax_scale,
                    causal,
                    window_size_0,
                    window_size_1,
                    softcap,
                    rotary_interleaved,
                    num_splits,
                ):
    """
    Arguments:
        q: (batch_size, seqlen, nheads, headdim)
        k_cache: (batch_size_cache, seqlen_cache, nheads_k, headdim) if there's no block_table,
            or (num_blocks, page_block_size, nheads_k, headdim) if there's a block_table (i.e. paged KV cache)
            page_block_size must be a multiple of 256.
        v_cache: (batch_size_cache, seqlen_cache, nheads_k, headdim) if there's no block_table,
            or (num_blocks, page_block_size, nheads_k, headdim) if there's a block_table (i.e. paged KV cache)
        k [optional]: (batch_size, seqlen_new, nheads_k, headdim). If not None, we concatenate
            k with k_cache, starting at the indices specified by cache_seqlens.
        v [optional]: (batch_size, seqlen_new, nheads_k, headdim). Similar to k.
        rotary_cos [optional]: (seqlen_ro, rotary_dim / 2). If not None, we apply rotary embedding
            to k and q. Only applicable if k and v are passed in. rotary_dim must be divisible by 16.
        rotary_sin [optional]: (seqlen_ro, rotary_dim / 2). Similar to rotary_cos.
        cache_seqlens: int, or (batch_size,), dtype torch.int32. The sequence lengths of the
            KV cache.
        block_table [optional]: (batch_size, max_num_blocks_per_seq), dtype torch.int32.
        cache_batch_idx: (batch_size,), dtype torch.int32. The indices used to index into the KV cache.
            If None, we assume that the batch indices are [0, 1, 2, ..., batch_size - 1].
            If the indices are not distinct, and k and v are provided, the values updated in the cache
                 might come from any of the duplicate indices.
        softmax_scale: float. The scaling of QK^T before applying softmax.
            Default to 1 / sqrt(headdim).
        causal: bool. Whether to apply causal attention mask (e.g., for auto-regressive modeling).
        window_size: (left, right). If not (-1, -1), implements sliding window local attention.
        softcap: float. Anything > 0 activates softcapping attention.
        rotary_interleaved: bool. Only applicable if rotary_cos and rotary_sin are passed in.
            If True, rotary embedding will combine dimensions 0 & 1, 2 & 3, etc. If False,
            rotary embedding will combine dimensions 0 & rotary_dim / 2, 1 & rotary_dim / 2 + 1
            (i.e. GPT-NeoX style).
        alibi_slopes: (nheads,) or (batch_size, nheads), fp32. A bias of
            (-alibi_slope * |i + seqlen_k - seqlen_q - j|)
            is added to the attention score of query i and key j.
        num_splits: int. If > 1, split the key/value into this many chunks along the sequence.
           If num_splits == 1, we don't split the key/value. If num_splits == 0, we use a heuristic
           to automatically determine the number of splits.
           Don't change this unless you know what you are doing.
        return_softmax_lse: bool. Whether to return the logsumexp of the attention scores.

    Return:
        out: (batch_size, seqlen, nheads, headdim).
        softmax_lse [optional, if return_softmax_lse=True]: (batch_size, nheads, seqlen). The
            logsumexp of each row of the matrix QK^T * scaling (e.g., log of the softmax
            normalization factor).
    """
    if out is None:
        out = torch.zeros_like(q)
    
    batch_size, seqlen, nheads, headdim = q.shape
    softmax_lse = torch.zeros((batch_size, nheads, seqlen), dtype=q.dtype, device=q.device)

    return out, softmax_lse

def get_mla_metadata_mock(
    cache_seqlens: torch.Tensor,
    num_heads_per_head_k: int,
    num_heads_k: int,
):
    """
    Arguments:
        cache_seqlens: (batch_size), dtype torch.int32.
        num_heads_per_head_k: Equals to seq_len_q * num_heads_q // num_heads_k.
        num_heads_k: num_heads_k.

    Return:
        tile_scheduler_metadata: (num_sm_parts, TileSchedulerMetaDataSize), 
                                 dtype torch.int32.
        num_splits: (batch_size + 1), dtype torch.int32.
    """
    sm_count = 80 # multiProcessorCount
    cdiv_head = (num_heads_per_head_k + 64 - 1) / 64
    num_sm_parts = int (sm_count / num_heads_k / cdiv_head) 
    batch_size = cache_seqlens.shape[0]
    tile_scheduler_metadata = torch.zeros((num_sm_parts, 8), dtype=torch.int32, device=cache_seqlens.device)
    num_splits = torch.zeros((batch_size + 1,), dtype=torch.int32, device=cache_seqlens.device)

    return tile_scheduler_metadata, num_splits

def fwd_kvcache_mla_mock(
    q: torch.Tensor,
    k_cache: torch.Tensor,
    unused,
    head_dim_v: int,
    cache_seqlens: torch.Tensor,
    block_table: torch.Tensor,
    softmax_scale,
    causal: bool,
    tile_scheduler_metadata: torch.Tensor,
    num_splits: torch.Tensor,
):
    """
    Arguments:
        q: (batch_size, seq_len_q, num_heads_q, head_dim).
        k_cache: (num_blocks, page_block_size, num_heads_k, head_dim).
        block_table: (batch_size, max_num_blocks_per_seq), torch.int32.
        cache_seqlens: (batch_size), torch.int32.
        head_dim_v: Head_dim of v.
        tile_scheduler_metadata: (num_sm_parts, TileSchedulerMetaDataSize), 
                                 torch.int32, return by get_mla_metadata.
        num_splits: (batch_size + 1), torch.int32, return by get_mla_metadata.
        softmax_scale: float. The scaling of QK^T before applying softmax. 
                       Default to 1 / sqrt(head_dim).
        causal: bool. Whether to apply causal attention mask.

    Return:
        out: (batch_size, seq_len_q, num_heads_q, head_dim_v).
        softmax_lse: (batch_size, num_heads_q, seq_len_q), torch.float32.
    """
    batch_size, seq_len_q, num_heads_q, head_dim = q.shape
    out = torch.zeros((batch_size, seq_len_q, num_heads_q, head_dim_v), dtype=q.dtype, device=q.device)
    softmax_lse = torch.zeros((batch_size, num_heads_q, seq_len_q), dtype=torch.float32, device=q.device)
    return out, softmax_lse
