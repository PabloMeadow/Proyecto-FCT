#!/bin/bash

# Actualizar paquetes
apt update && apt upgrade -y

# Instalar Apache, PHP y utilidades necesarias

apt install -y apache2 curl php php-mysql php-xml php-mbstring php-intl php-curl php-zip php-gd php-cli php-soap libapache2-mod-php openssl unzip wget

# Crear directorio SSL y copiar Certificados previamente generados #

mkdir -p /etc/apache2/ssl

cp /vagrant/files/web/prestashop.crt /etc/apache2/ssl/prestashop.crt
cp /vagrant/files/web/prestashop.key /etc/apache2/ssl/prestashop.key

# Descargar y descomprimir PrestaShop #

wget https://assets.prestashop3.com/dst/edition/corporate/8.2.0/prestashop_edition_classic_version_8.2.0.zip -O /tmp/prestashop.zip
unzip /tmp/prestashop.zip -d prestashop

# Mover y Cambiar permisos de la carpeta de PrestaShop #

cp -R prestashop/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Copiar archivo de VirtualHost #

cp /vagrant/files/web/prestashop.conf /etc/apache2/sites-available/prestashop.conf

# Activar el VirtualHost, modulos y reiniciar Apache #

a2enmod ssl
a2enmod rewrite
a2dissite 000-default.conf
rm -rf /var/www/html/index.html
a2ensite prestashop.conf

systemctl restart apache2
