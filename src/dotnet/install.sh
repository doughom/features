#!/usr/bin/env bash
set -e

function microsoft_source_install() {
  apt-get update
  apt-get install --yes --no-install-recommends apt-transport-https ca-certificates gnupg

  mkdir -p /etc/apt/keyrings
  keyring="/etc/apt/keyrings/microsoft.gpg"
  cat 2015.key 2023.key | gpg --dearmor -o "$keyring"
  chmod 644 "$keyring"

  sourceList="/etc/apt/sources.list.d/microsoft.list"
  echo "deb [signed-by=$keyring] https://packages.microsoft.com/debian/$VERSION_ID/prod $VERSION_CODENAME main" | tee "$sourceList"
  chmod 644 "$sourceList"
}

function ppa_install() {
  if [[ "$VERSION_CODENAME" == "jammy" ]]; then
    apt-get update
    apt-get install --yes --no-install-recommends gpg-agent software-properties-common
    add-apt-repository --yes ppa:dotnet/backports
  fi
}

function debian_install() {
  apt-get update
  apt-get install --yes --no-install-recommends "dotnet-sdk-$dotnetVersion"
}

function rhel_install() {
  cmd=$(command -v dnf || command -v microdnf)
  "$cmd" install --assumeyes "dotnet-sdk-$dotnetVersion"
}

dotnetVersion="$VERSION"

# shellcheck disable=SC1091
source /etc/os-release
os="${ID_LIKE:-$ID}"
export DEBIAN_FRONTEND=noninteractive

if [[ "$ID" == "debian" ]]; then
  microsoft_source_install
  debian_install
elif echo "$os" | grep -qE "debian"; then
  ppa_install
  debian_install
elif echo "$os" | grep -qE "fedora|rhel"; then
  rhel_install
else
  echo "$os not supported"
  exit 1
fi
