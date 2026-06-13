#!/usr/bin/env bash
set -euo pipefail
NAME=arcium-node
DATA=${ARCIUM_DATA:-/root/.arcium}
LOG=${ARCIUM_LOG:-/var/log/arcium.log}
mkdir -p "$(dirname "$LOG")" "$DATA"
if screen -ls | grep -q "\.${NAME}"; then echo "$NAME running"; exit 0; fi
screen -dmS "$NAME" /bin/bash -c "arx node --config $DATA/config.toml 2>&1 | tee -a $LOG"
sleep 2
screen -ls | grep "$NAME" || { echo "failed"; exit 1; }
