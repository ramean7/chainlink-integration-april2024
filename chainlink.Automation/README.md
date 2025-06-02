# 🌸 NFT Evolution with Chainlink Automation

This project consists of two smart contracts called **Photoalbum** and **Flower**, built on the ERC721 standard. The key feature is automatic NFT metadata updates using **Chainlink Automation** at regular time intervals.

---

### General Features:

- ERC721 NFT with enumerable and mutable metadata.
- Uses Chainlink Automation to trigger updates based on time (`interval`).
- NFT evolves (image or metadata changes) without manual interaction.
- Only the contract owner can mint new tokens.
- IPFS-hosted metadata for visual and stage tracking.

---

### Contract 1: `Photoalbum`

- Represents an NFT album with 3 sequential photos.
- After each set interval, the NFT image updates to the next one automatically.
- Uses `checkUpkeep` and `performUpkeep` from Chainlink Automation.

### Contract 2: `Flower`

- Represents a flower growing in 3 stages: seed → sprout → bloom.
- Grows automatically over time using Chainlink Automation.
- Minted once in the constructor.

---

### Technologies Used

- Solidity ^0.8.27
- Chainlink Automation (Keepers)
- OpenZeppelin Contracts:
  - ERC721, ERC721Enumerable, ERC721URIStorage
  - Ownable, Counters

---

### How It Works

1. `checkUpkeep`: Verifies whether enough time has passed and the NFT hasn't reached the final stage.
2. `performUpkeep`: If conditions are met, Chainlink triggers this function to update NFT metadata.

---

### Use Case Examples

- Growing flowers, evolving photo albums, NFT storytelling, timed art projects, and more.

---

## 🔗 Chainlink Automation Docs

- [Chainlink Automation Overview](https://docs.chain.link/chainlink-automation/introduction)
