// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    // 一个mapping来存储候选人的得票数
    mapping(uint256 personId => uint256 votes) public votesReceived; // mapping variable here

    uint256[] public candidates;

    constructor(uint256[] memory _canditateArry) {
        candidates = _canditateArry;
    }
    
    // constructor
    // 允许用户投票给某个候选人
    function vote(uint256 candidateId) public {
        
        votesReceived[candidateId] += 1;
    }

    function getVotes(uint256 candidateId) public view returns (uint256) {
        return votesReceived[candidateId];
    }

    function resetVotes() public {
        for (uint i=0; i < candidates.length; i++) {
            candidates[i] = 0;
        }
    }


}
