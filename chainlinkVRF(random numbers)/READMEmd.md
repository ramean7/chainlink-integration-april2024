# Runners Contract

## Overview
The Runners contract is an ERC721 NFT collection featuring four characters: Elf, Knight, Orc, Witch. Each NFT has attributes such as `distance` and `round`, which are updated randomly using Chainlink VRF.

## Features
- ERC721 token with on-chain Base64-encoded JSON metadata  
- Integration with Chainlink VRF v2 for secure randomness  
- Randomly increments the runner’s distance and rounds after each VRF callback  
- Predefined character images hosted on IPFS  
- Deployed on Fuji testnet (Avalanche)  

## Setup & Deployment

### Prerequisites
- Node.js and npm installed  
- Hardhat or Remix for development and deployment  
- A funded Chainlink VRF subscription ID for the target network  
- Install dependencies: OpenZeppelin contracts and Chainlink contracts  

### Deployment Steps
1. Configure your Chainlink subscription ID in the contract constructor.  
2. Make sure the VRF Coordinator address matches the network (e.g., Fuji).  
3. Deploy the contract to your target network (testnet or mainnet).  

## Usage
- Mint a Runner NFT by calling `safeMint(characterId)` where `characterId` is 0-3.  
- Call `run(tokenId)` to request a random number from Chainlink VRF and increase the runner’s distance.  
- Track request status and events (`RequestSent`, `RequestFulfilled`) for VRF calls.  

## Notes
- Ensure your Chainlink subscription is properly funded to avoid VRF request failures.  
- Adjust callback gas limit according to your logic complexity.  
- Test thoroughly on testnets like Fuji (Avalanche) before deploying on mainnet.  
