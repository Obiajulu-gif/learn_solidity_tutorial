// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract ExampleMappingWithdrawals {
    mapping(address => uint) public balanceRecieved; // this is just like the leger that record the transaction onchain
    
    // this records how much ether they have sent under thier address
    // it accumulate their deposit if they send mutiples transactions
    function sendMoney() public payable  {
        balanceRecieved[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint)  {
        return address(this).balance;
    }

    // this send back the ether the user store in the smart contract
    // by checking it address which is mapped to his ether
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceRecieved[msg.sender]; // this get how much the caller has stored in the smart contract
        balanceRecieved[msg.sender] = 0; // ensure that once the user withdraws their money, their stored record is reset
        _to.transfer(balanceToSendOut);
    }
}