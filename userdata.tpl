#!/bin/bash

# Install updates
sudo yum update -y

# Install Apache server
sudo yum install -y httpd

# e-store site installation steps
sudo mkdir store-dir
sudo cd store-dir
sudo wget https://www.free-css.com/assets/files/free-css-templates/download/page260/e-store.zip
sudo e-store.zip
sudo cd ecommerce-html-template
sudo mv * /var/www/html/
sudo cd /var/www/html/
sudo systemctl enable httpd
sudo systemctl start httpd
