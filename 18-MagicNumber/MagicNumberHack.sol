// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract MagicNum {

  address public solver;

  constructor() public {}

  function setSolver(address _solver) public {
    solver = _solver;
  }
}

contract MagicNumberHack {
    MagicNum ogContract = MagicNum(/* your instance address */);
    
    function attack() public {
        address solver;
        bytes32 salt = 0;
        bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
        
        assembly {
            solver := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        
        ogContract.setSolver(solver);
    }
}