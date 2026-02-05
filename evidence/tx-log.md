# Transaction Log (Polygon Amoy)

Wallets:
- Deployer/Admin: 0xEeE105C4838786C4e2A9Accbe9eca97b370456f91
- Treasury/Trader: 0xce80A9562BE69aFe89De7695493e60c8ae23C308

Contracts:
- SEUR: 0x94d3d4fe68e8754a5aacb4cba0ef11eebc1b3ef7
- SUSD: 0xedbf8c9a4d26d661b874743750dbca7051926bb5
- MockOracle: 0xff7d8a2e143a3f6323152837d62b9544a4a96e9f
- FxSettlement: 0x92c77ce00ec762119f6cf372f7d0232108ddf79c

## Transactions

### 1. Deployment Phase
- **Deploy SEUR**
  - Tx Hash: 0xcfac6f9223e5097d9138a6e2343f2d7e26a7a7163805fc36117ff4dc90f125f1
  - Note: Initial Deployment of Base Currency (Admin Owner)

- **Deploy SUSD**
  - Tx Hash: 0xa7fad4cd530a42cb86f49672076153e515785fd9de397fbbd7b7cdf2643d9ada
  - Note: Initial Deployment of Quote Currency

- **Deploy MockOracle**
  - Tx Hash: 0xddcc5d905cc17c62b0f98e519f4e2fdcb1d87bf712af5b4c26fe25fd0a60b44d
  - Note: Oracle initialized with price 1.18 USD (118000000)

- **Deploy FxSettlement**
  - Tx Hash: 0x57f2b0a1ff0692bf6943229ed402d137e60ffc8faf25edcdd186f6593eda3f2e
  - Note: Settlement Logic connected to tokens and oracle

### 2. Provisioning Phase
- Mint SEUR to Treasury:
	- Tx Hash: 0x57677d754ce235a81b206c7a0b1cc4c3869232129c5050b96c1af90c3ca2d8e2
	- Note: Initial liquidity for the corporate trader (10.000 EUR)

- Fund FxSettlement with SUSD reserve: 
	- Tx Hash: 0x8bdd68ff1b934ce95fda25146f0ab74a78ee924e52f0fb510a6a9fb53a33e328
	- Note: Funded Settlement Contract with liquidity (10.000 SUSD)

### 3. Governance Phase
- Grant TRADER_ROLE: 
	- Tx Hash: 0x21fb966e9a9707a4b4b7278e6b96c2a2f6e7744def8391e6d6359c2f38680f48
	- Note: Authorized Treasury Wallet to execute trades

### 4. Execution Phase
	- Tx Hash: 0xcb45802b8da431064fe8cdac9a29ec68542036997a1e51e3166c75829743ce8e
	- Note: Approved FxSettlement to spend 100.00 EUR
	
### 5. Happy Path	
	- Tx Hash: 0x05f144dedfba2ef7271c0b76e7509cee9bfeb3927482cdb2f0d0b372e29eef37
	- Note: Swapped 100.00 EUR for 118.00 USD (Rate: 1.18)