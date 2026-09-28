#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source dev-container-features-test-lib
check "pip-compile" pip-compile --version
check "pip-sync" pip-sync --version
reportResults
