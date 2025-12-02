# 📦 DHCP Auto-Config Script

![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Status: Active](https://img.shields.io/badge/Status-Active-brightgreen.svg)
![Platform: Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)
![DHCP](https://img.shields.io/badge/Service-DHCP-orange.svg)

Este repositorio contiene un script en **Bash** que configura automáticamente un servidor **DHCP** en sistemas Linux basados en Debian/Ubuntu.  
El objetivo es simplificar el proceso evitando editar archivos manualmente y obteniendo la información de red automáticamente.

---

## 📚 Tabla de contenido

- 🚀 Funcionalidad del script  
- 📁 Archivos incluidos en el repositorio  
- 🛠️ Requisitos  
- 🧩 Cómo instalar los requisitos  
- 📜 Cómo ejecutar el script  
- 📁 Archivos generados automáticamente  
- 🧠 Cómo funciona internamente  
- 🎯 Objetivo del proyecto  
- 📝 Licencia  

---

## 🚀 Funcionalidad del script

### ✔ Obtiene automáticamente:
- Interfaz por defecto  
- CIDR  
- Subnet  
- Netmask  
- Gateway  
- Broadcast  

### ✔ Pide al usuario:
- Rango DHCP (inicio y fin)

### ✔ Genera automáticamente:
- `/etc/dhcp/dhcpd.conf`
- `/etc/default/isc-dhcp-server`

### ✔ Verifica la configuración:
- `dhcpd -t -cf /etc/dhcp/dhcpd.conf`

### ✔ Gestiona el servicio:
- Reinicio  
- Habilitar  
- Estado  

### ✔ Ajusta firewall UFW:
- Permite puerto UDP 67

---

## 📁 Archivos incluidos en el repositorio

| Archivo | Descripción |
|--------|-------------|
| `dhcp_auto.sh` | Script principal |
| `apt-requirements.txt` | Lista de paquetes necesarios |
| `README.md` | Este archivo |

---

## 🛠️ Requisitos

Paquetes necesarios:

- `isc-dhcp-server`
- `ipcalc`
- `ufw`

Todos vienen en `apt-requirements.txt`.

---

## 🧩 Cómo instalar los requisitos

Ejecuta:

```bash
sudo xargs -a apt-requirements.txt apt-get install -y
```

---

## 📜 Cómo ejecutar el script

### 1️⃣ Clonar el repositorio:

```bash
git clone https://github.com/tuusuario/dhcp_auto.git
cd dhcp_auto
```

### 2️⃣ Dar permisos:

```bash
chmod +x dhcp_auto.sh
```

### 3️⃣ Ejecutar como root:

```bash
sudo ./dhcp_auto.sh
```

### 4️⃣ Introducir el rango DHCP cuando lo pida:

Ejemplo:

- Inicio: `10.0.2.20`  
- Fin: `10.0.2.50`

---

## 📁 Archivos generados automáticamente

### 📌 `/etc/dhcp/dhcpd.conf`

Incluye:
- subnet  
- netmask  
- rango DHCP  
- gateway  
- broadcast  
- DNS  
- tiempos de lease  

### 📌 `/etc/default/isc-dhcp-server`

Incluye:
- interfaz configurada

---

## 🧠 Cómo funciona internamente

Usa los siguientes comandos:

- `ip route` → interfaz por defecto y gateway  
- `ip addr` → CIDR y broadcast  
- `ipcalc` → subnet y netmask  
- `awk`, `cut`, `grep` → parseo  
- `systemctl` → servicio DHCP  
- `ufw` → reglas del firewall  

Todo se genera automáticamente.

---

## 🎯 Objetivo del proyecto

- Automatizar configuración DHCP  
- Evitar errores manuales  
- Mejorar conocimientos de redes y Bash  
- Crear herramienta útil y rápida  

---

## 📝 Licencia

Licencia **MIT**. Libre para compartir y modificar.

