# 🔐 CREDENCIALES DEL LABORATORIO SÚPER SEGURO

## 📧 **ACCESO AL SERVIDOR DE CORREO**

### 🌐 **Configuración del Servidor**
- **Servidor IMAP**: `localhost:143` (STARTTLS)
- **Servidor SMTP**: `localhost:587` (STARTTLS)  
- **Certificado CA**: `certs/ca.crt` (importar en cliente)

### 👤 **Usuarios de Correo**

#### **Alice Johnson**
- **Email**: `alice@server.local`
- **Contraseña**: `ClaveSegura1!`

#### **Bob Smith**  
- **Email**: `bob@server.local`
- **Contraseña**: `ClaveSegura2!`

#### **Usuario Test**
- **Email**: `test@server.local` 
- **Contraseña**: `password123`

## 🔒 **CLAVES PGP PARA CIFRADO END-TO-END**

### 🔑 **Alice Johnson - Claves PGP**
- **Passphrase PGP**: `AliceSecretPGP2025!`
- **Clave Privada**: `pgp_keys/alice/alice_private.asc`
- **Clave Pública**: `pgp_keys/alice/alice_public.asc`

### 🔑 **Bob Smith - Claves PGP**
- **Passphrase PGP**: `BobSecretPGP2025!`
- **Clave Privada**: `pgp_keys/bob/bob_private.asc`
- **Clave Pública**: `pgp_keys/bob/bob_public.asc`

## 🏢 **CERTIFICADOS SSL/TLS**

### 🏛️ **Autoridad Certificadora (CA)**
- **Nombre**: `Local Lab Root CA`
- **Archivo**: `certs/ca.crt`
- **Importar en**: Thunderbird, navegadores

### 🌐 **Certificados de Servidor**
- **Web Server**: `certs/server.local.crt`
- **Mail Server**: `certs/mail.server.local.crt`  
- **Válidos para**: `localhost`, `server.local`, `mail.server.local`

## 🚀 **ACCESO A SERVICIOS**

### 📧 **Servidor Web HTTPS**
- **URL**: `https://localhost:8443`
- **Certificado**: Válido (firmado por CA local)

### 📮 **Servidor de Correo**
- **IMAP**: `localhost:143` (STARTTLS) o `localhost:993` (SSL/TLS)
- **SMTP**: `localhost:587` (STARTTLS) o `localhost:465` (SSL/TLS)
- **Estado**: ✅ Funcionando con SSL/TLS + PGP

## 📂 **UBICACIÓN DE ARCHIVOS IMPORTANTES**

```
caso-2/
├── certs/                    # 🔐 Certificados SSL/TLS
│   ├── ca.crt               # 🏛️ Certificado CA (importar)
│   ├── server.local.crt     # 🌐 Cert. servidor web
│   └── mail.server.local.crt # 📧 Cert. servidor correo
├── pgp_keys/                # 🔒 Claves PGP
│   ├── alice/               # 👤 Claves de Alice
│   ├── bob/                 # 👤 Claves de Bob  
│   ├── public/              # 🌐 Claves públicas compartidas
│   └── GUIA_PGP_SUPER_SEGURO.md # 📖 Guía completa
└── README.md                # 📋 Documentación principal
```

## ⚠️ **SEGURIDAD CRÍTICA**

### 🔴 **NUNCA COMPARTIR:**
- ❌ Claves privadas (`.key`, `*_private.asc`)
- ❌ Passphrases de PGP
- ❌ Contraseñas de correo
- ❌ Archivo `KEY_INFO.txt`

### 🟢 **COMPARTIR LIBREMENTE:**
- ✅ Claves públicas (`*_public.asc`)
- ✅ Certificado CA (`ca.crt`)
- ✅ Documentación y guías
- ✅ Configuraciones de servidor

## 🏆 **NIVEL DE SEGURIDAD ALCANZADO**

Tu laboratorio tiene **MÁXIMA SEGURIDAD**:
- 🛡️ **SSL/TLS**: Conexiones cifradas
- 🔐 **PGP RSA 4096**: Mensajes cifrados end-to-end  
- ✍️ **Firmas digitales**: Autenticidad garantizada
- 🏢 **CA propia**: Control total de certificados
- 🔒 **Múltiples capas**: Protección redundante

**¡COMUNICACIÓN IMPENETRABLE LOGRADA!** 🚀🔒
