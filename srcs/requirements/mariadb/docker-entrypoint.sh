#!/bin/bash
set -e

# DB 데이터 디렉토리
DATA_DIR="/var/lib/mysql"

# DB가 이미 초기화되었는지 확인
if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "[INFO] MariaDB 초기화 시작..."

    # 데이터베이스 초기화
    mariadb-install-db --user=mysql --datadir="$DATA_DIR" --auth-root-password

    echo "[INFO] init.sql 스크립트 적용 중..."
    mysqld_safe --datadir="$DATA_DIR" &
    sleep 5
    mariadb -u root < /docker-entrypoint-initdb.d/init.sql
    mysqladmin shutdown

    echo "[INFO] MariaDB 초기화 완료!"
fi

# 최종적으로 mariadbd 실행
exec mariadbd