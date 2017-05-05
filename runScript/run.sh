#!/bin/bash;
#
# author:Eagle.Young
# Histroy:V1_01/05/17

docker run -it --name mysql -e MYSQL_USER_NAME=bacadmin -e MYSQL_USER_PWD=123456 -e MYSQL_DB_NAME=bacadmin_changepw -v /home/bac/docker/changepw-back/mysql/bacadmin_changepw:/var/lib/mysql/bacadmin_changepw -d debian-mysql

docker run -it -d --name nginx --link php -p 9090:80 -p 25:25 -v /home/bac/docker/file/Nginx/default-nginx-oci8:/etc/nginx/sites-available/default --volumes-from php debian-nginx

docker run -it -d --name php --link mysql -v /home/bac/docker/appFiles/changePW/webSite:/app -v /home/bac/docker/file/PHP-Oci8/www.conf:/etc/php/7.0/fpm/pool.d/www.conf debian-php7-oci8
