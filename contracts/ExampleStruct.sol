// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

// Child Contract
// this cost a bit more gas
contract Wallet {
    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

// Struct Contract
// this is more gas efficient , whereby it cost less in gas
contract Wallet2 {
    struct PaymentRecievedStruct {
        address from;
        uint amount;
    }

    PaymentRecievedStruct public payment;

    function paycontract() public payable {
        payment = PaymentRecievedStruct(msg.sender, msg.value);
    }
}


contract PaymentReceived {
    address public from;
    uint public amount;
    
    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}