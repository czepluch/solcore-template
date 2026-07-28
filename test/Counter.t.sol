// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Test} from "forge-std/Test.sol";
import {CoreDeploy} from "./CoreDeploy.sol";
import {CounterAbi} from "./CounterAbi.sol";

/// @notice The example suite: deploys the compiled Core Solidity bytecode
///         (build/Counter.json) and drives it through the hand-authored
///         typed interface, so tests read exactly like ordinary forge
///         tests - fuzzing and exact revert assertions included.
contract CounterTest is Test {
    CounterAbi counter;

    function setUp() public {
        counter = CounterAbi(CoreDeploy.deploy("Counter", ""));
    }

    function test_startsAtZero() public view {
        assertEq(counter.number(), 0);
    }

    function test_increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
        counter.increment();
        assertEq(counter.number(), 2);
    }

    function testFuzz_setNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_decrement() public {
        counter.setNumber(2);
        counter.decrement();
        assertEq(counter.number(), 1);
    }

    /// The require message arrives as raw bytes (the wire shape pinned by
    /// test/Probe.t.sol), so expectRevert matches the bare string - no
    /// Error(string) wrapping.
    function test_decrementRevertsAtZero() public {
        vm.expectRevert(bytes("underflow"));
        counter.decrement();
    }
}
