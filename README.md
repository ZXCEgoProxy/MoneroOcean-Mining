# MoneroOcean Mining Setup

This repository contains a setup for CPU mining Monero (XMR) using XMRig on the MoneroOcean pool. It provides two deployment methods: Docker and a direct script (for platforms like Railway that can run shell scripts).

## Configuration

The miner uses environment variables for configuration. You can set the following environment variables:

- **MINING_POOL**: The mining pool address (default: gulf.moneroocean.stream:10004)
- **WALLET_ADDRESS**: Your Monero wallet address (default: 4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC)
- **RIG_ID**: A identifier for your rig (default: rig01)
- **XMRIG_OPTIONS**: Additional options to pass to XMRig (default: --no-huge-pages to avoid issues in some container environments)

## Deployment Options

### Option 1: Docker (as before)

1. Fork this repository to your own GitHub account (recommended to keep your wallet address private).
2. Connect your Railway account to the GitHub repository.
3. Create a new project in Railway and select the repository.
4. In the Railway project settings, set the environment variables (MINING_POOL, WALLET_ADDRESS, RIG_ID, XMRIG_OPTIONS) as needed.
5. Railway will automatically build and deploy the Docker container.

The miner will start automatically and connect to the pool for mining.

### Option 2: Direct Script (no Docker)

Railway can run a shell script directly. This repository includes a `start.sh` script that downloads and configures XMRig.

1. Fork this repository to your own GitHub account (recommended to keep your wallet address private).
2. Connect your Railway account to the GitHub repository.
3. Create a new project in Railway and select the repository.
4. In the Railway project settings, set the environment variables (MINING_POOL, WALLET_ADDRESS, RIG_ID, XMRIG_OPTIONS) as needed.
5. In the Railway service settings, set the start command to: `bash start.sh`
6. Railway will clone the repository and run the start script, which will download XMRig and start mining.

## Local Testing

### Docker

```bash
docker build -t moneroocean-miner .
docker run -e MINING_POOL=gulf.moneroocean.stream:10004 -e WALLET_ADDRESS=your_wallet_address -e RIG_ID=your_rig_id moneroocean-miner
```

### Direct Script

```bash
chmod +x start.sh  # Make the script executable (optional if running with bash)
./start.sh
# Or with environment variables:
MINING_POOL=gulf.moneroocean.stream:10004 WALLET_ADDRESS=your_wallet_address RIG_ID=your_rig_id XMRIG_OPTIONS="--no-huge-pages" ./start.sh
```

Note: Mining requires CPU resources and may take some time for benchmarking on first run.

## Security Note

This setup uses environment variables for the wallet address, so you can keep your wallet address private by setting it as an environment variable and not committing it to the repository.