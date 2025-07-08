-- test_database.sql
-- Schema and sample data for testing the Savings Management project

-- Drop existing tables if needed
DROP TABLE IF EXISTS log_dang_nhap;
DROP TABLE IF EXISTS rule;
DROP TABLE IF EXISTS giao_dich;
DROP TABLE IF EXISTS so_tiet_kiem;
DROP TABLE IF EXISTS nhan_vien;
DROP TABLE IF EXISTS khach_hang;
DROP TABLE IF EXISTS account;

-- 1. Account table
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(10) NOT NULL CHECK(role IN ('CUSTOMER','EMPLOYEE','ADMIN')),
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE' CHECK(status IN ('ACTIVE','LOCKED')),
    created_at TIMESTAMP(3) NOT NULL DEFAULT NOW()
);

-- 2. Customer (khach_hang) table
CREATE TABLE khach_hang (
    ma_khach_hang VARCHAR(20) PRIMARY KEY,
    account_id INT NOT NULL UNIQUE REFERENCES account(account_id),
    ho_ten VARCHAR(100) NOT NULL,
    so_cmnd VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    so_dien_thoai VARCHAR(20) NOT NULL,
    dia_chi VARCHAR(255) NOT NULL,
    ngay_sinh DATE NOT NULL,
    ngay_tao TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    trang_thai VARCHAR(10) NOT NULL DEFAULT 'ACTIVE' CHECK(trang_thai IN ('ACTIVE','LOCKED','CLOSED'))
);

-- 3. Employee (nhan_vien) table
CREATE TABLE nhan_vien (
    ma_nhan_vien VARCHAR(20) PRIMARY KEY,
    account_id INT NOT NULL UNIQUE REFERENCES account(account_id),
    ho_ten VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(20) NOT NULL,
    chuc_vu VARCHAR(12) NOT NULL CHECK(chuc_vu IN ('TELLER','MANAGER','SUPERVISOR')),
    ngay_tao TIMESTAMP(3) NOT NULL DEFAULT NOW()
);

-- 4. Savings (so_tiet_kiem) table
CREATE TABLE so_tiet_kiem (
    ma_so VARCHAR(20) PRIMARY KEY,
    ma_khach_hang VARCHAR(20) NOT NULL REFERENCES khach_hang(ma_khach_hang),
    loai_so VARCHAR(50) NOT NULL,
    ky_han_thang INT NOT NULL,
    lai_suat DECIMAL(5,2) NOT NULL,
    so_du DECIMAL(18,2) NOT NULL DEFAULT 0,
    ngay_mo DATE NOT NULL,
    ngay_dao_han DATE NOT NULL,
    trang_thai VARCHAR(10) NOT NULL CHECK(trang_thai IN ('OPEN','CLOSED','MATURED')),
    mo_bo_boi VARCHAR(20) NOT NULL REFERENCES nhan_vien(ma_nhan_vien),
    cap_nhat_bo_boi VARCHAR(20) REFERENCES nhan_vien(ma_nhan_vien),
    dong_bo_boi VARCHAR(20) REFERENCES nhan_vien(ma_nhan_vien),
    ngay_cap_nhat TIMESTAMP(3),
    ngay_dong TIMESTAMP(3),
    ghi_chu TEXT
);

-- 5. Transaction (giao_dich) table
CREATE TABLE giao_dich (
    ma_giao_dich VARCHAR(30) PRIMARY KEY,
    ma_so VARCHAR(20) NOT NULL REFERENCES so_tiet_kiem(ma_so),
    loai_giao_dich VARCHAR(10) NOT NULL CHECK(loai_giao_dich IN ('DEPOSIT','WITHDRAW')),
    so_tien DECIMAL(18,2) NOT NULL,
    phi DECIMAL(18,2) NOT NULL DEFAULT 0,
    ngay_gd TIMESTAMP(3) NOT NULL,
    thuc_hien_bo_boi VARCHAR(20) NOT NULL REFERENCES nhan_vien(ma_nhan_vien),
    ghi_chu TEXT
);

-- 6. Regulation (rule) table
CREATE TABLE rule (
    rule_id SERIAL PRIMARY KEY,
    rule_key VARCHAR(50) NOT NULL,
rule_value VARCHAR(100) NOT NULL,
    data_type VARCHAR(10) NOT NULL CHECK(data_type IN ('INT','DECIMAL','STRING')),
    effective_from DATE NOT NULL DEFAULT NOW(),
    note TEXT,
    updated_by VARCHAR(20) NOT NULL REFERENCES nhan_vien(ma_nhan_vien),
    updated_at TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    UNIQUE (rule_key, effective_from)
);

-- 7. Login log (log_dang_nhap) table
CREATE TABLE log_dang_nhap (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(account_id),
    role VARCHAR(10) NOT NULL CHECK(role IN ('CUSTOMER','EMPLOYEE','ADMIN')),
    thoi_gian TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    dia_chi_ip VARCHAR(45),
    thiet_bi TEXT,
    trang_thai VARCHAR(10) NOT NULL DEFAULT 'SUCCESS' CHECK(trang_thai IN ('SUCCESS','FAILED'))
);

-- Sample data for testing
INSERT INTO account (username, password_hash, role) VALUES
('cust1', 'hash_customer1', 'CUSTOMER'),
('empl1', 'hash_employee1', 'EMPLOYEE'),
('admin1', 'hash_admin1', 'ADMIN');

INSERT INTO khach_hang (ma_khach_hang, account_id, ho_ten, so_cmnd, email, so_dien_thoai, dia_chi, ngay_sinh)
VALUES ('KH001', 1, 'Nguyen Van A', '123456789', 'a@example.com', '0912345678', 'Hanoi', '1990-01-01');

INSERT INTO nhan_vien (ma_nhan_vien, account_id, ho_ten, so_dien_thoai, chuc_vu)
VALUES ('NV001', 2, 'Tran Thi B', '0987654321', 'TELLER');

INSERT INTO rule (rule_key, rule_value, data_type, updated_by)
VALUES
('MIN_DEPOSIT', '1000', 'INT', 'NV001'),
('INTEREST_RATE', '5.0', 'DECIMAL', 'NV001'),
('TERM_MONTHS', '6', 'INT', 'NV001');

INSERT INTO so_tiet_kiem (ma_so, ma_khach_hang, loai_so, ky_han_thang, lai_suat, so_du, ngay_mo, ngay_dao_han, trang_thai, mo_bo_boi)
VALUES ('STK001', 'KH001', 'Standard', 6, 5.00, 5000.00, CURRENT_DATE - INTERVAL '6 months', CURRENT_DATE, 'MATURED', 'NV001');

INSERT INTO giao_dich (ma_giao_dich, ma_so, loai_giao_dich, so_tien, phi, ngay_gd, thuc_hien_bo_boi)
VALUES
('GD001', 'STK001', 'DEPOSIT', 5000.00, 0, CURRENT_TIMESTAMP - INTERVAL '6 months', 'NV001'),
('GD002', 'STK001', 'WITHDRAW', 2000.00, 0, CURRENT_TIMESTAMP - INTERVAL '3 months', 'NV001');

INSERT INTO log_dang_nhap (account_id, role, dia_chi_ip, thiet_bi, trang_thai)
VALUES (1, 'CUSTOMER', '127.0.0.1', 'Browser', 'SUCCESS');