# ==============================================================================
# Hardened Multi-Stage Dockerfile for Arkade VTXO Client Verification
# Runtime: Node.js 22 LTS (Alpine Linux) with pnpm & non-root user execution
# ==============================================================================

FROM node:22-alpine AS base

# Install necessary runtime and security dependencies
RUN apk add --no-cache bash curl ca-certificates && \
    corepack enable && \
    corepack prepare pnpm@10.30.1 --activate

WORKDIR /app

# Install dependencies separately for optimal Docker layer caching
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile || pnpm install

# Copy source code and build configurations
COPY tsconfig.json vitest.config.ts audit_ci.sh ./
COPY src/ ./src/

# Change ownership to non-root user for security hardening
RUN chown -R node:node /app
USER node

# Default entrypoint runs full verification test suite
CMD ["pnpm", "test"]
