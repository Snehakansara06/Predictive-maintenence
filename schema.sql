CREATE DATABASE IF NOT EXISTS ipms_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ipms_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS password_resets;
DROP TABLE IF EXISTS maintenance_logs;
DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS sensor_data;
DROP TABLE IF EXISTS machines;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fullname VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(30),
  password VARCHAR(255) NOT NULL,
  role ENUM('Admin', 'User') NOT NULL DEFAULT 'User',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE machines (
  id INT AUTO_INCREMENT PRIMARY KEY,
  machine_id VARCHAR(60) NOT NULL UNIQUE,
  machine_name VARCHAR(150) NOT NULL,
  location VARCHAR(150) NOT NULL,
  status ENUM('Active', 'Warning', 'Critical', 'Maintenance', 'Inactive') NOT NULL DEFAULT 'Active',
  health_score DECIMAL(5,2) NOT NULL DEFAULT 100.00,
  installation_date DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_machines_status (status),
  INDEX idx_machines_health (health_score)
) ENGINE=InnoDB;

CREATE TABLE sensor_data (
  id INT AUTO_INCREMENT PRIMARY KEY,
  machine_id INT NOT NULL,
  temperature DECIMAL(8,2) NOT NULL,
  vibration DECIMAL(8,2) NOT NULL,
  pressure DECIMAL(8,2) NOT NULL,
  humidity DECIMAL(8,2) NOT NULL,
  recorded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_sensor_machine FOREIGN KEY (machine_id) REFERENCES machines(id) ON DELETE CASCADE,
  INDEX idx_sensor_machine_time (machine_id, recorded_at),
  INDEX idx_sensor_recorded_at (recorded_at)
) ENGINE=InnoDB;

CREATE TABLE alerts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  machine_id INT NOT NULL,
  alert_type VARCHAR(50) NOT NULL,
  message TEXT NOT NULL,
  status ENUM('Open', 'Acknowledged', 'Resolved') NOT NULL DEFAULT 'Open',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_alert_machine FOREIGN KEY (machine_id) REFERENCES machines(id) ON DELETE CASCADE,
  INDEX idx_alert_machine_status (machine_id, status),
  INDEX idx_alert_created_at (created_at)
) ENGINE=InnoDB;

CREATE TABLE maintenance_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  machine_id INT NOT NULL,
  maintenance_date DATE NOT NULL,
  description TEXT NOT NULL,
  technician_name VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_maintenance_machine FOREIGN KEY (machine_id) REFERENCES machines(id) ON DELETE CASCADE,
  INDEX idx_maintenance_date (maintenance_date)
) ENGINE=InnoDB;

CREATE TABLE password_resets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  token_hash VARCHAR(128) NOT NULL,
  expires_at DATETIME NOT NULL,
  used_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_password_resets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_password_resets_token (token_hash),
  INDEX idx_password_resets_expires (expires_at)
) ENGINE=InnoDB;
