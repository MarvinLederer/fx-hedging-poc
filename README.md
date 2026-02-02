# FX Hedging Prototype (PoC) – Bachelor Thesis

This repository contains a proof-of-concept (PoC) prototype developed for my Bachelor thesis at Technische Hochschule Deggendorf (THD).

## 📌 Purpose
The prototype demonstrates a simplified blockchain-based FX settlement workflow for research and evaluation purposes (auditability, governance controls, and reproducibility on a public testnet).

## 🧩 System Components
The PoC consists of three smart contracts deployed on the Polygon Amoy testnet:

- **SEUR** – "Schaeffler Euro (PoC)": mock ERC-20 token representing the base currency balance (EUR) held by a treasury-controlled wallet.
- **SUSD** – "Schaeffler Dollar (PoC)": mock ERC-20 token representing the quote currency (USD). A reserve is funded to the settlement contract to emulate counterparty/bank-side liquidity.
- **FxSettlement** – main settlement contract that exchanges SEUR for SUSD at an oracle-referenced price when executing `executeTrade(baseAmount)`.

> **Disclaimer:** SEUR and SUSD are mock assets used exclusively for this thesis PoC. They are not official financial instruments or real-world tokens.

## 🛠 Toolchain
- **IDE:** Remix (browser-based)
- **Wallet:** MetaMask (transaction signing)
- **Network:** Polygon Amoy testnet
- **Block explorer:** amoy.polygonscan.com
- **Oracle:** Chainlink Data Feed (proxy feed used for demonstrative pricing)

## ✅ Reproducibility & Evidence
Transaction hashes, deployed contract addresses, gas usage, and screenshots are documented in:
- `evidence/tx-log.md`
- `evidence/screenshots/`

## 📂 Repository Structure
- `contracts/` – Solidity smart contracts
- `docs/` – prototype documentation (toolchain, test protocol, etc.)
- `evidence/` – transaction log, observations, and screenshots

## ⚠️ Confidentiality
This repository is intended for thesis work and is maintained as **private**. No internal company systems or confidential operational details are included.
