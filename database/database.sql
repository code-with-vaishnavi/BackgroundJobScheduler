CREATE DATABASE background_job_scheduler;

USE background_job_scheduler;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    role VARCHAR(20)
);

CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_name VARCHAR(100),
    job_description TEXT,
    job_type VARCHAR(50),
    job_status VARCHAR(20),
    schedule_date DATE,
    schedule_time TIME,
    execution_status VARCHAR(20)
);

CREATE TABLE job_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    job_name VARCHAR(100),
    execution_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30),
    result VARCHAR(255)
);