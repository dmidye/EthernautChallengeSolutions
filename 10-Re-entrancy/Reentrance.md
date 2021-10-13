The lesson of this level is that, if you order your transfers incorrectly, unintended recursion can occur. This is what happened with the infamous DAO hack.

## Explanation
This contract custodies ether donations and keeps balances on an internal ledger(the mapping).

In its withdraw function, the contract makes a call to send the specified amount of ether to msg.sender.

Afterwards, it decrements that amount from that address' balance. This is where the mistake lies.

Because the balance is decremented after the call() function, an attacking contract can call the withdraw() function of the original contract inside its fallback function.

This causes withdraw() to be called over and over again without ever decrementing the contract's balance inside the original contract.

## Solution
To solve this level, you'll need to define a contract in Remix that:
1) Has 1 ether as its balance inside the original contract's mapping. From your Metamask account, call:
```bash
contract.donate(*attacking contracts address*, { value: toWei("1", "ether") })
```

2) Has a function to call withdraw() initially
3) Has a fallback function defined to call withdraw()

NOTE:
When calling your attacking method in Remix, the transaction will never complete.

See ReentranceHack.sol for the full solution.

Helpful link:

https://medium.com/coinmonks/ethernaut-lvl-10-re-entrancy-walkthrough-how-to-abuse-execution-ordering-and-reproduce-the-dao-7ec88b912c14

