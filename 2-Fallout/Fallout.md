This is a (outdated) lesson on constructors.

## Explanation
At the time this level was written, Solidity constructors were defined like this:

```python
    contract Fallout {
        /* constructor */
        function Fallout() public payable {
           // initial contract setup....
        }
    }
```

In a later version, the syntax was changed to this:

```python
    contract Fallout {
        /* constructor */
        constructor() public {
            // initial contract setup...
        }
    }
```
This change was made in part to solve for the issue present in this level of misspelled constructor functions.

It is only possible to call correctly coded constructor functions one time, during contract creation.
Because the constructor in this level is misspelled, Solidity treats it like it would treat any other public function and allows you to call it.

This was important to fix because smart contract code is immutable, meaning it cannot be changed once it is deployed to the network.

If a contract with this error were to gain usage, it would be incredibly easy to steal funds from it.

## Solution
1) Call the misspelled constructor function and take ownership of the contract
```bash
    contract.Fal1out({ from: player, value: toWei(".01", "ether") })
```