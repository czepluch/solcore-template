#!/usr/bin/env bash
# Regenerate abi/<Name>.json from each hand-authored test/<Name>Abi.sol
# interface - the single source of the complete ABI (functions, events, and
# errors; the sol-core compiler emits functions only, so the interface
# carries the rest and `forge inspect` turns it into JSON).
#
# Usage: scripts/sync-abi.sh          # regenerate abi/*.json
#        scripts/sync-abi.sh --check  # diff committed files against fresh
#                                     # output; nonzero exit on drift
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/abi"

check="${1:-}"
status=0

for iface in "$ROOT"/test/*Abi.sol; do
    name="$(basename "$iface" Abi.sol)"
    out="$ROOT/abi/$name.json"
    fresh="$(forge inspect --root "$ROOT" "${name}Abi" abi --json)"
    if [ "$check" = "--check" ]; then
        if diff -u "$out" <(printf '%s\n' "$fresh"); then
            echo "abi/$name.json matches test/${name}Abi.sol"
        else
            echo "error: $out has drifted from test/${name}Abi.sol - run scripts/sync-abi.sh" >&2
            status=1
        fi
    else
        printf '%s\n' "$fresh" > "$out"
        echo "wrote $out"
    fi
done

exit "$status"
