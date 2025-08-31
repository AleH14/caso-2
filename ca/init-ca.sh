#!/usr/bin/env bash
set -euo pipefail

CA_KEY="/ca/private/ca.key"
CA_CRT="/ca/certs/ca.crt"

# Asegurar base de la CA
mkdir -p /ca/certs /ca/private /ca/newcerts /ca/crl
chmod 700 /ca/private
touch /ca/index.txt || true
[ -f /ca/serial ] || echo 1000 > /ca/serial

if [ ! -f "$CA_KEY" ] || [ ! -f "$CA_CRT" ]; then
  echo "[CA] Generando clave privada y certificado raíz..."
  openssl genrsa -out "$CA_KEY" 4096

  # Cert raíz autofirmado
  openssl req -x509 -new -nodes \
    -key "$CA_KEY" \
    -sha256 -days 3650 \
    -out "$CA_CRT" \
    -config /ca/openssl.cnf \
    -subj "/C=SV/O=Local Lab/CN=Local Lab Root CA" \
    -extensions v3_ca

  echo "[CA] Certificado raíz creado en $CA_CRT"
else
  echo "[CA] Certificado raíz ya existe, no se regenera."
fi

# Si hay volumen /certs, publica el root CA
if [ -d "/certs" ]; then
  if [ ! -f "/certs/ca.crt" ]; then
    cp "$CA_CRT" /certs/ca.crt
    echo "[CA] Copiado ca.crt a /certs/ca.crt"
  else
    echo "[CA] /certs/ca.crt ya existe."
  fi
  
  # Generar certificado para servidor de correo si no existe
  if [ ! -f "/certs/mail-server.crt" ]; then
    echo "[CA] Generando certificado para servidor de correo..."
    bash /ca/generate-mail-cert.sh
  else
    echo "[CA] Certificado de correo ya existe."
  fi
  
  # Firmar CSR del servidor web si existe
  if [ -f "/certs/server.local.csr" ] && [ ! -f "/certs/server.local.crt" ]; then
    echo "[CA] Firmando CSR del servidor web..."
    bash /usr/local/bin/sign-csr.sh /certs/server.local.csr server.local
  else
    echo "[CA] CSR del servidor web no encontrado o certificado ya existe."
  fi
fi

# Modo continuo: monitorear por nuevos CSRs
echo "[CA] Monitoreando CSRs..."
while true; do
  if [ -f "/certs/server.local.csr" ] && [ ! -f "/certs/server.local.crt" ]; then
    echo "[CA] Nuevo CSR detectado, firmando..."
    bash /usr/local/bin/sign-csr.sh /certs/server.local.csr server.local
  fi
  sleep 5
done
