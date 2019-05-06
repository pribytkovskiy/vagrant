#!/bin/bash

sudo add-apt-repository ppa:nginx/stable
sudo apt install -y software-properties-common
sudo apt update
sudo apt install -y nginx
sudo cp /home/vagrant/project/nginx/default /etc/nginx/sites-available/default
sudo service nginx restart

sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
