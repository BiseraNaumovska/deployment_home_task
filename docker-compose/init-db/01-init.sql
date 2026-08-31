CREATE EXTENSION IF NOT EXISTS "pgcrypto"; --pgcrypto extension for generating UUIDs if not exists

CREATE TABLE IF NOT EXISTS active_network_equipment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_type VARCHAR(50) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    ip_address VARCHAR(45) NOT NULL,
    install_date DATE NOT NULL,
    maintenance_date DATE NOT NULL
);

INSERT INTO active_network_equipment (device_type, serial_number, ip_address, install_date, maintenance_date) VALUES
('Router', 'SN-RTR-001', '192.168.1.1', '2023-01-15', '2024-01-15'),
('Switch', 'SN-SW-002', '192.168.1.2', '2023-02-10', '2024-02-10'),
('Firewall', 'SN-FW-003', '192.168.1.254', '2023-03-01', '2024-03-01'),
('Access Point', 'SN-AP-004', '192.168.1.50', '2023-03-12', '2024-03-12'),
('Router', 'SN-RTR-005', '10.0.0.1', '2023-04-05', '2024-04-05'),
('Switch', 'SN-SW-006', '10.0.0.2', '2023-04-18', '2024-04-18'),
('Switch', 'SN-SW-007', '10.0.0.3', '2023-05-01', '2024-05-01'),
('Firewall', 'SN-FW-008', '10.0.0.254', '2023-05-20', '2024-05-20'),
('Load Balancer', 'SN-LB-009', '192.168.2.1', '2023-06-01', '2024-06-01'),
('Access Point', 'SN-AP-010', '192.168.1.51', '2023-06-15', '2024-06-15'),
('Router', 'SN-RTR-011', '172.16.0.1', '2023-07-02', '2024-07-02'),
('Switch', 'SN-SW-012', '172.16.0.2', '2023-07-11', '2024-07-11'),
('Switch', 'SN-SW-013', '172.16.0.3', '2023-08-01', '2024-08-01'),
('Access Point', 'SN-AP-014', '192.168.1.52', '2023-08-14', '2024-08-14'),
('Firewall', 'SN-FW-015', '172.16.0.254', '2023-09-01', '2024-09-01'),
('Gateway', 'SN-GW-016', '192.168.3.1', '2023-09-10', '2024-09-10'),
('Switch', 'SN-SW-017', '192.168.3.2', '2023-09-25', '2024-09-25'),
('Router', 'SN-RTR-018', '10.1.0.1', '2023-10-05', '2024-10-05'),
('Access Point', 'SN-AP-019', '192.168.1.53', '2023-10-12', '2024-10-12'),
('Switch', 'SN-SW-020', '10.1.0.2', '2023-11-01', '2024-11-01'),
('Load Balancer', 'SN-LB-021', '192.168.2.2', '2023-11-15', '2024-11-15'),
('Firewall', 'SN-FW-022', '10.1.0.254', '2023-12-01', '2024-12-01'),
('Router', 'SN-RTR-023', '192.168.4.1', '2023-12-10', '2024-12-10'),
('Switch', 'SN-SW-024', '192.168.4.2', '2024-01-05', '2025-01-05'),
('Access Point', 'SN-AP-025', '192.168.1.54', '2024-01-20', '2025-01-20'),
('Switch', 'SN-SW-026', '192.168.4.3', '2024-02-01', '2025-02-01'),
('Gateway', 'SN-GW-027', '10.2.0.1', '2024-02-14', '2025-02-14'),
('Firewall', 'SN-FW-028', '10.2.0.254', '2024-03-01', '2025-03-01'),
('Router', 'SN-RTR-029', '10.2.0.2', '2024-03-15', '2025-03-15'),
('Switch', 'SN-SW-030', '10.2.0.3', '2024-04-01', '2025-04-01')
ON CONFLICT (serial_number) DO NOTHING;