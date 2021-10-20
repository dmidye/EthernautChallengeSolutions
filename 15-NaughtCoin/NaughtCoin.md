The lesson in this challenge is an introduction to ERC20 token contracts and that they can be poorly implemented.

## Explanation
The contract issues you a fake ERC20 token called Naughtcoin. It gives you all of the Naughtcoin that it mints and the goal is to reduce your balance to zero.

Note that the contract implements the ERC20 interface which consists of several agreed-upon methods that need to be implemented by the contract.

One of those methods is transfer(), and the contract correctly applies its lockTokens() modifier to it.

The contract leaves out all of the other methods, two of which are approve() and transferFrom(). We can use these to transfer the Naughtcoin out of our wallet.

The approve() function allows for a third party to spend or use tokens in your wallet. It is implemented for many popular dApps. In this case, the "third party" will be our wallet.

The transferFrom() function actually performs the transfer by the third party out of your wallet.

## Solution
There's no need to open Remix for this level, as it can be solved in the dev console in your browser.

1) Approve your wallet to spend your tokens

```bash
await contract.approve(player, await contract.balanceOf(player))
```

2) Transfer the tokens to any other valid address

```bash
await contract.transferFrom(player, *beneficiary address*, await contract.balanceOf(player))
```

This is a simpler level, but it is worth reading through the following links to get a better understanding of how ERC20 tokens are implemented:

https://ethereum.org/en/developers/tutorials/transfers-and-approval-of-erc-20-tokens-from-a-solidity-smart-contract/

https://docs.openzeppelin.com/contracts/2.x/api/token/erc20#IERC20-allowance-address-address-

https://medium.com/coinmonks/ethernaut-lvl-15-naught-coin-walkthrough-how-to-abuse-erc20-tokens-and-bad-icos-6668b856a176