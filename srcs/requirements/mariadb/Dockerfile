# 베이스 이미지
FROM debian:bullseye

# 비대화식 환경 설정 및 타임존 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# 필수 패키지 설치
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 설정 및 초기화 파일 복사
COPY ./my.cnf /etc/mysql/my.cnf
COPY init.sql /init.sql
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 포트 오픈
EXPOSE 3306

# 엔트리포인트 + 기본 명령
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# CMD ["tail", "-f", "/dev/null"]
# CMD ["mysqld"]