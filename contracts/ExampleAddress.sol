// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract ExampleAddress {
    address public someAddress;

    function setSomeAddress(address _someaddress) public {
        someAddress = _someaddress;
    }

    function getAddressBalance() public view returns(uint) {
        return someAddress.balance;
    }
}