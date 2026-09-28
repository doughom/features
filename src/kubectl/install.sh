#!/usr/bin/env bash
set -e

function debian_install() {
  apt-get update
  apt-get install --yes --no-install-recommends apt-transport-https ca-certificates gnupg

  mkdir -p /etc/apt/keyrings
  keyring="/etc/apt/keyrings/kubernetes-2024.gpg"
  cat 2024.key | gpg --dearmor -o "$keyring"
  chmod 644 "$keyring"

  sourceList="/etc/apt/sources.list.d/kubernetes.list"
  echo "deb [signed-by=$keyring] https://pkgs.k8s.io/core:/stable:/v$kubectlVersion/deb/ /" | tee "$sourceList"
  chmod 644 "$sourceList"

  apt-get update
  apt-get install --yes --no-install-recommends kubectl
}

kubectlVersion="$VERSION"
# shellcheck disable=SC1091
source /etc/os-release
os="${ID_LIKE:-$ID}"

if echo "$os" | grep -qE "debian"; then
  debian_install
elif echo "$os" | grep -qE "fedora|rhel"; then
  echo "$os not implemented"
  exit 1
else
  echo "$os not supported"
  exit 1
fi
