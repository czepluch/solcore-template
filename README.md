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

Stage 2: pin the toolchain and rebuild the bytecode yourself (requires
[nix](https://nixos.org)).

```sh
git clone https://github.com/argotorg/solcore ../solcore
git -C ../solcore checkout <rev>      # the solcore_rev in build/TOOLCHAIN,
                                      # or omit to try a newer toolchain
scripts/pin-toolchain.sh ../solcore
scripts/check-core.sh
forge test
git diff build/*.hex build/*.yul      # byte-identical rebuild -> no diff
```

`pin-toolchain.sh` also expects a pinned `solc` at `toolchain/solc/bin/solc`
(it prints the `nix-store --add-root` command to create one); alternatively
point `check-core.sh` at any solc 0.8.x via the `SOLC` env var. For a
byte-identical rebuild, use the solc version recorded in `build/TOOLCHAIN`.

At the pinned rev, the rebuilt hex must be byte-identical to the committed
hex - that is the point of the pin. At a newer rev, a diff (or a failing
test) is the canary doing its job: see `test/Probe.t.sol` for what changed.

## Layout

| Path | What it is |
| --- | --- |
| `src/Counter.solc` | The example contract: forge's default Counter, in Core Solidity |
| `src/Probe.solc` | Toolchain canary: one function per language feature relied on |
| `test/CoreDeploy.sol` | Deploys `build/<Name>.hex` inside forge tests |
| `test/CounterAbi.sol` | Hand-authored interface: the ABI source of truth |
| `test/Counter.t.sol` | Example suite: typed calls, fuzzing, exact reverts |
| `test/Probe.t.sol` | Pins the exact runtime behavior of each canary |
| `scripts/pin-toolchain.sh` | Builds and pins sol-core, yule, std from a solcore checkout |
| `scripts/check-core.sh` | Compiles `src/*.solc` to `build/`, stamps `build/TOOLCHAIN` |
| `scripts/sync-abi.sh` | Renders each `test/<Name>Abi.sol` to `abi/<Name>.json` |
| `scripts/scaffold.sh` | Renames the Counter example to your contract name |
| `build/` | Pipeline output; the example's `.hex`, `.yul`, and stamp are committed |
| `toolchain/` | Machine-local pinned toolchain (gitignored; created by the pin script) |
| `lib/forge-std` | Vendored forge-std, so a bare clone is self-contained |

## How the harness works

`scripts/check-core.sh` compiles each contract: `sol-core` (.solc to .hull),
`yule` (.hull to .yul), then `solc --strict-assembly` (.yul to hex
initcode) into `build/`. `test/CoreDeploy.sol` reads that hex with
`vm.readFile`, appends ABI-encoded constructor args, and deploys it with
`create`. Tests then talk to the deployed address through a hand-authored
interface, so they read like ordinary forge tests and every Foundry feature
works. The interface, not the compiler, is the ABI source of truth: the
compiler's `--abi` cannot see events, errors, or view/pure, so
`test/<Name>Abi.sol` declares them and `scripts/sync-abi.sh` renders JSON.

## The canary

A research compiler moves under you. `src/Probe.solc` holds one tiny
function per language feature this project relies on, and `test/Probe.t.sol`
pins each one's exact runtime behavior - down to the wire shape of
`require(cond, "msg")`, which reverts with the RAW message bytes, not
Solidity's `Error(string)` encoding. `check-core.sh` compiles Probe first,
so after a toolchain bump, drift fails small and labeled instead of
somewhere deep inside your real contract. When you adopt a new language
feature, add a canary function and a pinning test alongside it.

## The toolchain pin

The compiler binaries and the std library must move together: a compiler at
one rev running against std sources from another fails in confusing ways or,
worse, works by accident. `pin-toolchain.sh` therefore builds `sol-core` and
`yule` from a single solcore rev, snapshots `std/` at that same rev, and
records the rev; everything lands in `toolchain/` as nix GC-rooted links.
`check-core.sh` stamps every build with the rev, binary hashes, and solc
version in `build/TOOLCHAIN`. The committed stamp records exactly what
produced the committed hex; the reproducibility criterion is the hex itself,
byte for byte (binary hashes can differ across platforms, the bytecode must
not).

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
