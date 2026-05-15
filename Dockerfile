FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl

WORKDIR /app

RUN mkdir -p /app && cd /app && \
    url=$(curl -fsSL https://api.github.com/repos/MoneroOcean/xmrig/releases/latest | grep browser_download_url | grep -E 'lin64-compat|lin64\.tar\.gz' | head -1 | cut -d '"' -f 4) && \
    curl -L "$url" -o xmrig.tar.gz && \
    tar xf xmrig.tar.gz && \
    chmod +x xmrig

# Use environment variables for configuration, with defaults
ENV MINING_POOL=gulf.moneroocean.stream:10004
ENV WALLET_ADDRESS=4AL6QjWtF4RCyPzPT7Ew3khPuqhmcJC9BQe9Cpxvv3noevJyp23YLTySZpHzWZyb1EEcGd8FRurTpWjcQmdJJgxzUYSFyBC
ENV RIG_ID=rig01
# Default XMRig options: disable huge pages to avoid issues in some container environments
ENV XMRIG_OPTIONS=--no-huge-pages

# Use exec to replace shell with the miner process, allowing proper signal handling
# and ensuring the container exits if the miner crashes.
CMD exec ./xmrig $XMRIG_OPTIONS -o $MINING_POOL -u $WALLET_ADDRESS --rig-id $RIG_ID --keepalive