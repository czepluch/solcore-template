// A module: shared code with no contract. check-core.sh builds no artifact
// for it; it is compiled into each contract that imports it. `export` lists
// the names other files may import.
pragma solcore;

import * from std;

export { decremented };

// Returns n - 1. At zero it reverts with the raw message bytes "underflow"
// (not Solidity's Error(string) encoding); test/Counter.t.sol pins that wire
// shape. The message embeds no contract name, so scripts/scaffold.sh can
// rename the contract without invalidating the committed build artifacts.
function decremented(n: uint256) returns (uint256) {
    require(n > 0, "underflow");
    return n - 1;
}
