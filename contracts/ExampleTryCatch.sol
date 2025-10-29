// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract WillThrow {
    function aFunction() public pure{
        require(false, "Error Message");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);

    function catchTheError() public{
        WillThrow will = new WillThrow();
        try will.aFunction() { 

        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {
            emit ErrorLogCode(errorCode);
        } catch(bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }
    }
}