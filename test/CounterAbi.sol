// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

/// @notice Complete external interface of the Core Solidity `Counter`
///         contract. The solcore compiler's --abi covers functions,
///         constructor, and fallback only (no events, errors, or view/pure
///         mutability), so a hand-authored interface like this is the ABI
///         source of truth. Run scripts/sync-abi.sh (forge
///         inspect) to get it as JSON. Every signature here is verified
///         against the compiled bytecode by test/Counter.t.sol.
interface CounterAbi {
    function number() external view returns (uint256);
    function setNumber(uint256 newNumber) external;
    function increment() external;
    /// @dev Reverts with the raw bytes "underflow" at zero (Core Solidity's
    ///      native require message shape - not Error(string)).
    function decrement() external;
}
