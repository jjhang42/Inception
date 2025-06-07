#!/bin/bash
set -e

DATA_DIR="/var/lib/mysql"

# 1. MariaDB 초기화
if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "[INFO] MariaDB 초기화 시작..."
    mariadb-install-db --datadir="$DATA_DIR"
fi

echo "[INFO] init.sql 스크립트 재적용 중..."
mysqld_safe --datadir="$DATA_DIR" &
sleep 5

mariadb -u root < /init.sql || echo "[WARN] init.sql 실행 실패, 무시함"
mysqladmin shutdown

echo "[INFO] 초기화 및 init.sql 적용 완료."

exec mysqld --user=root