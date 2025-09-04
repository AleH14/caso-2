# Configuración de Clientes de Correo con PGP

Este documento describe paso a paso cómo configurar dos clientes de correo electrónico, **EM Client** y **Thunderbird**, para el uso de cifrado PGP en un servidor local.

---

## Cliente 1: EM Client

### 1. Iniciar sesión
- Abrir **EM Client**.
- Iniciar sesión con la cuenta: `alice@server.local`.

### 2. Importar claves
- **Clave privada de Alice**:  
  1. Ir a `Configuración` → `Firma y Cifrado` → `Certificados y Claves` → `Administrar certificados` → `Mis certificados`.
  2. Seleccionar `Importar`.
  3. Navegar hasta la ubicación del archivo de clave privada de Alice y cargarla.
- **Clave pública de Bob**:  
  1. Ir a `Certificados y claves de otros`.
  2. Seleccionar `Importar`.
  3. Navegar hasta la ubicación del archivo de clave pública de Bob y cargarla.

### 3. Configuración del servidor de entrada (IMAP)
- **Host:** `localhost`
- **Puerto:** `143`
- **Seguridad:** `Forzar uso de SSL/TLS`

### 4. Configuración del servidor de salida (SMTP)
- **Host:** `localhost`
- **Puerto:** `587`
- **Seguridad:** `Usar SSL/TLS disponible`

---

## Cliente 2: Thunderbird

### 1. Iniciar sesión
- Abrir **Thunderbird**.
- Iniciar sesión con la cuenta: `bob@local.server`.

### 2. Configuración del servidor de entrada (IMAP)
- **Host:** `localhost`
- **Puerto:** `143`
- **Seguridad:** `STARTTLS`
- **Método de identificación:** `Contraseña normal`

### 3. Configuración del servidor de salida (SMTP)
- **Host:** `localhost`
- **Puerto:** `587`
- **Seguridad:** `STARTTLS`
- **Método de identificación:** `Contraseña normal`

### 4. Configuración de cifrado PGP
1. Ir a `Configuración` → `Administración de cuenta` → `Cifrado extremo a extremo` → `Añadir clave`.
2. Importar **clave privada de Bob**.
3. Seleccionar la clave importada como **activa**.

### 5. Importar claves públicas
- Ir a `Administrar claves PGP`.
- Importar la **clave pública de Alice** para poder enviarle correos cifrados.

---

## Notas adicionales
- Asegúrese de que los puertos y la seguridad del servidor de correo coincidan exactamente con la configuración de los clientes.
- La correcta importación de las claves es fundamental para que el cifrado PGP funcione sin errores.
- Se recomienda probar enviando un correo de prueba entre Alice y Bob para verificar la configuración del cifrado.

---

## Referencias
- [Documentación oficial de EM Client](https://www.emclient.com/)
- [Documentación oficial de Thunderbird](https://www.thunderbird.net/)
- [Guía de uso de PGP](https://www.openpgp.org/)
