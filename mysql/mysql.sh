#!/bin/bash

sudo echo "mysql-server-5.6 mysql-server/root_password password root" | sudo debconf-set-selections
sudo echo "mysql-server-5.6 mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt install -y mysql-server-5.6

sudo mysql_secure_installation

sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
sudo mysql -uroot -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

mysql -uroot -proot -e "CREATE DATABASE bike_championship"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON bike_championship.* TO bike_championship@localhost IDENTIFIED BY 'root'"
sudo service mysql restart

sudo ufw enable
sudo ufw allow 22
sudo ufw allow 3306
