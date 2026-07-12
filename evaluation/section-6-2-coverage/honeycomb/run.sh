#!/usr/bin/env bash
set -euo pipefail

tool_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
benchmark_dir="$tool_dir/../benchmarks/honeycomb-simplified"
output_dir="$tool_dir/results"
image="${HONEYCOMB_IMAGE:-honeycomb}"
target="${1:-all}"

if [[ "${SKIP_BUILD:-0}" != 1 ]]; then
  docker build -t "$image" "$tool_dir/docker/honeycamb"
fi

mkdir -p "$output_dir"
docker run --rm -i --user "$(id -u):$(id -g)" \
  -e TARGET="$target" -e TIMEOUT="${TIMEOUT:-3600}" \
  -v "$benchmark_dir:/inputs:ro" -v "$output_dir:/results" "$image" bash -s <<'EOF'
set -euo pipefail
shopt -s nullglob
descriptors=(/inputs/*.json)
if [[ "$TARGET" != all ]]; then
  descriptors=("/inputs/${TARGET%.json}.json")
fi
(( ${#descriptors[@]} )) || { echo "No Honeycomb descriptors matched: $TARGET" >&2; exit 1; }

failures=0
for descriptor in "${descriptors[@]}"; do
  [[ -f "$descriptor" ]] || { echo "Descriptor not found: $descriptor" >&2; exit 1; }
  name="$(basename "$descriptor" .json)"
  binary="/inputs/$name.hip.o"
  [[ -f "$binary" ]] || { echo "AMDGPU object not found: $binary" >&2; failures=$((failures + 1)); continue; }
  echo "[$name] running Honeycomb"
  if timeout "$TIMEOUT" validator "$binary" "$descriptor" >"/results/$name.log" 2>&1; then
    :
  else
    status=$?
    echo "[$name] Honeycomb exited with status $status (see /results/$name.log)" >&2
    if [[ $status -eq 124 || $status -eq 127 ]]; then
      failures=$((failures + 1))
    fi
  fi
done
(( failures == 0 ))
EOF

echo "Honeycomb results: $output_dir"
