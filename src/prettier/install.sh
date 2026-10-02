#!/usr/bin/env bash
set -eu

tempDir=$(mktemp -d)
cp "$VERSION"/package{,-lock}.json "$tempDir"
cd "$tempDir"
npm install
mv node_modules/prettier /usr/local/lib/node_modules/
ln -s /usr/local/lib/node_modules/prettier/bin/prettier.cjs /usr/local/bin/prettier
