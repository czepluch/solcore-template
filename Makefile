# Build orchestration. forge cannot compile Core Solidity (foundry.toml
# skips src/), so the Core artifacts are built first (scripts/check-core.sh
# into build/) and then consumed by forge via vm.getCode. `make toolchain`
# installs the toolchain pinned in toolchain.lock into .toolchain/; without
# it, `make test` still works by testing the committed artifacts.

.PHONY: all toolchain build test fmt fmt-check clean

CORE_SOURCES := $(shell find src -name '*.sol')

all: build

## toolchain: download the toolchain pinned in toolchain.lock into .toolchain/
toolchain:
	./scripts/toolchain.sh install

## build: compile src/*.sol (Core Solidity) to build/ artifacts, then forge build
build:
	./scripts/check-core.sh
	forge build

## test: rebuild artifacts when the toolchain is installed, then forge test
test:
	@if ./scripts/check-core.sh --check-toolchain 2>/dev/null; then \
		./scripts/check-core.sh; \
	else \
		echo "note: no Core Solidity toolchain installed; testing the committed artifacts"; \
		echo "      (install it with: make toolchain)"; \
	fi
	forge test

## fmt: format the Core Solidity sources and the Solidity harness
fmt:
	fmt=$$(./scripts/toolchain.sh path solcore-fmt) && "$$fmt" --write $(CORE_SOURCES)
	forge fmt

## fmt-check: verify formatting of the Core Solidity sources and the harness
fmt-check:
	fmt=$$(./scripts/toolchain.sh path solcore-fmt) && "$$fmt" --check $(CORE_SOURCES)
	forge fmt --check

## clean: remove forge outputs (build/ holds committed artifacts; not cleaned)
clean:
	forge clean
