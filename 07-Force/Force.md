The lesson for this challenge is how the low-level function selfdestruct() works.

## Explanation
To intentionally make a contract payable, a smart contract should have a fallback function.

Even though the given contract is completely empty, it can still receive ether in a couple of ways.

1) The contract address can be designated to receive mining rewards.
2) A contract that contains ether can call selfdestruct(), passing in the target address as an argument

selfdestruct() takes in one argument: the address to send any remaining ether to(otherwise it would be burned)

## Solution
To solve this level it is necessary to create a contract in Remix. This is the contract that will be selfdestructing.

So you don't have to transfer ether from your Metamask account to the new contract, specify 1 Wei in the "Value" field in Remix.

See ForceHack.sol for the full solution.

NOTE: If you send ether via selfdestruct() to a smart contract without a way to withdraw that ether, it will be lost forever!