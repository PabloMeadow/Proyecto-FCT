#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar Bind9 y dependencias #

apt install -y bind9 bind9utils bind9-doc dnsutils ufw rsync

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

