#!/bin/sh
set -e

echo "[SETUP-BLOG] 블로그 초기 세팅을 시작합니다..."

# 제목만 있는 페이지 생성
echo "[STEP] Home, About 페이지 생성 (본문 없이)"
wp post create --post_type=page --post_title='Home' --post_status=publish --post_content='' --allow-root
wp post create --post_type=page --post_title='About' --post_status=publish --post_content='' --allow-root

# Home 페이지 ID 추출
HOME_ID=$(wp post list --post_type=page --pagename=home --field=ID --allow-root)

# 고정 홈페이지 설정
echo "[STEP] 홈페이지를 고정 페이지로 지정"
wp option update show_on_front 'page' --allow-root
wp option update page_on_front "${HOME_ID}" --allow-root

echo "[SETUP-BLOG] 완료: 제목만 있는 정적 페이지 구조 생성됨"