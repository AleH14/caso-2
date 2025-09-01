# 📧 Guía de Configuración para Thunderbird

## 🎯 Configuración Exacta

### Información de la Cuenta:
- Nombre: Alice
- Dirección de correo: alice@server.local
- Contraseña: ClaveSegura1!

### Configuración Manual en Thunderbird:

#### 🔐 MÉTODO 1 (Recomendado - SSL/TLS):
**Servidor de entrada (IMAP):**
- Servidor: localhost
- Puerto: 993
- Seguridad de conexión: SSL/TLS
- Método de autenticación: Contraseña normal
- Nombre de usuario: alice@server.local

**Servidor de salida (SMTP):**
- Servidor: localhost  
- Puerto: 465
- Seguridad de conexión: SSL/TLS
- Método de autenticación: Contraseña normal
- Nombre de usuario: alice@server.local

#### 🔄 MÉTODO 2 (Alternativo - STARTTLS):
**Servidor de entrada (IMAP):**
- Servidor: localhost
- Puerto: 143
- Seguridad de conexión: STARTTLS
- Método de autenticación: Contraseña normal
- Nombre de usuario: alice@server.local

**Servidor de salida (SMTP):**
- Servidor: localhost
- Puerto: 587
- Seguridad de conexión: STARTTLS
- Método de autenticación: Contraseña normal
- Nombre de usuario: alice@server.local

## 🚨 Posibles Problemas y Soluciones:

### Problema 1: "No se puede encontrar un servidor"
- ✅ Usar exactamente "localhost" como servidor
- ✅ NO usar "mail.server.local" inicialmente
- ✅ Certificado CA debe estar importado como "Local Lab Root CA"

### Problema 2: Error de certificado
- ✅ Verificar que "Local Lab Root CA" está en Autoridades
- ✅ Debe estar marcado para "correo electrónico"
- ✅ Intentar primero con puertos SSL directos (993/465)

### Problema 3: Error de autenticación
- ✅ Nombre de usuario COMPLETO: alice@server.local
- ✅ Contraseña exacta: ClaveSegura1!
- ✅ Método: "Contraseña normal"

## 🔧 Pasos de Diagnóstico:

1. **Configuración automática**: Desactivar
2. **Configuración manual**: Activar
3. **Probar primero**: Método 1 (SSL/TLS directo)
4. **Si falla**: Probar Método 2 (STARTTLS)

## 👥 Usuarios Disponibles:
- alice@server.local / ClaveSegura1!
- bob@server.local / ClaveSegura2!  
- test@server.local / password123
