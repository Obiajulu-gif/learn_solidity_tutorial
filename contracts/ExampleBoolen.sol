// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract MyBoolen {
    bool public mybool;

    function setBoolen(bool _setbool) public  {
        mybool = !_setbool;
    }
}