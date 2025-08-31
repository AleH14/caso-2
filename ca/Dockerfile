# CA minimal con OpenSSL
FROM ubuntu:22.04

# No-interactive APT
ENV DEBIAN_FRONTEND=noninteractive

# Paquetes necesarios
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl ca-certificates bash coreutils \
 && rm -rf /var/lib/apt/lists/*

# Directorios estándar de la CA
RUN mkdir -p /ca/certs /ca/private /ca/newcerts /ca/crl \
 && chmod 700 /ca/private

# Archivos de base para el índice/serie
RUN touch /ca/index.txt && echo 1000 > /ca/serial

# Copiar config y scripts
WORKDIR /ca
COPY openssl.cnf /ca/openssl.cnf
COPY san.cnf /ca/san.cnf
COPY init-ca.sh /usr/local/bin/init-ca.sh
COPY sign-csr.sh /usr/local/bin/sign-csr.sh
COPY generate-mail-cert.sh /ca/generate-mail-cert.sh
RUN chmod +x /usr/local/bin/*.sh && chmod +x /ca/generate-mail-cert.sh

# Mantén /certs como volumen compartido con otros servicios
VOLUME ["/certs"]

# Arranque: inicializa CA (si no existe) y queda vivo
CMD ["bash", "-c", "init-ca.sh && tail -f /dev/null"]
