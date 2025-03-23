#!/usr/bin/env bash
set -e

install_debian_packages() {
  local packages="\
        ca-certificates \
        curl \
        jq \
        unzip \
        xz-utils"

  # apt update takes a few seconds, so only run if packages are missing
  # shellcheck disable=SC2086
  if ! apt install --yes --no-install-recommends $packages; then
    apt update
    apt install --yes --no-install-recommends $packages
  fi
}

# shellcheck disable=SC1091
source /etc/os-release
case $ID in
debian | ubuntu) install_debian_packages ;;
esac

cp common-utils.sh /usr/local/bin/
