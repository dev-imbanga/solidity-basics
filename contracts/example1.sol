// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// example one.
contract SimpleStorage {
    uint storedData;
    function set(uint x) public {
        storedData = x;
    }
    function get() public view returns (uint) {
        return storedData;
    }
}
// the above contract declares a state variable of type uint 256
// has two functions and they can be used to modify or retrieve the value of the variable.


