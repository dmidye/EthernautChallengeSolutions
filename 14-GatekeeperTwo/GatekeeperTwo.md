The lesson of this challenge is about contract size and XOR.

## Explanation
Like the previous challenge, you must pass three gates to become an entrant.

### Gate One
Call the enter() function from a smart contract instead of your wallet address.
This is a refresher on the difference between tx.origin and msg.sender.

### Gate Two
Nicole Zhu did a great walkthrough of the mechanism behind contract creation that I'll include in the Helpful Links section at the bottom.

In a nutshell, to pass this gate you must call enter() in such a way that the size of your attacking contract's code is 0(that's what extcodesize is retrieving). To accomplish this, call the enter() function inside the constructor of your attacking contract. 

Because contract creation isn't complete when enter() is called, extcodesize registers as 0, satisfying the condition for gate two.

### Gate Three
This is an introduction to the bitwise operator ^.

Bitwise operators allow for bit manipulation. This particular operator adheres to the following:

If A ^ B = C then A ^ C = B

In this case:

**A = uint64(bytes8(keccak256(abi.encodePacked(address(this)))))**

**B = uint64(_gateKey)**

**C = uint64(0) - 1**

Logically then to pass this gate, we can do this:

```bash
uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0) - 1
```

And since enter() expects a bytes8 parameter, we can cast it to bytes8 easily like this:

```bash
bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0) - 1)
```

## Solution
To solve this level you'll need to create an attacking contract in Remix that calls enter() inside its constructor. 

The contract will need to compute the bytes8 key and pass it to enter() as its parameter.

See GatekeeperTwoHack.sol for the full solution.

Helpful Links:

https://medium.com/coinmonks/ethernaut-lvl-14-gatekeeper-2-walkthrough-how-contracts-initialize-and-how-to-do-bitwise-ddac8ad4f0fd

https://medium.com/@imolfar/bitwise-operations-and-bit-manipulation-in-solidity-ethereum-1751f3d2e216
