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
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service

sudo ufw allow 8080

cd ./.ssh/
sudo cp /home/vagrant/project/tomcat/app1.rsa.pub /home/vagrant/.ssh/app1.rsa.pub

