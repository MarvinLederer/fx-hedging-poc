# Transaction Log (Polygon Amoy)

Wallets:
- Deployer/Admin: 0xEeE105C4838786C4e2A9Accbe9eca97b370456f91
- Treasury/Trader: <Bitte Treasury Adresse einfügen>

Contracts:
- SEUR: 0x94d3d4fe68e8754a5aacb4cba0ef11eebc1b3ef7
- SUSD: 0x84802c37e624cb9aa389da009aee093321a7533e
- MockOracle: 0xff7d8a2e143a3f6323152837d62b9544a4a96e9f
- FxSettlement: 0x0cc71d05ce54697ddbbf649eb31bd4f201fba9e0

## Transactions

### 1. Deployment Phase
- **Deploy SEUR**
  - Tx Hash: 0xcfac6f9223e5097d9138a6e2343f2d7e26a7a7163805fc36117ff4dc90f125f1
  - Note: Initial Deployment of Base Currency (Admin Owner)

- **Deploy SUSD**
  - Tx Hash: 0xb11d415ac2479ceb453be06cbd79aac620569d4e762e85e2c356904005e967c3
  - Note: Initial Deployment of Quote Currency

- **Deploy MockOracle**
  - Tx Hash: 0xddcc5d905cc17c62b0f98e519f4e2fdcb1d87bf712af5b4c26fe25fd0a60b44d
  - Note: Oracle initialized with price 1.18 USD (118000000)

- **Deploy FxSettlement**
  - Tx Hash: 0x7376e055c9a3e8ff2080f726658e6676bcc8468ddabf874185eeb26ded8ca9f0
  - Note: Settlement Logic connected to tokens and oracle

### 2. Provisioning Phase
- Mint SEUR to Treasury: <tbd>
- Fund FxSettlement with SUSD reserve: <tbd>

### 3. Governance Phase
- Grant TRADER_ROLE: <tbd>

### 4. Execution Phase
- Approve SEUR allowance: <tbd>
- executeTrade (happy path): <tbd>