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

# Install MariaDB, PHP and necessary tools
sudo yum install -y mariadb-server

# Start MariaDB service and enable it on system startup
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Set database variables
DBName='e_store_db'
DBUser='e_store_user'
DBPassword='e_store_password'
DBRootPassword='rootpassword'

# Set MariaDB root password
sudo mysqladmin -u root password $DBRootPassword

# Create database for e-store data and grant privileges
echo "CREATE DATABASE $DBName;" | sudo mysql -u root --password=$DBRootPassword
echo "CREATE USER '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';" | sudo mysql -u root --password=$DBRootPassword
echo "GRANT ALL PRIVILEGES ON $DBName.* TO '$DBUser'@'localhost';" | sudo mysql -u root --password=$DBRootPassword
echo "FLUSH PRIVILEGES;" | sudo mysql -u root --password=$DBRootPassword

