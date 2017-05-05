# Eagle's Docker stack
#
# MySQL Dockerfile
#

# Base image
FROM debian:testing

MAINTAINER <Eagle_M_Young>

# Edit apt source'list
echo -e "deb http://ftp.us.debian.org/debian testing main contrib non-free \ndeb http://ftp.us.debian.org/debian testing-updates main contrib non-free \ndeb http://security.debian.org/ testing/updates main contrib non-free" > /etc/apt/sources.list

# Update apt
RUN apt-get update

# Define root's password
RUN echo 'mysql-server mysql-server/root_password password 12345678' | debconf-set-selections \
    && echo 'mysql-server mysql-server/root_password_again password 12345678' | debconf-set-selections

# Install MySQL
RUN apt-get install -y mysql-server mysql-client

# Copy config file to MySQL server
# COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY mysqld.cnf /etc/mysql/my.cnf

# Copy user's config file to MySQL server
COPY my.cnf /my.cnf

# Install MySQL
RUN export MYSQL_PWD=12345678 \
&& service mysql start \
&& mysql --defaults-file=/my.cnf -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;' \
&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
&& chmod 755 /var/run/mysqld

#RUN export MYSQL_USER_NAME=bacadmin \
#&& export MYSQL_USER_PWD=12345678 \
#&& export MYSQL_USER_DB=bacadmin_changepw \
#&& service mysql start \
#&& mysql --defaults-file=/my.cnf -e "CREATE USER  $MYSQL_USER_NAME @'%' IDENTIFIED BY '$MYSQL_USER_PWD';GRANT USAGE ON *.* TO $MYSQL_USER_NAME @'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;CREATE DATABASE IF NOT EXISTS $MYSQL_USER_NAME;GRANT ALL PRIVILEGES ON $MYSQL_USER_NAME.* TO $MYSQL_USER_NAME @'%';FLUSH PRIVILEGES;"

#COPY mysqlCreateUser.sh /mysqlCreateUser.sh
#RUN /bin/bash /mysqlCreateUser.sh

RUN usermod -d /var/lib/mysql/ mysql

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh
RUN PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENTRYPOINT ["docker-entrypoint.sh"]

# Define default command
EXPOSE 3306
CMD ["mysqld"]
