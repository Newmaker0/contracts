// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // You can initialize the token with fixed values since we're not using a constructor
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000 * (10 ** uint256(decimals())));
    }
}
