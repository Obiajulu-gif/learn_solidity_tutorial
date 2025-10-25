// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract ExampleMsgSender {
    address public someAddress;
    function updateSomeAddress() public  {
        someAddress = msg.sender;
    }
}