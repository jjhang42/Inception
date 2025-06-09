#!/bin/bash
set -e

echo "[INFO] Google Chrome 설치를 시작합니다..."

# 필요한 패키지 설치
echo "[INFO] 의존성 패키지를 설치합니다..."
sudo apt-get update
sudo apt-get install -y wget curl gnupg2 apt-transport-https

# Chrome .deb 다운로드
echo "[INFO] Google Chrome DEB 파일을 다운로드합니다..."
wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# 설치
echo "[INFO] Google Chrome을 설치합니다..."
sudo dpkg -i /tmp/google-chrome.deb || sudo apt-get install -f -y

# 확인
echo "[INFO] 설치된 버전 확인:"
google-chrome --version || google-chrome-stable --version

echo "[INFO] Google Chrome 설치가 완료되었습니다."