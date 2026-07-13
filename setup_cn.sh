#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/" && pwd)"
DEPS_DIR="${PROJECT_DIR}/.deps"
VENV_DIR="${PROJECT_DIR}/.venv"
CUKLEE_BUILD_DIR="${PROJECT_DIR}/cuKLEE/build"
LLVM_PROJECT_DIR="${DEPS_DIR}/llvm-project"
Z3_DIR="${DEPS_DIR}/z3"
Z3_REF="z3-4.12.2"

GITHUB_PROXY="https://ghfast.top/https://github.com"
PYPI_INDEX_URL="https://mirrors.aliyun.com/pypi/simple/"
PYTORCH_INDEX_URL="https://mirrors.aliyun.com/pytorch-wheels/cu126"
LLVM_APT_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/llvm-apt"

APT_PACKAGES=(
  tzdata
  g++
  gcc
  make
  cmake
  git
  ninja-build
  wget
  curl
  lld
  python3
  python3-pip
  python3-venv
  python3.10-venv
  software-properties-common
  lldb-13
  gdb
  file
  git-lfs
  g++-multilib
  gcc-multilib
  libcap-dev
  libgoogle-perftools-dev
  libncurses5-dev
  libsqlite3-dev
  libtcmalloc-minimal4
  unzip
  graphviz
  doxygen
  python3-tabulate
  clang-13
  llvm-13
  llvm-13-dev
  llvm-13-tools
  gnupg2
  lsb-release
  nano
)

PIP_PACKAGES=(
  lit
  wllvm
)

log() {
  printf '[setup_cn] %s\n' "$*"
}

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

sudo_cmd() {
  if [[ "${EUID}" -eq 0 ]]; then
    "$@"
  else
    sudo "$@"
  fi
}

apt_is_installed() {
  dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q 'install ok installed'
}

require_ubuntu_apt() {
  if ! have_cmd apt-get || ! have_cmd dpkg-query; then
    printf 'This setup script expects an Ubuntu/Debian apt environment.\n' >&2
    exit 1
  fi
}

ensure_universe_repo() {
  if apt-cache policy | grep -q 'universe'; then
    return
  fi

  log 'Enabling Ubuntu universe repository'
  sudo_cmd add-apt-repository -y universe
}

ensure_llvm_repo() {
  if apt-cache policy clang-13 | grep -q 'Candidate: [^(]'; then
    return
  fi

  local codename
  codename="$(lsb_release -cs)"

  log "Adding Tsinghua LLVM mirror for ${codename}"
  curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key \
    | sudo_cmd tee /usr/share/keyrings/llvm-snapshot.gpg.key >/dev/null

  printf 'deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg.key] %s/%s/ llvm-toolchain-%s-13 main\n' \
    "${LLVM_APT_MIRROR}" "${codename}" "${codename}" \
    | sudo_cmd tee /etc/apt/sources.list.d/llvm-toolchain-13.list >/dev/null

  sudo_cmd apt-get update
}

install_apt_packages() {
  require_ubuntu_apt
  ensure_universe_repo
  sudo_cmd apt-get update
  ensure_llvm_repo

  local missing=()
  local pkg
  for pkg in "${APT_PACKAGES[@]}"; do
    if ! apt_is_installed "${pkg}"; then
      missing+=("${pkg}")
    fi
  done

  if ((${#missing[@]} == 0)); then
    log 'All Dockerfile apt packages are already installed'
    return
  fi

  log "Installing missing apt packages: ${missing[*]}"
  sudo_cmd env DEBIAN_FRONTEND=noninteractive apt-get install -y "${missing[@]}"
}

install_global_pip_packages() {
  local missing=()
  local pkg
  for pkg in "${PIP_PACKAGES[@]}"; do
    if ! python3 -m pip show "${pkg}" >/dev/null 2>&1; then
      missing+=("${pkg}")
    fi
  done

  if ((${#missing[@]} == 0)); then
    log 'Dockerfile pip packages are already installed'
    return
  fi

  log "Installing Dockerfile pip packages: ${missing[*]}"
  if ! python3 -m pip install --user -i "${PYPI_INDEX_URL}" "${missing[@]}"; then
    python3 -m pip install --user --break-system-packages -i "${PYPI_INDEX_URL}" "${missing[@]}"
  fi
}

ensure_z3() {
  if ldconfig -p 2>/dev/null | grep -q 'libz3\.so' && python3 -c 'import z3' >/dev/null 2>&1; then
    log 'Z3 is already installed'
    return
  fi

  mkdir -p "${DEPS_DIR}"
  if [[ ! -d "${Z3_DIR}/.git" ]]; then
    log "Cloning Z3 ${Z3_REF}"
    git clone --depth 1 --branch "${Z3_REF}" \
      "${GITHUB_PROXY}/Z3Prover/z3.git" "${Z3_DIR}"
  else
    log "Checking out Z3 ${Z3_REF}"
    git -C "${Z3_DIR}" fetch --depth 1 origin \
      "refs/tags/${Z3_REF}:refs/tags/${Z3_REF}"
    git -C "${Z3_DIR}" checkout --detach "${Z3_REF}"
    git -C "${Z3_DIR}" reset --hard "${Z3_REF}"
    git -C "${Z3_DIR}" clean -fdx
  fi

  if [[ ! -f "${Z3_DIR}/build/libz3.so" ]]; then
    log 'Building Z3'
    (cd "${Z3_DIR}" && python3 scripts/mk_make.py && make -C build -j"$(nproc)")
  fi

  log 'Installing Z3'
  sudo_cmd make -C "${Z3_DIR}/build" install
}

ensure_signed_clang() {
  if [[ -x "${LLVM_PROJECT_DIR}/build/bin/clang" ]]; then
    log 'Signed clang is already built'
    return
  fi

  mkdir -p "${DEPS_DIR}"
  if [[ ! -d "${LLVM_PROJECT_DIR}/.git" ]]; then
    log 'Cloning signed LLVM project'
    git clone --depth 1 --branch signed \
      "${GITHUB_PROXY}/molly-ting/llvm-project.git" "${LLVM_PROJECT_DIR}"
  fi

  log 'Checking out signed LLVM branch'
  git -C "${LLVM_PROJECT_DIR}" checkout signed

  log 'Building signed clang'
  cmake -S "${LLVM_PROJECT_DIR}/llvm" \
    -B "${LLVM_PROJECT_DIR}/build" \
    -DLLVM_ENABLE_PROJECTS=clang \
    -DCMAKE_BUILD_TYPE=Release
  cmake --build "${LLVM_PROJECT_DIR}/build" \
    --target clang \
    --parallel "$(nproc)"

  if [[ ! -x "${LLVM_PROJECT_DIR}/build/bin/clang++" ]]; then
    printf 'Signed clang build did not produce %s\n' \
      "${LLVM_PROJECT_DIR}/build/bin/clang++" >&2
    exit 1
  fi
}

create_python_venv() {
  if [[ ! -d "${VENV_DIR}" ]]; then
    log "Creating Python virtual environment at ${VENV_DIR}"
    python3.10 -m venv "${VENV_DIR}"
  else
    log 'Python virtual environment already exists'
  fi

  log 'Installing Python build tools'
  "${VENV_DIR}/bin/python" -m pip install --no-cache-dir --progress-bar on \
    -i "${PYPI_INDEX_URL}" \
    --upgrade pip setuptools wheel packaging psutil

  log 'Installing CUDA PyTorch packages'
  "${VENV_DIR}/bin/python" -m pip install --no-cache-dir --progress-bar on \
    --index-url "${PYTORCH_INDEX_URL}" \
    torch==2.7.0 torchvision==0.22.0 torchaudio==2.7.0

  "${VENV_DIR}/bin/python" -m pip install --no-cache-dir --progress-bar on \
    -i "${PYPI_INDEX_URL}" \
    --prefer-binary \
    -r "${PROJECT_DIR}/requirements.txt"
  "${VENV_DIR}/bin/python" -m pip check
}

ensure_artifact_lfs() {
  log 'Fetching Git LFS files'
  git -C "${PROJECT_DIR}" lfs pull

  log 'Validating bundled LLVM bitcode'
  llvm-dis-13 "${PROJECT_DIR}/example/fp8_common_combined.bc" -o /dev/null
}

build_cuklee() {
  log 'Configuring cuKLEE'
  cmake -S "${PROJECT_DIR}/cuKLEE" -B "${CUKLEE_BUILD_DIR}" -DLLVM_DIR=/usr/lib/llvm-13/lib/cmake/llvm

  log 'Building cuKLEE'
  cmake --build "${CUKLEE_BUILD_DIR}" -j"$(nproc)"
}

main() {
  cd "${PROJECT_DIR}"

  install_apt_packages
  install_global_pip_packages
  ensure_z3
  ensure_signed_clang
  ensure_artifact_lfs
  create_python_venv
  build_cuklee

  log 'Setup complete'
  log 'Run this before using the artifact: source env.sh'
}

main "$@"
