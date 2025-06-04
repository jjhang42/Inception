# Makefile for Docker Compose in ./srcs directory

# Compose 설정
COMPOSE       = docker compose
COMPOSE_FILE  = --file ./srcs/docker-compose.yml

# 바인딩 디렉토리 설정
VOLUME_DIRS = \
	srcs/requirements/mariadb \
	srcs/requirements/wordpress \
	srcs/requirements/nginx

# ✅ 디렉토리 존재 확인 및 생성
init_dirs:
	@echo "📁 디렉토리 확인 및 생성 중..."
	@for dir in $(VOLUME_DIRS); do \
		if [ ! -d $$dir ]; then \
			echo "📂 생성: $$dir"; \
			mkdir -p $$dir; \
		fi \
	done
	@echo "✅ 완료."

# 컨테이너 실행
up: init_dirs
	$(COMPOSE) $(COMPOSE_FILE) up

# 컨테이너 중지 및 제거
down:
	$(COMPOSE) $(COMPOSE_FILE) down

# 이미지 빌드
build: init_dirs
	$(COMPOSE) $(COMPOSE_FILE) build

# 로그 보기
logs:
	$(COMPOSE) $(COMPOSE_FILE) logs -f

# 서비스 재시작
restart:
	$(COMPOSE) $(COMPOSE_FILE) down
	$(COMPOSE) $(COMPOSE_FILE) up -d

# 상태 확인
ps:
	$(COMPOSE) $(COMPOSE_FILE) ps

# 셸 접속 (예: make sh SERVICE=wordpress)
sh:
	$(COMPOSE) $(COMPOSE_FILE) exec $(SERVICE) /bin/bash

# 컨테이너 + 볼륨 제거
clean:
	$(COMPOSE) $(COMPOSE_FILE) down -v

# 도움말
help:
	@echo "🛠️ Docker Compose Makefile 명령어 목록:"
	@echo "  make up         - 컨테이너 실행"
	@echo "  make down       - 컨테이너 중지 및 제거"
	@echo "  make build      - 이미지 빌드"
	@echo "  make logs       - 로그 보기"
	@echo "  make restart    - 서비스 재시작"
	@echo "  make ps         - 서비스 상태 보기"
	@echo "  make sh SERVICE=서비스명 - 셸 접속"
	@echo "  make clean      - 컨테이너 + 볼륨 제거"
	@echo "  make init_dirs  - 바인딩 디렉토리 생성"