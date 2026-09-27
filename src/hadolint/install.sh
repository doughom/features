#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url hadolint/hadolint "$TAG")
filename=$(download "$url")
mv "$filename" "$TAG-$filename"
filename=$(test_file_hash)

install "$filename" /usr/local/bin/hadolint
