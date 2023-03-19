// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// @custom:security-contact alexfi.dev@code.mba
contract Token is ERC20 {
    constructor() ERC20("LexToken", "LT") {
        _mint(msg.sender, 100 * 10 ** decimals());
    }
}