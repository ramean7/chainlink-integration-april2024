# Chainlink Functions Contracts (Solidity Only)

## English

This repository contains three Solidity smart contracts that demonstrate how to use **Chainlink Functions** to make off-chain HTTP API calls directly from the blockchain. All deployments are done manually (no Hardhat or Node.js), and interaction is via Remix IDE or a compatible wallet like MetaMask. 

The contracts are designed for the **Avalanche Fuji Testnet**.

---

## 🔗 Contracts Summary

### 1. GettingStartedFunctionsConsumer
- Fetches Star Wars character data from `https://swapi.dev/api/people/{id}/`.
- Uses inline JavaScript with Chainlink Functions to request and return the character’s name.

### 2. TemperatureFunctions
- Fetches the weather for a given city using `https://wttr.in/{city}?format=3`.
- Stores the last requested city and temperature.

### 3. WeatherFunctions
- Similar to `TemperatureFunctions` but supports:
  - Multiple users
  - Request tracking with timestamps
  - User-specific storage

---

## 🧪 How to Use

1. **Deploy the Contract** on the **Fuji testnet** using Remix or any web3 wallet that supports contract deployment.

2. **Fund Your Contract** with LINK:
   - Use the [Chainlink Faucet](https://faucets.chain.link/fuji) to get testnet LINK and AVAX.

3. **Subscribe to Chainlink Functions**:
   - Go to [Chainlink Functions Subscription Page](https://functions.chain.link/)
   - Create a new subscription and add your deployed contract as a consumer.

4. **Send a Request**:
   - Use the public `sendRequest()` or `getTemperature()` functions with your subscription ID and arguments.
   - Wait for Chainlink to fulfill the request.
   - Use public variables or events to read the response.

---

## 🌐 Requirements

- Avalanche Fuji Testnet (with test AVAX)
- Chainlink Subscription ID
- Remix IDE or a web3 wallet (e.g., MetaMask)