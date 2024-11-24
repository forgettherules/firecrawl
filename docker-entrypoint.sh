#!/bin/bash
set -e

# Iniciar Redis em background
redis-server --daemonize yes

# Iniciar workers em background
cd apps/api && pnpm run workers &

# Iniciar servidor principal
cd apps/api && pnpm run start