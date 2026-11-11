#!/usr/bin/env bash
# Manage the Core Solidity toolchain pinned in toolchain.lock: the solcore
# release (solcore, solcore-fmt, and the std library beside them) and the solc
# release that assembles the generated Yul into bytecode. Both are downloaded
# from GitHub releases and checked against the sha256 recorded in the lock.
#
# Usage:
#   scripts/toolchain.sh install
#       Download the pinned releases for this machine into .toolchain/.
#       Releases that are already installed are left alone.
#   scripts/toolchain.sh path solcore|solcore-fmt|solc
#       Print the executable to use. The SOLCORE, SOLCORE_FMT, and SOLC
#       environment variables take precedence over the pinned install.
#   scripts/toolchain.sh get solcore|solc|evm-version
#       Print a value from toolchain.lock.
#   scripts/toolchain.sh pin [--solcore VERSION] [--solc VERSION] [--evm-version NAME]
#       Rewrite toolchain.lock with the given versions and the sha256 digests
#       GitHub publishes for their release assets. VERSION is an exact
#       version or "latest" (the newest published release, prereleases
#       included). Options left out keep their current value.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCK="$ROOT/toolchain.lock"
INSTALL_DIR="$ROOT/.toolchain"

SOLCORE_REPO="argotorg/solcore-rs"
SOLC_REPO="argotorg/solidity"
HOSTS="linux-x86_64 linux-aarch64 darwin-x86_64 darwin-arm64"

die() {
    echo "error: $*" >&2
    exit 1
}

# This machine as <os>-<arch>, the form toolchain.lock uses.
host() {
    echo "$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m)"
}

repo() {
    case "$1" in
        solcore) echo "$SOLCORE_REPO" ;;
        solc) echo "$SOLC_REPO" ;;
    esac
}

# Name of the release asset that holds a tool for a host.
asset_name() { # <tool> <version> <host>
    case "$1:$3" in
        solcore:linux-x86_64) echo "solcore-v$2-x86_64-unknown-linux-gnu.tar.gz" ;;
        solcore:linux-aarch64) echo "solcore-v$2-aarch64-unknown-linux-gnu.tar.gz" ;;
        solcore:darwin-x86_64) echo "solcore-v$2-x86_64-apple-darwin.tar.gz" ;;
        solcore:darwin-arm64) echo "solcore-v$2-aarch64-apple-darwin.tar.gz" ;;
        solc:linux-x86_64) echo "solc-static-linux" ;;
        solc:linux-aarch64) echo "solc-static-linux-arm" ;;
        solc:darwin-*) echo "solc-macos" ;;
    esac
}

lock_get() { # <key>
    [ -f "$LOCK" ] || die "toolchain.lock not found"
    local value
    value="$(awk -v key="$1" '$1 == key { print $2; exit }' "$LOCK")"
    [ -n "$value" ] || die "toolchain.lock has no '$1' entry"
    echo "$value"
}

# Prints "<asset> <sha256>" for a tool on a host.
lock_asset() { # <tool> <host>
    local line
    line="$(awk -v tool="$1" -v host="$2" \
        '$1 == "asset" && $2 == tool && $3 == host { print $4, $5; exit }' "$LOCK")"
    [ -n "$line" ] || die "toolchain.lock pins no $1 release asset for $2"
    echo "$line"
}

sha256() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | cut -d' ' -f1
    else
        shasum -a 256 "$1" | cut -d' ' -f1
    fi
}

# Downloads a release asset to <dest> and checks its sha256.
fetch() { # <tool> <version> <asset> <sha256> <dest>
    local url actual
    url="https://github.com/$(repo "$1")/releases/download/v$2/$3"
    echo "   $url"
    curl -fsSL --retry 3 -o "$5" "$url"
    actual="$(sha256 "$5")"
    if [ "$actual" != "$4" ]; then
        rm -f "$5"
        die "$3 has sha256 $actual, but toolchain.lock expects $4"
    fi
}

cmd_install() {
    local h version line asset sum dest
    h="$(host)"
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR"' EXIT

    # The solcore archive holds one top-level directory with the executables
    # and std/ inside; it is unpacked into .toolchain/solcore-<version>/.
    # .sha256 marks a complete install of that exact archive.
    version="$(lock_get solcore)"
    line="$(lock_asset solcore "$h")"
    read -r asset sum <<< "$line"
    dest="$INSTALL_DIR/solcore-$version"
    if [ "$(cat "$dest/.sha256" 2>/dev/null || true)" = "$sum" ]; then
        echo "== solcore $version already installed"
    else
        echo "== solcore $version"
        fetch solcore "$version" "$asset" "$sum" "$TMP_DIR/$asset"
        rm -rf "$dest"
        mkdir -p "$dest"
        tar -xzf "$TMP_DIR/$asset" -C "$dest" --strip-components=1
        echo "$sum" > "$dest/.sha256"
    fi

    # The solc asset is the executable itself.
    version="$(lock_get solc)"
    line="$(lock_asset solc "$h")"
    read -r asset sum <<< "$line"
    dest="$INSTALL_DIR/solc-$version"
    if [ -x "$dest/solc" ] && [ "$(sha256 "$dest/solc")" = "$sum" ]; then
        echo "== solc $version already installed"
    else
        echo "== solc $version"
        fetch solc "$version" "$asset" "$sum" "$TMP_DIR/solc"
        mkdir -p "$dest"
        mv "$TMP_DIR/solc" "$dest/solc"
        chmod +x "$dest/solc"
    fi
}

cmd_path() { # <tool>
    local tool="${1:-}" override candidate
    case "$tool" in
        solcore) override="${SOLCORE:-}" ;;
        solcore-fmt) override="${SOLCORE_FMT:-}" ;;
        solc) override="${SOLC:-}" ;;
        *) die "usage: scripts/toolchain.sh path solcore|solcore-fmt|solc" ;;
    esac
    if [ -n "$override" ]; then
        command -v "$override" 2>/dev/null || die "$tool not found: $override (set in the environment)"
        return
    fi
    if [ "$tool" = solc ]; then
        candidate="$INSTALL_DIR/solc-$(lock_get solc)/solc"
    else
        candidate="$INSTALL_DIR/solcore-$(lock_get solcore)/$tool"
    fi
    [ -x "$candidate" ] || die "$tool is not installed; run: scripts/toolchain.sh install"
    echo "$candidate"
}

cmd_get() { # <key>
    case "${1:-}" in
        solcore | solc | evm-version) lock_get "$1" ;;
        *) die "usage: scripts/toolchain.sh get solcore|solc|evm-version" ;;
    esac
}

# Newest published release of a tool, prereleases included, without the "v".
latest_release() { # <tool>
    local tag
    tag="$(curl -fsSL "https://api.github.com/repos/$(repo "$1")/releases?per_page=20" \
        | jq -r '[.[] | select(.draft | not)][0].tag_name // empty')"
    [ -n "$tag" ] || die "found no published $1 release in $(repo "$1")"
    echo "${tag#v}"
}

# Prints one "asset <tool> <host> <asset> <sha256>" line per host that the
# release has an asset for.
asset_lines() { # <tool> <version>
    local json h asset digest
    json="$(curl -fsSL "https://api.github.com/repos/$(repo "$1")/releases/tags/v$2")" \
        || die "found no $1 release v$2 in $(repo "$1")"
    for h in $HOSTS; do
        asset="$(asset_name "$1" "$2" "$h")"
        digest="$(jq -r --arg name "$asset" \
            '.assets[] | select(.name == $name) | .digest // "none"' <<< "$json")"
        if [ -z "$digest" ]; then
            echo "note: $1 v$2 has no $asset; $h is not pinned" >&2
            continue
        fi
        [ "$digest" != none ] || die "GitHub publishes no digest for $asset in $1 v$2; pick a newer release"
        echo "asset $1 $h $asset ${digest#sha256:}"
    done
}

cmd_pin() {
    local solcore="" solc="" evm="" old_evm="" solcore_assets solc_assets
    while [ $# -gt 0 ]; do
        [ $# -ge 2 ] || die "$1 requires a value"
        case "$1" in
            --solcore) solcore="$2" ;;
            --solc) solc="$2" ;;
            --evm-version) evm="$2" ;;
            *) die "unknown option '$1'" ;;
        esac
        shift 2
    done
    command -v jq >/dev/null 2>&1 || die "'jq' not found on PATH"

    if [ -f "$LOCK" ]; then
        old_evm="$(lock_get evm-version)"
        [ -n "$solcore" ] || solcore="$(lock_get solcore)"
        [ -n "$solc" ] || solc="$(lock_get solc)"
        [ -n "$evm" ] || evm="$old_evm"
    fi
    [ -n "$solcore" ] && [ -n "$solc" ] && [ -n "$evm" ] \
        || die "toolchain.lock does not exist yet; pass --solcore, --solc, and --evm-version"
    if [ "$solcore" = latest ]; then
        solcore="$(latest_release solcore)"
    fi
    if [ "$solc" = latest ]; then
        solc="$(latest_release solc)"
    fi

    solcore_assets="$(asset_lines solcore "$solcore")"
    solc_assets="$(asset_lines solc "$solc")"
    {
        echo "# Core Solidity toolchain for this project. scripts/toolchain.sh pin"
        echo "# writes this file and scripts/toolchain.sh install reads it."
        echo "solcore $solcore"
        echo "solc $solc"
        echo "evm-version $evm"
        echo
        echo "# asset <tool> <host> <release asset> <sha256>"
        echo "$solcore_assets"
        echo "$solc_assets"
    } > "$LOCK.tmp"
    mv "$LOCK.tmp" "$LOCK"

    echo "== pinned solcore $solcore, solc $solc, evm-version $evm"
    if [ -n "$old_evm" ] && [ "$evm" != "$old_evm" ]; then
        echo "   set evm_version = \"$evm\" in foundry.toml to match"
    fi
    echo "   next: scripts/toolchain.sh install && make build && forge test && git diff build/"
}

case "${1:-}" in
    install) shift; cmd_install "$@" ;;
    path) shift; cmd_path "$@" ;;
    get) shift; cmd_get "$@" ;;
    pin) shift; cmd_pin "$@" ;;
    *)
        echo "usage: scripts/toolchain.sh install | path <tool> | get <key> | pin [options]" >&2
        echo "       (see the comment at the top of scripts/toolchain.sh)" >&2
        exit 2
        ;;
esac
