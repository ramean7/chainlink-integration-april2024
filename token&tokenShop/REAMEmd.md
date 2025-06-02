# token-tokenShop  

# Token Shop Using Chainlink and Ethereum

This project includes two basic smart contracts built on Ethereum (or compatible networks like Avalanche):

## 1. MyToken Contract

- ERC20 token implementation.
- Supports `mint` and `burn`.
- Only addresses with `MINTER_ROLE` can mint new tokens.
- The token uses 2 decimal places.
- Built using OpenZeppelin Contracts.

## 2. TokenShop Contract

- Accepts ETH and calculates equivalent tokens based on real-time ETH/USD price using Chainlink.
- Connects to Chainlink Data Feeds for accurate price information.
- Fixed token price: 200 USD.
- Handles stale or invalid price feed responses.
- Only the owner can withdraw collected ETH.

## Libraries Used

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Chainlink Data Feeds](https://docs.chain.link/data-feeds/)

## How to Use

1. First, deploy the `MyToken` contract.
2. Deploy the `TokenShop` contract using the `MyToken` address as `_minter`.
3. Provide a valid Chainlink ETH/USD feed as `_priceFeed` (e.g., on Avalanche Fuji Testnet):

4. Now, users can send ETH to `TokenShop` and receive tokens in return.



