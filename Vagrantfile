# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.network "forwarded_port", guest: 80, host: 5555
  config.vm.network "private_network", ip: "172.30.1.5"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "2048"
  end

  config.vm.box = "ubuntu/focal64"
  config.vm.provision "shell", path: "provision/provision_script.sh"
  config.vm.provision "shell", path: "provision/bootstrap_script.sh", run: "always"
end