#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysqld --initialize-insecure --user=mysql
fi

mysqld_safe --user=mysql &
echo "Waiting for MariaDB to start..."

until mysqladmin ping --silent; do
  sleep 1
done

echo "Running init.sql..."
mysql -uroot < /init.sql

wait