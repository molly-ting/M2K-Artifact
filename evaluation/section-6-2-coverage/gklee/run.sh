#!/usr/bin/env bash
set -euo pipefail

tool_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
benchmark_dir="$tool_dir/../benchmarks/gklee-simplified"
output_dir="$tool_dir/results"
image="${GKLEE_IMAGE:-gklee}"
target="${1:-all}"

if [[ "${SKIP_BUILD:-0}" != 1 ]]; then
  docker build -t "$image" "$tool_dir/docker/gklee"
fi

mkdir -p "$output_dir"
docker run --rm -i --user "$(id -u):$(id -g)" \
  -e TARGET="$target" -e TIMEOUT="${TIMEOUT:-3600}" \
  -v "$benchmark_dir:/inputs:ro" -v "$output_dir:/results" "$image" bash -s <<'EOF'
set -euo pipefail
shopt -s nullglob
files=(/inputs/*.cu)
if [[ "$TARGET" != all ]]; then
  files=("/inputs/${TARGET%.cu}.cu")
fi
(( ${#files[@]} )) || { echo "No GKLEE inputs matched: $TARGET" >&2; exit 1; }

failures=0
for source in "${files[@]}"; do
  [[ -f "$source" ]] || { echo "Input not found: $source" >&2; exit 1; }
  name="$(basename "$source" .cu)"
  work="/results/$name"
  mkdir -p "$work"
  cp "$source" "$work/$name.cu"
  echo "[$name] compiling"
  if ! (cd "$work" && gklee-nvcc "$name.cu" -o "$name") >"$work/compile.log" 2>&1; then
    echo "[$name] compile failed (see $work/compile.log)" >&2
    failures=$((failures + 1))
    continue
  fi
  echo "[$name] running GKLEE"
  if (cd "$work" && timeout "$TIMEOUT" gklee "./$name") >"$work/gklee.log" 2>&1; then
    :
  else
    status=$?
    echo "[$name] GKLEE exited with status $status (see $work/gklee.log)" >&2
    if [[ $status -eq 124 || $status -eq 127 ]]; then
      failures=$((failures + 1))
    fi
  fi
done
(( failures == 0 ))
EOF

echo "GKLEE results: $output_dir"
