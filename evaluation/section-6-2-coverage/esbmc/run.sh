#!/usr/bin/env bash
set -euo pipefail

tool_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
benchmark_dir="$tool_dir/../benchmarks/esbmc-simplified"
output_dir="$tool_dir/results"
image="${ESBMC_IMAGE:-esbmc}"
target="${1:-all}"

if [[ "${SKIP_BUILD:-0}" != 1 ]]; then
  docker build -t "$image" "$tool_dir/docker/esbmc"
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
(( ${#files[@]} )) || { echo "No ESBMC inputs matched: $TARGET" >&2; exit 1; }

failures=0
for source in "${files[@]}"; do
  [[ -f "$source" ]] || { echo "Input not found: $source" >&2; exit 1; }
  name="$(basename "$source" .cu)"
  echo "[$name] running ESBMC"
  if timeout "$TIMEOUT" esbmc "$source" >"/results/$name.log" 2>&1; then
    :
  else
    status=$?
    echo "[$name] ESBMC exited with status $status (see /results/$name.log)" >&2
    if [[ $status -ne 1 ]]; then
      failures=$((failures + 1))
    fi
  fi
done
(( failures == 0 ))
EOF

echo "ESBMC results: $output_dir"
