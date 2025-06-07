#!/bin/bash
set -e

DATA_DIR="/var/lib/mysql"

# MariaDB 데이터 디렉토리 초기화 여부 확인
if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "[INFO] Initializing MariaDB..."

    # 데이터 디렉토리 초기화
    mariadb-install-db --user=mysql --datadir="$DATA_DIR"

    # MariaDB 임시 실행
    echo "[INFO] Starting temporary MariaDB server..."
    mysqld_safe --datadir="$DATA_DIR" --skip-networking &
    pid="$!"

    # MariaDB 시작 대기
    for i in {30..0}; do
        if mariadb -u root --silent --execute "SELECT 1;" &>/dev/null; then
            break
        fi
        echo "[INFO] Waiting for MariaDB to start... ($i)"
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 "[ERROR] MariaDB did not start."
        exit 1
    fi

    # 초기화 SQL 실행
    echo "[INFO] Applying init.sql script..."
    mariadb -u root < /init.sql

    echo "[INFO] Shutting down temporary MariaDB server..."
    mysqladmin -u root shutdown

    wait "$pid"
    echo "[INFO] MariaDB initialization completed."
fi

# 실제 MariaDB 실행
exec mysqld --user=mysql