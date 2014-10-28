# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # ubuntu 14.04 LTS
  #config.vm.box = "ubuntu/trusty64"
  # ubuntu 12.04 LTS
  config.vm.box = "ubuntu/precise64"

  config.vm.network "private_network", ip: "10.10.10.10"

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/var/www", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--name", "ideato-vagrant-box"]
  end

  config.vm.provision :shell, :path => "scripts/install-ansible.sh"
  config.vm.provision :shell, :path => "scripts/run-ansible.sh"

end