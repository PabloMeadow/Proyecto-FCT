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
  
  end

  # Servidor FTP #
  
  config.vm.define "ftp" do |ftp|
    ftp.vm.hostname = "ftp"
    ftp.vm.network "private_network", 
    type: "dhcp", 
    mac: "0800275EE143", 
    virtualbox__intnet: "ProyectoFCT"

  end
  # Servidor DataBase (MariaDB) #

  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", 
    type: "dhcp", 
    mac: "080027AABBCC", 
    virtualbox__intnet: "ProyectoFCT"

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

end