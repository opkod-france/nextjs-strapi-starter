#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
ENV_EXAMPLE="$ROOT_DIR/.env.example"

echo "──────────────────────────────────────"
echo "  Next.js + Strapi Starter — Setup"
echo "──────────────────────────────────────"

# 1. Copy .env if it doesn't exist
if [ ! -f "$ENV_FILE" ]; then
  echo "→ Creating .env from .env.example..."
  cp "$ENV_EXAMPLE" "$ENV_FILE"
else
  echo "→ .env already exists, skipping copy."
fi

# 2. Generate secrets
generate_secret() {
  openssl rand -base64 32
}

fill_secret() {
  local key="$1"
  local current
  current=$(grep "^${key}=" "$ENV_FILE" | cut -d'=' -f2-)
  if [ -z "$current" ]; then
    local secret
    secret=$(generate_secret)
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' "s|^${key}=.*|${key}=${secret}|" "$ENV_FILE"
    else
      sed -i "s|^${key}=.*|${key}=${secret}|" "$ENV_FILE"
    fi
    echo "  ✓ Generated ${key}"
  else
    echo "  · ${key} already set"
  fi
}

echo ""
echo "→ Generating secrets..."
fill_secret "JWT_SECRET"
fill_secret "ADMIN_JWT_SECRET"
fill_secret "API_TOKEN_SALT"
fill_secret "TRANSFER_TOKEN_SALT"

# APP_KEYS needs comma-separated values
APP_KEYS_CURRENT=$(grep "^APP_KEYS=" "$ENV_FILE" | cut -d'=' -f2-)
if [ -z "$APP_KEYS_CURRENT" ]; then
  KEY1=$(generate_secret)
  KEY2=$(generate_secret)
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|^APP_KEYS=.*|APP_KEYS=${KEY1},${KEY2}|" "$ENV_FILE"
  else
    sed -i "s|^APP_KEYS=.*|APP_KEYS=${KEY1},${KEY2}|" "$ENV_FILE"
  fi
  echo "  ✓ Generated APP_KEYS"
else
  echo "  · APP_KEYS already set"
fi

# 3. Install dependencies
echo ""
echo "→ Installing dependencies..."
cd "$ROOT_DIR" && yarn install --ignore-engines

echo ""
echo "──────────────────────────────────────"
echo "  Setup complete!"
echo ""
echo "  Next steps:"
echo "    1. docker compose up -d    (start PostgreSQL)"
echo "    2. yarn dev                (start dev servers)"
echo "    3. Open https://api.localhost/admin to create your Strapi admin"
echo "    4. Open https://app.localhost for the frontend"
echo "──────────────────────────────────────"
