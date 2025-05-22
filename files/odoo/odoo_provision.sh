#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar dependencias necesarias #

apt install -y \
    git python3-pip python3-venv python3-dev \
    libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libpq-dev \
    libjpeg-dev libpng-dev liblcms2-dev libblas-dev libatlas-base-dev \
    libssl-dev libffi-dev libtiff5-dev libopenjp2-7-dev build-essential \
    curl nodejs npm apache2

# Crear usuario y entorno virtual #

adduser --system --quiet --shell=/bin/bash --home=/opt/odoo --group odoo
sudo -u odoo python3 -m venv /opt/odoo/venv
source /opt/odoo/venv/bin/activate

# Clonar Odoo #

sudo -u odoo git clone --depth 1 --branch 16.0 https://github.com/odoo/odoo /opt/odoo/odoo
pip install -r /opt/odoo/odoo/requirements.txt

# Copiar configuración de Odoo #

cp /vagrant/files/odoo/odoo.conf /etc/odoo.conf
sudo chown odoo:odoo /etc/odoo.conf
sudo mkdir -p /var/log/odoo
sudo chown odoo:odoo /var/log/odoo

# Copiar servicio de Odoo #

sudo cp /vagrant/files/odoo/odoo.service /etc/systemd/system/odoo.service

sudo systemctl daemon-reload
sudo systemctl enable odoo
sudo systemctl restart odoo

# Activar modulos de Apache #

sudo a2enmod proxy proxy_http ssl headers rewrite

# Copiar configuración Apache #

sudo cp /vagrant/files/odoo/odoo_site.conf /etc/apache2/sites-available/odoo_site.conf

# Crear directorio SSL y copiar Certificados previamente generados #

mkdir -p /etc/apache2/ssl
cp /vagrant/files/odoo/odoo.crt /etc/apache2/ssl/odoo.crt
cp /vagrant/files/odoo/odoo.key /etc/apache2/ssl/odoo.key

# Habilitar el sitio

sudo a2ensite odoo_site.conf
sudo systemctl restart apache2

