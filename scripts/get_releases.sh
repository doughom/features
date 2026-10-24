#!/bin/bash
set -eu

help='
Usage: get_releases.sh [options...] <owner/repo>
  -t, include tag in filename
'

includeTag=false
while getopts ":t" opt; do
  case "$opt" in
  t) includeTag=true ;;
  *) echo "$help" && exit 1 ;;
  esac
done
shift $((OPTIND - 1))

repo="$1"

# shellcheck disable=SC2016
filter='
.[]
| . as $root
| .assets[]
| select(
    (.name | test("Linux|linux"))
    and (.name | test("amd64|x86_64|x64|arm64|aarch64"))
    and (.name | endswith("sha256") | not)
    and (.digest != null)
  )
'

if $includeTag; then
  # shellcheck disable=SC2016
  filter+='| "\(.digest)  \($root.tag_name)-\(.name)"'
else
  filter+='| "\(.digest)  \(.name)"'
fi

tempFile=$(mktemp)
url="https://api.github.com/repos/$repo/releases"

while [ -v url ]; do
  response=$(curl --retry 3 --max-time 30 --show-error --silent --dump-header "$tempFile" "$url")
  echo "$response" | jq --raw-output "$filter" | sed -e "s/^sha256://g"
  url=$(grep "^link:" "$tempFile" | grep -oP '(?<=<)[^>]+(?=>;\s*rel="next")')
done

rm "$tempFile"
