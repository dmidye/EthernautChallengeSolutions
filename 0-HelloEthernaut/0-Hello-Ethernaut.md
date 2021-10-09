## Explanation

This is the introduction challenge. Follow the instructions and call
```bash
    await contract.info
```

From there, you can follow what the output from the first call gives you to get a feel for method calls.

NOTE: 
When calling properties(public-type state variables inside the contract), you are really calling a getter method that solidity creates automatically. Because of this, parentheses must be included at the end to get intelligible output. EX) contract.name ---> contract.name()

## Solution
1) Get password (it is of 'public' type, so it is available via method call)
```bash
    await contract.password()
```
2) Copy the output and call
```bash
    await contract.authenticate(*output from previous call*)
```