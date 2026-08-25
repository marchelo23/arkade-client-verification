# Containerization & Sandbox Execution Guide (Docker / Podman)

This repository includes a hardened container configuration for running tests, security audits, and benchmarks in an isolated, reproducible environment.

---

## 1. Quick Commands

### Run Full Test Suite (104 Tests)
Using Docker Compose:
```bash
docker compose run --rm test
```
Or with plain Docker:
```bash
docker build -t arkade-vtxo-verification .
docker run --rm arkade-vtxo-verification
```

### Run Adversarial Blackbox Security Tests
```bash
docker compose run --rm sec
```

### Run Stress & DoS Tests (1,000+ Node DAGs)
```bash
docker compose run --rm stress
```

### Run Full CI Security Audit
```bash
docker compose run --rm audit
```

### Interactive Development Mode
```bash
docker compose up dev
```

---

## 2. Podman Support

If running with Podman, the setup is 100% compatible:
```bash
podman-compose run --rm test
# or
podman build -t arkade-vtxo-verification .
podman run --rm arkade-vtxo-verification
```

---

## 3. Security Hardening Details

- **Base Image**: `node:22-alpine` (minimal attack surface, no unnecessary build utilities).
- **Package Manager**: `pnpm@10.30.1` via Corepack.
- **Non-Root Execution**: Runs under the unprivileged `node` user (`UID 1000`).
- **Deterministic Dependencies**: Locked with `pnpm-lock.yaml`.
