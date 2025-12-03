-- 1) Create clinics table
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(150) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

-- 2) Create customer table
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20)
);

-- 3) Create clinic_sales table
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50) NOT NULL,
    cid VARCHAR(50) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    datetime DATETIME NOT NULL,
    sales_channel VARCHAR(100),

    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- 4) Create expenses table
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    amount DECIMAL(12,2) NOT NULL,
    datetime DATETIME NOT NULL,

    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ Clinic', 'Hyderabad', 'Telangana', 'India'),
('cnc-0100002', 'Sunrise Clinic', 'Bengaluru', 'Karnataka', 'India'),
('cnc-0100003', 'CarePlus Clinic', 'Chennai', 'Tamil Nadu', 'India'),
('cnc-0100004', 'City Health Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100005', 'Apollo Clinic', 'Pune', 'Maharashtra', 'India'),
('cnc-0100006', 'HealthFirst Clinic', 'Delhi', 'Delhi', 'India'),
('cnc-0100007', 'UltraCare Clinic', 'Kolkata', 'West Bengal', 'India'),
('cnc-0100008', 'Wellness Clinic', 'Ahmedabad', 'Gujarat', 'India'),
('cnc-0100009', 'Medico Clinic', 'Jaipur', 'Rajasthan', 'India'),
('cnc-0100010', 'Family Care Clinic', 'Kochi', 'Kerala', 'India');

INSERT INTO customer (uid, name, mobile) VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('bk-12ab4-x91mn', 'Alice Smith', '98XXXXXXXX'),
('bk-45cd9-p73qs', 'Robert Brown', '96XXXXXXXX'),
('bk-78ef2-r56tu', 'Emma Wilson', '95XXXXXXXX'),
('bk-90gh3-n18op', 'Michael Lee', '94XXXXXXXX'),
('bk-23ij7-h84vw', 'Sophia Taylor', '93XXXXXXXX'),
('bk-56kl1-j72zx', 'Daniel Harris', '92XXXXXXXX'),
('bk-89mn4-k55yt', 'Olivia Davis', '91XXXXXXXX'),
('bk-34op8-l49qr', 'James Martin', '90XXXXXXXX'),
('bk-67qr2-m78st', 'Ava Thompson', '89XXXXXXXX');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'bk-12ab4-x91mn', 'cnc-0100002', 15000, '2021-09-24 14:12:10', 'online'),
('ord-00100-00102', 'bk-45cd9-p73qs', 'cnc-0100003', 18500, '2021-09-25 11:45:37', 'offline'),
('ord-00100-00103', 'bk-78ef2-r56tu', 'cnc-0100004', 21000, '2021-09-26 09:22:55', 'sodat'),
('ord-00100-00104', 'bk-90gh3-n18op', 'cnc-0100005', 9900, '2021-09-27 13:40:18', 'online'),
('ord-00100-00105', 'bk-23ij7-h84vw', 'cnc-0100006', 12500, '2021-09-28 16:18:22', 'offline'),
('ord-00100-00106', 'bk-56kl1-j72zx', 'cnc-0100007', 30500, '2021-09-29 10:05:44', 'sodat'),
('ord-00100-00107', 'bk-89mn4-k55yt', 'cnc-0100008', 17500, '2021-09-30 08:25:10', 'online'),
('ord-00100-00108', 'bk-34op8-l49qr', 'cnc-0100009', 22000, '2021-10-01 12:55:33', 'offline'),
('ord-00100-00109', 'bk-67qr2-m78st', 'cnc-0100010', 14000, '2021-10-02 07:40:12', 'sodat');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'First-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'Cleaning supplies', 1200, '2021-09-24 09:20:10'),
('exp-0100-00102', 'cnc-0100003', 'Medical equipment repair', 3500, '2021-09-25 11:18:55'),
('exp-0100-00103', 'cnc-0100004', 'Gloves & masks purchase', 800, '2021-09-26 08:14:22'),
('exp-0100-00104', 'cnc-0100005', 'Internet bill', 999, '2021-09-27 10:25:19'),
('exp-0100-00105', 'cnc-0100006', 'Electricity bill', 2300, '2021-09-28 15:12:40'),
('exp-0100-00106', 'cnc-0100007', 'Water bill', 750, '2021-09-29 13:45:11'),
('exp-0100-00107', 'cnc-0100008', 'Stationery items', 430, '2021-09-30 09:30:27'),
('exp-0100-00108', 'cnc-0100009', 'Sanitizer refills', 560, '2021-10-01 12:10:44'),
('exp-0100-00109', 'cnc-0100010', 'Clinic maintenance', 4800, '2021-10-02 17:05:16');
