# solcore-template

A project template for [Core Solidity](https://github.com/argotorg/solcore-rs), using Foundry for testing until the tooling matures.

The Core Solidity sources in `src/` are compiled to EVM bytecode, deployed inside forge tests, and called through hand-written Solidity interfaces.
The compiled artifacts are committed, so `forge test` works without a Core Solidity toolchain.

## Quickstart

```sh
forge init my-project --template czepluch/solcore-template
cd my-project
forge test
```

To rename the example contract:

```sh
scripts/scaffold.sh MyContract
```

## Development

Install the pinned toolchain once (Linux or macOS, needs `curl`, `tar`, and `jq`):

```sh
make toolchain
```

Then edit `src/*.sol` and run:

```sh
make fmt
make test
```

`make test` rebuilds `build/` from `src/` and runs `forge test`.
Plain `forge test` only tests what is already in `build/`, so commit the rebuilt `build/` together with your source changes.

For editor support, install an editor integration from the [solcore-rs releases](https://github.com/argotorg/solcore-rs/releases) and set `SOLCORE_PATH` (in VS Code, the `solcore.path` setting) to the absolute path of `.toolchain/solcore-<version>/solcore`.

## Layout

| Path | Contents |
| --- | --- |
| `src/` | Core Solidity sources: the example contract `Counter.sol` and the example module `math.sol` |
| `test/` | Forge tests, the interface `CounterAbi.sol`, and `CoreDeploy.sol`, which deploys a built contract |
| `build/` | Committed artifacts (`<Name>.json`) and the `TOOLCHAIN` stamp |
| `abi/` | Complete ABI JSON, rendered from `test/<Name>Abi.sol` by `scripts/sync-abi.sh` |
| `toolchain.lock` | Pinned solcore and solc releases with their checksums, and the EVM version |
| `scripts/` | `toolchain.sh`, `check-core.sh`, `sync-abi.sh`, `scaffold.sh` |

## How it works

`scripts/check-core.sh` compiles every contract in a top-level `src/*.sol` file with `solcore` to Yul, then with `solc` to bytecode, and writes `build/<Name>.json`.
forge never compiles `src/`: `foundry.toml` excludes it from build, test, and fmt.
Tests deploy the artifact with `CoreDeploy` and call it through the interface in `test/<Name>Abi.sol`.

That interface is the source of truth for the ABI, because the compiler's ABI output has no events, errors, or view/pure.
`scripts/sync-abi.sh` renders it to `abi/<Name>.json`.

## Modules

Every Core Solidity source starts with `pragma solcore;`.
Contract files are named after their contract in UpperCamelCase (`Counter.sol`).
Shared code goes in lowercase modules without a contract (`math.sol`), which export names with `export { ... }`.

| Import | Resolves to |
| --- | --- |
| `from math` | `math.sol` next to the importing file |
| `from util.math` | `util/math.sol` below the importing file's folder |
| `from lib.src.math` | `src/math.sol` from the repository root |
| `from std.dispatch` | the standard library shipped with `solcore` |

Builds resolve `lib.` imports from the repository root, as editors do when the repository is the open workspace.

## Toolchain

`toolchain.lock` pins the [solcore](https://github.com/argotorg/solcore-rs/releases) and [solc](https://github.com/argotorg/solidity/releases) releases and the EVM version.
`make toolchain` downloads them into `.toolchain/` and rejects any download whose sha256 differs from the lock.
`build/TOOLCHAIN` records the toolchain that built the artifacts.

To bump it:

```sh
scripts/toolchain.sh pin --solcore latest   # or --solc, or an exact version
make toolchain
make test
git diff build/
```

When changing `--evm-version`, set the same `evm_version` in `foundry.toml`.
To build with other binaries, set `SOLCORE`, `SOLCORE_FMT`, and `SOLC`.

## CI

The `forge` job runs the tests against the committed artifacts.
The `reproduce` job installs the pinned toolchain, rebuilds `build/`, and fails if it differs from what is committed or if a source is not formatted.

## License

MIT, see [LICENSE](LICENSE).
