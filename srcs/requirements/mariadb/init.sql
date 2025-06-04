-- WordPress용 DB 생성 및 사용자 설정
CREATE DATABASE IF NOT EXISTS wp;
USE wp;

-- WordPress 접속용 사용자 생성 및 권한 부여
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON wp.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;

-- 추가 사용자 테이블 생성
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    role ENUM('admin', 'visitor') NOT NULL
);

-- 테스트용 사용자 삽입
INSERT INTO users (username, role) VALUES ('jjhang', 'admin'), ('visitor', 'visitor');