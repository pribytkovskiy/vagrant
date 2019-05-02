# -*- mode: ruby -*-
# vi: set ft=ruby :

$app_mach = 2
$db_mach = 1

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  (1..$app_mach).each do |i|
    config.vm.define "app#i" do |app|
      app.vm.network  "private_network", ip: "192.168.1.#{10+i}"
      app.vm.hostname = "app#i"
      app.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      end
      app.ssh.forward_agent = true
      app.vm.synced_folder "./", "/vagrant", :nfs => true
    end
  end

  (1..$db_mach).each do |i|
    config.vm.define "db#i" do |db|
      db.vm.network "private_network", ip: "192.168.1.#{50+i}"
      db.vm.hostname = "db#i"
      db.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      end
      db.ssh.forward_agent = true
      db.vm.synced_folder "./", "/vagrant", :nfs => true
    end
  end

  config.vm.define "ci" do |ci|
    ci.vm.network "private_network", ip: "192.168.1.60"
    ci.vm.hostname = "ci"
    ci.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    end
    ci.ssh.forward_agent = true
    ci.vm.synced_folder "./", "/vagrant", :nfs => true
    ci.vm.provision "shell" do |s|
      s.path = "jenkins.sh"
    end
  end

  config.vm.define "gate" do |gate|
    gate.vm.network "forwarded_port", guest: 80, host: 8080
    gate.vm.network "private_network", ip: "192.168.1.2"
    gate.vm.hostname = "gate"
    gate.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    end
    gate.vm.provision "shell" do |s|
      s.path = "nginx.sh"
    end
  end
end

#config.vm.network  "forwarded_port", guest: 80, host: 9999, auto_correct: true
#config.vm.network "private_network", ip: "192.168.1.100"
#config.vm.synced_folder "src/", "/var/www/html"
