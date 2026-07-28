# solcore-template

A starter for [Core Solidity](https://github.com/argotorg/solcore) projects
with a full Foundry test setup: clone it, run `forge test`, see green -
before you build any toolchain.

Core Solidity is a research-stage redesign of Solidity (the `sol-core`
compiler from argotorg/solcore). It has no test tooling of its own, but its
output is ordinary EVM bytecode, and forge does not care where bytecode
comes from. So this template compiles `.solc` sources to hex, deploys that
hex inside forge tests, and drives it through hand-authored Solidity
interfaces - which buys the entire Foundry toolbox for a language that has
none: fuzzing, invariants, exact revert and event assertions, gas reports.

## Quickstart

Stage 1: a working project in one command. No Core Solidity toolchain
needed - the example's compiled bytecode is committed.

```sh
forge init my-project --template <owner>/solcore-template
cd my-project
forge test
```

`forge init --template` (forge 1.7.x) accepts a GitHub `owner/repo` slug, a
full `https://` URL, or a `file:///abs/path` URL for a local copy; a bare
local path does not work. Plain `git clone <repo> && cd <repo> && forge
test` is the equivalent fallback.

Stage 2: enter the pinned toolchain and rebuild the bytecode yourself
(requires [nix](https://nixos.org); the first run builds the sol-core
compiler from source).

```sh
nix develop        # sol-core, yule, solc, jq, make, forge - all pinned
make build         # scripts/check-core.sh + forge build
forge test
git diff build/    # byte-identical rebuild -> no diff
```

The pin is the solcore rev in flake.nix's input URL, resolved by the
committed flake.lock; the std library ships inside that same input, so
compiler and std can never skew apart. Without nix, point `check-core.sh`
at your own binaries via the `SOL_CORE`, `YULE`, `SOLC`, and `STD` env
vars - for a byte-identical rebuild, match the toolchain recorded in
`build/TOOLCHAIN`.

The rebuilt artifacts must be byte-identical to the committed ones - that
is the point of the pin. After a toolchain bump (edit the rev in flake.nix,
then `nix develop` and `make build`), a diff or a failing test is the
canary doing its job: see `test/Probe.t.sol` for what changed.

## Layout

| Path | What it is |
| --- | --- |
| `src/Counter.solc` | The example contract: forge's default Counter, in Core Solidity |
| `src/Probe.solc` | Toolchain canary: one function per language feature relied on (optional) |
| `test/CoreDeploy.sol` | Deploys `build/<Name>.json` inside forge tests via `vm.getCode` |
| `test/CounterAbi.sol` | Hand-authored interface: the ABI source of truth |
| `test/Counter.t.sol` | Example suite: typed calls, fuzzing, exact reverts |
| `test/Probe.t.sol` | Pins the exact runtime behavior of each canary |
| `flake.nix` | The toolchain pin: solcore (compiler + std), solc, forge as one input set |
| `Makefile` | `make build / test / fmt / clean`; test rebuilds artifacts when it can |
| `scripts/check-core.sh` | Compiles `src/*.solc` to `build/`, stamps `build/TOOLCHAIN` |
| `scripts/sync-abi.sh` | Renders each `test/<Name>Abi.sol` to `abi/<Name>.json` |
| `scripts/scaffold.sh` | Renames the Counter example to your contract name |
| `build/` | Committed pipeline output: `<Name>.json` artifacts, `.yul`, `TOOLCHAIN` stamp |
| `lib/forge-std` | Vendored forge-std, so a bare clone is self-contained |

## How the harness works

`scripts/check-core.sh` compiles each contract: `sol-core` (.solc to .hull),
`yule` (.hull to .yul), then `solc --strict-assembly` (.yul to hex
initcode), wrapped into a Foundry-shaped artifact `build/<Name>.json`.
`test/CoreDeploy.sol` loads it with `vm.getCode`, appends ABI-encoded
constructor args, and deploys it with `create`. Tests then talk to the
deployed address through a hand-authored interface, so they read like
ordinary forge tests and every Foundry feature works. The interface, not
the compiler, is the ABI source of truth: the artifact bundles the
compiler's own `--abi` emission so tooling like `cast interface
build/<Name>.json` works, but that emission is partial (functions only,
no events, errors, or view/pure), so `test/<Name>Abi.sol` declares the
complete surface and `scripts/sync-abi.sh` renders it to `abi/<Name>.json`.

## The canary

A research compiler moves under you. `src/Probe.solc` holds one tiny
function per language feature this project relies on, and `test/Probe.t.sol`
pins each one's exact runtime behavior - down to the wire shape of
`require(cond, "msg")`, which reverts with the RAW message bytes, not
Solidity's `Error(string)` encoding, and the storage layout itself (fields
occupy sequential slots from 0, pinned by reading the slots with
`vm.load`). `check-core.sh` compiles Probe first,
so after a toolchain bump, drift fails small and labeled instead of
somewhere deep inside your real contract. When you adopt a new language
feature, add a canary function and a pinning test alongside it.

The canary is optional scaffolding for a young language. It earns its keep
while you track a moving compiler; once the toolchain stabilizes (or your
project pins a rev and never moves), remove it:

```sh
git rm src/Probe.solc test/Probe.t.sol build/Probe.json build/Probe.yul
```

Everything else keeps working: `check-core.sh` only compiles Probe first
when the file exists, and no other file references it.

## The toolchain pin

The compiler binaries and the std library must move together: a compiler at
one rev running against std sources from another fails in confusing ways or,
worse, works by accident. `flake.nix` therefore takes solcore as a single
input - the `sol-core` and `yule` binaries are built from it, the std
library is read from it - with the rev pinned right in the input URL, and
the committed `flake.lock` resolves `solc` and `forge` through solcore's
own pins, so the whole toolchain moves as one set or not at all.
`check-core.sh` stamps every build with the rev, binary hashes, and solc
version in `build/TOOLCHAIN`. The committed stamp records exactly what
produced the committed artifacts; the reproducibility criterion is the
bytecode itself, byte for byte (binary hashes can differ across platforms,
the bytecode must not). To bump the toolchain: edit the rev in `flake.nix`,
re-enter `nix develop`, run `make build`, and let the canary tell you what
moved.

## Starting your own project

```sh
scripts/scaffold.sh MyContract
forge test
```

The rename keeps the committed build artifacts byte-exact (the compiled hex
is name-independent), so tests stay green before any toolchain setup. Keep
`src/Probe.solc` as your canary and grow it with your project.

## License

MIT - see [LICENSE](LICENSE).
