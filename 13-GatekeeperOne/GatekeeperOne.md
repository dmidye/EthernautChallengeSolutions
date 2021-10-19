The lesson for this challenge is to better understand how gas is spent when Ethereum does transactions and to better understand how bytes conversions work in Solidity. This is the hardest level so far and the accepted solution does not seem to work any longer. Luckily there is another way!

In any case, I'd recommend to take your time with this one and introduce yourself to all of the different concepts this contract presents.

## Explanation
To become an entrant, you must pass three logic gates. 

### Gate One
To pass this gate, call the enter() function from a smart contract and not from your wallet address.
This is a refresher on the difference between tx.origin and msg.sender.

### Gate Two
To pass this gate, gasLeft() must be a multiple of 8191. The accepted way to do this is to use the built-in test blockchain on Remix(London VM), call enter() with an arbitrary amount of gas, and step through until you get to the "gas" opcode.  

The information that comes with the gas opcode includes the amount of gas left at that point.

So, we can take the amount of gas we specified and subtract the amount of gas left. The difference is the amount of gas used.

With that information we can take a multiple of 8191 and add the amount of gas used to it to satisfy the condition.

This method seems to only work on the London VM, it goes like this:

```python
function attack() public {
    # 8 * 12 is our multiple of 8191. 252 is the amount of gas used to get to the require(gasleft().mod(8191) == 0);
    (bool success,) = address(ogContract).call{ gas: (8191 * 12 + 252) }(abi.encodeWithSignature('enter(bytes8)', key));
    
    if(success) {
    }
}
```
I could not get this method to work on Rinkeby.

### Gate Three
To pass gate 3 you'll need to pass 3 sub-gates.

To pass all three gates, the key needs to fulfill two conditions, both achieved by using "bit masking":

1) 0x11111111 == 0x1111 -->  = 0x0000FFFF
    
    this causes the last 4 bits to be the same for both uint32 and uint16

2) 0x1111111100001111 != 0x00001111 --> 0xFFFFFFFF0000FFFF
    
    this causes uint32(uint64(_gateKey)) != uint64(_gateKey) by keeping the preceding values of the last step


Note that the last four bytes of condition 2 are just condition 1. The last sub-gate is solved by keeping the four 0's in the middle and the last 4 bytes the same.


## Solution
To solve this level, it's necessary to create a contract in Remix that calls an attacking function that iterates ~300 times to attempt to brute force the amount of gas that is needed to pass Gate 2.

The key you'll pass in to your attacking function is calculated before calling the attacking function.

See GatekeeperOneHack.sol for the full solution

Helpful Links:

https://medium.com/coinmonks/ethernaut-lvl-13-gatekeeper-1-walkthrough-how-to-calculate-smart-contract-gas-consumption-and-eb4b042d3009

https://www.youtube.com/watch?v=TH3ZeWcISmY&t=113s

https://medium.com/@imolfar/bitwise-operations-and-bit-manipulation-in-solidity-ethereum-1751f3d2e216

