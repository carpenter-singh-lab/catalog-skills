#!/usr/bin/env bash
# Validate a composed or edited marimo notebook: lint, static-check, then execute
# it through marimo export. The mechanical half of the validation rule - you still
# have to open the notebook and look at the outputs afterward.
#
# Usage: bash validate-notebook.sh notebooks/<topic>.py
set -euo pipefail

NB="${1:?usage: validate-notebook.sh notebooks/<topic>.py}"

# marimo check --fix first: it auto-resolves markdown-indentation (and other) warnings on
# mo.md cells. Running it BEFORE ruff format means ruff then formats the fixed output, and the
# export below runs after both - so the committed .py is clean and execution sees
# the final source.
echo "==> marimo check --fix ($NB)"
uvx marimo check --fix "$NB"

echo "==> ruff check + format ($NB)"
uvx ruff check "$NB"
uvx ruff format "$NB"

# Executing the notebook here surfaces runtime failures that static checks miss.
# env -u PYTHONPATH avoids the Nix websockets shim.
echo "==> execute notebook via marimo export (failure here is a real bug in the notebook)"
env -u PYTHONPATH uvx marimo export session --sandbox "$NB"

cat <<EOF

OK - mechanical checks passed.

marimo may have written __marimo__/session/*.json as a local export artifact.
Do not commit those snapshots unless this repo intentionally tracks them for
molab/static rendering; they can contain random UI widget ids and create noisy
diffs across otherwise identical exports.

NOW open the notebook and inspect the outputs yourself. Static checks do not catch
empty tables, wrong sign conventions, stale endpoints, or plots that render but say nothing:

  PORT=\$(python -c "import socket; s=socket.socket(); s.bind(('127.0.0.1',0)); print(s.getsockname()[1])")
  env -u PYTHONPATH uvx marimo edit --sandbox --headless --no-token --port \$PORT $NB
EOF
