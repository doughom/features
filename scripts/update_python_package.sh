#!/usr/bin/env bash
set -eu
package="$1"
version="$2"

output="src/$package/requirements-$version.txt"
if [ -f "$output" ]; then
  echo "$output already exists"
  exit 1
fi

trap 'rm requirements.in' EXIT
echo "$package==$version" >requirements.in
pip-compile --generate-hashes --strip-extras --output-file "$output" requirements.in
