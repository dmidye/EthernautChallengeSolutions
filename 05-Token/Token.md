This is a simple contract representing a token built on Ethereum. The goal is to grow your balance to more than 20 tokens.

## Explanation
The lesson for this level is to be aware that unsigned integers(uint) can be implemented in a way that makes your balance checks useless.

The function transfer() includes this balance check:
```python
    require(balances[msg.sender] - _value >= 0);
```

The issue with this is that both integers in question are unsigned. They cannot be negative.

So, when you subtract uint A from uint B, even if uint A < uint B, the value will be an unsigned integer(positive), rendering the check useless.

Once this check is 'satisfied', the transfer() function subtracts the value provided from the balance of msg.sender.

If the value provided is greater than the balance of msg.sender, the value will underflow.
When a value underflows it simply goes to the highest possible value rather than becoming negative.

For example:

```python
    uint8 A = 20; // (max storable # is 255)
    uint8 B = 21;

    A - B ---> 255
```

## Solution

To solve this level, you'll need to call the transfer method with an account address different than the one you're using for Ethernaut and a value greater than 20.

```bash
    contract.transfer(*address*, 21)
```

The reason you must use a different address is that using the same address will cause it to underflow when subtracting the value, but cause it to overflow once _value is added back in.
