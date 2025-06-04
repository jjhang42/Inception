# Makefile for Docker Compose in ./srcs directory

# 경로 설정
COMPOSE=docker compose
COMPOSE_FILE=--file ./srcs/docker-compose.yml
PROJECT_NAME=srcs

# 컨테이너 실행
up:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) up

# 컨테이너 중지 및 제거
down:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) down

# 이미지 빌드
build:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) build

# 로그 보기
logs:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) logs -f

# 서비스 재시작
restart:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) down
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) up -d

# 상태 확인
ps:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) ps

# 셸 접속
sh:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) exec $(SERVICE) /bin/bash

# 클린업
clean:
	$(COMPOSE) $(COMPOSE_FILE) --project-name $(PROJECT_NAME) down -v

# 도움말
help:
	@echo "🛠️ Docker Compose Makefile 명령어 (docker-compose.yml → ./srcs):"
	@echo "  make up         - 컨테이너 실행"
	@echo "  make down       - 컨테이너 중지 및 제거"
	@echo "  make build      - 이미지 빌드"
	@echo "  make logs       - 로그 보기"
	@echo "  make restart    - 서비스 재시작"
	@echo "  make ps         - 서비스 상태 보기"
	@echo "  make sh SERVICE=서비스명 - 셸 접속"
	@echo "  make clean      - 컨테이너 + 볼륨 제거"