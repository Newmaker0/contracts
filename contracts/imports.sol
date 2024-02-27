// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    struct Poll {
        uint id;
        string question;
        string[] options;
        mapping(uint => uint) votes; // option index => votes count
        mapping(address => bool) hasVoted;
        bool exists;
    }

    uint private pollCount = 0;
    mapping(uint => Poll) private polls;
    mapping(address => bool) private voters;

    event PollCreated(uint pollId, string question, string[] options);
    event Voted(uint pollId, uint option, address voter);

    modifier hasNotVoted(uint pollId) {
        require(polls[pollId].exists, "Poll does not exist.");
        require(!polls[pollId].hasVoted[msg.sender], "You have already voted.");
        _;
    }

    function createPoll(string memory question, string[] memory options) public {
        require(options.length > 1, "A poll must have at least two options.");
        Poll storage newPoll = polls[++pollCount];
        newPoll.id = pollCount;
        newPoll.question = question;
        newPoll.options = options;
        newPoll.exists = true;
        emit PollCreated(pollCount, question, options);
    }

    function vote(uint pollId, uint option) public hasNotVoted(pollId) {
        require(option < polls[pollId].options.length, "Invalid option.");
        polls[pollId].votes[option]++;
        polls[pollId].hasVoted[msg.sender] = true;
        emit Voted(pollId, option, msg.sender);
    }

    function getPoll(uint pollId) public view returns (string memory question, string[] memory options, uint[] memory votes) {
        require(polls[pollId].exists, "Poll does not exist.");
        uint optionsCount = polls[pollId].options.length;
        votes = new uint[](optionsCount);

        for (uint i = 0; i < optionsCount; i++) {
            votes[i] = polls[pollId].votes[i];
        }

        return (polls[pollId].question, polls[pollId].options, votes);
    }

    function getPollResults(uint pollId) public view returns (uint[] memory) {
        require(polls[pollId].exists, "Poll does not exist.");
        uint[] memory results = new uint[](polls[pollId].options.length);
        for(uint i = 0; i < polls[pollId].options.length; i++) {
            results[i] = polls[pollId].votes[i];
        }
        return results;
    }
}
