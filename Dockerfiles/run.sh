#!/bin/sh

if [ ! -d /run/mysqld ]
then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]
then
    mysql_install_db --user=mysql
    /usr/bin/mysqld_safe &
    sleep 10s

    if [[ -z ${MYSQL_ROOT_PASSWORD} ]]
    then
        MYSQL_ROOT_PASSWORD=root
        echo "MySQL root Password: $MYSQL_ROOT_PASSWORD"
    fi

    mysql -u root --password="" <<-EOSQL
SET @@SESSION.SQL_LOG_BIN=0;
USE mysql;
DELETE FROM mysql.user;
DROP USER IF EXISTS 'root'@'%', 'root'@'localhost';
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOSQL

    killall mysqld
    killall mysqld_safe
    sleep 5s
    killall -9 mysqld
    killall -9 mysqld_safe
    sleep 5s
fi

exec /usr/bin/mysqld --user=mysql
