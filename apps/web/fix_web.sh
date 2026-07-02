#!/bin/bash

set -e

echo "================================"
echo "FIXING LIFE CIRCLE WEB"
echo "================================"

export NVM_DIR="$HOME/.nvm"
source /opt/homebrew/opt/nvm/nvm.sh
nvm use 22 >/dev/null

echo
echo "Node:"
node -v
npm -v

echo
echo "Cleaning old artifacts..."
rm -rf apps/web/.next

echo
echo "Checking root node_modules..."
ls node_modules/next >/dev/null

echo
echo "Starting Next.js using root installation..."
cd apps/web

../../node_modules/.bin/next dev -p 3000
