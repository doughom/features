#!/usr/bin/env bash
set -e

baseDir="/opt/python-tools/pip-tools"
mkdir -p "$baseDir"
python3 -m venv "$baseDir"
# shellcheck disable=SC1091
source "$baseDir/bin/activate"

pip install --require-hashes --requirement "requirements-$VERSION.txt"
deactivate

sitePackages=$(find "$baseDir" -type d -name site-packages)

cat <<EOF >/usr/local/bin/pip-compile
#!/usr/bin/env bash
PYTHONPATH="$sitePackages" python3 -m piptools compile "\$@"
EOF

cat <<EOF >/usr/local/bin/pip-sync
#!/usr/bin/env bash
PYTHONPATH="$sitePackages" python3 -m piptools sync "\$@"
EOF

chmod +x /usr/local/bin/pip-compile /usr/local/bin/pip-sync
