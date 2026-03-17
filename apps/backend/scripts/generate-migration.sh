#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: pnpm sql <migration_name>"
  exit 1
fi
drizzle-kit generate --name "$1" && bash scripts/sync-migrations.sh
