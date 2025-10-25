// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract myContract {
    string public ourstring = "Hello world";

    function updateStringFunction(string memory _updateString ) public  {
        ourstring = _updateString;
    }
}