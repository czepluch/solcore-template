#!/usr/bin/env bash
# Compile the Core Solidity sources in src/ to Foundry-shaped artifacts in
# build/: <Name>.json ({abi, bytecode.object}) plus the <Name>.yul
# intermediate for inspection (gitignored). Tests load the artifact with
# vm.getCode("build/<Name>.json"); cast interface build/<Name>.json works.
#
# Pipeline per contract: solcore (Core .sol -> Yul object <Name>Deploy)
#                        -> solc --strict-assembly (Yul -> hex initcode)
#
# src/*.sol is Core Solidity, not solc Solidity: foundry.toml skips src/
# entirely, so this script is the only thing that compiles it. Every
# contract declared in a top-level src/*.sol file gets an artifact. Files
# that declare no contract are modules, compiled through their importers.
#
# The toolchain is the one pinned in toolchain.lock and installed into
# .toolchain/ by scripts/toolchain.sh; SOLCORE and SOLC override it. Each
# run records the toolchain in build/TOOLCHAIN.
#
# Usage: scripts/check-core.sh [src/<File>.sol ...]
#        scripts/check-core.sh --check-toolchain   # exit 0 if a toolchain is available
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOOLCHAIN="$ROOT/scripts/toolchain.sh"

command -v jq >/dev/null 2>&1 || { echo "error: 'jq' not found on PATH" >&2; exit 1; }
SOLCORE="$("$TOOLCHAIN" path solcore)"
SOLC="$("$TOOLCHAIN" path solc)"
EVM_VERSION="$("$TOOLCHAIN" get evm-version)"

# forge executes the artifacts, so it must apply the EVM rules solc compiled
# them for.
forge_evm="$(sed -nE 's/^evm_version *= *"([^"]*)".*/\1/p' "$ROOT/foundry.toml" | head -1)"
if [ "$forge_evm" != "$EVM_VERSION" ]; then
    echo "error: foundry.toml sets evm_version = \"$forge_evm\", but toolchain.lock pins evm-version $EVM_VERSION" >&2
    exit 1
fi

# --check-toolchain: exit here, after the toolchain checks, without
# compiling. Lets callers (the Makefile) ask "is a complete toolchain
# available?" with the exact preconditions this script enforces.
if [ "${1:-}" = "--check-toolchain" ]; then
    exit 0
fi

solcore_version="$("$SOLCORE" --version | awk '{ print $2 }')"
solc_version="$("$SOLC" --version | sed -nE 's/^Version: ([0-9.]+\+commit\.[0-9a-f]+).*/\1/p')"
if [ "$solcore_version" != "$("$TOOLCHAIN" get solcore)" ]; then
    echo "warning: $SOLCORE is solcore $solcore_version; toolchain.lock pins $("$TOOLCHAIN" get solcore)" >&2
fi
if [ "${solc_version%%+*}" != "$("$TOOLCHAIN" get solc)" ]; then
    echo "warning: $SOLC is solc $solc_version; toolchain.lock pins $("$TOOLCHAIN" get solc)" >&2
fi

SRC="$ROOT/src"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
    # Probe first, when present: it is the toolchain canary, so drift fails
    # on the small labeled contract before your real contracts do. The
    # canary is optional; see "The canary" in README.md for removing it.
    files=()
    [ -f "$SRC/Probe.sol" ] && files+=("$SRC/Probe.sol")
    for f in "$SRC"/*.sol; do
        [ -f "$f" ] || continue
        [ "$f" = "$SRC/Probe.sol" ] || files+=("$f")
    done
    if [ ${#files[@]} -eq 0 ]; then
        echo "error: no .sol sources found in src/" >&2
        exit 1
    fi
fi

# The per-contract .abi files are intermediates and live in a per-run temp dir.
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for f in "${files[@]}"; do
    base="$(basename "$f" .sol)"
    contracts="$(sed -nE 's/^contract ([A-Za-z_][A-Za-z0-9_]*).*/\1/p' "$f")"
    if [ -z "$contracts" ]; then
        echo "== $base.sol (module, skipped)"
        continue
    fi
    for name in $contracts; do
        echo "== $name ($base.sol)"
        # solcore emits one top-level Yul object per contract, named
        # <Name>Deploy. --abi writes <Name>.abi for every contract reachable
        # from the file, including contracts in imported modules.
        "$SOLCORE" "$f" --root "$SRC" --abi -o "$WORK" \
            --emit-yul="$BUILD/$name.yul" --emit-yul-object "${name}Deploy"
        creation="0x$("$SOLC" --strict-assembly --bin --optimize \
            --evm-version "$EVM_VERSION" "$BUILD/$name.yul" | tail -1 | tr -d '\n')"
        # The bundled ABI is the compiler's own emission and is PARTIAL: it
        # covers functions, constructor, and fallback, each marked payable or
        # nonpayable; events, errors, and view/pure are invisible to it. It is
        # included because it is purely pipeline-derived (so artifact
        # reproducibility stays a statement about the toolchain alone). The
        # complete ABI is the hand-authored interface under test/, rendered
        # to abi/<Name>.json by scripts/sync-abi.sh, and proven against this
        # bytecode by the forge suite.
        jq -n --argjson abi "$(cat "$WORK/$name.abi")" --arg creation "$creation" \
            '{abi: $abi, bytecode: {object: $creation}}' > "$BUILD/$name.json"
        echo "   -> $BUILD/$name.json ($(( ${#creation} - 2 )) hex chars of initcode)"
    done
done

# Record the toolchain that produced these artifacts. No timestamps, paths,
# or platform names, so a reproducible rebuild on any machine diffs clean.
# The release commit comes from the release.json shipped beside solcore.
solcore_commit="$(jq -r '.commit // "unknown"' "$(dirname "$SOLCORE")/release.json" 2>/dev/null || echo unknown)"
{
    echo "solcore $solcore_version"
    echo "solcore_commit $solcore_commit"
    echo "solc $solc_version"
    echo "evm_version $EVM_VERSION"
} > "$BUILD/TOOLCHAIN"
echo "== stamped $BUILD/TOOLCHAIN"
