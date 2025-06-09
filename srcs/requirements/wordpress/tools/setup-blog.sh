#!/bin/sh
set -e

echo "[SETUP-BLOG] 블로그 초기 세팅을 시작합니다..."

# 제목만 있는 페이지 생성 + ID 저장
echo "[STEP] Home 페이지 생성"
HOME_ID=$(wp post create \
  --post_type=page \
  --post_title='Home' \
  --post_status=publish \
  --post_content='' \
  --porcelain \
  --allow-root)

echo "[STEP] About 페이지 생성"
wp post create \
  --post_type=page \
  --post_title='About' \
  --post_status=publish \
  --post_content='' \
  --allow-root

# 댓글창 열기
echo "[STEP] Home 페이지에 댓글창(방명록) 활성화"
wp post update "${HOME_ID}" --comment_status=open --allow-root

# 고정 홈페이지 설정
echo "[STEP] 홈페이지를 고정 페이지로 지정"
wp option update show_on_front 'page' --allow-root
wp option update page_on_front "${HOME_ID}" --allow-root

echo "[SETUP-BLOG] 완료: 안정적으로 댓글 가능한 Home 페이지 생성됨"