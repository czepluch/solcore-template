# solcore-template

A project template for [Core Solidity](https://github.com/argotorg/solcore-rs), using Foundry for testing until the tooling matures.

The `solcore` compiler emits standard EVM bytecode.
The harness compiles the Core Solidity sources in `src/` to bytecode artifacts, deploys them inside forge tests, and drives them through hand-written Solidity interfaces.
Fuzzing, invariant testing, exact revert assertions, and gas reports work unchanged.

The example's compiled artifacts are committed, so a fresh clone passes `forge test` without any Core Solidity toolchain.
The toolchain is only needed to rebuild the bytecode.
`toolchain.lock` pins it to exact releases, and `make toolchain` installs it.

## Quickstart

```sh
forge init my-project --template czepluch/solcore-template
cd my-project
forge test
```

`forge init --template` (forge 1.7.x) accepts `owner/repo`, an `https://` URL, or a `file:///abs/path` URL; a bare local path does not work.
`git clone` plus `forge test` is equivalent.

To rebuild the bytecode (needs Linux or macOS with `curl`, `tar`, and `jq`):

```sh
make toolchain     # download the pinned solcore and solc releases into .toolchain/
make build         # scripts/check-core.sh + forge build
forge test
git diff build/    # empty: the rebuild is byte-identical to the committed artifacts
```

## Development

Work on the Core Solidity sources in `src/`; `make test` recompiles them before running the suite:

```sh
# edit src/*.sol, then:
make fmt
make test
```

Plain `forge test` does not compile Core Solidity: it tests whatever is in `build/`.
Commit the regenerated `build/` artifacts together with the source change; the committed artifacts are what let people without a toolchain run the tests.

Committing artifacts is a policy, not a requirement: add `build/` to `.gitignore` and it behaves like forge's `out/`.
The trade-off is that a fresh clone then needs the toolchain before tests run, and `git diff build/` no longer verifies reproducibility.

The solcore-rs [releases](https://github.com/argotorg/solcore-rs/releases) also ship editor integrations for VS Code, Neovim/Vim, and Emacs, which run the `solcore lsp` language server.
To use the compiler from `.toolchain/`, set `SOLCORE_PATH` (or the editor's `solcore.path` setting) to the absolute path of `.toolchain/solcore-<version>/solcore`.
The [playground](https://playground.solcore.soliditylang.org/) and the [tutorial](https://github.com/argotorg/solcore-rs/blob/main/solcore-tutorial/README.md) cover the language itself.

## Layout

| Path | What it is |
| --- | --- |
| `src/Counter.sol` | Example contract: forge's default Counter in Core Solidity |
| `src/math.sol` | Example module: a helper Counter imports |
| `test/CoreDeploy.sol` | Deploys `build/<Name>.json` inside forge tests via `vm.getCode` |
| `test/CounterAbi.sol` | Hand-written interface: the ABI source of truth |
| `test/Counter.t.sol` | Example suite: typed calls, fuzzing, exact reverts |
| `toolchain.lock` | Pinned solcore and solc releases, the sha256 of each platform's download, and the EVM version |
| `Makefile` | `make toolchain / build / test / fmt / clean`; test rebuilds artifacts when the toolchain is installed |
| `foundry.toml` | Harness config; `skip` and `fmt.ignore` keep forge away from `src/`, `evm_version` matches the lock |
| `scripts/toolchain.sh` | Installs, locates, and pins the toolchain in `toolchain.lock` |
| `scripts/check-core.sh` | Compiles `src/*.sol` (Core Solidity) to `build/`, stamps `build/TOOLCHAIN` |
| `scripts/sync-abi.sh` | Renders each `test/<Name>Abi.sol` to `abi/<Name>.json` |
| `scripts/scaffold.sh` | Renames the Counter example to your contract name |
| `build/` | Committed pipeline output: `<Name>.json` artifacts and the `TOOLCHAIN` stamp; `<Name>.yul` is written for inspection and gitignored |
| `lib/forge-std` | Vendored forge-std, so a bare clone is self-contained |

## How the harness works

Core Solidity uses the `.sol` extension, like classic Solidity, and its module system requires it: `import * from util;` resolves to `util.sol`.
Every Core Solidity source starts with `pragma solcore;`, which tells the compiler and editors it is not classic Solidity.
forge is told to leave `src/` alone: `skip` in foundry.toml keeps `forge build` and `forge test` away from it, and `fmt.ignore` keeps `forge fmt` from parsing it.
Only `scripts/check-core.sh` compiles `src/`.

`scripts/check-core.sh` compiles each contract in two steps: `solcore` (Core `.sol` to Yul) and `solc --strict-assembly` (Yul to bytecode, for the EVM version in `toolchain.lock`).
It writes a Foundry-shaped artifact `build/<Name>.json` for every contract declared in a top-level `src/*.sol` file.
Files that declare no contract are modules and are compiled through the files that import them.
`test/CoreDeploy.sol` loads the artifact with `vm.getCode`, appends ABI-encoded constructor arguments, and deploys it with `create`.
Tests call the deployed address through a hand-written interface and read like ordinary forge tests.

The interface is the ABI source of truth, not the compiler.
The artifact bundles the compiler's `--abi` output so `cast interface build/<Name>.json` works, but that output is partial: functions, constructor, and fallback only, each marked payable or nonpayable, with no events, errors, or view/pure.
`test/<Name>Abi.sol` declares the complete surface; `scripts/sync-abi.sh` renders it to `abi/<Name>.json`.

## Modules

Contracts live in top-level files in `src/`, each named after its contract in UpperCamelCase (`Counter.sol`).
Shared code lives in lowercase modules that declare no contract, such as `src/math.sol`, which may also sit in subfolders.
A module lists the names other files may use with `export { ... }`, and an importer names what it uses: `import { decremented } from math;`.

| Import | Resolves to |
| --- | --- |
| `from math` | `math.sol` in the importing file's folder |
| `from util.math` | `util/math.sol` below the importing file's folder |
| `from lib.src.math` | `src/math.sol` from the repository root |
| `from std.dispatch` | the standard library shipped with `solcore` |

`check-core.sh` compiles with the repository root as the module root.
An editor uses the same root when the repository is opened as its workspace, so `lib.` imports resolve the same way in both.

The solcore-rs language server only indexes `.sol` files that start with `pragma solcore;`, and the VS Code extension hands every other `.sol` file to a Solidity extension.
The Core Solidity sources in `src/` and the Solidity tests in `test/` can therefore share one workspace.

## The toolchain pin

`toolchain.lock` pins the [solcore](https://github.com/argotorg/solcore-rs/releases) release, the [solc](https://github.com/argotorg/solidity/releases) release that assembles the Yul, and the EVM version both target.
For each platform it records the release asset and its sha256, taken from the digests GitHub publishes for release assets.
It covers Linux x86-64 and ARM64, and macOS on Apple Silicon and Intel.
`scripts/toolchain.sh install` (or `make toolchain`) downloads the assets for your platform into `.toolchain/` and rejects any download whose sha256 differs.
The solcore archive ships `solcore`, `solcore-fmt`, and the matching std library side by side, so compiler and std always come from the same release.

`check-core.sh` records the solcore version and release commit, the solc version, and the EVM version in `build/TOOLCHAIN`.
The reproducibility criterion is the bytecode, byte for byte.

To use another toolchain without changing the pin, for example a local build of solcore-rs, set `SOLCORE`, `SOLCORE_FMT`, and `SOLC` to its executables.
`check-core.sh` warns when their versions differ from the lock.

To bump the toolchain:

```sh
scripts/toolchain.sh pin --solcore latest    # or an exact version
scripts/toolchain.sh install
make build && forge test
git diff build/    # artifact changes, if any
```

`pin` takes `--solcore` and `--solc`, each with an exact version or `latest`, and `--evm-version` with a name such as `osaka`.
Options left out keep their current value.
`latest` includes prereleases, because solcore-rs has published only prereleases so far.
When the EVM version changes, set the same value as `evm_version` in `foundry.toml`; `check-core.sh` refuses to build while the two differ.

## CI

The `forge` job runs the suite against the committed artifacts with no Core Solidity toolchain, checks harness formatting, and checks `abi/` against the interfaces.
The `reproduce` job installs the pinned toolchain, rebuilds `build/`, and fails if the result differs from the committed artifacts or if a Core Solidity source is not formatted.

## Renaming the example

```sh
scripts/scaffold.sh MyContract
forge test
```

This renames Counter in place: source, tests, interface, ABI, and the committed build artifacts.
The compiled bytecode contains no contract name, so the artifacts stay byte-exact and tests pass without a rebuild.

## License

MIT, see [LICENSE](LICENSE).
