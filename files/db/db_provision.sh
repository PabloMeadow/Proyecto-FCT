#!/bin/bash

# Actualizar paquetes

apt update && apt upgrade -y

# Instalar MariaDB y dependencias

apt install -y mariadb-server ufw

## Configurar UFW para permitir tráfico SSH y de base de datos #

ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow from 192.168.1.0/24 to any port 3306 proto tcp
ufw --force enable

# Configurar para permitir conexiones externas #

sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Crear base de datos y usuario para PrestaShop #
mysql -u root <<EOF
CREATE DATABASE prestashop;
CREATE USER 'psuser'@'%' IDENTIFIED BY '@psAdmin';
GRANT ALL PRIVILEGES ON prestashop.* TO 'psuser'@'%';
FLUSH PRIVILEGES;
EOF

# Reiniciar Servidor MariaDB #

systemctl restart mariadb