#!/usr/bin/env bash
# Postavljanje na macOS/Linux: submoduli (i ugniježđeni libs/hbb_common) + remote `upstream` u svakom forku.
set -euo pipefail
cd "$(dirname "$0")/.."
git submodule update --init --recursive
while read -r put upstream; do
  if git -C "$put" remote | grep -qx upstream; then
    git -C "$put" remote set-url upstream "$upstream"
  else
    git -C "$put" remote add upstream "$upstream"
  fi
  echo "$put -> upstream $upstream"
done < scripts/upstreami.txt
echo "Gotovo. Alati i verzije: docs/forkovi.md, koraci: docs/plan.md"
