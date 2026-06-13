#!/usr/bin/env bash
# status.sh
set -euo pipefail
RPC=${ARCIUM_RPC:-127.0.0.1:9001}
echo "cluster height: $(arx rpc --rpc=$RPC clusterheight 2>/dev/null || echo n/a)"
echo "ceremonies    : $(arx rpc --rpc=$RPC ceremonies 2>/dev/null || echo n/a)"
echo "balance       : $(arx rpc --rpc=$RPC balance 2>/dev/null || echo n/a)"
echo "identity      : $(cat /root/.arcium/identity.key.pub 2>/dev/null || echo n/a)"
