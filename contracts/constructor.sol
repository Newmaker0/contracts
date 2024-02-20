// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ConstructorContract {
    uint256 private initialValue1;

    constructor(uint256 _initialValue) {
        initialValue1 = _initialValue ;
    }

    function getInitialValue() public view returns (uint256) {
        return initialValue1;
    }
}

