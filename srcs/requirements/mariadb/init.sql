CREATE DATABASE IF NOT EXISTS appdb;
USE appdb;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    role ENUM('admin', 'visitor') NOT NULL
);

INSERT INTO users (username, role) VALUES ('jjhang', 'admin'), ('visitor', 'visitor');