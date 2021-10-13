The lesson in this level is about fallbacks and to be aware that the order in which you do things can lead unintended effects.

## Explanation
To become king, you must send a transaction containing more ether than the current king has pledged.

Inside the fallback function it makes sure that the value being sent is higher than the prize money

```bash
# make sure value being sent is higher than prize, or sender is the owner
require(msg.value >= prize || msg.sender == owner);

king.transfer(msg.value); # transfer the value to current king
king = msg.sender; # make sender the new king
prize = msg.value; # set prize as the value sent
```

The issue is with the transfer() call. If that fails for whatever reason, the lines below it cannot be executed, which leads us to the solution...

## Solution
To solve this level, define a contract in Remix that cannot accept ether(just leave out the fallback function).

This will cause the transfer() call to fail and will prevent the level from reclaiming kingship.

See KingHack.sol for the full solution.