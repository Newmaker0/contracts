// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleContract {
    uint256 public storedData;

    function set(uint256 main) public {
        storedData = main;
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}
