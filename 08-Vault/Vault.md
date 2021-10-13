The lesson for this level is that private-type variables can be viewed by anyone, because blockchain storage is visible to anyone.

## Explanation
This level is solved by switching the locked variable from true to false by calling unlock().

To call unlock(), you need to find the password. 

Since there is no function in the contract that allows us to get the password variable directly, we have to use a web3 built-in function, getStorageAt().

getStorageAt() allows us to access the memory slots that the contract is using to store its data.

It takes in the address of the contract you want to read and an integer representing the slot you want to read. It returns a bytes32 hex value.

## Solution
To solve this level in the console:

1) Get the hex value of the slot at index 1

```bash
password = await web3.eth.getStorageAt(contract.address, 1)
```

2) Optional: Convert the hex value to a string so you can read the password

```bash
password = web3.utils.hexToAscii(hex)
```

3) Call unlock() and pass in the hex value(function expects a bytes32 argument):

```bash
contract.unlock(hex)
```