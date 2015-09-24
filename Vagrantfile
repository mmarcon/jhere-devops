# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Run: vagrant plugin install landrush
# for the DNS plugin

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # No need to sync the vagrant folder, everything gets deployed
  # with the ansible playbook
  config.vm.synced_folder '.', '/vagrant', :disabled => true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    vb.memory = "512"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.extra_vars = {
        ghost_config: "./ghost/config.vagrant.js"
    }
  end

  config.vm.hostname = "jhere.vagrant.dev"
  config.landrush.enabled = true
end
