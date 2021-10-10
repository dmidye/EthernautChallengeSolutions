This contract addresses the limits(or lack) of randomness in Solidity.

## Explanation

To simulate a coinflip, this contract generates a pseudo-random number by getting the hash of the previous block and dividing it by FACTOR to produce a 1(true) or 0(false).

This value is pseudo-random because any contract can generate this hash and therefore know what the outcome is before calling flip()

## Solution
To solve this level it is helpful to use Remix, a web IDE for Solidity.

You will need to copy the CoinFlip contract from the level and paste it into a Solidity .sol file in remix.

Then, create another contract on the same page with the "contract" keyword that will be your attacking contract. It will need FACTOR, lastHash, and 'using Safemath for uint256' at the top. I'll leave it up to you to figure out how to get Safemath into Remix.

Once you have all that, copy/paste the flip() method and rename it to something more sinister.

Your edited flip() method will need to generate the random number just like the original flip() method, but instead of returning true/false, you will call the original flip() with the value generated.

Once that works it's just a matter of calling it 10 times and submitting the level.

See CoinflipHack.sol to see the full solution.

Helpful Links:
https://medium.com/@nicolezhu/ethernaut-lvl-3-walkthrough-how-to-abuse-psuedo-randomness-in-smart-contracts-4cc06bb82570
https://medium.com/coinmonks/is-block-blockhash-block-number-1-okay-14a28e40cc4b