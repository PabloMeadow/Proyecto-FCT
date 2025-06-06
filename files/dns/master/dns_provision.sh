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

cp /vagrant/files/dns/master/named.conf.options /etc/bind/named.conf.options
cp /vagrant/files/dns/master/named.conf.local /etc/bind/named.conf.local
cp /vagrant/files/dns/master/named.conf /etc/bind/named.conf
cp /vagrant/files/dns/master/db.proyectofct.local /etc/bind/db.proyectofct.local
cp /vagrant/files/dns/master/db.192.168.1 /etc/bind/db.192.168.1

systemctl restart bind9

