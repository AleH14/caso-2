#!/usr/bin/env bash
set -euo pipefail

CSR_PATH="${1:-}"
NAME="${2:-server}"

if [ -z "$CSR_PATH" ] || [ ! -f "$CSR_PATH" ]; then
  echo "Uso: sign-csr.sh <ruta-al-csr> [nombre-salida-sin-ext]"
  echo "Ej:  sign-csr.sh /certs/web.csr web"
  exit 1
fi

OUT="/certs/${NAME}.crt"

echo "[CA] Firmando CSR: $CSR_PATH -> $OUT"
# -batch para evitar prompts interactivos
openssl ca -batch \
  -config /ca/openssl.cnf \
  -in "$CSR_PATH" \
  -out "$OUT" \
  -extensions v3_server

echo "[CA] Certificado emitido: $OUT"
