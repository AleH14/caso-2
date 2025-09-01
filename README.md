# Proyecto de Infraestructura Docker

Este proyecto implementa una infraestructura completa con:
- **Autoridad Certificadora (CA)** para generar certificados SSL/TLS
- **Servidor HTTPS** con Nginx y certificados SSL
- **Servidor de Correo** con Postfix y Dovecot

## 🏗️ Estructura del Proyecto

```
├── ca/                     # Autoridad Certificadora
│   ├── Dockerfile
│   ├── init-ca.sh         # Script de inicialización de CA
│   ├── sign-csr.sh        # Script para firmar CSRs
│   ├── openssl.cnf        # Configuración de OpenSSL
│   └── san.cnf           # Configuración de SAN
├── Server-HTTPS/          # Servidor Web HTTPS
│   ├── Dockerfile
│   ├── nginx.conf         # Configuración de Nginx
│   └── generate_csr.sh    # Generador de CSR
├── server-PGP/           # Servidor de Correo
│   ├── Dockerfile
│   └── init-mail.sh      # Configuración de correo
├── certs/                # Certificados generados (auto-creado)
├── maildata/             # Datos de correo (auto-creado)
└── docker-compose.yml    # Orquestación de servicios
```

## 🚀 Inicio Rápido

### Prerrequisitos
- Docker
- Docker Compose

### Ejecución
```bash
# Construir e iniciar todos los servicios
docker compose up --build -d

# Ver logs de todos los servicios
docker compose logs -f

# Ver logs de un servicio específico
docker logs ca_server
docker logs web_server
```

## 🌐 Servicios Disponibles

### 1. Servidor HTTPS
- **URL**: https://localhost:8443
- **Puerto**: 8443:443
- **Certificado**: Generado automáticamente por la CA
- **Características**: 
  - SSL/TLS con certificado válido
  - Headers CORS configurados
  - Configuración de seguridad SSL

### 2. Autoridad Certificadora (CA)
- **Función**: Genera y firma certificados SSL
- **Ubicación certificados**: `./certs/`
- **Certificado raíz**: `ca.crt`
- **Monitoreo**: Automático de CSRs

### 3. Servidor de Correo
- **SMTP**: Puerto 25, 587 (STARTTLS), 465 (SSL/TLS)
- **IMAP**: Puerto 143 (STARTTLS), 993 (SSL/TLS)
- **Usuarios disponibles**:
  - `alice@server.local` - Password: `ClaveSegura1!`
  - `bob@server.local` - Password: `ClaveSegura2!`  
  - `test@server.local` - Password: `password123`
- **Dominio**: server.local
- **Hostname**: mail.server.local

## � Configuración de Thunderbird

Para configurar Thunderbird con el servidor de correo:

### Configuración de Cuenta
1. **Nombre**: Alice o Bob (según el usuario)
2. **Email**: `alice@server.local` o `bob@server.local` o `test@server.local`
3. **Contraseña**: `ClaveSegura1!` o `ClaveSegura2!` o `password123`

### Configuración del Servidor
**Servidor de entrada (IMAP):**
- Servidor: `localhost` o `127.0.0.1`
- Puerto: `993` (SSL/TLS) o `143` (STARTTLS)
- Seguridad: SSL/TLS o STARTTLS
- Método de autenticación: Contraseña normal

**Servidor de salida (SMTP):**
- Servidor: `localhost` o `127.0.0.1`
- Puerto: `587` (STARTTLS) o `465` (SSL/TLS)
- Seguridad: STARTTLS o SSL/TLS
- Método de autenticación: Contraseña normal

### ⚠️ Certificados
- El servidor usa certificados autofirmados
- Thunderbird mostrará advertencias de seguridad
- Hacer clic en "Confirmar excepción de seguridad" para continuar

## �🔧 Configuración

### Variables de Entorno
```env
# Servidor web
SERVER_NAME=server.local

# Servidor de correo
USERS=usuario1@domain.com:password1,usuario2@domain.com:password2
```

### Volúmenes
- `./certs:/certs` - Certificados compartidos
- `./maildata:/var/mail` - Datos de correo persistentes

## 🛠️ Comandos Útiles

```bash
# Reiniciar un servicio específico
docker compose restart web_server

# Firmar manualmente un CSR
docker exec ca_server bash /usr/local/bin/sign-csr.sh /certs/ejemplo.csr ejemplo

# Ver certificados generados
ls -la certs/

# Probar el servidor HTTPS
curl -k https://localhost:8443/

# Acceder a un contenedor
docker exec -it web_server bash
```

## 🔐 Seguridad

### ⚠️ IMPORTANTE
- Los certificados y claves privadas están excluidos del repositorio
- Nunca subas archivos `.key`, `.crt`, o del directorio `certs/`
- Las claves PGP están excluidas del repositorio
- Los datos de correo son locales y no se suben

### Archivos Sensibles Excluidos
- `certs/` - Certificados y claves
- `pgp_keys/` - Claves PGP/GPG  
- `maildata/` - Datos de correo
- `*.key`, `*.crt`, `*.pem` - Archivos de certificados

## 🐛 Troubleshooting

### El servidor HTTPS no responde
```bash
# Verificar que nginx está corriendo
docker exec web_server ps aux | grep nginx

# Verificar certificados
docker exec web_server ls -la /etc/ssl/server/

# Reiniciar nginx manualmente
docker exec -d web_server nginx -g "daemon off;"
```

### Certificados no se generan
```bash
# Verificar logs de CA
docker logs ca_server

# Firmar CSR manualmente
docker exec ca_server bash /usr/local/bin/sign-csr.sh /certs/server.local.csr server.local
```

## 📝 Notas de Desarrollo

- El proyecto usa certificados autofirmados válidos para desarrollo
- La CA funciona en modo continuo monitoreando nuevos CSRs
- Nginx incluye configuración CORS para desarrollo web
- El servidor de correo funciona sin SSL para simplicidad

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request
