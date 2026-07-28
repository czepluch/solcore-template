#!/usr/bin/env bash
# Compile Core Solidity sources in src/ to Foundry-shaped artifacts in
# build/: <Name>.json ({abi, bytecode.object}) plus the <Name>.yul
# intermediate for inspection. Tests load the artifact with
# vm.getCode("build/<Name>.json"); cast interface build/<Name>.json works.
#
# Pipeline per contract: sol-core (.solc -> .hull) -> yule (.hull -> .yul)
#                        -> solc --strict-assembly (.yul -> hex initcode)
#
# The toolchain lives in toolchain/ (machine-local, gitignored): GC-rooted nix
# links for sol-core/yule/solc plus a std snapshot, all at the single solcore
# rev recorded in toolchain/SOLCORE_REV. It is (re)created by
# scripts/pin-toolchain.sh, so binaries and std move together or not at all.
# Every path is env-overridable (SOL_CORE, YULE, SOLC, STD; SOLCORE_REV for
# the stamp). Each run stamps the exact toolchain into build/TOOLCHAIN.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOOLCHAIN="$ROOT/toolchain"

SOL_CORE="${SOL_CORE:-$TOOLCHAIN/sol-core/bin/sol-core}"
YULE="${YULE:-$TOOLCHAIN/sol-core/bin/yule}"
SOLC="${SOLC:-$TOOLCHAIN/solc/bin/solc}"
STD="${STD:-$TOOLCHAIN/std}"

for tool in "$SOL_CORE" "$YULE" "$SOLC"; do
    if [ ! -x "$tool" ]; then
        echo "error: $tool not found or not executable" >&2
        echo "       run scripts/pin-toolchain.sh first (see its header)" >&2
        exit 1
    fi
done
if ! command -v jq >/dev/null 2>&1; then
    echo "error: jq not found (needed to assemble the artifact JSON)" >&2
    exit 1
fi
if [ ! -d "$STD" ]; then
    echo "error: std library not found at $STD (run scripts/pin-toolchain.sh)" >&2
    exit 1
fi

SRC="$ROOT/src"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
    # Probe first, when present: it is the toolchain canary, so drift fails
    # on the small labeled contract before your real contracts do. The
    # canary is optional - see "The canary" in README.md for removing it.
    files=()
    [ -f "$SRC/Probe.solc" ] && files+=("$SRC/Probe.solc")
    for f in "$SRC"/*.solc; do
        [ -f "$f" ] || continue
        [ "$f" = "$SRC/Probe.solc" ] || files+=("$f")
    done
    if [ ${#files[@]} -eq 0 ]; then
        echo "error: no .solc sources found in src/" >&2
        exit 1
    fi
fi

# Intermediates (.hull) live in a per-run temp dir, so build/ only ever
# holds the committed artifacts.
WORK_ROOT="$(mktemp -d)"
trap 'rm -rf "$WORK_ROOT"' EXIT

for f in "${files[@]}"; do
    base="$(basename "$f" .solc)"
    # Shared modules (no contract declaration) are compiled via their importers.
    if ! grep -q '^contract ' "$f"; then
        echo "== $base (module, skipped)"
        continue
    fi
    echo "== $base"
    work="$WORK_ROOT/$base"
    mkdir -p "$work"
    "$SOL_CORE" -f "$f" --root "$SRC" -i "$STD" -o "$work" --abi
    # sol-core names its Core-IR output output<N>.hull, indexed per contract
    # in the file, so a second contract would land in output2.hull. Keep one
    # contract per file; fail loudly instead of silently dropping it.
    if [ ! -f "$work/output1.hull" ]; then
        echo "error: $base.solc produced no contract output" >&2
        exit 1
    fi
    if [ -f "$work/output2.hull" ]; then
        echo "error: $base.solc defines more than one contract; keep one contract per file" >&2
        exit 1
    fi
    "$YULE" "$work/output1.hull" -o "$BUILD/$base.yul"
    # Extraction idiom from the solcore harness (contest.sh).
    creation="0x$("$SOLC" --strict-assembly --bin --optimize "$BUILD/$base.yul" \
        | tail -1 | tr -d '\n')"
    # The bundled ABI is the compiler's own emission and is PARTIAL: it
    # covers functions/constructor/fallback and marks everything nonpayable;
    # events, errors, and view/pure are invisible to it. It is included
    # because it is purely pipeline-derived (so artifact reproducibility
    # stays a statement about the toolchain alone). The complete ABI is the
    # hand-authored interface under test/, rendered to abi/<Name>.json by
    # scripts/sync-abi.sh, and proven against this bytecode by the forge
    # suite.
    abi='[]'
    if [ -f "$work/$base.abi" ]; then
        abi="$(cat "$work/$base.abi")"
    fi
    jq -n --argjson abi "$abi" --arg creation "$creation" \
        '{abi: $abi, bytecode: {object: $creation}}' > "$BUILD/$base.json"
    echo "   -> $BUILD/$base.json ($(( (${#creation} - 2) )) hex chars of initcode)"
done

# Stamp the exact toolchain that produced these artifacts. No timestamps, so
# reproducible rebuilds diff clean.
{
    echo "solcore_rev ${SOLCORE_REV:-$(cat "$TOOLCHAIN/SOLCORE_REV" 2>/dev/null || echo unknown)}"
    echo "sol_core_sha256 $(sha256sum "$SOL_CORE" | cut -d' ' -f1)"
    echo "yule_sha256 $(sha256sum "$YULE" | cut -d' ' -f1)"
    echo "solc $("$SOLC" --version | tail -1)"
    if [ "$STD" != "$TOOLCHAIN/std" ]; then
        echo "std_override $STD"
    fi
} > "$BUILD/TOOLCHAIN"
echo "== stamped $BUILD/TOOLCHAIN"
