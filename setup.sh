#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/" && pwd)"
DEPS_DIR="${PROJECT_DIR}/.deps"
VENV_DIR="${PROJECT_DIR}/.venv"
CUKLEE_BUILD_DIR="${PROJECT_DIR}/cuKLEE/build"
LLVM_PROJECT_DIR="${DEPS_DIR}/llvm-project"
Z3_DIR="${DEPS_DIR}/z3"
Z3_REF="z3-4.12.2"

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
  printf '[setup] %s\n' "$*"
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

  log "Adding apt.llvm.org repository for ${codename}"
  curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key \
    | sudo_cmd tee /usr/share/keyrings/llvm-snapshot.gpg.key >/dev/null

  printf 'deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg.key] http://apt.llvm.org/%s/ llvm-toolchain-%s-13 main\n' \
    "${codename}" "${codename}" \
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
  if ! python3 -m pip install --user "${missing[@]}"; then
    python3 -m pip install --user --break-system-packages "${missing[@]}"
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
      https://github.com/Z3Prover/z3.git "${Z3_DIR}"
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
      https://github.com/molly-ting/llvm-project.git "${LLVM_PROJECT_DIR}"
  fi

  log 'Checking out signed LLVM branch'
  git -C "${LLVM_PROJECT_DIR}" checkout signed

  log 'Building signed clang'
  cmake -S "${LLVM_PROJECT_DIR}/llvm" -B "${LLVM_PROJECT_DIR}/build"
  cmake --build "${LLVM_PROJECT_DIR}/build" -j"$(nproc)"
}

create_python_venv() {
  if [[ ! -d "${VENV_DIR}" ]]; then
    log "Creating Python virtual environment at ${VENV_DIR}"
    python3.10 -m venv "${VENV_DIR}"
  else
    log 'Python virtual environment already exists'
  fi

  log 'Installing Python requirements'
  "${VENV_DIR}/bin/python" -m pip install --upgrade pip

  log 'Installing CPU PyTorch packages'
  "${VENV_DIR}/bin/python" -m pip install --no-cache-dir --progress-bar on \
    https://mirrors.aliyun.com/pytorch-wheels/cpu/torch-2.7.0%2Bcpu-cp310-cp310-manylinux_2_28_x86_64.whl \
    https://mirrors.aliyun.com/pytorch-wheels/cpu/torchvision-0.22.0%2Bcpu-cp310-cp310-manylinux_2_28_x86_64.whl \
    https://mirrors.aliyun.com/pytorch-wheels/cpu/torchaudio-2.7.0%2Bcpu-cp310-cp310-manylinux_2_28_x86_64.whl

  local cpu_requirements
  cpu_requirements="${VENV_DIR}/requirements.cpu.txt"
  grep -Ev '^(torch|flash_attn|triton|bitblas|tvm|bitsandbytes|torchao|tensorflow|flashinfer-python)' \
    "${PROJECT_DIR}/requirements.txt" >"${cpu_requirements}"

  "${VENV_DIR}/bin/python" -m pip install \
    -i https://mirrors.aliyun.com/pypi/simple/ \
    --prefer-binary \
    -r "${cpu_requirements}"
  rm -f "${cpu_requirements}"
  "${VENV_DIR}/bin/python" -m pip check
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
  create_python_venv
  build_cuklee

  log 'Setup complete'
  log 'Run this before using the artifact: source env.sh'
}

main "$@"
