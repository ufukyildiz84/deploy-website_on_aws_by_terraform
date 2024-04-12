#!/bin/bash

# Install updates
sudo yum update -y

# Install Apache server
sudo yum install -y httpd

# e-store site installation steps
sudo mkdir /var/www/html/store-dir
sudo wget -P /var/www/html/store-dir https://www.free-css.com/assets/files/free-css-templates/download/page260/e-store.zip
sudo unzip /var/www/html/store-dir/e-store.zip -d /var/www/html/store-dir/
sudo mv /var/www/html/store-dir/ecommerce-html-template/* /var/www/html/
sudo systemctl restart httpd

# Install MariaDB, PHP and necessary tools
sudo yum install -y mariadb-server

# Start Apache server and enable it on system startup
sudo systemctl start httpd
sudo systemctl enable httpd

# Start MariaDB service and enable it on system startup
sudo systemctl start mariadb
sudo systemctl enable mariadb

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

