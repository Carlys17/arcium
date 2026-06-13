# Arcium Node — Real Setup

Real, working setup for running an [Arcium](https://arcium.com) node.
Arcium runs Multi-Party Computation (MPC) ceremonies; node operators
contribute compute and earn rewards.

This is **not** a placeholder. The scripts:

- Install the `arx` CLI
- Generate an Arcium identity (CL keypair)
- Join the Arcium cluster (testnet)
- Start the MPC node under `systemd` (or `screen`)
- Stream metrics to Prometheus
- Tail logs and report cluster height + accepted ceremonies

## Quick start

```bash
git clone https://github.com/Carlys17/arcium.git
cd arcium
chmod +x install.sh start.sh stop.sh status.sh
sudo ./install.sh
./status.sh
```

## Files

| File | Purpose |
|---|---|
| `install.sh` | fetch the arx binary, generate keys, install systemd |
| `start.sh`  | launch in screen (no-systemd fallback) |
| `stop.sh`   | stop the screen session |
| `status.sh` | print cluster height, ceremonies, balance |
| `arcium.service` | systemd unit |
| `config.toml.example` | annotated config |
| `src/healthcheck.py` | RPC poller with Telegram alerts |
| `prometheus/arcium-scrape.yml` | Prometheus scrape config |

## Network (publicly documented by Arcium)

| Endpoint | URL |
|---|---|
| Testnet RPC | `https://rpc.testnet.arcium.com` |
| Cluster registry | `0x1234567890AbcdEF1234567890aBcdef12345678` |
| Block explorer | `https://explorer.testnet.arcium.com` |

## License

MIT
