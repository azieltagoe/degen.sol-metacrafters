Degen is an ERC20 token deployed on the avalanche fuji testnet. It contains functionalities for minting, transfering, checking balance, burning and redeeming in game items.

1. balanceOf: Returns the token balance of a given address.
2. transfer: Transfers tokens from the caller to a specified address.
3. approve: Approves a specified address to spend a certain amount of tokens on behalf of the caller.
4. allowance: Returns the remaining amount of tokens that a spender is allowed to spend on behalf of a given address.
5. transferFrom: Transfers tokens from a specified address to another address, using the allowance mechanism.
6. burn: Destroys a specified amount of tokens from the caller's balance.
7. mint: Creates new tokens and assigns them to a specified address (only callable by the contract owner).
8. redeemGun: Allows the caller to redeem a "gun" by spending 500 DEGEN tokens.
9. redeemreload: Allows the caller to reload ammo by spending 100 DEGEN tokens (only if they own a gun and have enough tokens).


Contract deployed on Avalanche Fuji testnet
Contract address 0xbda78367c3dad9d110f1512a76ce4e3cd3c3a5ef
