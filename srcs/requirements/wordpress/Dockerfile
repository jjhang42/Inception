FROM debian:bullseye

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    curl unzip wget vim mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# FPM을 TCP 9000 포트에서 listen하도록 설정
RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# PID 경로 생성 (FPM 실행 오류 방지)
RUN mkdir -p /run/php

# 워드프레스 다운로드 및 압축 해제
WORKDIR /var/www/html
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

COPY ./conf/php.ini /etc/php/7.4/fpm/php.ini

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
