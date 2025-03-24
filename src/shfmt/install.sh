#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url mvdan/sh "$TAG")
download "$url" localFile

if [[ "$HASH" != "none" ]]; then
  test_file_hash localFile "$HASH"
fi

install localFile /usr/local/bin/shfmt
