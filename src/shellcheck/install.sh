#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source /usr/local/bin/common-utils.sh

url=$(get_github_asset_url koalaman/shellcheck "$TAG" | grep 'tar.xz$')
download "$url"
filename=$(test_file_hash)

tar xf "$filename"
find . -type f -name shellcheck -exec install {} /usr/local/bin/shellcheck \;
