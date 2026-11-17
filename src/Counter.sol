// The example contract: a Core Solidity port of forge's default Counter.
// Same external surface (number(), setNumber(uint256), increment()) plus a
// decrement() that uses the decremented helper from the src/math.sol module.
//
// Replace this contract with your own.
pragma solcore;

import * from std;
import * from std.dispatch;
import { decremented } from math;

contract Counter {
    number: uint256;

    // A storage field and a public function may share a name; the function
    // is the ABI accessor (there are no auto-generated getters).
    function number() public returns (uint256) {
        return number;
    }

    function setNumber(newNumber: uint256) public {
        number = newNumber;
    }

    function increment() public {
        number = number + 1;
    }

    // Reverts with the raw bytes "underflow" at zero (see src/math.sol).
    function decrement() public {
        number = decremented(number);
    }
}
