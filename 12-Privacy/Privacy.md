This is another lesson in using private-type variables and accessing storage slots. 

## Explanation
When using private-type variables you must be aware that they are readable by anyone via the web3 function getStorageAt().

This level is a little trickier in that it defines an array as the last state variable. Here's a rundown of how Solidity stores these variables:

```bash
  bool public locked = true; # bool is 1 byte but uses a whole 32 byte slot
  uint256 public ID = block.timestamp; # uint256 is 32 bytes --> 1 whole slot
  uint8 private flattening = 10; # 1 byte --> takes up 1/32 bytes of a slot
  uint8 private denomination = 255; # 1 byte --> takes up another 1/32 of the same slot
  uint16 private awkwardness = uint16(now); # 2 bytes --> takes up another 2/32 of the same slot (total of 4/32 bytes occupied in the current slot)
  bytes32[3] private data; # Takes up 3 different slots to account for all three 32 byte array values
```

In total, the variables of this contract take up 6 slots of memory.

NOTE: 
This is also a mini-lesson on efficient variable ordering. There is no reason the bool variable should be taking up a whole slot when the 3rd slot has room. To be more efficient with contract storage, simply switch the locked variable and the ID variable to reduce the number of slots needed.

Since we now know how many slots there are and we know that the key is in the 2nd array index, we can solve this level.

## Solution
To solve this level, use Remix to create an attacking contract that uses the key to call the unlock function of the original contract.

What I did was call the following:

```bash
    await web3.eth.getStorageAt(contract.address, 5)
```

I then copied that value into a bytes32 variable in my attacking contract. 

From there, cast it into a bytes16 and you have your key.

See PrivacyHack.sol for the full solution.

