USE ipms_db;

INSERT INTO users (fullname, email, phone, password, role) VALUES
('System Administrator', 'admin@ipms.local', '+1-555-0100', '$2a$12$vRFrpR1NKNSSJobBW1cd5.jELWNmdyxwwWDRlsi2rVrbNhNQkA1xS', 'Admin'),
('Maintenance Operator', 'operator@ipms.local', '+1-555-0101', '$2a$12$UeC0WSZoibUb/TeWnioDv.wdTvOkggtvVH1eHHdJAZK5qS1ZTLmoi', 'User');

INSERT INTO machines (machine_id, machine_name, location, status, health_score, installation_date) VALUES
('CNC-AX-1001', 'CNC Axis Mill 1001', 'Plant A - Line 1', 'Active', 92.00, '2022-02-15'),
('PMP-HY-2210', 'Hydraulic Pump 2210', 'Plant A - Pump Room', 'Warning', 68.00, '2021-06-20'),
('CMP-AR-3322', 'Air Compressor 3322', 'Plant B - Utilities', 'Critical', 34.00, '2020-11-10'),
('CNV-PK-4412', 'Packaging Conveyor 4412', 'Plant C - Packaging', 'Active', 87.00, '2023-03-08');

INSERT INTO sensor_data (machine_id, temperature, vibration, pressure, humidity, recorded_at) VALUES
(1, 72.5, 3.4, 88.0, 45.0, NOW() - INTERVAL 6 HOUR),
(1, 74.2, 3.8, 89.1, 46.5, NOW() - INTERVAL 3 HOUR),
(1, 75.1, 4.0, 90.0, 47.0, NOW() - INTERVAL 1 HOUR),
(2, 82.4, 7.6, 105.0, 58.0, NOW() - INTERVAL 5 HOUR),
(2, 84.8, 8.1, 108.5, 59.0, NOW() - INTERVAL 2 HOUR),
(3, 93.2, 11.4, 128.0, 66.0, NOW() - INTERVAL 4 HOUR),
(3, 95.5, 12.2, 131.0, 68.0, NOW() - INTERVAL 1 HOUR),
(4, 70.3, 3.2, 82.0, 42.0, NOW() - INTERVAL 7 HOUR),
(4, 71.0, 3.3, 83.0, 43.0, NOW() - INTERVAL 2 HOUR);

INSERT INTO alerts (machine_id, alert_type, message, status, created_at) VALUES
(2, 'Warning', 'Temperature: Temperature 84.8C exceeded warning threshold of 80C.', 'Open', NOW() - INTERVAL 2 HOUR),
(2, 'Warning', 'Vibration: Vibration 8.1 mm/s exceeded warning threshold of 7 mm/s.', 'Acknowledged', NOW() - INTERVAL 2 HOUR),
(3, 'Critical', 'Temperature: Temperature 95.5C exceeded critical threshold of 90C.', 'Open', NOW() - INTERVAL 1 HOUR),
(3, 'Critical', 'Vibration: Vibration 12.2 mm/s exceeded critical threshold of 10 mm/s.', 'Open', NOW() - INTERVAL 1 HOUR);

INSERT INTO maintenance_logs (machine_id, maintenance_date, description, technician_name) VALUES
(1, CURDATE() - INTERVAL 12 DAY, 'Routine lubrication and spindle inspection completed.', 'Avery Stone'),
(2, CURDATE() - INTERVAL 4 DAY, 'Hydraulic filter replaced; pressure valve recalibrated.', 'Mina Patel'),
(3, CURDATE() - INTERVAL 1 DAY, 'Emergency vibration inspection opened. Bearing replacement recommended.', 'Jordan Lee');
