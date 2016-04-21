# DockerFileLNPM
Docker stack:Nginx+PHP+MySQL+Haproxy

[NOTE]

1.If you want change server name , you will change server name in Dockerfile.

2.All Docker image on the Debian,and All service package from debian package

#Docker Build

docker build -t='haproxy'  Haproxy/.

docker build -t='mysql'  MySQL/.

docker build -t='nginx' Nginx/.

docker build -t='php' PHP/.

#Docker Run images

MySQL
docker run -it -d --name mysql mysql

PHP
docker run -it -d --name php --link mysql -v /DockerCode/html:/app -v /DockerCode/PHP/www.conf:/etc/php5/fpm/pool.d/www.conf php

Nginx
docker run -it -d --name nginx --link php -p 9090:80 -v /DockerCode/Nginx/default:/etc/nginx/sites-available/default --volumes-from php nginx

Haproxy
docker run -it -d --name haproxy --link nginx
