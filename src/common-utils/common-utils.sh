#!/usr/bin/env bash
set -euo pipefail
set -o posix

get_github_asset_url() {
  local repo="$1"
  local tag="$2"

  # jq filters for asset name (usually similar to name_1.1_linux_amd64.tar.gz)
  local architecture
  local linux="(test(\"Linux|linux\"))"
  local notFileHash="(endswith(\"sha256\") | not)"

  case $(uname -m) in
  x86_64 | x64) architecture="(test(\"amd64|x86_64|x64\"))" ;;
  arm64 | aarch64) architecture="(test(\"arm64|aarch64\"))" ;;
  esac

  local filter=".assets[] | select(.name | $linux and $architecture and $notFileHash) | .browser_download_url"
  local response
  local url

  if [ "$tag" == "latest" ]; then
    response=$(curl --retry 3 --max-time 30 --show-error --silent "https://api.github.com/repos/$repo/releases/latest")
  else
    response=$(curl --retry 3 --max-time 30 --show-error --silent "https://api.github.com/repos/$repo/releases/tags/$tag")
  fi

  url=$(echo "$response" | jq --raw-output "$filter")

  if [ -n "$url" ]; then
    echo "$url"
  else
    echo "ERROR: Could not find download URL with $filter"
    return 1
  fi
}

download() {
  local src="$1"
  local dest="$2"

  curl \
    --connect-timeout 5 --max-time 120 \
    --retry 3 --retry-connrefused --retry-max-time 30 \
    --show-error --silent \
    --output "$dest" \
    --location "$src"
}

test_file_hash() {
  local filePath="$1"
  local expectedHash="$2"

  fileHash=$(sha256sum "$filePath" | awk '{print $1}')
  if echo "$expectedHash" | grep -q "$fileHash"; then
    echo "OK"
  else
    echo "ERROR: hash mismatch $fileHash"
    return 1
  fi
}
