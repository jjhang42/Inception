FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./certs /etc/nginx/certs

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]