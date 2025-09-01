# 🚀 Proyecto de Infraestructura Docker - Caso 2

Este proyecto implementa una infraestructura completa con tres servicios interconectados que utilizan certificados SSL/TLS generados automáticamente:

- **🔐 Autoridad Certificadora (CA)** - Genera y firma certificados SSL/TLS automáticamente
- **🌐 Servidor Web HTTPS** - Nginx con certificados SSL generados por la CA
- **📧 Servidor de Correo** - Docker Mailserver con soporte SSL/TLS completo

## 🏗️ Arquitectura del Proyecto

```
caso-2/
├── ca/                        # 🔐 Autoridad Certificadora
│   ├── Dockerfile            # Imagen Ubuntu con OpenSSL
│   ├── init-ca.sh            # Inicialización automática de CA
│   ├── sign-csr.sh           # Firmado automático de CSRs
│   ├── generate-mail-cert.sh # Generador específico para correo
│   ├── openssl.cnf           # Configuración OpenSSL para CA
│   └── san.cnf              # Configuración Subject Alternative Names
├── Server-HTTPS/             # 🌐 Servidor Web HTTPS
│   ├── Dockerfile           # Nginx + herramientas SSL
│   ├── nginx.conf           # Configuración Nginx con SSL
│   └── generate_csr.sh      # Generador automático de CSR
├── server-PGP/              # 📧 Servidor de Correo
│   ├── Dockerfile           # Docker Mailserver
│   ├── mailserver.env       # Variables de configuración
│   └── config/              # Configuraciones específicas
│       ├── postfix-accounts.cf
│       ├── postfix-aliases.cf
│       └── dovecot-quotas.cf
├── certs/                   # 📁 Certificados (generado automáticamente)
├── maildata/                # 📁 Datos persistentes de correo
├── maillogs/                # 📁 Logs del servidor de correo
└── docker-compose.yml       # 🐳 Orquestación de servicios
```

## ⚡ Inicio Rápido

### 📋 Prerrequisitos
- **Docker** (versión 20.10+)
- **Docker Compose** (versión 2.0+)
- **Puertos libres**: 8443, 25, 143, 465, 587, 993

### 🎯 Ejecución Completa

```powershell
# 1. Clonar y navegar al proyecto
git clone <repository-url>
cd caso-2

# 2. Limpiar certificados previos (opcional)
Remove-Item -Path ".\certs\*" -Force -ErrorAction SilentlyContinue

# 3. Construir todas las imágenes desde cero
docker compose build --no-cache

# 4. Iniciar todos los servicios
docker compose up -d

# 5. Verificar el estado de los contenedores
docker compose ps

# 6. Ver logs en tiempo real (opcional)
docker compose logs -f
```

### ✅ Verificación de Funcionamiento

```powershell
# Verificar certificados generados
Get-ChildItem -Path ".\certs\" -Force

# Verificar puertos activos
netstat -an | Select-String ":8443|:25|:143|:465|:587|:993"

# Probar servidor web
# Abrir https://localhost:8443 en el navegador (aceptar certificado)
```

## 🌐 Servicios Disponibles

### 1. 🔐 Autoridad Certificadora (CA)
- **Función**: Genera certificados SSL/TLS automáticamente
- **Contenedor**: `ca_server`
- **Certificados generados**:
  - `ca.crt` - Certificado raíz de la CA
  - `server.local.crt` - Certificado para servidor web
  - `mail-server.crt` - Certificado para servidor de correo
- **Características**:
  - Monitoreo automático de CSRs
  - Generación automática al inicio
  - Firmado con algoritmo SHA-256 + RSA

### 2. 🌐 Servidor Web HTTPS
- **URL**: https://localhost:8443
- **Puerto**: 8443 → 443 (interno)
- **Contenedor**: `web_server`
- **Características**:
  - SSL/TLS con certificado válido generado por CA
  - Headers CORS configurados para desarrollo
  - Configuración de seguridad SSL moderna (TLSv1.2/TLSv1.3)
  - Respuesta de prueba: "Servidor HTTPS funcionando correctamente!"

### 3. 📧 Servidor de Correo
- **Dominio**: server.local
- **Hostname**: mail.server.local
- **Contenedor**: `mail_server`

#### 📮 Puertos de Correo:
- **SMTP**: 25 (sin cifrar)
- **SMTP SSL/TLS**: 465 (cifrado)
- **SMTP STARTTLS**: 587 (cifrado)
- **IMAP**: 143 (sin cifrar/STARTTLS)
- **IMAPS**: 993 (cifrado SSL/TLS)

#### 👥 Usuarios Preconfigurados:
- `alice@server.local` 
- `bob@server.local`

> **Nota**: Las contraseñas se configuran en `server-PGP/config/postfix-accounts.cf`

## 🔧 Comandos de Gestión

### 🐳 Docker Compose
```powershell
# Iniciar servicios
docker compose up -d

# Detener servicios
docker compose down

# Reiniciar un servicio específico
docker compose restart ca
docker compose restart web
docker compose restart mail

# Ver logs de todos los servicios
docker compose logs -f

# Ver logs de un servicio específico
docker compose logs -f ca
docker compose logs -f web
docker compose logs -f mail

# Reconstruir imágenes
docker compose build --no-cache

# Estado de los contenedores
docker compose ps -a
```

### 🔍 Diagnóstico y Debugging

```powershell
# Verificar certificados generados
Get-ChildItem -Path ".\certs\" -Force

# Inspeccionar certificado del servidor web
docker exec ca_server openssl x509 -in /certs/server.local.crt -text -noout

# Inspeccionar certificado del servidor de correo
docker exec ca_server openssl x509 -in /certs/mail-server.crt -text -noout

# Verificar que nginx está ejecutándose
docker exec web_server ps aux

# Verificar archivos en el servidor web
docker exec web_server ls -la /etc/ssl/server/

# Verificar configuración del servidor de correo
docker exec mail_server supervisorctl status

# Acceder al shell de un contenedor
docker exec -it ca_server bash
docker exec -it web_server bash
docker exec -it mail_server bash
```

### 🔧 Troubleshooting Común

#### 🚨 Problema: Certificados no se generan
```powershell
# Verificar logs de la CA
docker compose logs ca

# Regenerar certificados manualmente
docker exec ca_server bash /usr/local/bin/sign-csr.sh /certs/server.local.csr server.local

# Verificar permisos de archivos
docker exec ca_server ls -la /certs/
```

#### 🚨 Problema: Servidor web no responde
```powershell
# Verificar que nginx está corriendo
docker exec web_server ps aux | grep nginx

# Verificar configuración de nginx
docker exec web_server nginx -t

# Reiniciar nginx manualmente
docker exec web_server nginx -s reload
```

#### 🚨 Problema: Servidor de correo se reinicia
```powershell
# Verificar logs detallados
docker compose logs mail

# Verificar certificados del correo
docker exec mail_server ls -la /etc/letsencrypt/live/server.local/

# Verificar configuración de mailserver
docker exec mail_server cat /etc/postfix/main.cf | grep ssl
```

#### 🚨 Problema: Puertos no disponibles
```powershell
# Verificar qué procesos usan los puertos
netstat -ano | findstr ":8443"
netstat -ano | findstr ":25"

# En Linux/Mac usar:
# lsof -i :8443
# lsof -i :25
```

## 📧 Configuración de Cliente de Correo (Thunderbird)

### 🔧 Configuración Manual

#### **Datos de la Cuenta**:
- **Nombre completo**: Alice (o Bob)
- **Dirección de correo**: alice@server.local (o bob@server.local)
- **Contraseña**: [Ver archivo postfix-accounts.cf]

#### **Servidor de Entrada (IMAP)**:
- **Servidor**: localhost (o 127.0.0.1)
- **Puerto**: 993
- **Seguridad de conexión**: SSL/TLS
- **Método de autenticación**: Contraseña normal

#### **Servidor de Salida (SMTP)**:
- **Servidor**: localhost (o 127.0.0.1)  
- **Puerto**: 587
- **Seguridad de conexión**: STARTTLS
- **Método de autenticación**: Contraseña normal

### ⚠️ Certificados Autofirmados
- Thunderbird mostrará advertencias de seguridad
- Hacer clic en **"Confirmar excepción de seguridad"** para cada certificado
- Los certificados son válidos pero no están firmados por una CA reconocida públicamente

## 🔐 Seguridad y Certificados

### 📋 Detalles de Certificados Generados

#### **Certificado CA (ca.crt)**:
- **Emisor**: Local Lab Root CA
- **Algoritmo**: SHA-256 con RSA (4096 bits)
- **Validez**: 10 años
- **Uso**: Firma de certificados de servidor

#### **Certificado Servidor Web (server.local.crt)**:
- **Dominio**: server.local
- **Emisor**: Local Lab Root CA
- **Algoritmo**: SHA-256 con RSA (2048 bits)
- **Validez**: ~2 años
- **Uso**: Autenticación de servidor web TLS

#### **Certificado Servidor Correo (mail-server.crt)**:
- **Dominio**: mail.server.local
- **Emisor**: Local Lab Root CA
- **Algoritmo**: SHA-256 con RSA (2048 bits)
- **Validez**: ~2 años
- **Uso**: Autenticación de servidor de correo TLS

### 🚫 Archivos Excluidos del Repositorio
```gitignore
# Certificados y claves privadas
certs/
*.key
*.crt
*.pem
*.p12

# Datos sensibles del servidor de correo
maildata/
maillogs/

# Claves PGP/GPG
pgp_keys/
*.gpg
*.asc
```

### ⚠️ **IMPORTANTE - Seguridad**
- ❌ **NUNCA** subas archivos `.key`, `.crt` o contenido del directorio `certs/`
- ❌ **NUNCA** subas datos del directorio `maildata/`
- ✅ Los certificados se regeneran automáticamente en cada despliegue
- ✅ Usa contraseñas fuertes para cuentas de correo en producción

## 🧪 Testing y Validación

### 🌐 Probar Servidor Web
```powershell
# Método 1: Navegador web
# Ir a https://localhost:8443
# Aceptar certificado autofirmado

# Método 2: PowerShell (ignorar certificado)
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
Invoke-WebRequest -Uri "https://localhost:8443" -UseBasicParsing

# Método 3: Desde dentro del contenedor
docker exec ca_server wget --no-check-certificate https://web_server:443 -O -
```

### 📧 Probar Servidor de Correo
```powershell
# Verificar conectividad SMTP
telnet localhost 25

# Verificar conectividad IMAP
telnet localhost 143

# Desde contenedor (testing interno)
docker exec mail_server netstat -tlnp
```

### 🔍 Validar Certificados
```powershell
# Verificar cadena de certificados web
docker exec ca_server openssl verify -CAfile /certs/ca.crt /certs/server.local.crt

# Verificar cadena de certificados correo
docker exec ca_server openssl verify -CAfile /certs/ca.crt /certs/mail-server.crt

# Probar conexión SSL al servidor web
docker exec ca_server openssl s_client -connect web_server:443 -servername server.local
```

## 📈 Monitoreo y Logs

### 📊 Logs Importantes
```powershell
# Logs de inicialización de CA
docker compose logs ca

# Logs de generación de certificados
docker exec ca_server tail -f /var/log/openssl.log

# Logs del servidor web (nginx)
docker exec web_server tail -f /var/log/nginx/access.log
docker exec web_server tail -f /var/log/nginx/error.log

# Logs del servidor de correo
docker exec mail_server tail -f /var/log/mail/mail.log
docker exec mail_server supervisorctl tail -f mailserver
```

### 🔍 Estados de Servicios
```powershell
# Estado de contenedores
docker compose ps

# Estado detallado de servicios
docker compose top

# Uso de recursos
docker stats ca_server web_server mail_server

# Información de red
docker network ls
docker network inspect caso-2_labnet
```

## 🤝 Contribución y Desarrollo

### 🚀 Desarrollo Local
```powershell
# Clonar repositorio
git clone <repository-url>
cd caso-2

# Crear rama de desarrollo  
git checkout -b feature/nueva-funcionalidad

# Realizar cambios...

# Probar cambios
docker compose down
docker compose build --no-cache
docker compose up -d

# Verificar funcionamiento
docker compose ps
docker compose logs -f
```

### 📝 Estructura de Commits
```
feat: agregar nueva funcionalidad
fix: corregir bug específico  
docs: actualizar documentación
refactor: mejorar código sin cambiar funcionalidad
test: agregar o mejorar pruebas
chore: tareas de mantenimiento
```

### 🔄 Workflow de Contribución
1. **Fork** el repositorio
2. **Crear** rama feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** cambios (`git commit -m 'Add some AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. **Abrir** Pull Request

---

## 📞 Soporte

Si encuentras problemas:

1. **Verificar logs**: `docker compose logs -f`
2. **Revisar puertos**: `netstat -an | Select-String ":8443|:25"`
3. **Limpiar y reconstruir**: 
   ```powershell
   docker compose down
   docker system prune -f
   docker compose build --no-cache
   docker compose up -d
   ```
4. **Consultar sección troubleshooting** arriba

---

**🎯 ¡El proyecto está completamente funcional y listo para usar!** 🚀

> Desarrollado para demostrar integración de servicios Docker con certificados SSL/TLS automáticos.
