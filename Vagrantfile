# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 3000, host: 3001

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision.yml"
    ansible.sudo = true
  end
end
