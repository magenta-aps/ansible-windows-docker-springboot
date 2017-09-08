# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "windows-server-2016"

  vagrant_root = File.dirname(__FILE__)
  ENV['ANSIBLE_ROLES_PATH'] = "#{vagrant_root}/ansible/roles"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbooks/default.yml"
    ansible.verbose = "vv"
    ansible.raw_arguments = ["-i", "ansible/hostsfile"]
  end
end
