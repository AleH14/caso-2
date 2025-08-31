#!/bin/bash
set -e

echo "[CA] Generando CSR para servidor de correo..."

# Crear clave privada sin contraseña
openssl genrsa -out /certs/mail-server.key 2048

# Crear CSR para el servidor de correo
openssl req -new \
  -key /certs/mail-server.key \
  -out /certs/mail-server.csr \
  -subj "/C=MX/ST=Estado/L=Ciudad/O=MiEmpresa/OU=Mail/CN=s2.miempresa.local"

echo "[CA] Firmando certificado para servidor de correo..."
openssl ca -batch \
  -config /ca/openssl.cnf \
  -in /certs/mail-server.csr \
  -out /certs/mail-server.crt \
  -extensions v3_server

echo "[CA] Certificado de correo generado: /certs/mail-server.crt"
chmod 644 /certs/mail-server.crt
chmod 600 /certs/mail-server.key
