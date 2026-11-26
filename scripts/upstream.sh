#!/usr/bin/env bash
# Za svaki fork: fetch upstream, fast-forward zadane grane forka i push u fork (logomedo/*).
# Grana `logomedo` (naše izmjene) se ne dira: nju rebaseaj ručno nakon ovoga.
set -euo pipefail
cd "$(dirname "$0")/.."
while read -r put _; do
  grana=$(git -C "$put" remote show upstream | sed -n 's/.*HEAD branch: //p')
  git -C "$put" fetch -q upstream
  git -C "$put" checkout -q "$grana"
  git -C "$put" merge -q --ff-only "upstream/$grana"
  git -C "$put" push -q origin "$grana"
  echo "$put: $grana = $(git -C "$put" rev-parse --short HEAD)"
done < scripts/upstreami.txt
