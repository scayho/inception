#!/bin/bash

service mariadb start 

sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "CREATE DATABASE IF NOT EXISTS "$DATABASE";" | mysql -u root
echo "CREATE USER '"$USER_NAME"'@'%' IDENTIFIED BY '"$USER_PASS"';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON "$DATABASE".* TO '"$USER_NAME"'@'%' " | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service mariadb stop

mysqld 


