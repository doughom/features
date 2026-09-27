#!/bin/bash

export PATH="$PATH:$PWD/node_modules/.bin"

for attempt in {0..2}; do
  ((seconds = attempt * 10))
  sleep $seconds
  "$@" && break
done
