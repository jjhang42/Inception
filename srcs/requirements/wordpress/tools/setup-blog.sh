#!/bin/sh
set -e

echo "[SETUP-BLOG] 블로그 초기 세팅을 시작합니다..."

# Home 페이지 ID 추출
HOME_ID=$(wp post list --post_type=page --pagename=home --field=ID --allow-root)
wp post update "${HOME_ID}" --comment_status=open --allow-root
# 고정 홈페이지 설정
echo "[STEP] 홈페이지를 고정 페이지로 지정"
wp option update show_on_front 'page' --allow-root
wp option update page_on_front "${HOME_ID}" --allow-root

echo "[SETUP-BLOG] 페이지 생성 완료"