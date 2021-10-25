The lesson for this challenge is an introduction into using assembly in Solidity.

## Explanation
This level requires you to set a "solver" which is a smart contract that returns the number 42. 

Your solver must also be very small in size. 10 opcodes or less, to be exact.

To accomplish this, you'll have to use assembly language that's built into Solidity. Assembly allows for gas optimization because you can feed it only the actions you want to be done without all the fluff.

To avoid making this document overly long, I encourage you to read the links in the Helpful Links section at the bottom. They will take you through what opcodes are, why they help with this level, and which ones you'll need to solve this level.

## Solution
To solve this level you'll need to create a contract in Remix that has a method that will create a "solver" contract with assembly.

Then, you'll call the setSolver() method from the original contract, passing in the address of the newly created(and tiny) solver contract.

See MagicNumberHack.sol for the full solution.

Helpful Links:

https://medium.com/coinmonks/ethernaut-lvl-19-magicnumber-walkthrough-how-to-deploy-contracts-using-raw-assembly-opcodes-c50edb0f71a2

https://medium.com/@blockchain101/solidity-bytecode-and-opcode-basics-672e9b1a88c2

https://hackernoon.com/using-ethereums-create2-nw2137q7

