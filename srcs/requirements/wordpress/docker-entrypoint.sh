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
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --path="/var/www/html" \
        --allow-root

    wp user create \
        "${WP_USER_NAME}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role="${WP_USER_ROLE}" \
        --path="/var/www/html" \
        --allow-root
fi

exec "$@"