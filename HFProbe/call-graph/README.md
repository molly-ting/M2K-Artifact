## Setup
```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
$ pip install -r py/requirements.txt
```

## Usage
```bash
usage: ./x [-h] {scan,flatten} ...

positional arguments:
  {scan,flatten}
    scan          Scan a directory for python files
    flatten       Flatten a directory

options:
  -h, --help      show this help message and exit
```

### Scan Command
```bash
usage: ./x scan [-h] [--dir DIR] [--dir-dir DIR_DIR] [--out OUT] {tf,hf,vllm}

positional arguments:
  {tf,hf,vllm}       Source to scan from, can be tf (transformers), hf (huggingface) or vllm

options:
  -h, --help         show this help message and exit
  --dir DIR          Directory to scan
  --dir-dir DIR_DIR  Directory to scan for directories
  --out OUT          Output directory for scan
```

#### Examples
```bash
# Scan a Huggingface Repo
$ ./x scan --dir py/testdata/chinoll_chatsakura-3b-int4
$ ./x scan --dir py/testdata/qwen-7b
$ ./x scan --dir py/testdata/mgalkin_ultra_3g
$ ./x scan --dir py/testdata/minchul_cvlface_adaface_vit_base_kprpe_webface4m
$ ./x scan --dir py/testdata/Baichuan-7B --vllm-dir /opt/anaconda3/envs/vllm-env/lib/python3.10/site-packages/vllm
$ ./x scan --dir py/testdata/Qwen1.5-MoE-A2.7B-Chat-quantized.w4a16 --vllm-dir /opt/anaconda3/envs/vllm-env/lib/python3.10/site-packages/vllm
```

## Features
- Support extra python paths (to support models from transformers)