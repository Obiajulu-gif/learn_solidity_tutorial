# Web3 Solidity Contracts Collection

This repository contains a set of Solidity smart contracts demonstrating fundamental Web3 development concepts such as storage, ownership, voting, messaging, address handling, booleans, constructors, mappings, strings, view and pure functions, wrap-around arithmetic, and more. Designed for educational and development purposes, these contracts serve as a solid foundation for building decentralized applications.



Contracts Overview

## Storage (1_Storage.sol)

A simple contract to store and retrieve a uint256 value.


// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Storage {
    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256) {
        return number;
    }
}

## Owner Management (2_Owner.sol)

Handles owner assignment and transfer with access control.


// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Owner {
    address private owner;
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }

    function changeOwner(address newOwner) public isOwner {
        require(newOwner != address(0), "New owner should not be zero address");
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}

## Voting System (3_Ballot.sol)

Implements a ballot voting process with delegation.


// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) external {
        require(msg.sender == chairperson, "Only chairperson can give right to vote");
        require(!voters[voter].voted, "Voter already voted");
        require(voters[voter].weight == 0, "Voter already has right to vote");
        voters[voter].weight = 1;
    }

    function delegate(address to) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "No right to vote");
        require(!sender.voted, "Already voted");
        require(to != msg.sender, "Self-delegation disallowed");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Loop in delegation");
        }

        Voter storage delegate_ = voters[to];
        require(delegate_.weight >= 1, "Delegate has no right to vote");

        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "No right to vote");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint) {
        uint winningVoteCount 0;
        uint winningProposalIndex = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposalIndex = p;
            }
        }
        return winningProposalIndex;
    }

    function winnerName() external view returns (bytes32) {
        proposals[winningProposal()].name;
    }
}

## Address Handling (4_ExampleAddress.sol)

Allows setting an address and checking its balance.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleAddress {
    address public someAddress;

    function setSomeAddress(address _someaddress) public {
        someAddress = _someaddress;
    }

    functionAddressBalance() public view returns (uint) {
        return someAddress.balance;
    }
}

Boolean State (5_ExampleBoolean.sol)

Toggle a boolean value.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract MyBoolean {
    bool public mybool;

    function setBoolean(bool _setbool) public {
        mybool = !_setbool;
    }
}

Constructor Usage (6_ExampleConstructor.sol)

Set initial address at deployment or later.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleConstructor {
    address public myAddress;

    constructor(address _someAddress) {
        myAddress = _someAddress;
    }

    function setMyAddress(address _myAddress) public {
        my = _myAddress;
    }

    function setMyAddressToMsgSender() public {
        myAddress = msg.sender;
    }
}

## Mappings in Solidity (7_ExampleMapping.sol)

Demonstrates different types of mappings.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleMapping {
    mapping(uint => bool) public myMapping;
   (address => bool) public myAddressMapping;
    mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
        uintUintBoolMapping[_key1][_key2] = _value;
    }
}

Msg Sender Example (8_ExampleMsgSender.sol)

Stores the sender’s address.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleMsgSender {
    address public someAddress;

    function updateSomeAddress() public {
        someAddress = msg.sender;
    }
}

## String Handling (9_ExampleString.sol)

Stores and compares strings.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleStrings {
    string public myString = "Hello World";

    function setString(string memory _setString) public {
        myString = _setString;
    }

    function compareTwoStrings(string memory _myString) public view returns (bool) {
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}

## View & Pure Functions (10_ExampleViewPure.sol)

Showcases functions that do not modify state.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleViewPure {
    uint public myStorageVariable;

    function getMyStorageVariable() public view returns (uint) {
        return myStorageVariable;
    }

    function getAddition(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function setMyStorageVariable(uint _newVar) public returns (uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }
}

## Wrap-Around Arithmetic (11_ExampleWrapAround.sol)

Demonstrates unsigned integer overflow/underflow handling.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract ExampleWrapAround {
    uint256 public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function decrementUint() public {
        unchecked {
            myUint--;
        }
    }

    function incrementUint() public {
        myUint++;
    }
}

Simple String Contract (12_myContract.sol)

Basic string update via function.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract myContract {
    string public ourstring = "Hello world";

    function updateStringFunction(string memory _updateString) public {
        ourstring = _updateString;
    }
}

## Messaging with Access Control (13_TheBlockchainMessenger.sol)

Allows the owner to update a message.


// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.30;

contract TheBlockchainMessenger {
    uint public changeCounter;
    address public owner;
    string public theMessage;

    constructor() {
        owner = msg.sender;
    }

    function updateTheMessage(string memory _newMessage) public {
        if (msg.sender == owner) {
            theMessage = _newMessage;
            changeCounter++;
        }
    }
}


Usage & Deployment


Use Remix IDE for deploying and testing these contracts.

Use provided scripts (deploy_with_ethers.ts, deploy_with_web3.ts) for automated deployment via Hardhat or Web3.js.



License

All contracts are licensed under GPL-3.0.



Feedback & Contributions

Feel free to fork, modify, and suggest improvements. Ensure to follow best Web3 security and gas optimization practices.



This collection serves as a resource for Solidity learners and developers to understand core concepts and best practices in blockchain development.

AI Beta
