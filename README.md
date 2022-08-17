# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```

# Faucet

Our user’s interact with our platform primarily by interactions with smart contracts. Therefore they must have a nominal amount of ETH in order to be able to pay for their transactions. In this context we will be operating on a chain that has either cheap or free gas.

## User stories

- As a user I expect to call a function with a requested top-up value on the faucet. I should only receive the requested amount of ETH if my wallet balance is below a specified threshold, my requested value is below the top-up limit and I have been approved to use the faucet.
- As a user I want to request funds when my balance drops below a set threshold so I can continue transacting on the network
- As an admin I want to only dispense ether to users with a balance below a configurable threshold
- As an admin I want to only dispense ether to authenticated users to limit abuse
- As an admin I want to dispense ether such that a user’s balance never exceeds a set level so I can control the amount being spent.
- If a user requests funds (set at 0.1), and their balance is 0.05, contract should dispense 0.05, not 0.1
- As a platform maintenance user I expect to be able to call a function to dispense a top-up to a wallet address. I should be able to top-up another address regardless of the other address’ balance or approval status, provided the amount I am requesting is below a seperate limit to above.
- As a platform maintenance user I expect to be able to change a user’s approval status
- As a platform admin user I expect to be able to change both the self-serve top-up and maintenance user top-up limit
- As a platform admin user I expect to be able to withdraw an arbitrary amount of ETH funds held by the faucet

## Requirements

- Users must be authenticated to use the faucet
- User balances cannot exceed a set threshold when withdrawing
- If a user requests funds (dispensation amount set at 0.1), and their balance is 0.05, contract should dispense 0.05, not 0.1, so that the user’s balance will not exceed 0.1
- Users cannot receive ether if their balance is above a set balance
- Users should receive an initial amount of ether when being authenticated
- Admins can set user authentication status
- Admins can use the faucet to top up system worker accounts
- Admins can configure the top up threshold for system worker accounts
- Admins can configure the top up threshold for users
- Admins can withdraw arbitrary amounts of ether from the contract