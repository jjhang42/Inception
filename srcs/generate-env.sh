#!/bin/bash

# 현재 사용자 정보 가져오기
HOST_UID=$(id -u)
HOST_GID=$(id -g)

# .env 파일 생성
cat <<EOF > .env
# 호스트 사용자 UID/GID
HOST_UID=$HOST_UID
HOST_GID=$HOST_GID

# 바인딩할 데이터 디렉토리를 입력하세요
HOST_DATA=
EOF

echo "✅ .env 파일이 생성되었습니다:"
cat .env