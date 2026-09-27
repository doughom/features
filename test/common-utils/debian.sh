#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source dev-container-features-test-lib
source /usr/local/bin/common-utils.sh

check "Get GitHub Asset URL" get_github_asset_url github/gh-ost v1.1.7 | grep -q "^https://github.com/"
check "Empty file hash" test_file_hash "$(mktemp)" e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

reportResults
