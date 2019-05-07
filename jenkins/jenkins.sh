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

#chmod 777 /home/vagrant/.ssh/app1
#chmod 777 /home/vagrant/.ssh/app2

#cd /home/vagrant/.ssh/
#ssh-keygen -t rsa -N '' -f ci.rsa
#cp /home/vagrant/.ssh/ci.rsa.pub /home/vagrant/project/ci.rsa.pub

#sudo apt install -y sshpass
#cat ~/.ssh/ci.rsa.pub | sshpass -p 'admin' ssh ssh@84.0.0.41 "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"
#ssh -i ci.rsa ssh@84.0.0.41

#cp /home/vagrant/project/app1.rsa /home/vagrant/.ssh/app1.rsa
#rm /home/vagrant/project/app1.rsa
#chmod 600 app1.rsa
#echo "Host app1" >> config
#echo "Hostname app1" >> config
#echo "IdentityFile ~/.ssh/app1.rsa" >> config
#ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" vagrant@84.0.0.41 echo 'Hi'

#cp /home/vagrant/project/app2.rsa /home/vagrant/.ssh/app2.rsa
#rm /home/vagrant/project/app2.rsa
#chmod 600 app2.rsa
#echo "Host app2" >> config
#echo "Hostname app2" >> config
#echo "IdentityFile2 ~/.ssh/app2.rsa" >> config
#ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" vagrant@84.0.0.42 echo 'Hi'
