#!/bin/bash
set -e

if [ ! -f /var/www/html/index.php ]; then
    echo "📦 초기 WordPress 파일 복사 중..."
    id
    ls -alh /var/www/html
    touch /var/www/html/asdfasd
    cp -r /tmp/wordpress/* /var/www/html/
else
    echo "✅ WordPress 파일이 이미 존재합니다. 복사 생략."
fi

exec "$@"