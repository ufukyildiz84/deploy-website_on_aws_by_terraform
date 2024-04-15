#!/bin/bash
sudo yum update -y
sudo yum install -y httpd ##apache webserver
mkdir store-dir
cd store-dir
wget https://www.free-css.com/assets/files/free-css-templates/download/page260/e-store.zip
unzip e-store.zip
cd ecommerce-html-template
mv * /var/www/html/
cd /var/www/html/
sudo systemctl enable httpd
sudo systemctl start httpd