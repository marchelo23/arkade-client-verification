# Upstream Integration Guide: Porting to `@arkade-os/sdk`

This guide explains how to integrate this verification pipeline into the official [`arkade-os/ts-sdk`](https://github.com/arkade-os/ts-sdk) repository (`packages/ts-sdk`).

---

## 1. Upstream Monorepo Structure

In `arkade-os/ts-sdk`, packages are structured using `pnpm` workspaces:
```
arkade-monorepo/
├── package.json
├── pnpm-workspace.yaml
└── packages/
    ├── boltz-swap/
    ├── swap/
    └── ts-sdk/               <-- Target Package (@arkade-os/sdk)
        ├── package.json
        └── src/
            ├── tree/
            │   ├── txTree.ts
            │   ├── signingSession.ts
            │   └── validation.ts
            ├── musig2.ts
            └── index.ts
```

---

## 2. File Placement in `packages/ts-sdk`

Place the verification modules into `packages/ts-sdk/src/verification/` or extend `packages/ts-sdk/src/tree/`:

| Source File (Local Repo) | Destination in `packages/ts-sdk` | Purpose |
| :--- | :--- | :--- |
| `src/vtxoDAGVerification.ts` | `src/tree/vtxoDAGVerification.ts` | Core DAG reconstruction, inflation, and cycle checks. |
| `src/taprootVerification.ts` | `src/tree/taprootVerification.ts` | Taproot leaf Merkle audit & MuSig2 aggregation checks. |
| `src/timelockVerification.ts` | `src/tree/timelockVerification.ts` | BIP 68 CSV relative timelock validation. |
| `src/hashPreimageVerification.ts`| `src/tree/hashPreimageVerification.ts` | Atomic swap HTLC preimage verification. |
| `src/signatureVerification.ts` | `src/tree/signatureVerification.ts` | BIP 340 Schnorr signature validation. |
| `src/sovereignStorage.ts` | `src/storage/sovereignStorage.ts` | Encrypted persistence of sovereign exit plans. |
| `src/bitcoinRpc.ts` | `src/providers/bitcoinRpc.ts` | Multi-node on-chain anchoring verification. |

---

## 3. Handling Upstream Dependency Upgrades (`@scure/btc-signer` v2)

When porting to `@scure/btc-signer@2.0.1` and `@noble/curves@2.0.1`:
1. **Transaction ID Computation**:
   - In `@scure/btc-signer@1.x`, accessing `.id` on unsigned PSBTs required a manual SHA256d helper `computeTxid()`.
   - In `@scure/btc-signer@2.x`, verify compatibility with `tx.id` vs manual serialization.
2. **TypeDoc & Biome Compliance**:
   - Run `pnpm run lint` and `pnpm run format` using Biome in the monorepo root.
   - Ensure all public functions have TypeDoc docstrings for automated SDK docs generation (`pnpm docs:build`).
