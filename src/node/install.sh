#!/usr/bin/env bash
# shellcheck disable=SC1091
set -eu

nodeVersion="$VERSION"

source /usr/local/bin/common-utils.sh
source /etc/os-release
os="${ID_LIKE:-$ID}"

if echo "$os" | grep -qE "debian"; then
  apt-get update
  apt-get install --yes --no-install-recommends curl gpgv xz-utils
elif echo "$os" | grep -qE "fedora|rhel"; then
  cmd=$(command -v dnf || command -v microdnf)
  "$cmd" install --assumeyes curl gnupg tar xz
else
  echo "$os not supported"
  exit 1
fi

case $(uname -m) in
x86_64 | x64) architecture="x64" ;;
arm64 | aarch64) architecture="arm64" ;;
esac

download "https://nodejs.org/dist/v$nodeVersion/node-v$nodeVersion-linux-$architecture.tar.xz"
download "https://nodejs.org/dist/v$nodeVersion/SHASUMS256.txt.asc"

# Keyring source: https://raw.githubusercontent.com/nodejs/release-keys/refs/heads/main/gpg/pubring.kbx
gpgv --keyring="$PWD/pubring.kbx" --output SHA256SUMS <SHASUMS256.txt.asc
archive=$(test_file_hash)

tar xf "$archive"
folder=$(basename --suffix=.tar.xz "$archive")
rm "$archive"

find /usr/local -maxdepth 1 -type f -exec rm {} \;
cp -a "$folder/." /usr/local/
rm -rf "$folder"
