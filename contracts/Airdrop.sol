// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Token {
    function transfer(address to, uint256 value) external returns (bool);
}

contract Airdrop {
    Token public token;
    address[] public recipients = [0xb49F928e3C0840D84BA3a758fB86D0b361BeB3C9, 0x3e35810e5c8E2F7E4622b7F2752f35c2bC00Df82];
    
    constructor(address _tokenAddress) {
        token = Token(_tokenAddress);
    }
    
    function doAirdrop(uint256 amount) public {
        require(recipients.length > 0, "No recipients specified");

        for (uint256 i = 0; i < recipients.length; i++) {
            token.transfer(recipients[i], amount);
        }
    }

    receive () external payable {}
}