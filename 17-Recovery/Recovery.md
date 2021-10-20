The lesson for this challenge is both how you can investigate transactions using a block explorer like etherscan and how addresses are calculated when they are created by a smart contract.

## Explanation
According to the problem statement, someone used a contract factory to create a token, sent ether to the token address, then forgot the address.

### The first way to derive an address:
According to the Ethereum Yellowpaper:

"The address of the new account is defined as being the rightmost 160 bits of the Keccak hash of the RLP encoding of the structure containing only the sender and the account nonce. Thus we define the resultant address for the new account a ≡ B96..255 KEC RLP (s, σ[s]n − 1)"

An easier representation:

```bash
address = rightmost_20_bytes(keccak(RLP(sender address, nonce)))
```

**sender address** = contract that created this address

**nonce** = number of contracts the creator contract has created (for normal addresses it would be the number of transactions that address has performed)

**RLP** = Recursive Length Prefix (see the rlp link in Helpful Links section for more detail)

**keccak** = The accepted Ethereum hashing algorithm

### The second way to derive an address
Simply use etherscan to find the address.

## Solution
### To solve this level with the first way
Using your dev console in your browser, call: 

```bash
await web3.utils.soliditySha3("0xd6", "0x94", contract.address, "0x01");
```

where:

- 0xd6 & 0x94 = the values that signify RLP encoding

- contract.address = your instance address

- 0x01 = the nonce = the number of contracts contract.address has created = 1 

This will yield a 32 byte value with the token contract address being the right-most 20 bytes(40 characters) of the value.

Once you have the token contract address, you can create a contract in Remix that calls the destroy() function, passing in your metamask address as the recipient.

Reminder: the selfdestruct() function deletes the contract and sends any remaining ether to the address it is given.

### To solve this level with the second way
Using etherscan(in this case rinkeby.etherscan.io), we can get our instance address and search for it in etherscan.

From there, we can see a list of transactions that the instance has made and we see a Contract Creation event in that list.

Click on that and you'll be taken to the token contract's etherscan page.

Copy the address and pass it to your contract in Remix that calls destroy().

See RecoveryHack.sol for the full solution.


**Helpful Links:**

https://eth.wiki/fundamentals/rlp

https://medium.com/coinmonks/ethernaut-lvl-18-recovery-walkthrough-how-to-retrieve-lost-contract-addresses-in-2-ways-aba54ab167d3

https://www.youtube.com/watch?v=ODLTq3yZ0nM