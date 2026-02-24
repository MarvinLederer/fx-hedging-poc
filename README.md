# FX Hedging Prototype (PoC) – Bachelor Thesis

This repository contains a proof-of-concept (PoC) prototype developed for my Bachelor thesis at Technische Hochschule Deggendorf (THD).

## Purpose
The prototype demonstrates a simplified blockchain-based FX settlement workflow for research and evaluation purposes. It focuses on demonstrating Atomic Payment-versus-Payment (PvP), governance controls (Segregation of Duties), and reproducibility on a public testnet.

## System Components
The PoC consists of **four** smart contracts deployed on the Polygon Amoy testnet:

- **SEUR** – "Schaeffler Euro": A mock ERC-20 token representing the base currency balance (EUR) held by a treasury-controlled wallet.
- **SUSD** – "Schaeffler Dollar": A mock ERC-20 token representing the quote currency (USD). A reserve is funded to the settlement contract to emulate counterparty/bank-side liquidity.
- **MockOracle** – A helper contract implementing the Chainlink `AggregatorV3Interface`. It returns a fixed exchange rate (e.g., 1.18) to ensure deterministic and reproducible test conditions independent of live market volatility.
- **FxSettlement** – The main settlement contract that atomically exchanges SEUR for SUSD based on the oracle-referenced price. It utilizes OpenZeppelin's `AccessControl` to enforce Segregation of Duties (SoD) by restricting the `executeTrade` function strictly to wallets holding the `TRADER_ROLE`.

> **Disclaimer:** SEUR and SUSD are mock assets used exclusively for this thesis PoC. They are not official financial instruments or real-world tokens.

## Toolchain
- **IDE:** Remix IDE
- **Wallet:** MetaMask (transaction signing & Web3 provider)
- **Network:** Polygon Amoy testnet
- **Block explorer:** amoy.polygonscan.com
- **Oracle Standard:** Chainlink Data Feeds (simulated via on-chain Mock Oracle for deterministic testing)

## Reproducibility & Evidence
Transaction hashes, deployed contract addresses, gas usage, and screenshots are documented to support the thesis evaluation:
- `evidence/tx-log.md`
- `evidence/screenshots/`

## Repository Structure
- `contracts/` – Solidity smart contracts (`SEUR.sol`, `SUSD.sol`, `MockOracle.sol`, `FxSettlement.sol`)
- `docs/` – prototype documentation (toolchain, test protocol, etc.)
- `evidence/` – transaction log, observations, and screenshots

## Confidentiality
This repository is intended for thesis work. No internal company systems, actual treasury data, or confidential operational details are included.
