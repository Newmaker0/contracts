// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ConstructorContract {
    uint256 private initialValue;

    constructor(uint256 _initialValue) {
        initialValue = _initialValue + 1123;
    }

    function getInitialValue() public view returns (uint256) {
        return initialValue;
    }
}

