// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract ExampleStrings {
    string public myString = "Hello World";

    function setString(string memory _setString) public  {
        myString = _setString;
    }

    function compareTwoStrings(string memory _myString) public view returns(bool){
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}