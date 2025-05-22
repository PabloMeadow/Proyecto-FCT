Vagrant.configure("2") do |config|
  
  config.vm.box = "Debian/bookworm64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1

  end
  
  # Servidor DNS (Master) #

  config.vm.define "dns" do |dns|
    dns.vm.hostname = "dns"
    dns.vm.network "private_network", 
      type: "dhcp",
      mac: "080027EF0DA6", 
      virtualbox__intnet: "ProyectoFCT"

    dns.vm.provision "shell", path: "files/dns/master/dns_provision.sh"
  
  end

    # Servidor DNS (Slave) #

  config.vm.define "slave" do |slave|
    slave.vm.hostname = "slave"
    slave.vm.network "private_network", 
      type: "dhcp",
      mac: "080027C9678D", 
      virtualbox__intnet: "ProyectoFCT"

    slave.vm.provision "shell", path: "files/dns/slave/slave_provision.sh"
  
  end

  # Servidor FTP #
  
  config.vm.define "ftp" do |ftp|
    ftp.vm.hostname = "ftp"
    ftp.vm.network "private_network", 
      type: "dhcp", 
      mac: "0800275EE143", 
      virtualbox__intnet: "ProyectoFCT"

    ftp.vm.provision "shell", path: "files/ftp/ftp_provision.sh"

  end
  
  # Servidor DataBase (MariaDB) #

  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", 
      type: "dhcp", 
      mac: "080027AABBCC", 
      virtualbox__intnet: "ProyectoFCT"

    db.vm.provision "shell", path: "files/db/db_provision.sh"

  end

  # Servidor Web (Apache2 + PrestaShop) #

  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.network "private_network", 
      type: "dhcp", 
      mac: "080027CCDDEE", 
      virtualbox__intnet: "ProyectoFCT"

    web.vm.provision "shell", path: "files/web/web_provision.sh"
    
  end

  # Servidor Database (PostgreSQL) #

  config.vm.define "postgresql" do |postgresql|
    postgresql.vm.hostname = "postgresql"
    postgresql.vm.network "private_network", 
      type: "dhcp", 
      mac: "0800278DC04D",
      virtualbox__intnet: "ProyectoFCT"

    postgresql.vm.provision "shell", path: "files/postgresql/postgresql_provision.sh"
    
  end

  # Servidor ERP (Odoo) #

  config.vm.define "odoo" do |odoo|
    odoo.vm.hostname = "odoo"
    odoo.vm.network "private_network", 
      type: "dhcp", 
      mac: "080027B451AC",
      virtualbox__intnet: "ProyectoFCT"

    odoo.vm.provision "shell", path: "files/odoo/odoo_provision.sh"

  end

    # Servidor Copias de Seguridad (rsync) #

  config.vm.define "backup" do |backup|
    backup.vm.hostname = "backup"
    backup.vm.network "private_network", 
      type: "dhcp", 
      mac: "080027333752",
      virtualbox__intnet: "ProyectoFCT"



  end
end