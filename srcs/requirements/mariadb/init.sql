CREATE DATABASE IF NOT EXISTS appdb;
USE appdb;

-- WordPress 접속용 사용자 생성
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON appdb.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;

-- 추가 사용자 테이블 생성
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    role ENUM('admin', 'visitor') NOT NULL
);

INSERT INTO users (username, role) VALUES ('jjhang', 'admin'), ('visitor', 'visitor');