// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    struct Voter {
        uint256 weight; // 权重（拥有的票数）
        bool voted;  // 是否已经投票
        address delegate; // t投票人地址
        uint8 candidateId; // 投给的候选人编号
    }
    struct candidate {
        string name;
        uint8 id;
        uint256 votes;
    }
    mapping(address => uint256 ) public votesReceived; // mapping variable here
    
    function vote(address sender, uint256 voteCount) public {
        votesReceived[sender] += voteCount;
    }

    function getVotes() public {}

    function resetVotes() public {
        votesReceived.clear();
    }


}