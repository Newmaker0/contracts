// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ImportContract is Ownable {
    uint256 private value;

    function setValue(uint256 _value) public onlyOwner {
        value = _value;
    }

    function getValue() public view returns (uint256) {
        return value;
    }
}

