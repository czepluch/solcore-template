# solcore-template

A project template for [Core Solidity](https://github.com/argotorg/solcore)
with a Foundry test harness.

Core Solidity's `sol-core` compiler has no test tooling, but it emits
standard EVM bytecode. The harness compiles `.solc` sources to bytecode
artifacts, deploys them inside forge tests, and drives them through
hand-written Solidity interfaces. Fuzzing, invariant testing, exact revert
assertions, and gas reports work unchanged.

The example's compiled artifacts are committed, so a fresh clone passes
`forge test` without any Core Solidity toolchain. The toolchain is only
needed to rebuild the bytecode; it is pinned by a nix flake.

## Quickstart

```sh
forge init my-project --template czepluch/solcore-template
cd my-project
forge test
```

`forge init --template` (forge 1.7.x) accepts `owner/repo`, an `https://`
URL, or a `file:///abs/path` URL; a bare local path does not work.
`git clone` plus `forge test` is equivalent.

To rebuild the bytecode (requires [nix](https://nixos.org); the first run
compiles sol-core from source):

```sh
nix develop        # sol-core, yule, solc, jq, make, forge - all pinned
make build         # scripts/check-core.sh + forge build
forge test
git diff build/    # empty: the rebuild is byte-identical to the committed artifacts
```

Without nix, set `SOL_CORE`, `YULE`, `SOLC`, and `STD` to your own binaries
and std library. `build/TOOLCHAIN` records what produced the committed
artifacts; match it for byte-identical output.

## Layout

| Path | What it is |
| --- | --- |
| `src/Counter.solc` | Example contract: forge's default Counter in Core Solidity |
| `src/Probe.solc` | Toolchain canary: one function per language feature in use (optional) |
| `test/CoreDeploy.sol` | Deploys `build/<Name>.json` inside forge tests via `vm.getCode` |
| `test/CounterAbi.sol` | Hand-written interface: the ABI source of truth |
| `test/Counter.t.sol` | Example suite: typed calls, fuzzing, exact reverts |
| `test/Probe.t.sol` | Pins the runtime behavior of each canary |
| `flake.nix` | Toolchain pin: solcore (compiler + std), solc, forge as one input set |
| `Makefile` | `make build / test / fmt / clean`; test rebuilds artifacts when a toolchain is present |
| `scripts/check-core.sh` | Compiles `src/*.solc` to `build/`, stamps `build/TOOLCHAIN` |
| `scripts/sync-abi.sh` | Renders each `test/<Name>Abi.sol` to `abi/<Name>.json` |
| `scripts/scaffold.sh` | Renames the Counter example to your contract name |
| `build/` | Committed pipeline output: `<Name>.json` artifacts, `.yul`, `TOOLCHAIN` stamp |
| `lib/forge-std` | Vendored forge-std, so a bare clone is self-contained |

## How the harness works

`scripts/check-core.sh` compiles each contract in three steps - `sol-core`
(`.solc` to Core IR), `yule` (Core IR to Yul), `solc --strict-assembly`
(Yul to bytecode) - and writes a Foundry-shaped artifact
`build/<Name>.json`. `test/CoreDeploy.sol` loads the artifact with
`vm.getCode`, appends ABI-encoded constructor arguments, and deploys it
with `create`. Tests call the deployed address through a hand-written
interface and read like ordinary forge tests.

The interface is the ABI source of truth, not the compiler: the artifact
bundles the compiler's `--abi` output so `cast interface build/<Name>.json`
works, but that output is partial (functions only; no events, errors, or
view/pure). `test/<Name>Abi.sol` declares the complete surface;
`scripts/sync-abi.sh` renders it to `abi/<Name>.json`.

## The canary

`src/Probe.solc` contains one small function per language feature the
project relies on; `test/Probe.t.sol` pins each one's runtime behavior.
Current pins: constructor arguments and dispatch, the revert payload of
`require(cond, "msg")` (raw message bytes, not Solidity's `Error(string)`
encoding), bare integer literals, and storage layout (sequential slots
from 0, read with `vm.load`). `check-core.sh` compiles Probe first, so
after a toolchain bump, drift fails in a small labeled test rather than
somewhere in your contract. When you adopt a new language feature, add a
canary function and a pinning test.

The canary is optional. To remove it:

```sh
git rm src/Probe.solc test/Probe.t.sol build/Probe.json build/Probe.yul
```

Nothing else references it; `check-core.sh` skips the Probe-first ordering
when the file is absent.

## The toolchain pin

Compiler binaries and the std library must come from the same solcore rev;
mixed revs fail confusingly or mask errors. `flake.nix` takes solcore as a
single input - binaries are built from it, std is read from it - with the
rev in the input URL. The committed `flake.lock` resolves `solc` and
`forge` through solcore's own pins, so the whole toolchain moves together.

`check-core.sh` stamps each build's rev, binary hashes, and solc version
into `build/TOOLCHAIN`. The reproducibility criterion is the bytecode,
byte for byte; binary hashes may differ across platforms.

To bump the toolchain:

```sh
# edit the solcore rev in flake.nix, then:
nix flake update solcore
nix develop
make build && forge test
git diff build/    # artifact changes, if any; failing Probe tests name what moved
```

## Renaming the example

```sh
scripts/scaffold.sh MyContract
forge test
```

This renames Counter in place: source, tests, interface, ABI, and the
committed build artifacts. The compiled bytecode contains no contract
name, so the artifacts stay byte-exact and tests pass without a rebuild.

## License

MIT - see [LICENSE](LICENSE).
