#!/bin/bash
set -e

if [ ! -f wp-config.php ]; then
    echo "[INFO] wp-config.php not found. Running wp core install setup..."

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --path="/var/www/html" \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception WordPress" \
        --admin_user="admin" \
        --admin_password="adminpass" \
        --admin_email="admin@example.com" \
        --skip-email \
        --path="/var/www/html" \
        --allow-root
fi

exec "$@"