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