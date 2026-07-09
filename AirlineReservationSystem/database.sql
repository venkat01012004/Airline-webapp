-- =========================================================
-- Airline Reservation System - Database Schema
-- Database: MySQL 8.x
-- =========================================================

DROP DATABASE IF EXISTS airline_reservation;
CREATE DATABASE airline_reservation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airline_reservation;

-- ---------------------------------------------------------
-- Table: users
-- Stores both customers and administrators
-- ---------------------------------------------------------
CREATE TABLE users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password      VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    address       VARCHAR(255),
    role          ENUM('CUSTOMER','ADMIN') NOT NULL DEFAULT 'CUSTOMER',
    status        ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table: flights
-- Stores all flight information managed by admins
-- ---------------------------------------------------------
CREATE TABLE flights (
    flight_id       INT AUTO_INCREMENT PRIMARY KEY,
    flight_number   VARCHAR(20)  NOT NULL UNIQUE,
    airline_name    VARCHAR(100) NOT NULL,
    source          VARCHAR(50)  NOT NULL,
    destination     VARCHAR(50)  NOT NULL,
    departure_time  DATETIME     NOT NULL,
    arrival_time    DATETIME     NOT NULL,
    total_seats     INT          NOT NULL,
    available_seats INT          NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    status          ENUM('SCHEDULED','CANCELLED','COMPLETED') NOT NULL DEFAULT 'SCHEDULED',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table: bookings
-- Stores ticket bookings made by customers
-- ---------------------------------------------------------
CREATE TABLE bookings (
    booking_id      INT AUTO_INCREMENT PRIMARY KEY,
    pnr             VARCHAR(20)  NOT NULL UNIQUE,
    user_id         INT          NOT NULL,
    flight_id       INT          NOT NULL,
    num_seats       INT          NOT NULL,
    passenger_name  VARCHAR(100) NOT NULL,
    passenger_age   INT,
    passenger_gender VARCHAR(10),
    total_amount    DECIMAL(10,2) NOT NULL,
    booking_status  ENUM('PENDING','CONFIRMED','CANCELLED') NOT NULL DEFAULT 'PENDING',
    booking_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_user   FOREIGN KEY (user_id)   REFERENCES users(user_id)   ON DELETE CASCADE,
    CONSTRAINT fk_booking_flight FOREIGN KEY (flight_id) REFERENCES flights(flight_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table: payments
-- Stores payment details for each booking
-- ---------------------------------------------------------
CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    payment_method  VARCHAR(30) NOT NULL,
    card_number     VARCHAR(20),
    transaction_id  VARCHAR(50) NOT NULL UNIQUE,
    payment_status  ENUM('SUCCESS','FAILED','PENDING') NOT NULL DEFAULT 'PENDING',
    payment_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Table: contact_messages
-- Stores messages submitted via the Contact Us page
-- ---------------------------------------------------------
CREATE TABLE contact_messages (
    message_id   INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    subject      VARCHAR(150),
    message      TEXT NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =========================================================
-- Sample Data
-- =========================================================

-- Default administrator account
-- Email: admin@airline.com | Password: Admin@123  (SHA-256 hashed)
INSERT INTO users (first_name, last_name, email, password, phone, address, role) VALUES
('System', 'Admin', 'admin@airline.com', 'e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc', '9999999999', 'Head Office', 'ADMIN');

-- Sample customer account
-- Email: john@example.com | Password: John@123
INSERT INTO users (first_name, last_name, email, password, phone, address, role) VALUES
('John', 'Doe', 'john@example.com', '0f4dd6c67bc8c827a2b181bc763f9ab96166d8f50840fe1ae0bbc0e77464da2', '9876543210', '123 Main Street', 'CUSTOMER');

-- Sample flights
INSERT INTO flights (flight_number, airline_name, source, destination, departure_time, arrival_time, total_seats, available_seats, price, status) VALUES
('AI-101', 'Air India',       'Hyderabad', 'Delhi',     '2026-08-01 06:00:00', '2026-08-01 08:15:00', 180, 180, 4500.00, 'SCHEDULED'),
('6E-202', 'IndiGo',          'Hyderabad', 'Mumbai',    '2026-08-01 09:30:00', '2026-08-01 11:00:00', 186, 186, 3800.00, 'SCHEDULED'),
('SG-303', 'SpiceJet',        'Delhi',     'Bengaluru', '2026-08-02 14:00:00', '2026-08-02 16:45:00', 150, 150, 5200.00, 'SCHEDULED'),
('UK-404', 'Vistara',         'Mumbai',    'Chennai',   '2026-08-03 07:15:00', '2026-08-03 09:20:00', 158, 158, 4100.00, 'SCHEDULED'),
('AI-505', 'Air India',       'Chennai',   'Kolkata',   '2026-08-03 18:00:00', '2026-08-03 20:30:00', 180, 180, 4700.00, 'SCHEDULED'),
('6E-606', 'IndiGo',          'Bengaluru', 'Hyderabad', '2026-08-04 10:00:00', '2026-08-04 11:15:00', 186, 186, 2900.00, 'SCHEDULED'),
('SG-707', 'SpiceJet',        'Kolkata',   'Delhi',     '2026-08-05 05:45:00', '2026-08-05 08:00:00', 150, 150, 5000.00, 'SCHEDULED'),
('UK-808', 'Vistara',         'Delhi',     'Mumbai',    '2026-08-05 20:00:00', '2026-08-05 22:10:00', 158, 158, 4600.00, 'SCHEDULED');
