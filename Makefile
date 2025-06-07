# Makefile for Docker Compose in ./srcs directory

# Docker Compose 설정
COMPOSE       = docker compose
COMPOSE_FILE  = --file ./srcs/docker-compose.yml

# .env 변수 불러오기
include srcs/.env
export HOST_UID HOST_GID HOST_DATA

# UID/GID 설정
MYSQL_UID := 999
MYSQL_GID := 999

# 바인딩될 로컬 경로
MARIADB_PATH = $(HOST_DATA)/mariadb
WORDPRESS_PATH = $(HOST_DATA)/wordpress
LOCAL_PATHS = $(MARIADB_PATH) $(WORDPRESS_PATH)

# 초기 볼륨 디렉토리 생성 및 권한 설정
init_volumes:
	@echo "Checking and creating bind mount directories..."
	@for dir in $(LOCAL_PATHS); do \
		if [ ! -d $$dir ]; then \
			echo "Creating directory: $$dir"; \
			sudo mkdir -p $$dir; \
		else \
			echo "Directory already exists: $$dir"; \
		fi \
	done
	@echo "Setting ownership and permissions..."
	@echo "MariaDB volume: $(MARIADB_PATH), owner: $(MYSQL_UID):$(MYSQL_GID)"
	@sudo chmod 755 $(MARIADB_PATH)
	@sudo chown -R $(MYSQL_UID):$(MYSQL_GID) $(MARIADB_PATH)
	@echo "WordPress volume: $(WORDPRESS_PATH), owner: $(HOST_UID):$(HOST_GID)"
	@sudo chmod 755 $(WORDPRESS_PATH)
	@sudo chown -R $(HOST_UID):$(HOST_GID) $(WORDPRESS_PATH)
	@echo "Volume initialization completed."

# 컨테이너 실행
up: init_volumes
	$(COMPOSE) $(COMPOSE_FILE) up

# 컨테이너 중지 및 제거
down:
	$(COMPOSE) $(COMPOSE_FILE) down -v

# 이미지 빌드
build: init_volumes
	$(COMPOSE) $(COMPOSE_FILE) build

# 로그 출력
logs:
	$(COMPOSE) $(COMPOSE_FILE) logs -f

# 서비스 재시작
restart:
	$(COMPOSE) $(COMPOSE_FILE) down
	$(COMPOSE) $(COMPOSE_FILE) up -d

# 상태 확인
ps:
	$(COMPOSE) $(COMPOSE_FILE) ps

# 쉘 접속
sh:
	$(COMPOSE) $(COMPOSE_FILE) exec $(SERVICE) /bin/bash

# 전체 정리
clean:
	$(COMPOSE) $(COMPOSE_FILE) down -v

# 도움말
help:
	@echo "Makefile Commands:"
	@echo "  make up             - Start containers"
	@echo "  make down           - Stop and remove containers"
	@echo "  make build          - Build images"
	@echo "  make logs           - Show container logs"
	@echo "  make restart        - Restart services"
	@echo "  make ps             - Show container status"
	@echo "  make sh SERVICE=x   - Open shell inside container"
	@echo "  make clean          - Remove containers and volumes"
	@echo "  make init_volumes   - Prepare bind mount directories"