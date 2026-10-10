#!/usr/bin/env bash
set -e

function microsoft_source_install() {
  apt-get update
  apt-get install --yes --no-install-recommends apt-transport-https ca-certificates gnupg

  mkdir -p /etc/apt/keyrings
  keyring="/etc/apt/keyrings/microsoft-2023.gpg"
  cat 2023.key | gpg --dearmor -o "$keyring"
  chmod 644 "$keyring"

  sourceList="/etc/apt/sources.list.d/microsoft.list"
  echo "deb [signed-by=$keyring] https://packages.microsoft.com/debian/$VERSION_ID/prod $VERSION_CODENAME main" | tee "$sourceList"
  chmod 644 "$sourceList"
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

if [[ "$ID" == "debian" ]]; then
  microsoft_source_install
  debian_install
elif echo "$os" | grep -qE "debian"; then
  debian_install
elif echo "$os" | grep -qE "fedora|rhel"; then
  rhel_install
else
  echo "$os not supported"
  exit 1
fi
