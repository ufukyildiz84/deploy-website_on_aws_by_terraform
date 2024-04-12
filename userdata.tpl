#!/bin/bash

# Install updates
sudo yum update -y

# Install Apache server
sudo yum install -y httpd

# e-store site installation steps
sudo mkdir store-dir
cd store-dir
sudo wget https://www.free-css.com/assets/files/free-css-templates/download/page260/e-store.zip
sudo e-store.zip
cd ecommerce-html-template
mv * /var/www/html/
cd /var/www/html/
systemctl enable httpd
systemctl start httpd
