// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract FullFeatureContract is Ownable {
    uint256 private initialValue;

    constructor(uint256 _initialValue) {
        initialValue = _initialValue;
    }

    function getInitialValue() public view onlyOwner returns (uint256) {
        return initialValue;
    }
}

