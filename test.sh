#!/usr/bin/env bash
set -eu
feature="$1"

images=(
  "almalinux:10-minimal"
  "debian:trixie-slim"
)

if [ "$feature" == "all" ]; then
  features=()
  for item in "$PWD"/test/*; do
    features+=("$(basename "${item%/}")")
  done
else
  features=("$feature")
fi

results="----- Test Results -----"
trap 'echo -e $results' EXIT

for feature in "${features[@]}"; do
  for image in "${images[@]}"; do
    devcontainer features test --skip-scenarios --base-image "$image" -f "$feature"
    results+="\n$(printf '\e[32m\u2714\e[0m PASS %s %s' "$feature" "$image")"
  done
done
