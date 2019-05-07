#!/bin/bash

#sudo apt install -y tomcat8
sudo apt install -y openjdk-8-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8.0.33.tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chgrp -R tomcat conf
sudo chmod g+rwx conf
sudo chmod g+r conf/*
sudo chown -R tomcat webapps/ work/ temp/ logs/

sudo apt -y install maven
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export M2_HOME=/usr/share/maven
export MAVEN_HOME=/usr/share/maven
export PATH=${M2_HOME}/bin:${PATH}

sudo cp /home/vagrant/project/tomcat/tomcat.service /etc/systemd/system/tomcat.service
sudo cp /home/vagrant/project/tomcat/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl status tomcat

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install -y nodejs
sudo apt install -y npm

sudo ufw enable
sudo ufw allow 22
sudo ufw allow 8080
sudo ufw allow 3000

#sudo chown -R tomcat /opt/tomcat/
#sudo -s -u tomcat 
#sh /opt/tomcat/bikeChampionship/backend/mvnw install
#sh /opt/tomcat/bikeChampionship/backend/mvnw spring-boot:run -f ./server/ 
#./mvnw spring-boot:run

#sudo useradd -p '$1$9DX7Rwnk$9ei1vao6efFMYsDj3uQja0' -s /bin/false -g ssh -d /home/ssh ssh
#sudo mkdir /home/ssh
#sudo usermod --shell /bin/bash --home /home/ssh ssh
#sudo chown -R ssh:ssh /home/ssh
#sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
#sudo service sshd restart

#cd /home/vagrant/.ssh/
#cp /home/vagrant/project/ci.rsa.pub /home/vagrant/.ssh/ci.rsa.pub
#cat ./ci.rsa.pub >> ./authorized_keys

#cp /etc/skel/.* /home/ssh/
#ssh-keygen -t rsa -N '' -f $HOSTNAME.rsa
#cat $HOSTNAME.rsa.pub >> authorized_keys
#chmod 600 authorized_keys
#rm $HOSTNAME.rsa.pub
#cp ./$HOSTNAME.rsa /home/vagrant/project/$HOSTNAME.rsa
