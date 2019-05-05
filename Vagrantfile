# -*- mode: ruby -*-
# vi: set ft=ruby :

$app_mach = 2
$db_mach = 1

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.define "base" do |base|
    #base.vm.network "forwarded_port", guest: 8000, host: 8000, id: 'ci'
    base.vm.network "forwarded_port", guest: 8080, host: 8080, id: 'gate'
    config.vm.network :public_network, ip: '192.168.1.10', :netmask => '255.255.248.0', :bridge => 'enp7s0'
    base.vm.hostname = "base"
    base.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
      vb.memory = "3072"
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    end
    base.ssh.forward_agent = true
    base.vm.synced_folder "./", "/home/vagrant/project"
    base.vm.provision "shell" do |s|
      s.path = "vagrant.sh"
    end
  end

  (1..$app_mach).each do |i|
    config.vm.define "app#{i}" do |app|
      app.vm.network  "private_network", ip: "192.168.2.#{10+i}", :netmask => '255.255.248.0', :bridge => 'enp7s0'
      app.vm.hostname = "app#{i}"
      app.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = "512"
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      end
      app.ssh.forward_agent = true
      app.vm.synced_folder "./", "/home/vagrant/project"
    end
  end

  (1..$db_mach).each do |i|
    config.vm.define "db#{i}" do |db|
      db.vm.network "private_network", ip: "192.168.2.#{50+i}", :netmask => '255.255.248.0', :bridge => 'enp7s0'
      db.vm.hostname = "db#{i}"
      db.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = "512"
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      end
      db.ssh.forward_agent = true
      db.vm.synced_folder "./", "/home/vagrant/project"
    end
  end

  config.vm.define "ci" do |ci|
    ci.vm.network "forwarded_port", guest: 8000, host: 8000
    ci.vm.network "private_network", ip: "192.168.2.60", :netmask => '255.255.248.0', :bridge => 'enp7s0'
    ci.vm.hostname = "ci"
    ci.vm.provider "virtualbox" do |vb|
      vb.cpus = 1
      vb.memory = "512"
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    end
    ci.ssh.forward_agent = true
    ci.vm.synced_folder "./", "/home/vagrant/project"
    ci.vm.provision "shell" do |s|
      s.path = "jenkins.sh"
    end
  end

  config.vm.define "gate" do |gate|
    gate.vm.network "forwarded_port", guest: 8080, host: 8080
    gate.vm.network "private_network", ip: "192.168.2.2", :netmask => '255.255.248.0', :bridge => 'enp7s0'
    gate.vm.hostname = "gate"
    gate.vm.provider "virtualbox" do |vb|
      vb.cpus = 1
      vb.memory = "512"
    end
    gate.vm.provision "shell" do |s|
      s.path = "nginx.sh"
    end
  end
end

#config.vm.network  "forwarded_port", guest: 80, host: 9999, auto_correct: true
#config.vm.network "private_network", ip: "192.168.1.100"
#config.vm.synced_folder "src/", "/var/www/html"
