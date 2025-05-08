CREATE DATABASE IF NOT EXISTS GoRent;
CREATE TABLE users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       fname VARCHAR(50) NOT NULL,
                       lname VARCHAR(50) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       role INT DEFAULT 0, -- 0 = user, 1 = admin
                       phone VARCHAR(20),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE category (
                          categoryId INT PRIMARY KEY AUTO_INCREMENT,
                          category_name VARCHAR(100) NOT NULL,
                          category_image VARCHAR(255),
                          category_description TEXT
);
CREATE TABLE vehicle (
                         vehicleId INT PRIMARY KEY AUTO_INCREMENT,
                         vehicle_brand VARCHAR(100) NOT NULL,
                         vehicle_model VARCHAR(100) NOT NULL,
                         vehicle_price_per_day DECIMAL(10,2) NOT NULL,
                         vehicle_status VARCHAR(50) NOT NULL,
                         categoryId int(11) NOT NULL ,
                         vehicle_image VARCHAR(255) NOT NULL



);

CREATE TABLE booking (
                         bookingId INT PRIMARY KEY AUTO_INCREMENT,
                         booking_status VARCHAR(50),
                         booking_start_date DATE,
                         booking_end_date DATE,
                         booking_total_amount DECIMAL(10,2)
);
CREATE TABLE booking_vehicle (
                                 bookingId INT,
                                 vehicleId INT,
                                 categoryId INT,
                                 user_id INT,
                                 PRIMARY KEY (bookingId, vehicleId),
                                 FOREIGN KEY (bookingId) REFERENCES booking(bookingId),
                                 FOREIGN KEY (vehicleId) REFERENCES vehicle(vehicleId),
                                 FOREIGN KEY (categoryId) REFERENCES category(categoryId),
                                 FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE user_booking (
                              bookingId INT PRIMARY KEY,
                              vehicleId INT,
                              user_id INT,
                              paymentId INT,
                              FOREIGN KEY (vehicleId) REFERENCES vehicle(vehicleId),
                              FOREIGN KEY (user_id) REFERENCES users(user_id),
                              FOREIGN KEY (paymentId) REFERENCES payment(paymentId)
);
CREATE TABLE payment (
                         paymentId INT PRIMARY KEY AUTO_INCREMENT,
                         payment_date DATE,
                         payment_amount DECIMAL(10,2),
                         payment_method VARCHAR(50),
                         payment_status VARCHAR(50)
);