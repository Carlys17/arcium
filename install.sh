#!/usr/bin/env bash
set -euo pipefail
REPO="${ARCIUM_REPO:-arcium-foundation/arx}"
VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | grep -m1 '"tag_name"' | cut -d'"' -f4)
VERSION="${VERSION#v}"
ARCH=$(uname -m); case "$ARCH" in x86_64) B=amd64 ;; aarch64) B=arm64 ;; *) echo "bad arch"; exit 1 ;; esac
URL="https://github.com/${REPO}/releases/download/v${VERSION}/arx-${VERSION}-linux-${B}.tar.gz"
echo "==> installing arx v${VERSION}"
TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
curl -fsSL "$URL" -o "$TMP/a.tgz"
tar -xzf "$TMP/a.tgz" -C "$TMP"
install -m 0755 "$TMP/arx" /usr/local/bin/arx

mkdir -p /root/.arcium
[[ -f /root/.arcium/config.toml ]] || cp config.toml.example /root/.arcium/config.toml
if [[ ! -f /root/.arcium/identity.key ]]; then
  echo "==> generating identity"
  arx identity gen --out /root/.arcium/identity.key
fi
echo "==> joining testnet cluster"
arx cluster join --config /root/.arcium/config.toml || true

if command -v systemctl >/dev/null && systemctl --no-pager status >/dev/null 2>&1; then
  cp arcium.service /etc/systemd/system/arcium.service
  systemctl daemon-reload
  systemctl enable --now arcium
  echo "==> service installed: arcium (systemd)"
fi
arx --version
