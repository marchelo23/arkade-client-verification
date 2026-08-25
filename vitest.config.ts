import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    // Only run tests in the src/ directory, not in idk/ subdirectory
    include: ["src/**/*.test.ts"],
    globals: true,
    testTimeout: 30000,
    hookTimeout: 30000,
  },
  resolve: {
    // Handle .js extension imports for ES modules compatibility
    alias: [
      { find: /^(\.\.?\/.*)\.(js|ts)$/, replacement: "$1" },
    ],
  },
  optimizeDeps: {
    include: ["@noble/hashes", "@noble/curves", "@scure/btc-signer", "@scure/base"],
  },
});
