# Build orchestration. forge has no native hook for compiling .solc, so the
# Core Solidity artifacts are built first (scripts/check-core.sh into
# build/) and then consumed by forge via vm.getCode. Inside the dev shell
# (nix develop) the toolchain is on PATH; outside it, `make test` still
# works by testing the committed artifacts.

.PHONY: all build test fmt fmt-check clean

all: build

## build: compile src/*.solc to build/ artifacts, then forge build
build:
	./scripts/check-core.sh
	forge build

## test: rebuild artifacts when a complete toolchain is available, then forge test
test:
	@if ./scripts/check-core.sh --check-toolchain 2>/dev/null; then \
		./scripts/check-core.sh; \
	else \
		echo "note: no complete Core Solidity toolchain available; testing the committed artifacts"; \
		echo "      (enter one with: nix develop)"; \
	fi
	forge test

## fmt: format the Solidity harness
fmt:
	forge fmt

## fmt-check: verify formatting
fmt-check:
	forge fmt --check

## clean: remove forge outputs (build/ holds committed artifacts; not cleaned)
clean:
	forge clean
