#!/bin/bash
service nginx start
service php7.3-fpm start
service mysql start
#creating db, making accounts, comparing username
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root
service nginx restart

bash
