#!/bin/bash

sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install -y openjdk-8-jre
sudo apt install -y openjdk-8-jdk
sudo apt -y install maven
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export M2_HOME=/usr/share/maven
export MAVEN_HOME=/usr/share/maven
export PATH=${M2_HOME}/bin:${PATH}

cd /tmp && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | sudo tee -a /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install -y jenkins
sudo systemctl stop jenkins.service

sudo cp /home/vagrant/project/jenkins/config.xml /var/lib/jenkins/
sudo mkdir -p /var/lib/jenkins/users/admin
sudo cp /home/vagrant/project/jenkins/users/admin/config.xml /var/lib/jenkins/users/admin/
sudo chown -R jenkins:jenkins /var/lib/jenkins/users/

sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service

sudo ufw enable
sudo ufw allow 22
sudo ufw allow 8080

cp /home/vagrant/project/.vagrant/machines/app1/virtualbox/private_key /home/vagrant/.ssh/app1
cp /home/vagrant/project/.vagrant/machines/app2/virtualbox/private_key /home/vagrant/.ssh/app2 #ssh -i ./.ssh/app#{i} vagrant@84.0.0.41
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/app1
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/app2
