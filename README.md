# 📦 DHCP Auto-Config Script

![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)
![DHCP-Server](https://img.shields.io/badge/Service-DHCP-orange.svg)

Este repositorio contiene un script en **Bash** que configura automáticamente un servidor **DHCP** en sistemas Linux basados en Debian/Ubuntu.  
El objetivo es simplificar todo el proceso de configuración del servicio, evitando la edición manual de archivos y obteniendo la información de red directamente desde el sistema.

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

Este script realiza toda la configuración necesaria para desplegar un servidor DHCP completamente funcional:

### ✔️ Obtiene automáticamente información de red:
- Interfaz por defecto (`interface`)
- Dirección CIDR (ip/máscara)
- Subnet (ej: `10.0.2.0`)
- Netmask (ej: `255.255.255.0`)
- Gateway real (ej: `10.0.2.2`)
- Broadcast real (ej: `10.0.2.255`)

### ✔️ Pide al usuario:
- Rango de direcciones DHCP (inicio y fin)

### ✔️ Genera automáticamente:
- `/etc/dhcp/dhcpd.conf`
- `/etc/default/isc-dhcp-server`

### ✔️ Verifica la configuración:
- Usa `dhcpd -t -cf` para validar el archivo antes de iniciar el servicio

### ✔️ Gestiona el servicio DHCP:
- Reinicia el servicio  
- Lo habilita en el arranque  
- Muestra su estado actual  

### ✔️ Ajusta el firewall UFW:
- Abre el puerto **UDP 67** automáticamente

---

## 📁 Archivos incluidos en el repositorio

| Archivo | Descripción |
|--------|-------------|
| `dhcp_auto.sh` | Script principal que configura el servidor DHCP automáticamente |
| `apt-requirements.txt` | Archivo con todos los paquetes necesarios para que el script funcione |
| `README.md` | Documentación del proyecto (este archivo) |

> 🔵 **Nota:** El archivo `apt-requirements.txt` viene incluido en el repositorio.  
> No necesitas crearlo manualmente.

---

## 🛠️ Requisitos

El script requiere los siguientes paquetes del sistema:

- `isc-dhcp-server` → Servidor DHCP  
- `ipcalc` → Para calcular subnet y netmask  
- `ufw` → Para abrir automáticamente el puerto 67  

Todos están listados dentro del archivo `apt-requirements.txt`.

---

## 🧩 Cómo instalar los requisitos

Ejecuta este comando en la carpeta del proyecto:

```bash
sudo xargs -a apt-requirements.txt apt-get install -y
Esto instalará automáticamente todos los paquetes necesarios.

📜 Cómo ejecutar el script
1️⃣ Clona el repositorio:

bash
Copiar código
git clone https://github.com/tuusuario/dhcp_auto.git
cd dhcp_auto
2️⃣ Dale permisos de ejecución:

bash
Copiar código
chmod +x dhcp_auto.sh
3️⃣ Ejecútalo como root:

bash
Copiar código
sudo ./dhcp_auto.sh
4️⃣ Introduce el rango DHCP cuando te lo pida:

Ejemplo:

Inicio: 10.0.2.20

Fin: 10.0.2.50

📁 Archivos generados automáticamente
📌 /etc/dhcp/dhcpd.conf
Incluye:

subnet

netmask

rango DHCP

gateway

broadcast

DNS

tiempos de lease

📌 /etc/default/isc-dhcp-server
Incluye:

la interfaz que usará el servidor DHCP

🧠 Cómo funciona internamente
El script utiliza comandos del sistema para obtener información real de red:

ip route → interfaz por defecto y gateway

ip addr → CIDR y broadcast

ipcalc → subnet y netmask

awk, cut, grep → parseo de datos

systemctl → gestión del servicio DHCP

ufw → apertura automática del puerto del servicio

Toda esta información se escribe automáticamente en la configuración del DHCP.

🎯 Objetivo del proyecto
Este proyecto fue creado con las siguientes metas:

Automatizar la configuración completa de un servidor DHCP

Evitar errores al editar archivos manualmente

Mejorar conocimientos de scripting y redes

Crear una herramienta rápida, útil y fácil de usar

📝 Licencia
Proyecto con licencia MIT — libre para modificar, copiar y compartir.
