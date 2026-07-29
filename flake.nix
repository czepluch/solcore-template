{
  description = "solcore-template - Core Solidity compiler plus Foundry toolchain";

  inputs = {
    # The Core Solidity compiler (one package, two executables: bin/sol-core
    # and bin/yule) and, via its source tree, the std library. The rev in
    # this URL IS the toolchain pin: binaries and std can never skew apart
    # because both come from this single input. To bump the toolchain, edit
    # the rev here (or drop the /<rev> suffix and run `nix flake update
    # solcore`), rebuild with scripts/check-core.sh, and let the canary
    # tests tell you what moved.
    solcore.url = "github:argotorg/solcore/ca20a51fe28d2d3fe6046ad77e1877f3fcec38bc";

    # Reuse solcore's pinned nixpkgs and foundry overlay so the whole
    # toolchain (compiler, solc assembler, forge) moves as one set.
    nixpkgs.follows = "solcore/nixpkgs";
    flake-utils.follows = "solcore/flake-utils";
    foundry.follows = "solcore/foundry";
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.foundry.overlay ];
        };

        solcorePkg = inputs.solcore.packages.${system}.sol-core;
        solcoreStd = "${inputs.solcore}/std";
        solcoreRev = inputs.solcore.rev or "unlocked";
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            solcorePkg # sol-core + yule
            pkgs.foundry-bin # forge, cast, anvil
            pkgs.solc # Yul -> EVM assembler
            pkgs.jq
            pkgs.gnumake
          ];

          # scripts/check-core.sh reads STD (std library path) and
          # SOLCORE_REV (for the build/TOOLCHAIN stamp); the binaries it
          # finds on PATH.
          shellHook = ''
            export STD="${solcoreStd}"
            export SOLCORE_REV="${solcoreRev}"
            echo "solcore-template dev shell: sol-core, yule, forge, solc, jq (solcore ${solcoreRev})"
            echo "  compile:  scripts/check-core.sh   (or: make build)"
            echo "  test:     forge test              (or: make test)"
          '';
        };
      });
}
