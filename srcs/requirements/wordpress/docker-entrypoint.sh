#!/bin/sh
set -e
echo "[ENTRY] docker-entrypoint 시작"

if [ ! -f wp-config.php ]; then
    echo "[INFO] wp-config.php not found. Running wp core install setup..."

    echo "[INFO] Waiting for MariaDB to be available..."
    until mysqladmin ping -h "mariadb" -u root -p"${MYSQL_ROOT_PASSWORD}" --silent; do
        echo "[INFO] MariaDB is unavailable - sleeping"
        sleep 2
    done
    echo "[INFO] MariaDB is up!"

    echo "[WP] wp-config 생성"
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb" \
        --path="/var/www/html" \
        --allow-root
    echo "[WP] wp-config 생성 완료"

    echo "[WP] core 설치 시작"
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Jjhang's NOTE" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --path="/var/www/html" \
        --allow-root
    echo "[WP] core 설치 완료"

    echo "[WP] 테마 jjhangBlog 활성화"
    wp theme activate jjhangBlog --allow-root

    echo "[WP] 일반 사용자 생성"
    wp user create \
        "${WP_USER_NAME}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role="${WP_USER_ROLE}" \
        --path="/var/www/html" \
        --allow-root
    echo "[WP] 일반 사용자 생성 완료"
fi

exec "$@"