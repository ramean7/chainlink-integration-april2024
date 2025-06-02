# 🌐 Cross-Chain NFT Minting with Chainlink CCIP

## English

This project demonstrates how to mint NFTs across chains using **Chainlink CCIP (Cross-Chain Interoperability Protocol)**. It uses three Solidity smart contracts deployed on **Sepolia** and **Fuji** testnets. All actions are manual — no Hardhat or Node.js required — ideal for use with **Remix IDE**, **MetaMask**, and **Chainlink's CCIP interface**.

---

## 📦 Contracts Overview

### 1. `CrossChainPriceNFT` (Sepolia)
- An ERC721 NFT contract that:
  - Mints SVG NFTs with real-time **BTC/USD price emoji** (😀, 😔, 😑).
  - Uses Chainlink Price Feed to fetch current BTC price.
  - Background color of the NFT changes based on **source chain**:
    - **Sepolia** = 🔵 Blue
    - **Fuji** = 🔴 Red
    - **Mumbai** = 🟣 Purple
  - Updates metadata dynamically based on price trend.
  - Accepts cross-chain minting via `mintFrom()`.

📌 *This allows users to visually identify which chain minted the NFT.*

---

## 🚀 Usage

1. Call `mintSepolia()` from `CrossSourceMinter` on Fuji.
2. The NFT is minted **on Sepolia**, but the background color reflects the **source chain** (e.g., red for Fuji).
3. View your NFT using `tokenURI()` and decode the SVG image manually.