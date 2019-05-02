#!/bin/bash

sudo add-apt-repository ppa:nginx/stable
sudo apt-get install -y software-properties-common
sudo apt-get update
sudo apt-get install -y nginx
