#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url mvdan/sh "$TAG")
download "$url"
filename=$(test_file_hash)

install "$filename" /usr/local/bin/shfmt
