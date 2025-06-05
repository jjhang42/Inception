# Makefile for Docker Compose in ./srcs directory

# Compose 설정
COMPOSE       = docker compose
COMPOSE_FILE  = --file ./srcs/docker-compose.yml

# 바인딩 디렉토리 (호스트 머신 기준)
VOLUME_DIRS = \
	/home/jjhang/data/mariadb \
	/home/jjhang/data/wordpress

# 디렉토리 생성 + 권한 설정
init_volumes:
	@echo "📁 바인딩 디렉토리 확인 및 생성 중..."
	@for dir in $(VOLUME_DIRS); do \
		if [ ! -d $$dir ]; then \
			echo "📂 생성: $$dir"; \
			sudo mkdir -p $$dir; \
			sudo chown -R 1000:1000 $$dir; \
		else \
			echo "✅ 존재: $$dir"; \
		fi \
	done
	@echo "🎉 바인딩 디렉토리 준비 완료."

# 컨테이너 실행
up: init_volumes
	$(COMPOSE) $(COMPOSE_FILE) up

# 컨테이너 중지 및 제거
down:
	$(COMPOSE) $(COMPOSE_FILE) down

# 이미지 빌드
build: init_volumes
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

# 셸 접속
sh:
	$(COMPOSE) $(COMPOSE_FILE) exec $(SERVICE) /bin/bash

# 컨테이너 + 볼륨 제거
clean:
	$(COMPOSE) $(COMPOSE_FILE) down -v

# 도움말
help:
	@echo "🛠️ Docker Compose Makefile 명령어 목록:"
	@echo "  make up             - 컨테이너 실행"
	@echo "  make down           - 컨테이너 중지 및 제거"
	@echo "  make build          - 이미지 빌드"
	@echo "  make logs           - 로그 보기"
	@echo "  make restart        - 서비스 재시작"
	@echo "  make ps             - 서비스 상태 보기"
	@echo "  make sh SERVICE=서비스명 - 셸 접속"
	@echo "  make clean          - 컨테이너 + 볼륨 제거"
	@echo "  make init_volumes   - 바인딩 디렉토리 생성 및 권한 설정"