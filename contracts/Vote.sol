// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    
    struct Poll {
        uint256 id;
        string topic;
        string[] options;
        uint256[] votesCount;
        bool active;
    }
    
    Poll[] public polls;
    uint256 public nextSessionId = 0;

    constructor() {}
    
    function openPoll(string memory _topic, string[] memory _options) public payable {
        uint256[] memory initialVotesCount = new uint256[](_options.length);
        polls.push(Poll({
            id: nextSessionId,
            topic: _topic,
            options: _options,
            votesCount: initialVotesCount,
            active: true
        }));
        nextSessionId++;
    }

    function vote(uint256 _id, string memory _option) public payable {
        require(_id < polls.length, "Invalid session ID");
        Poll storage poll = polls[_id];
        
        require(poll.active, "Session is not active");

        uint256 optionIndex = findOptionIndex(poll, _option);
        require(optionIndex != type(uint256).max, "Option not found");
        
        poll.votesCount[optionIndex]++;
    }

    function findOptionIndex(Poll storage poll, string memory option) internal view returns (uint256) {
        for (uint256 i = 0; i < poll.options.length; i++) {
            if (keccak256(abi.encodePacked(poll.options[i])) == keccak256(abi.encodePacked(option))) {
                return i;
            }
        }
        return type(uint256).max;
    }

    function closePoll(uint256 _id) public payable {
        
    }
    
    function getPollsCount() public view returns(uint256) {
        return polls.length;
    }
    
    function getPoll(uint256 _id) public view returns(string memory, string[] memory, uint256[] memory) {
        require(_id < polls.length, "Invalid session ID");
        Poll storage poll = polls[_id];
        return (poll.topic, poll.options, poll.votesCount);
    }
}