#
# Eagle's Docker stack
#
# MySQL Dockerfile
#

# Base image
FROM debian:testing

MAINTAINER <Eagle_M_Young>

# Update apt
RUN apt-get update

# Define root's password
RUN echo 'mysql-server-5.6 mysql-server/root_password password 12345678' | debconf-set-selections \
    && echo 'mysql-server-5.6 mysql-server/root_password_again password 12345678' | debconf-set-selections

# Install MySQL
RUN apt-get install -y mysql-server mysql-client

# Copy config file to MySQL server
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Copy user's config file to MySQL server
COPY my.cnf /my.cnf

# Install MySQL
RUN export MYSQL_PWD=12345678 \
&& service mysql start \
&& mysql --defaults-file=/my.cnf -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

# Define default command
CMD ["mysqld"]
