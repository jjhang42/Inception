#!/bin/bash
set -e

DATA_DIR="/var/lib/mysql"

if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "[INFO] MariaDB 초기화 시작..."

    # 루트 권한으로 초기화
    mariadb-install-db --datadir="$DATA_DIR"

    echo "[INFO] init.sql 스크립트 적용 중..."
    mysqld_safe --datadir="$DATA_DIR" &
    sleep 5
    mariadb -u root < /init.sql
    mysqladmin shutdown

    echo "[INFO] MariaDB 초기화 완료!"
fi

exec mysqld --user=root