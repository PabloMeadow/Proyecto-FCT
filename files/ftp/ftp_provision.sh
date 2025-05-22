#!/bin/bash

# Actualizar paquetes #

apt update && apt upgrade -y

# Instalar vsftpd y dependencias #

apt install -y vsftpd ufw nfs-common

# Configurar el firewall #

ufw allow 20
ufw allow 21
ufw allow 22
ufw allow 50000:50100/tcp
ufw --force enable

# Importar la configuración de vsftpd #

cp /vagrant/files/ftp/vsftpd.conf /etc/vsftpd.conf

# Crear Usuario FTP #

useradd -m ftpuser
echo "ftpuser:ftp1234" | chpasswd
chown -R ftpuser:ftpuser /home/ftpuser
chmod 755 /home/ftpuser

# Reiniciar el servicio de vsftpd #

systemctl restart vsftpd