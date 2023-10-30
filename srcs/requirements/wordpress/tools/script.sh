#!/bin/bash

apt install -y wget unzip
apt install -y curl
apt install -y php-fpm php-mysql
service php7.4-fpm start 
sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -e "/var/www/html/wordpress/wp-config.php" ]; then
wget https://wordpress.org/latest.zip
unzip latest.zip -d /var/www/html/
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php

sed -i 's/define( '\''DB_NAME'\''.*/define( '\''DB_NAME'\'', '\'$DATABASE\'' );/' /var/www/html/wordpress/wp-config.php
sed -i 's/define( '\''DB_USER'\''.*/define( '\''DB_USER'\'', '\'$USER_NAME\'' );/' /var/www/html/wordpress/wp-config.php
sed -i 's/define( '\''DB_PASSWORD'\''.*/define( '\''DB_PASSWORD'\'', '\'$USER_PASS\'' );/' /var/www/html/wordpress/wp-config.php
sed -i 's/define( '\''DB_HOST'\''.*/define( '\''DB_HOST'\'', '\''mariadb'\'' );/' /var/www/html/wordpress/wp-config.php

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core install --url="$URL" --allow-root --title="$TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_MAIL"
wp user create $USER $USER_MAIL --user_pass=$USER_PASS  --allow-root
fi

kill $(cat /var/run/php/php7.4-fpm.pid)

/usr/sbin/php-fpm7.4 -F