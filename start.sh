#!/bin/bash
set -e

# Download and extract XMRig (same logic as in Dockerfile)
echo "Downloading latest XMRig from MoneroOcean releases..."
url=$(curl -fsSL https://api.github.com/repos/MoneroOcean/xmrig/releases/latest | grep browser_download_url | grep -E 'lin64-compat|lin64\.tar\.gz' | head -1 | cut -d '"' -f 4)
if [ -z "$url" ]; then
    echo "Failed to get download URL"
    exit 1
fi
echo "Download URL: $url"
curl -L "$url" -o xmrig.tar.gz
tar xf xmrig.tar.gz
# Find the extracted directory (usually xmrig-*)
dir=$(ls -d xmrig-* | head -1)
if [ -z "$dir" ]; then
    echo "Failed to extract XMRig"
    exit 1
fi
chmod +x "$dir/xmrig"

# Use environment variables for configuration, with defaults
MINING_POOL=${MINING_POOL:-gulf.moneroocean.stream:10004}
WALLET_ADDRESS=${WALLET_ADDRESS:-4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC}
RIG_ID=${RIG_ID:-rig01}
THREADS=${THREADS:-2}
XMRIG_OPTIONS=${XMRIG_OPTIONS:---no-huge-pages}
HTTP_HOST=${HTTP_HOST:-0.0.0.0}
HTTP_PORT=${HTTP_PORT:-3333}
HTTP_ACCESS_TOKEN=${HTTP_ACCESS_TOKEN:-changeme123}

echo "Starting XMRig..."
echo "Pool: $MINING_POOL"
echo "Wallet: $WALLET_ADDRESS"
echo "Rig ID: $RIG_ID"
echo "Threads: $THREADS"
echo "HTTP API: $HTTP_HOST:$HTTP_PORT"
exec "$dir/xmrig" $XMRIG_OPTIONS --threads=$THREADS --http-host=$HTTP_HOST --http-port=$HTTP_PORT --http-access-token=$HTTP_ACCESS_TOKEN -o "$MINING_POOL" -u "$WALLET_ADDRESS" --rig-id "$RIG_ID" --keepalive