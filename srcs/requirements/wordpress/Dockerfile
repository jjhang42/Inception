FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

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
    mariadb-client \
    curl \
    unzip \
    wget \
    less \
    vim \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# WP-CLI 설치
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM PID 디렉토리
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# 워드프레스 설치 디렉토리
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# 사전 WordPress 다운로드
RUN curl -o /tmp/wordpress.zip https://wordpress.org/latest.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    cp -r /tmp/wordpress/* /var/www/html && \
    rm -rf /tmp/wordpress /tmp/wordpress.zip

# FPM 설정 및 엔트리포인트 복사
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]