#!/bin/bash
echo "Setupenv" > /home/ubuntu/setup.txt
sudo apt-get update -y
sudo apt-get install -y apache2


sudo systemctl enable apache2
sudo systemctl start apache2

git clone https://github.com/Suvarna7/Suvarna-Repo.git

sudo mv /var/www/html/index.html /var/www/html/index_old.html

sudo cp -R /Suvarna-Repo/* /var/www/html/
