#!/bin/bash
cd /etc/ssl/server
SERVER_NAME=${SERVER_NAME:-"server.local"}
openssl genrsa -out ${SERVER_NAME}.key 2048
openssl req -new -key ${SERVER_NAME}.key -out ${SERVER_NAME}.csr \
    -subj "/C=SV/ST=San Salvador/L=San Salvador/O=MiEmpresa/OU=IT/CN=${SERVER_NAME}"
echo "[Web] CSR generado listo para firmar por la CA"
