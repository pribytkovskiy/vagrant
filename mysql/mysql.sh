#!/bin/bash

sudo echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
sudo echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt install -y mysql-server-5.7

mysql -uroot -proot -e "CREATE DATABASE bike_championship;"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON bike_championship.* TO bike_championship@localhost IDENTIFIED BY 'root';"
sudo service mysql restart

sudo ufw enable
sudo ufw allow 22
sudo ufw allow 3306
