-- hotel database
USE hotel;

-- users table
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email_id VARCHAR(100) NOT NULL UNIQUE,
    billing_address VARCHAR(255)
);

INSERT INTO users (user_id, name, phone_number, email_id, billing_address) VALUES
('98ujk4rf-22kls', 'Alice Smith', '97xxxxxxxx', 'alice.smith@example.com', 'abc street, hyderabad'),
('ab92kfj3-11qwe', 'Robert Johnson', '96xxxxxxxx', 'robert.johnson@example.com', 'lake view road, bengaluru'),
('lk92jf72-19ddf', 'Emma Williams', '95xxxxxxxx', 'emma.williams@example.com', 'green park colony, mumbai'),
('qw87jdy5-09xks', 'Michael Brown', '94xxxxxxxx', 'michael.brown@example.com', 'sector 12, new delhi'),
('po98as12-88mnb', 'Sophia Davis', '93xxxxxxxx', 'sophia.davis@example.com', 'metro layout, pune'),
('ty66gh23-44bvc', 'Daniel Miller', '92xxxxxxxx', 'daniel.miller@example.com', 'cross road, kolkata'),
('mn55za98-12qwr', 'Olivia Wilson', '91xxxxxxxx', 'olivia.wilson@example.com', 'station area, jaipur'),
('ds77kj54-90plm', 'James Taylor', '90xxxxxxxx', 'james.taylor@example.com', 'old town, chennai'),
('cv44mn21-01rty', 'Ava Anderson', '89xxxxxxxx', 'ava.anderson@example.com', 'park colony, kochi'),
('hb22pl90-55ghj', 'William Martinez', '88xxxxxxxx', 'william.martinez@example.com', 'sunset street, ahmedabad');

-- bookings table
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME NOT NULL,
    room_no VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL 
);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-12ab4-x91mn', '2021-09-24 10:15:22', 'rm-a91k-lop34', '21wrcxuy-67erfn'),
('bk-45cd9-p73qs', '2021-10-01 14:22:10', 'rm-b23f-mne87', '98ujk4rf-22kls'),
('bk-78ef2-r56tu', '2021-10-05 18:45:02', 'rm-c49h-kdi56', 'ab92kfj3-11qwe'),
('bk-90gh3-n18op', '2021-10-11 09:12:44', 'rm-d73l-oas99', 'lk92jf72-19ddf'),
('bk-23ij7-h84vw', '2021-10-15 07:55:31', 'rm-e82p-qwe44', 'qw87jdy5-09xks'),
('bk-56kl1-j72zx', '2021-10-20 16:05:12', 'rm-f33z-hyu11', 'po98as12-88mnb'),
('bk-89mn4-k55yt', '2021-10-25 20:25:48', 'rm-g61d-iop67', 'ty66gh23-44bvc'),
('bk-34op8-l49qr', '2021-11-01 11:35:29', 'rm-h74x-wer89', 'mn55za98-12qwr'),
('bk-67qr2-m78st', '2021-11-05 13:10:56', 'rm-i88c-sdf22', 'ds77kj54-90plm'),
('bk-91st5-n60uv', '2021-11-10 08:50:14', 'rm-j92v-plo33', 'cv44mn21-01rty');


-- booking_commercials table
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50) NOT NULL,
    bill_id VARCHAR(50) NOT NULL,
    bill_date DATETIME NOT NULL,
    item_id VARCHAR(50) NOT NULL,
    item_quantity DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

INSERT INTO booking_commercials 
(id, booking_id, bill_id, bill_date, item_id, item_quantity) 
VALUES
('a93k-29fhe-93kd', 'bk-12ab4-x91mn', 'bl-12kfa-98hd', '2021-09-24 09:44:18', 'itm-k92d-qp49', 2),
('b48f-h38dk-59sl', 'bk-45cd9-p73qs', 'bl-45jud-72kd', '2021-10-01 11:22:41', 'itm-p83l-a93d', 1),
('c29d-k49do-18qp', 'bk-78ef2-r56tu', 'bl-23fjs-19sl', '2021-10-05 15:12:09', 'itm-q29w-ld90', 4),
('d73k-l28sj-77fd', 'bk-90gh3-n18op', 'bl-77abc-ls92', '2021-10-11 10:02:37', 'itm-r84d-vp33', 2.5),
('e84l-h39as-82pw', 'bk-23ij7-h84vw', 'bl-55ksd-18dj', '2021-10-15 08:40:56', 'itm-s93k-e04p', 1),
('f92o-k48dh-03sm', 'bk-56kl1-j72zx', 'bl-92jdh-77ks', '2021-10-20 17:28:21', 'itm-t72h-k93f', 3.5),
('g38a-l27fg-29qp', 'bk-89mn4-k55yt', 'bl-11udh-39kd', '2021-10-25 19:12:50', 'itm-u39n-p03e', 2),
('h20p-m38kd-56jf', 'bk-34op8-l49qr', 'bl-98ahd-21lf', '2021-11-01 12:33:14', 'itm-v88s-k28w', 1.5),
('i45l-n49sk-19we', 'bk-67qr2-m78st', 'bl-45lsk-92jf', '2021-11-05 09:45:33', 'itm-w92p-d82k', 4),
('j39s-o58dj-75qx', 'bk-91st5-n60uv', 'bl-72kdh-65pw', '2021-11-10 07:56:48', 'itm-x37d-qp84', 0.75);

-- items table
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_rate DECIMAL(10,2) NOT NULL
);

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Veg Sandwich', 45),
('itm-w978-23u4', 'Masala Tea', 15),
('itm-k92d-qp49', 'Paneer Butter Masala', 180),
('itm-p83l-a93d', 'Jeera Rice', 70),
('itm-q29w-ld90', 'Veg Biryani', 120),
('itm-r84d-vp33', 'Chicken Curry', 200),
('itm-s93k-e04p', 'Gobi Manchurian', 110),
('itm-t72h-k93f', 'Dal Tadka', 90),
('itm-u39n-p03e', 'Chapati', 10)

