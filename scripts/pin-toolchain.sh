#!/usr/bin/env bash
# (Re)pin the Core Solidity toolchain into toolchain/ from a solcore checkout
# (github.com/argotorg/solcore).
#
# Produces, under toolchain/ (machine-local, gitignored):
#   sol-core/     nix out-link (GC root) with bin/sol-core and bin/yule,
#                 built from the checkout via its flake
#   std/          snapshot of the checkout's std library at the SAME rev
#                 (git archive), so binaries and std can never skew apart
#   solc          GC-rooted link to a pinned solc (created once by you;
#                 this script only verifies it exists)
#   SOLCORE_REV   the pinned revision, read by check-core.sh for the
#                 build stamp
#
# Usage: scripts/pin-toolchain.sh <solcore-checkout>
#        (the rev pinned is the checkout's HEAD, which must be a clean tree
#         so build == rev == std snapshot)
set -euo pipefail

if [ $# -lt 1 ]; then
    echo "usage: scripts/pin-toolchain.sh <solcore-checkout>" >&2
    echo "       (git clone https://github.com/argotorg/solcore first)" >&2
    exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOOLCHAIN="$ROOT/toolchain"
CHECKOUT="$1"
NIX="${NIX:-/nix/var/nix/profiles/default/bin/nix}"

if [ ! -d "$CHECKOUT/.git" ]; then
    echo "error: $CHECKOUT is not a git checkout of solcore" >&2
    exit 1
fi
if [ -n "$(git -C "$CHECKOUT" status --porcelain)" ]; then
    echo "error: $CHECKOUT has uncommitted changes; pin refuses a dirty tree" >&2
    echo "       (the nix build would use the tree while the pin records HEAD)" >&2
    exit 1
fi
REV="$(git -C "$CHECKOUT" rev-parse HEAD)"

mkdir -p "$TOOLCHAIN"

echo "== building sol-core + yule at $REV (nix, GC-rooted out-link)"
"$NIX" build "path:$CHECKOUT#sol-core" --out-link "$TOOLCHAIN/sol-core"

echo "== snapshotting std at $REV"
rm -rf "$TOOLCHAIN/std"
git -C "$CHECKOUT" archive "$REV" std | tar -x -C "$TOOLCHAIN/"

echo "$REV" > "$TOOLCHAIN/SOLCORE_REV"

if [ ! -x "$TOOLCHAIN/solc/bin/solc" ]; then
    echo "warning: toolchain/solc missing. Pin one once with:" >&2
    echo "  nix-store --add-root $TOOLCHAIN/solc --indirect -r <solc-0.8.x store path>" >&2
    echo "or point check-core.sh at any solc 0.8.x via the SOLC env var." >&2
fi

echo "== pinned solcore $REV"
echo "   sol-core -> $(readlink -f "$TOOLCHAIN/sol-core")"
echo "   next: ./scripts/check-core.sh && forge test"
