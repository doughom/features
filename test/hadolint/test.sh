#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source dev-container-features-test-lib
check "version" hadolint --version
reportResults
