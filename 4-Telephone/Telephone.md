This is a simple contract that highlights an important aspect of the data that is passed to a Solidity function by default.

## Explanation
In the changeOwner() function, there are two values being compared:

```python
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
```

Both of these values are addresses, and they can be either a regular address or the address of a smart contract.

msg.sender represents the *address of the caller of the function* and CAN BE a smart contract

tx.origin represents the *address that originated the function call* and CANNOT BE a smart contract

These may sound the same, and a lot of the time they are. The key thing to note is that *smart contracts can call other smart contracts* which is how this level is solved.

## Solution

To solve this level, create a function in a new contract in Remix that calls the changeOwner() function of the original contract, but pass in your Metamask address.

This will result in tx.origin being your Metamask address but msg.sender being the address of the smart contract you created.

See TelephoneHack.sol for the full solution.

Helpful Link:

https://ethereum.stackexchange.com/questions/1891/whats-the-difference-between-msg-sender-and-tx-origin/1892