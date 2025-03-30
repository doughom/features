#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url koalaman/shellcheck "$TAG")
download "$url" localFile

if [[ "$HASH" != "none" ]]; then
  test_file_hash localFile "$HASH"
fi

tar xf localFile
find . -type f -name shellcheck -exec install {} /usr/local/bin/shellcheck \;
