#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar nfs-server y dependencias #

apt install -y nfs-kernel-server nfs-common

# Crear el directorio de exportación #

mkdir -p /srv/backups
chown nobody:nogroup /srv/backups

# Copiar configuración de NFS y reiniciar servicio #

cp /vagrant/files/backup/exports /etc/exports
exportfs -ra
systemctl restart nfs-server