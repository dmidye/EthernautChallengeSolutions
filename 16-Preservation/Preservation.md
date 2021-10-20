The lesson for this challenge is another delegatecall() warning and a refresher on how smart contracts store state variables.

## Explanation
This contract attempts to implement a library contract to track timezones. Looking at it, there is no way to explicitly change the owner variable, so we must look for a less obvious way.

Recall that smart contract storage works in 32 byte slots. An address takes up 20 bytes, so for this contract the first three variables are put into a slot on their own.

Also recall that delegateCall() allows another contract to change variables inside the caller's contract. In this case, the Preservation contract wants to allow LibraryContract to change the storedTime variable inside the Preservation contract.

The mistake lies in the implementation of LibraryContract.

The way delegateCall() keeps track of which function to call is by the function signature(in this case it's setTime()). However, when it changes a variable, it only sees which slot the variable is in, not the name of the variable.

So, when storedTime is initialized in LibraryContract, all delegateCall() understands is that there is a variable at slot 0(because storedTime is in slot 0 inside LibraryContract).

Because of that, delegateCall() is going to change slot 0 inside Preservation, which is timeZone1Library. This opens up our attack vector.

Now that we know it's possible to change the timeZone1Library variable, we can write an attacking library contract and change the timeZone1Library variable to the attacking contract's address.

From there, we can write a setTime() function that changes the owner variable to our metamask address. Easy peasy. Not really.

## Solution
To solve this level, you'll need to create a small library contract in Remix that follows the same pattern of variables as Preservation and defines a setTime() function that changes the owner variable.

When that is complete, in the dev console in your browser you'll need to call:

```bash
await contract.setFirstTime(*attacking library address*)
```

then call:

```bash
await contract.setFirstTime(0)
```

The first call changes the timeZone1Library to the address of our attacking library. setFirstTime() makes a delegateCall() to LibraryContract's setTime() function, which changes whatever variable is at slot 0 in Preservation (timeZone1Library).

Now that timeZone1Library is pointing to our attacking contract, the second call to setFirstTime() is calling the setTime() function inside the attacking contract, which sets the owner variable to our metamask address. 

See PreservationHack.sol for the full solution.

Helpful Links:

https://www.youtube.com/watch?v=_YkulBTqIcQ <---Fantastic explanation of this level

https://medium.com/coinmonks/ethernaut-lvl-16-preservation-walkthrough-how-to-inject-malicious-contracts-with-delegatecall-81e071f98a12







