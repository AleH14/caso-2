FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
    openssl \
    nginx \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /etc/ssl/server

# Copiar script de generación de CSR y Nginx config
COPY generate_csr.sh /usr/local/bin/generate_csr.sh
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /usr/local/bin/generate_csr.sh

# Exponer puerto HTTPS
EXPOSE 443

# Generar CSR al iniciar si no existe clave
CMD bash -c "\
  if [ ! -f /etc/ssl/server/${SERVER_NAME}.key ]; then \
    generate_csr.sh; \
  fi && \
  echo 'Esperando certificado firmado en /etc/ssl/server/${SERVER_NAME}.crt...' && \
  while [ ! -f /etc/ssl/server/${SERVER_NAME}.crt ]; do sleep 2; done && \
  nginx -g 'daemon off;'"
