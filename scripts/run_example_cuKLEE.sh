#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXAMPLES_DIR="$PROJECT_DIR/examples"
JSON_FILE="$EXAMPLES_DIR/dynamic_scaled_fp8_quant.json"
LOG_FILE="$EXAMPLES_DIR/dynamic_scaled_fp8_quant_log.txt"

python3 -c 'import json, pathlib, sys
project_dir = pathlib.Path(sys.argv[1])
json_file = pathlib.Path(sys.argv[2])
run_json = pathlib.Path(sys.argv[3])
data = json.loads(json_file.read_text())
for entry in data:
    input_path = entry.get("input_file_path")
    if input_path and input_path.startswith("examples/"):
        entry["input_file_path"] = str(project_dir / input_path)
run_json.write_text(json.dumps(data, indent=4) + "\n")
' "$PROJECT_DIR" "$JSON_FILE" "$JSON_FILE"

cuKLEE --timeout=3600 --output-dir="$EXAMPLES_DIR" "$JSON_FILE" >"$LOG_FILE" 2>&1
