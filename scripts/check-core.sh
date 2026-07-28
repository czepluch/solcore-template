#!/usr/bin/env bash
# Compile Core Solidity sources in src/ to Foundry-shaped artifacts in
# build/: <Name>.json ({abi, bytecode.object}) plus the <Name>.yul
# intermediate for inspection. Tests load the artifact with
# vm.getCode("build/<Name>.json"); cast interface build/<Name>.json works.
#
# Pipeline per contract: sol-core (.solc -> .hull) -> yule (.hull -> .yul)
#                        -> solc --strict-assembly (.yul -> hex initcode)
#
# The toolchain comes from the nix dev shell: flake.nix pins the solcore
# rev, and `nix develop` puts sol-core, yule, solc, and jq on PATH and
# exports STD (the std library path, from the SAME rev as the binaries)
# plus SOLCORE_REV (for the build stamp). Everything is env-overridable
# (SOL_CORE, YULE, SOLC, STD; SOLCORE_REV for the stamp), so any toolchain
# can be substituted. Each run stamps the exact toolchain into
# build/TOOLCHAIN.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

SOL_CORE="${SOL_CORE:-sol-core}"
YULE="${YULE:-yule}"
SOLC="${SOLC:-solc}"

for tool in "$SOL_CORE" "$YULE" "$SOLC" jq; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "error: '$tool' not found on PATH" >&2
        echo "       enter the dev shell first: nix develop" >&2
        exit 1
    fi
done
if [ -z "${STD:-}" ] || [ ! -d "$STD" ]; then
    echo "error: STD (Core Solidity std library path) is unset or not a directory" >&2
    echo "       enter the dev shell (nix develop), which exports it, or point" >&2
    echo "       STD at the std/ directory of a solcore checkout" >&2
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
# reproducible rebuilds diff clean. The rev comes from the dev shell
# (SOLCORE_REV) or, outside it, from the committed flake.lock.
rev="${SOLCORE_REV:-$(jq -r '.nodes.solcore.locked.rev // "unknown"' "$ROOT/flake.lock" 2>/dev/null || echo unknown)}"
{
    echo "solcore_rev $rev"
    echo "sol_core_sha256 $(sha256sum "$(command -v "$SOL_CORE")" | cut -d' ' -f1)"
    echo "yule_sha256 $(sha256sum "$(command -v "$YULE")" | cut -d' ' -f1)"
    echo "solc $("$SOLC" --version | tail -1)"
    echo "std $STD"
} > "$BUILD/TOOLCHAIN"
echo "== stamped $BUILD/TOOLCHAIN"
