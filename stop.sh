#!/usr/bin/env bash
set -euo pipefail
if screen -ls | grep -q '\.arcium-node'; then screen -S arcium-node -X quit; echo "stopped"; else echo "not running"; fi
