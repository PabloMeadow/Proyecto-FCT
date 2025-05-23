#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar Bind9 y dependencias #

apt install -y bind9 bind9utils bind9-doc dnsutils ufw nfs-common

# Configurar el firewall #

ufw allow 53
ufw allow 53/udp
ufw allow 22
ufw --force enable

# Importar la configuración de Bind9 #

cp /vagrant/files/dns/slave/named.conf.options /etc/bind/named.conf.options
cp /vagrant/files/dns/slave/named.conf.local /etc/bind/named.conf.local
cp /vagrant/files/dns/slave/named.conf /etc/bind/named.conf

mkdir -p /var/cache/bind
chown -R bind:bind /var/cache/bind

systemctl restart bind9

# Montar el directorio NFS #

mkdir -p /mnt/backup

grep -q "192.168.1.9:/srv/backups" /etc/fstab || cat <<EOF >> /etc/fstab
192.168.1.9:/srv/backups  /mnt/backup  nfs  defaults  0  0
EOF

mount -a

# Añadir la entrada crontab para la sincronización #

crontab /vagrant/files/dns/slave/cronjobs.txt 
