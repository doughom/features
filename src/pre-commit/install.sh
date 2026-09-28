#!/usr/bin/env bash
set -e

baseDir="/opt/python-tools/pre-commit"
mkdir -p "$baseDir"
python3 -m venv "$baseDir"
# shellcheck disable=SC1091
source "$baseDir/bin/activate"

pip install --require-hashes --requirement "requirements-$VERSION.txt"
deactivate

sitePackages=$(find "$baseDir" -type d -name site-packages)

cat <<EOF >/usr/local/bin/pre-commit
#!/usr/bin/env bash
PYTHONPATH="$sitePackages" python3 -m pre_commit "\$@"
EOF

chmod +x /usr/local/bin/pre-commit
