#!/usr/bin/env bash
# shellcheck disable=SC1091
set -e

source dev-container-features-test-lib
source /usr/local/bin/common-utils.sh

check "Get GitHub Asset URL" get_github_asset_url github/gh-ost v1.1.7 | grep -q "^https://github.com/"

url=$(get_github_asset_url github/gh-ost v1.1.7)
filename=$(download "$url")

cat <<EOF >SHA256SUMS
5bb2ed9ece5db42ae747b28585572afd9d123a45e3e916f4d93601dbf5f1d430  gh-ost
9e7c91d07ccae51c653252b8c58c148032f3785223bfa8e531eba81aa912b71a  gh-ost-1.1.7-1.x86_64.rpm
bf99e7df791e08642fbfbfefc8bd63cad55c563cd15c0741c996bb11b0f0d392  gh-ost_1.1.7_amd64.deb
71e6277957e52efb7c050f2ef0fac3c4f71a1045c9af809cf10a58b69959faae  gh-ost-binary-linux-amd64-20241219160321.tar.gz
1afffa95bb3e1f62d47d82b517e58ce9a8f81d80c9369ec798274359a2b9b7c8  gh-ost-binary-linux-arm64-20241219160321.tar.gz
dacfa1b516d4558d8db90c73ffac749733ea64d355cb8a53f6ea8db47769fe2b  gh-ost-binary-osx-amd64-20241219160321.tar.gz
769d8290245d2e7d9ccc1c7c8256617c2f757a9810bba4a539581c43d3ba3731  gh-ost-binary-osx-arm64-20241219160321.tar.gz
EOF
check "File hash" test_file_hash

function not() {
  ! "$@"
}

rm "$filename"
check "No files matched" not test_file_hash

reportResults
