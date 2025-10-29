// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Sender {
    // this receive ether in the contract
    receive() external payable { }

    function withdrawTransfer(address payable _to) public {
        // the .transfer() will throw an error when the transaction fails
        // and it will revert back
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public returns(bool) {
        // the .send() will return a boolen false when the transaction fails
        // and it return true when it when sucessfully
        bool sucess = _to.send(10);
        return sucess;
    }

}

contract ReceiverNoAction {
    function balance() public view returns(uint){
        return address(this).balance;
    }

    // recieve ether in the contract without doing anything
    receive() external payable { }
}

contract ReceiverAction {
    uint public balanceReceived;

    // receive ether and store the ether in a storage variable
    // the process of storing ether basically cost much 
    receive() external payable { 
        balanceReceived += msg.value;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }
}