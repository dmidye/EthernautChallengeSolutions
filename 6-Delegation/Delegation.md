The lesson for this challenge is that the low-level function delegatecall() can be implemented in insecure ways.

## Explanation
delegatecall() is used when you want to change a state variable in a contract by using another contract. Put another way, when a contract calls delegatecall(), it is employing a separate contract to change its data in some way. 

It is important to be careful with this function because you are essentially giving write-access to another contract, so you have to be 100% certain that the contract will not change anything but what you are intending it to change.

## Solution
This level can be solved by calling this:

```python
sendTransaction({ to: contract.address, data: web3.eth.abi.encodeFunctionSignature("pwn()"), from: player })
```
The Delegation contract has a fallback function that can be activated with sendTransaction().

Once inside, the fallback uses delegatecall, passing in msg.data.

So, to beat the level you must pass in the *function signature* of Delegate's pwn() function.

The function signature is necessary because of how contracts read data of other contracts. 

The abi is a human readable representation of contract data(functions, variables, etc), so you must change "pwn()" into something that the contract can interpret.


Helpful links:

https://medium.com/coinmonks/ethernaut-lvl-6-walkthrough-how-to-abuse-the-delicate-delegatecall-466b26c429e4

https://web3js.readthedocs.io/en/v1.2.11/web3-eth-abi.html