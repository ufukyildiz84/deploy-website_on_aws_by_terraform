#! /bin/bash
# Install updates
sudo yum update -y
# Install Apache server
sudo yum install -y httpd
# Install MariaDB, PHP and necessary tools
sudo yum install -y mariadb105-server php php-mysqlnd unzip

# Set database variables
DBName='estore_db'
DBUser='estore_user'
DBPassword='estore_password'
DBRootPassword='rootpassword'

# Start Apache server and enable it on system startup
sudo systemctl start httpd
sudo systemctl enable httpd

# Start MariaDB service and enable it on system startup
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Set MariaDB root password
mysqladmin -u root password $DBRootPassword

# Create database for e-store
echo "CREATE DATABASE $DBName;" >> /tmp/db.setup
echo "CREATE USER '$DBUser'@'localhost' IDENTIFIED BY '$DBPassword';" >> /tmp/db.setup
echo "GRANT ALL ON $DBName.* TO '$DBUser'@'localhost';" >> /tmp/db.setup
echo "FLUSH PRIVILEGES;" >> /tmp/db.setup
mysql -u root --password=$DBRootPassword < /tmp/db.setup
sudo rm /tmp/db.setup

# Configure permissions for Apache
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
