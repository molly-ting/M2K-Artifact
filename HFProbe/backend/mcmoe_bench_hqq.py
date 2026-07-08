# mcm_bench_hqq.py
# Purpose: trigger HQQ dequant/unpack frontends (generic + suffix) under fake CUDA,
#          with realistic packed shapes and 3D dequant output (B,S,H).

import os
import math
import argparse
import torch

# Will be intercepted by your cpp_load_mcm mock
import hqq_aten  # noqa: F401

def r_by_nbits(nbits: int) -> int:
    """
    Packing ratio r: how many logical values are contained per 'packed row' element.
      - 8bit u8   : r=1   -> packed_rows = H / 1
      - 4bit u8   : r=2   -> packed_rows = H / 2
      - 2bit u8   : r=4   -> packed_rows = H / 4
      - 1bit u8   : r=8   -> packed_rows = H / 8
      - 3bit int32: r=10  -> packed_rows = H / 10
    """
    if nbits == 8:
        return 1
    if nbits == 4:
        return 2
    if nbits == 2:
        return 4
    if nbits == 1:
        return 8
    if nbits == 3:
        return 10
    raise ValueError(f"Unsupported nbits={nbits}")

def dtype_for_packed(nbits: int):
    return torch.int32 if nbits == 3 else torch.uint8

def packing_tag(nbits: int) -> str:
    return "int32" if nbits == 3 else "u8"

def build_packed_weight(H: int, S: int, nbits: int, device: torch.device):
    """
    Build a packed Wq of shape (H//r, S) with the proper integer dtype.
    """
    r = r_by_nbits(nbits)
    assert H % r == 0, f"H={H} must be divisible by packing ratio r={r} for nbits={nbits}"
    h_packed = H // r
    dt = dtype_for_packed(nbits)
    # Random integers in valid range (0..255 for u8; 32-bit int arbitrary for 3-bit demo)
    if dt == torch.uint8:
        Wq = torch.randint(0, 256, (h_packed, S), dtype=dt, device=device)
    else:
        # 3-bit in int32 packing; values are bitfields, but for mock占位随意
        Wq = torch.randint(-(2**30), 2**30 - 1, (h_packed, S), dtype=dt, device=device)
    return Wq

def consume_out_any(out: torch.Tensor):
    """
    Use the tensor to avoid dead-code elimination and keep dtype/device sane.
    - If 3D (B,S,H): take batch 0 -> (S,H) -> transpose to (H,S) and do mv in fp32.
    - If 2D (H,S): do mv in fp32.
    - If integer/byte (e.g., unpack outputs): just do sum().
    """
    if out.dtype.is_floating_point:
        if out.dim() == 3:
            out2d = out[0].transpose(0, 1).contiguous()  # (S,H)->(H,S)
        elif out.dim() == 2:
            out2d = out
        else:
            # Fallback: flatten and sum
            _ = out.float().sum()
            return
        out2d_fp32 = out2d.float()
        M, N = out2d_fp32.shape
        x = torch.randn(N, dtype=out2d_fp32.dtype, device=out2d_fp32.device)
        y = torch.mv(out2d_fp32, x)
        _ = y.sum()
    else:
        _ = out.sum()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--nbits", type=int, default=4, choices=[1, 2, 3, 4, 8], help="quantization bit width")
    parser.add_argument("--group_size", type=int, default=64)
    parser.add_argument("--device", type=str, default="cuda")
    parser.add_argument("--B_list", type=str, default="1,8,32")
    parser.add_argument("--S_list", type=str, default="4096,5120,8192")
    parser.add_argument("--layers", type=int, default=2, help="repeat loops to emulate multiple layers")
    parser.add_argument("--scale_dtype", type=str, default="f16", choices=["f16", "f32", "bf16"])
    args = parser.parse_args()

    DEV = torch.device(args.device)
    NBITS = args.nbits
    GROUP_SIZE = args.group_size
    AXIS = 0  # per-column (j=i%w) in kernels; consistent with scale/zero of shape (S,)
    PACKING = packing_tag(NBITS)

    # choose dtype for scales/zeros (kernel expects same floating dtype as output)
    if args.scale_dtype == "f16":
        scale_dtype = torch.float16
    elif args.scale_dtype == "f32":
        scale_dtype = torch.float32
    else:
        scale_dtype = torch.bfloat16

    B_list = [int(x) for x in args.B_list.split(",") if x]
    S_list = [int(x) for x in args.S_list.split(",") if x]

    print(f"[BENCH] nbits={NBITS}, group_size={GROUP_SIZE}, B_list={B_list}, S_list={S_list}, device={DEV}")

    torch.manual_seed(0)

    for _layer in range(args.layers):
        for B in B_list:
            for S in S_list:
                # In dense linear, H often equals hidden dim; we set H=S for bench
                H = S

                # --- build packed weights & per-column scales/zeros ---
                Wq = build_packed_weight(H, S, NBITS, DEV)
                scale = torch.randn(S, dtype=scale_dtype, device=DEV).abs() + 1e-3  # positive scales
                zero = torch.zeros(S, dtype=scale_dtype, device=DEV)

                # --- generic dequantize: target (B,S,H) ---
                shape_3d = (B, S, H)
                out = hqq_aten.dequantize(Wq, scale, zero, shape_3d, GROUP_SIZE, NBITS, AXIS, PACKING)
                consume_out_any(out)

                # --- suffix frontends: build expected 2D outputs and consume ---
                # They ignore group_size in these unit ops; we pass what kernels expect.
                if NBITS == 8:
                    out8 = hqq_aten.dequantize_8bit_u8(Wq, scale, zero)
                    consume_out_any(out8)
                elif NBITS == 4:
                    up4 = hqq_aten.unpack_4bit_u8(Wq)
                    consume_out_any(up4)
                    deq4 = hqq_aten.dequantize_4bit_u8(Wq, scale, zero)
                    consume_out_any(deq4)
                elif NBITS == 3:
                    up3 = hqq_aten.unpack_3bit_32(Wq)
                    consume_out_any(up3)
                    deq3 = hqq_aten.dequantize_3bit_32(Wq, scale, zero)
                    consume_out_any(deq3)
                elif NBITS == 2:
                    up2 = hqq_aten.unpack_2bit_u8(Wq)
                    consume_out_any(up2)
                    deq2 = hqq_aten.dequantize_2bit_u8(Wq, scale, zero)
                    consume_out_any(deq2)
                elif NBITS == 1:
                    up1 = hqq_aten.unpack_1bit_u8(Wq)
                    consume_out_any(up1)
                    deq1 = hqq_aten.dequantize_1bit_u8(Wq, scale, zero)
                    consume_out_any(deq1)

    print("done.")

if __name__ == "__main__":
    # In case fake CUDA needs environment hints
    os.environ.setdefault("LOCAL_ONLY", "1")
    main()
