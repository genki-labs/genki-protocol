# Genki Protocol

The Genki Protocol is a decentralized on-chain marketing platform.

## Requirements

Install Node.js (https://nodejs.org/en/).

Install the project dependencies specified in `package.json`.

```bash
npm install
```

## Get Started

Compile the contracts.

```bash
npx hardhat compile
```

Run the demo.

```bash
npx hardhat demo
```

### Deploy to a Network

Start a hardhat node.

```bash
npx hardhat node
```

Deploy GenkiHub to a blockchain network with JSON-RPC

```bash
npx hardhat run --network localhost scripts/deploy.js  # Deploy to the node running by `npx hardhat node`
npx hardhat run --network <your-network> scripts/deploy.js  # Target any network configured in the `hardhat.config.js`
```

### Test

```bash
npx hardhat test
```
