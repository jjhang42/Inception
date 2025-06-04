FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# 패키지 설치
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-cli \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    curl \
    unzip \
    wget \
    mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# php-fpm이 pid 파일을 쓸 수 있도록 디렉토리 생성
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# 워드프레스 다운로드 및 설치
RUN mkdir -p /var/www/html && \
    curl -o /tmp/wordpress.zip https://wordpress.org/latest.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    mv /tmp/wordpress/* /var/www/html && \
    rm -rf /tmp/wordpress /tmp/wordpress.zip

# 소유권 설정
RUN chown -R www-data:www-data /var/www/html

# PHP-FPM 설정 적용
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# 헬스체크
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
  CMD curl -f http://localhost:9000 || exit 1

EXPOSE 9000
CMD ["php-fpm7.4", "-F"]