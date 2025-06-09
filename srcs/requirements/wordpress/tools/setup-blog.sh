#!/bin/bash
set -e

echo "[SETUP-BLOG] 블로그 초기 세팅을 시작합니다..."

# 페이지 생성
echo "[STEP] Home, About 페이지 생성"
wp post create --post_type=page --post_title='Home' --post_status=publish --allow-root
wp post create --post_type=page --post_title='About' --post_status=publish --allow-root

# 고정 페이지 설정
echo "[STEP] 홈페이지를 고정 페이지로 설정"
HOME_ID=$(wp post list --post_type=page --pagename=home --field=ID --allow-root)
wp option update show_on_front 'page' --allow-root
wp option update page_on_front "${HOME_ID}" --allow-root

# 테마 설치 및 활성화
echo "[STEP] 테마 설치 및 적용"
wp theme install astra --activate --allow-root

# 메뉴 생성 및 연결
echo "[STEP] 메인 메뉴 생성 및 페이지 연결"
wp menu create "Main Menu" --allow-root
wp menu item add-post "Main Menu" "${HOME_ID}" --title="Home" --allow-root
wp menu location assign "Main Menu" primary --allow-root

# 커스텀 CSS 추가
echo "[STEP] 커스텀 CSS 설정"
wp custom-css set '
.wp-block-button__link {
  background-color: #ff6347;
  color: white;
}' --allow-root

# 플러그인 설치 예시 (선택)
echo "[STEP] 플러그인 설치 및 활성화"
wp plugin install contact-form-7 --activate --allow-root
wp plugin install wp-super-cache --activate --allow-root

echo "[SETUP-BLOG] 블로그 세팅 완료"