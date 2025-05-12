FROM alpine:3.20

RUN apk add --no-cache nginx openssl

# Nginx 기본 설정 파일 및 인증서 복사
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./conf/proxy_params /etc/nginx/proxy_params
COPY ./certs /etc/nginx/certs

# 포트 오픈
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
