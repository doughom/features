#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url rhysd/actionlint "$TAG")
download "$url"
filename=$(test_file_hash)

tar xf "$filename"
install actionlint /usr/local/bin/actionlint
