# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/vivid64"

  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3000, host: 3001
  config.vm.network "forwarded_port", guest: 4000, host: 4001
  config.vm.network "forwarded_port", guest: 11211, host: 11212

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 1024
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/provision.yml"
    ansible.sudo = true
    ansible.extra_vars = {
      nginx_https_ip_address: "0.0.0.0",
      nginx_server_names: "localhost"
    }
  end
end
