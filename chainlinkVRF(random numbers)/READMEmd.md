# Chainlink VRF Smart Contracts

This repository contains two smart contracts that use Chainlink VRF (Verifiable Random Function) to provide secure and verifiable randomness on-chain:

1. **Runners**: An NFT contract where each character can "run" and increase their distance by a random amount using Chainlink VRF.  
2. **Raffle**: A sample raffle contract that allows users to enter by paying ETH, and periodically picks a random winner using Chainlink VRF and Chainlink Keepers.

---

## Table of Contents

- [Runners Contract](#runners-contract)  
- [Raffle Contract](#raffle-contract)  
- [Setup & Deployment](#setup--deployment)  
- [Usage](#usage)  
- [Notes](#notes)

---

## Runners Contract

### Overview  
The **Runners** contract is an ERC721 NFT collection featuring four characters (Elf, Knight, Orc, Witch). Each NFT has attributes such as distance and round, which are updated randomly using Chainlink VRF.

### Features

- ERC721 token with on-chain Base64-encoded JSON metadata  
- Integration with Chainlink VRF v2 for secure randomness  
- Randomly increments the runner’s distance and rounds after each VRF callback  
- Predefined character images hosted on IPFS  
- Deployed on Fuji testnet (Avalanche)

---

## Raffle Contract

### Overview  
The **Raffle** contract is a decentralized lottery where participants can enter by paying an entrance fee. After a specified time interval, Chainlink Keepers trigger a VRF request to randomly select and pay the winner.

### Features

- Uses Chainlink VRF v2 Plus for randomness  
- Compatible with Chainlink Keepers for automation  
- Handles raffle states (OPEN, CALCULATING) to prevent reentrancy issues  
- Custom errors for better gas efficiency  
- Tracks participants and distributes prize funds automatically

---

## Setup & Deployment

### Prerequisites

- Node.js and npm installed  
- Hardhat or Remix for development and deployment  
- A funded Chainlink VRF subscription ID for the target network  
- Install dependencies: OpenZeppelin contracts and Chainlink contracts

### Deployment Steps

1. Configure your Chainlink subscription ID in the contract constructor.  
2. For Runners: Make sure the VRF Coordinator address matches the network (e.g., Fuji).  
3. For Raffle: Provide gas lane (keyHash), callback gas limit, interval, and entrance fee when deploying.  
4. Deploy the contracts to your target network (testnet or mainnet).

---

## Usage

### Runners

- Mint a Runner NFT by calling `safeMint` with a character ID (0-3).  
- Call `run(tokenId)` to request a random number from Chainlink VRF and increase the runner’s distance.  
- Track request status and events (`RequestSent`, `RequestFulfilled`) for VRF calls.

### Raffle

- Users enter the raffle by sending ETH equal to or above the entrance fee via `enterRaffle()`.  
- Chainlink Keepers automatically check if it’s time to pick a winner.  
- When conditions are met, `performUpkeep()` is called to request a random winner from VRF.  
- Winner is paid automatically and raffle resets for the next round.

---

## Notes

- Ensure your Chainlink subscription is properly funded to avoid VRF request failures.  
- Set the `callbackGasLimit` appropriately based on your fulfill logic complexity.  
- Adjust the entrance fee and raffle interval based on your use case and network conditions.  
- It is recommended to test on testnets like Fuji (Avalanche) or Sepolia before deploying on mainnet.

---

## Contact

Feel free to open issues or reach out if you need help with deployment, integration, or further customization!

---
