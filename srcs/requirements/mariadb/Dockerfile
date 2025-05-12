FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    gnupg \
    lsb-release \
    curl \
    ca-certificates

RUN curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash

RUN apt-get update && apt-get install -y \
    mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

USER mysql

EXPOSE 3306

CMD ["mariadbd"]
