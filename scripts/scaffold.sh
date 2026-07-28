#!/usr/bin/env bash
# Rename the Counter example to your own contract name, in place: source,
# tests, interface, ABI, and the committed build artifacts.
#
# The compiled hex is name-independent (yul object names are resolved away
# during compilation, and Counter's require message embeds no contract
# name), so the renamed build/ artifacts remain byte-identical to what a
# rebuild of the renamed source produces: forge test stays green before any
# toolchain setup, and the reproducibility check keeps meaning something.
# src/Probe.solc is the toolchain canary and is not touched.
#
# Usage: scripts/scaffold.sh [<Name>]
#        (UpperCamelCase; prompted for interactively if omitted)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

NAME="${1:-}"
if [ -z "$NAME" ]; then
    printf "New contract name (UpperCamelCase): "
    read -r NAME
fi

if ! [[ "$NAME" =~ ^[A-Z][A-Za-z0-9]*$ ]]; then
    echo "error: name must be UpperCamelCase alphanumerics ([A-Z][A-Za-z0-9]*)" >&2
    exit 1
fi
if [ "$NAME" = "Counter" ]; then
    echo "nothing to do: the example is already named Counter"
    exit 0
fi
if [ "$NAME" = "Probe" ]; then
    echo "error: Probe is the toolchain canary; pick another name" >&2
    exit 1
fi
if [ ! -f "$ROOT/src/Counter.solc" ]; then
    echo "error: src/Counter.solc not found (already scaffolded?)" >&2
    exit 1
fi
if [ -e "$ROOT/src/$NAME.solc" ]; then
    echo "error: src/$NAME.solc already exists" >&2
    exit 1
fi

# counter -> myToken-style identifier for the test's local variable.
lower="$(printf '%s' "${NAME:0:1}" | tr '[:upper:]' '[:lower:]')${NAME:1}"

# rename <old> <new> <sed-expr>...: rewrite while renaming; plain mv when no
# sed expressions are given. Skips silently if <old> is absent.
rename() {
    local old="$1" new="$2"
    shift 2
    [ -f "$old" ] || return 0
    if [ $# -eq 0 ]; then
        mv "$old" "$new"
    else
        sed "$@" "$old" > "$new"
        rm "$old"
    fi
    echo "  $old -> $new"
}

echo "== renaming Counter to $NAME"
rename "$ROOT/src/Counter.solc"      "$ROOT/src/$NAME.solc"       -e "s/Counter/$NAME/g"
rename "$ROOT/test/CounterAbi.sol"   "$ROOT/test/${NAME}Abi.sol"  -e "s/Counter/$NAME/g"
rename "$ROOT/test/Counter.t.sol"    "$ROOT/test/$NAME.t.sol"     -e "s/Counter/$NAME/g" -e "s/counter/$lower/g"
rename "$ROOT/build/Counter.yul"     "$ROOT/build/$NAME.yul"      -e "s/Counter/$NAME/g"
rename "$ROOT/build/Counter.json"    "$ROOT/build/$NAME.json"
rename "$ROOT/abi/Counter.json"      "$ROOT/abi/$NAME.json"

echo "== done. Next:"
echo "   forge test                                # still green, no toolchain needed"
echo "   scripts/check-core.sh && forge test       # once a toolchain is pinned"
echo "   (README.md still describes the Counter example; update it as you go)"
