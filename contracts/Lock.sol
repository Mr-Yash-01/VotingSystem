// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Lock {
    struct ElectionDetails {
        string electionName;
        string[] candidateNames; // Store candidate names separately
        mapping(string => uint256) candidateVotes;
    }

    mapping(string => ElectionDetails) private elections;
    event VoteCast(string electionName,string candidateName);

    function addElectionWithCandidates(string memory _electionName, string[] memory _candidates) public {
        require(bytes(_electionName).length > 0, "Election name cannot be empty");
        require(bytes(elections[_electionName].electionName).length == 0, "Election already exists");

        elections[_electionName].electionName = _electionName;

        for (uint256 i = 0; i < _candidates.length; i++) {
            elections[_electionName].candidateVotes[_candidates[i]] = 0;
            elections[_electionName].candidateNames.push(_candidates[i]); // Add candidate name
        }
    }

    function vote(string memory _electionName, string memory _candidateName) public {
        require(bytes(_electionName).length > 0, "Election name cannot be empty");
        require(bytes(elections[_electionName].electionName).length > 0, "Election does not exist");

        // uint256 votes = elections[_electionName].candidateVotes[_candidateName];
        // require(votes != 0, "Candidate does not exist");

        elections[_electionName].candidateVotes[_candidateName]++;
        emit  VoteCast(_electionName, _candidateName);
    }

    function getCandidateVotes(string memory _electionName, string memory _candidateName) public view returns (uint256) {
        require(bytes(_electionName).length > 0, "Election name cannot be empty");
        require(bytes(elections[_electionName].electionName).length > 0, "Election does not exist");

        return elections[_electionName].candidateVotes[_candidateName];
    }

    function getCandidateNames(string memory _electionName) public view returns (string[] memory) {
        require(bytes(_electionName).length > 0, "Election name cannot be empty");
        require(bytes(elections[_electionName].electionName).length > 0, "Election does not exist");

        return elections[_electionName].candidateNames;
    }

    function getElectionResult(string memory _electionName) public view returns (string memory, string[] memory, uint256[] memory) {
        require(bytes(_electionName).length > 0, "Election name cannot be empty");
        require(bytes(elections[_electionName].electionName).length > 0, "Election does not exist");

        ElectionDetails storage election = elections[_electionName];
        uint256 length = election.candidateNames.length;
        uint256[] memory votes = new uint256[](length);

        for (uint256 i = 0; i < length; i++) {
            votes[i] = election.candidateVotes[election.candidateNames[i]];
        }

        return (election.electionName, election.candidateNames, votes);
    }
}
