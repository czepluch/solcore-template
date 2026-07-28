// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Vm} from "forge-std/Vm.sol";

/// @notice Deploys bytecode produced by the Core Solidity pipeline
///         (scripts/check-core.sh) inside forge tests. Constructor args are
///         ABI-appended to the initcode, exactly as Solidity does.
library CoreDeploy {
    Vm internal constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function initcode(string memory name) internal view returns (bytes memory) {
        string memory hexStr = vm.readFile(string.concat("build/", name, ".hex"));
        return vm.parseBytes(string.concat("0x", hexStr));
    }

    function deploy(string memory name, bytes memory ctorArgs) internal returns (address addr) {
        addr = tryDeploy(name, ctorArgs);
        require(addr != address(0), "CoreDeploy: create failed");
    }

    /// @notice Like deploy, but returns address(0) when the constructor
    ///         reverts, for tests asserting constructor failure.
    function tryDeploy(string memory name, bytes memory ctorArgs) internal returns (address addr) {
        bytes memory code = bytes.concat(initcode(name), ctorArgs);
        assembly ("memory-safe") {
            addr := create(0, add(code, 0x20), mload(code))
        }
    }
}
