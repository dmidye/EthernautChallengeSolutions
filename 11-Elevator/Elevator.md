The lesson in this level is to be careful when using interfaces or other contracts. If you don't implement them correctly, an attacker can imitate them and have your contract call the code that they want it to call. It's also important to note that function modifiers such as pure and view should not be treated guarantees for function behavior.

## Explanation
In Solidity(and many other languages) there is a concept call Inheritance. This defines the ability of a contract to be able to use functions or state variables from an Interface.

More on Inheritance here --> https://www.geeksforgeeks.org/solidity-inheritance/

What this contract is attempting to do is define a "Building" interface and use its isLastFloor() method to determine whether or not the elevator has reached the top.

The mistake in the original contract comes with the contract definition itself.

How it's defined: 
```bash
contract Elevator {...} 
```

How it should be defined: 
```bash
contract Elevator is Building {...} 
```

When implementing an Interface, the contract must define each function defined in the Interface. So, since the Elevator contract did not actually implement the Interface, it is not required to define an isLastFloor() function.

Because of this, *you* can provide the isLastFloor() function...

## Solution
To solve this level, you must create a malicious contract in Remix and have your isLastFloor() function first return false to satisfy this:

```bash
if (! building.isLastFloor(_floor)) 
```

And then return true to set the top variable to true here:

```bash
top = building.isLastFloor(floor); 
```

See ElevatorHack.sol for the full solution.

Helpful Link:

https://medium.com/coinmonks/ethernaut-lvl-11-elevator-walkthrough-how-to-abuse-solidity-interfaces-and-function-state-41005470121d

