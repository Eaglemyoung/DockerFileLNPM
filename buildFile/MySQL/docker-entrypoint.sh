#!/bin/bash
set -eo pipefail
shopt -s nullglob 

service mysql start

MYSQL_USER_PWD=${MYSQL_USER_PWD:-1234657890}

if [ ! $MYSQL_USER_NAME  ]; then
	echo "Enter a username as a normal user"
	exit 1
elif [ $MYSQL_USER_NAME = "root" ]; then
	echo "Root is not a normal user"
	exit 2
else
  mysql --defaults-file=/my.cnf -e "CREATE USER $MYSQL_USER_NAME @'%' IDENTIFIED BY '$MYSQL_USER_PWD';GRANT USAGE ON *.* TO $MYSQL_USER_NAME @'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
  echo "Mysql username is created"
fi


if [ ! $MYSQL_ROOT_PWD ]; then
	echo "Mysql root password has not been changed"
else
  mysql --defaults-file=/my.cnf -e "use mysql;SET PASSWORD FOR 'root'@'%' = '$MYSQL_ROOT_PWD';"
	echo "Mysql root password is changed"
fi

if [ ! $MYSQL_DB_NAME ]; then
	echo "Enter the database name of the user default database"
	exit 3
else
	mysql --defaults-file=/my.cnf -e "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO $MYSQL_USER_NAME @'%';FLUSH PRIVILEGES;"
	echo "Build database"
fi

chown -R mysql:mysql /var/lib/mysql/$MYSQL_DB_NAME

echo $MYSQL_USER_NAME
echo $MYSQL_USER_PWD
echo $MYSQL_ROOT_PWD
echo $MYSQL_DB_NAME


service mysql stop

exec "$@"
