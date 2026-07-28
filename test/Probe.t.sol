// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {CoreDeploy} from "./CoreDeploy.sol";

/// @notice Toolchain gate: proves the full sol-core -> yule -> solc -> forge
///         pipeline (constructor args, storage, dispatch) and pins the exact
///         runtime behavior of every language-feature canary in Probe.solc.
///         Raw .call is deliberate here: these tests assert wire shapes, so
///         no interface sugar sits between the assertion and the bytes.
contract ProbeTest is Test {
    address p;

    function setUp() public {
        p = CoreDeploy.deploy("Probe", abi.encode(uint256(42)));
    }

    function test_probe_ctorArgs_storage_and_dispatch() public {
        (bool ok, bytes memory ret) = p.call(abi.encodeWithSignature("get()"));
        assertTrue(ok, "get() reverted");
        assertEq(abi.decode(ret, (uint256)), 42, "ctor arg lost");

        // Unknown selector must revert (default dispatch behavior).
        (ok,) = p.call(abi.encodeWithSignature("nope()"));
        assertFalse(ok, "unknown selector did not revert");
    }

    /// require(cond, "message"): the failure payload is the RAW UTF-8 bytes
    /// of the message - no Error(string) selector, no ABI head. Anything
    /// matching revert messages (tests, clients, indexers) must expect this
    /// shape, which is why it gets its own pin.
    function test_probe_requireMessage_revertsRawBytes() public {
        (bool ok, bytes memory ret) =
            p.call(abi.encodeWithSignature("demandPositive(uint256)", 5));
        assertTrue(ok, "happy path reverted");
        assertEq(abi.decode(ret, (uint256)), 5);

        (ok, ret) = p.call(abi.encodeWithSignature("demandPositive(uint256)", 0));
        assertFalse(ok, "zero did not revert");
        assertEq(ret, bytes("Probe: x must be positive"), "revert is not raw message bytes");
    }

    /// Bare integer literals in non-tail returns (call-expected-type
    /// unification).
    function test_probe_bareLiteralNonTailReturn() public {
        (bool ok, bytes memory ret) = p.call(abi.encodeWithSignature("bareLit(uint256)", 0));
        assertTrue(ok);
        assertEq(abi.decode(ret, (uint256)), 1);
        (ok, ret) = p.call(abi.encodeWithSignature("bareLit(uint256)", 7));
        assertTrue(ok);
        assertEq(abi.decode(ret, (uint256)), 0);
    }
}
