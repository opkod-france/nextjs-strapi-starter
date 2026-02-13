#!/usr/bin/env bash
set -euo pipefail

# Generate self-signed SSL certificates for local development
# Trusted by your browser via mkcert (recommended) or plain openssl fallback.

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CERT_DIR="$ROOT_DIR/docker/certs"
DOMAIN="${LOCAL_DOMAIN:-app.localhost}"
API_DOMAIN="${LOCAL_API_DOMAIN:-api.localhost}"

mkdir -p "$CERT_DIR"

if command -v mkcert &> /dev/null; then
  echo "→ Using mkcert for trusted local certificates..."
  mkcert -install 2>/dev/null || true
  mkcert -cert-file "$CERT_DIR/local.crt" -key-file "$CERT_DIR/local.key" \
    "$DOMAIN" "$API_DOMAIN" "*.localhost" localhost 127.0.0.1 ::1
  echo "  ✓ Certificates generated and trusted by your system"
else
  echo "→ mkcert not found, using openssl (browser will show security warning)..."
  echo "  Tip: Install mkcert for trusted certs → brew install mkcert"
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERT_DIR/local.key" \
    -out "$CERT_DIR/local.crt" \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:$DOMAIN,DNS:$API_DOMAIN,DNS:*.localhost,DNS:localhost,IP:127.0.0.1"
  echo "  ✓ Self-signed certificates generated"
fi

echo ""
echo "  Certificates saved to: $CERT_DIR/"
echo "  Domains: $DOMAIN, $API_DOMAIN"
