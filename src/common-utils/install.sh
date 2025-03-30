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

install_rhel_packages() {
  local packages="\
        gzip \
        jq \
        tar \
        unzip \
        xz"

  local pkgMgr
  if ! pkgMgr=$(command -v dnf); then
    pkgMgr=$(command -v microdnf)
  fi

  # shellcheck disable=SC2086
  "$pkgMgr" install --assumeyes $packages
}

# shellcheck disable=SC1091
source /etc/os-release
case $ID in
debian | ubuntu) install_debian_packages ;;
almalinux | centos | fedora | rhel | rocky) install_rhel_packages ;;
*) echo "$ID is not yet supported" && exit 1 ;;
esac

cp common-utils.sh /usr/local/bin/
