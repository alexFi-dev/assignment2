// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Game {
    // Тип - перечисление для выбора ходов
    enum SPS {STONE, PAPER, SCISSORS}
    SPS public spsGame;

    // Ставка - мин. для участия в игре
    uint constant MIN_BET = 0.0001 ether;

    // события для отправки в приложение
    event gamePlayed(address user, bool isWinner);
    
    constructor() {}

    // типа(fake game) начинаем играть
    function play(SPS choice) payable public {
        require(msg.value >= MIN_BET, "Minimum bid not met");

        // из ТЗ: игрок случайным образом может выиграть или проиграть 
        if (theFate()) {
            payable(msg.sender).transfer(msg.value*2); 
            emit gamePlayed(msg.sender, true);
        }
    }

    // случайным образом получаем true/false
    function theFate() private returns (bool) {
        uint256 isLucky = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        return (isLucky % 2 == 0);
    }

    // чтобы пополнить контракт
    receive () external payable {}
}