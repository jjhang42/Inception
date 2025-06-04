FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# 필요한 패키지 설치
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

# php-fpm이 PID 파일을 쓸 수 있도록 디렉토리 생성
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# 워드프레스 파일을 미리 다운로드 받아 두기만 함 (설치하지 않음)
RUN curl -o /tmp/wordpress.zip https://wordpress.org/latest.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    rm /tmp/wordpress.zip

# 엔트리포인트 스크립트 복사
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# PHP-FPM 설정 복사
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

# 엔트리포인트 지정
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]