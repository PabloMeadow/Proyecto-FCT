#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar PostgreSQL y dependencias #

apt install -y postgresql ufw

# Configurar el firewall #

ufw allow 5432
ufw allow 22
ufw --force enable

# Importar la configuración de PostgreSQL #

cp /vagrant/files/postgresql/postgresql.conf /etc/postgresql/15/main/postgresql.conf
cp /vagrant/files/postgresql/pg_hba.conf /etc/postgresql/15/main/pg_hba.conf

# Crear Usuario PostgreSQL #

sudo -u postgres psql -c "CREATE ROLE odoo WITH LOGIN PASSWORD '@AdminOdoo';"
sudo -u postgres psql -c "CREATE DATABASE odoo OWNER odoo;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE odoo TO odoo;"

# Reiniciar el servicio de PostgreSQL #

systemctl restart postgresql
