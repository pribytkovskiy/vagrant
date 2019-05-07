# -*- mode: ruby -*-
# vi: set ft=ruby :

$app_mach = 2
$db_mach = 1

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  (1..$db_mach).each do |i|
    config.vm.define "db#{i}" do |db|
      db.vm.network "private_network", ip: "84.0.0.#{30+i}"
      db.vm.hostname = "db#{i}"
      db.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = "512"
      end
      db.ssh.forward_agent = true
      db.vm.synced_folder "./", "/home/vagrant/project"
      db.vm.provision "shell" do |s|
        s.path = "./mysql/mysql.sh"
      end
    end
  end

  (1..$app_mach).each do |i|
    config.vm.define "app#{i}" do |app|
      app.vm.network  "private_network", ip: "84.0.0.#{40+i}"
      app.vm.hostname = "app#{i}"
      app.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = "512"
      end
      app.ssh.forward_agent = true
      app.vm.synced_folder "./", "/home/vagrant/project"
      app.vm.provision "shell" do |s|
        s.path = "./tomcat/tomcat.sh"
      end
    end
  end

  config.vm.define "ci" do |ci|
    ci.vm.network "forwarded_port", guest: 8080, host: 8080
    ci.vm.network "private_network", ip: "84.0.0.20"
    ci.vm.hostname = "ci"
    ci.vm.provider "virtualbox" do |vb|
      vb.cpus = 1
      vb.memory = "512"
    end
    ci.ssh.forward_agent = true
    ci.vm.synced_folder "./", "/home/vagrant/project"
    ci.vm.provision "shell" do |s|
      s.path = "./jenkins/jenkins.sh"
    end
  end

  config.vm.define "gate" do |gate|
    gate.vm.network "forwarded_port", guest: 80, host: 80
    gate.vm.network "private_network", ip: "84.0.0.10"
    gate.vm.hostname = "gate"
    gate.vm.provider "virtualbox" do |vb|
      vb.cpus = 1
      vb.memory = "512"
    end
    gate.ssh.forward_agent = true
    gate.vm.synced_folder "./", "/home/vagrant/project"
    gate.vm.provision "shell" do |s|
      s.path = "./nginx/nginx.sh"
    end
  end
end
