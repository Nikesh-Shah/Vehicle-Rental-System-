-- Creating Database
CREATE DATABASE G0Rent;

-- users table
CREATE TABLE GoRent.users (
                              user_id INT PRIMARY KEY AUTO_INCREMENT,
                              name VARCHAR(100) NOT NULL,
                              email VARCHAR(100) NOT NULL UNIQUE,
                              password VARCHAR(255) NOT NULL,
                              role VARCHAR(20) NOT NULL,
                              phone VARCHAR(15) NOT NULL
);

-- Booking Table
CREATE TABLE GoRent.booking (
                           bookingId INT PRIMARY KEY AUTO_INCREMENT,
                           booking_status VARCHAR(50),
                           booking_start_date DATE,
                           booking_end_date DATE,
                           booking_total_amount DECIMAL(10, 2)
);

-- Rental Table
CREATE TABLE GoRent.Rental (
                          rentalId INT PRIMARY KEY AUTO_INCREMENT,
                          rental_date DATE,
                          rental_return_date DATE,
                          rental_status VARCHAR(50),
                          rental_late_fee DECIMAL(10, 2)
);

--  Vehicle Table
CREATE TABLE GoRent.Vehicle (
                           vehicleId INT PRIMARY KEY AUTO_INCREMENT,
                           vehicle_brand VARCHAR(100),
                           vehicle_model VARCHAR(100),
                           vehicle_price_per_day DECIMAL(10, 2),
                           vehicle_status VARCHAR(50)
);

--  Category Table
CREATE TABLE GoRent.Category (
                            categoryId INT PRIMARY KEY AUTO_INCREMENT,
                            category_name VARCHAR(100),
                            category_image VARCHAR(255),
                            category_description TEXT
);

--  User_Booking Table
CREATE TABLE GoRent.User_Booking (
                                     bookingId INT,
                                     userId INT,
                                     vehicleId INT,
                                     rentalId INT,
                                     PRIMARY KEY (bookingId, userId, vehicleId),
                                     FOREIGN KEY (bookingId) REFERENCES GoRent.booking(bookingId) ON DELETE CASCADE,
                                     FOREIGN KEY (userId) REFERENCES GoRent.users(user_id) ON DELETE CASCADE,
                                     FOREIGN KEY (vehicleId) REFERENCES GoRent.Vehicle(vehicleId) ON DELETE CASCADE,
                                     FOREIGN KEY (rentalId) REFERENCES GoRent.Rental(rentalId) ON DELETE CASCADE
);

--  Booking_Vehicle Table
CREATE TABLE GoRent.Booking_Vehicle (
                                        vehicleId INT,
                                        bookingId INT,
                                        user_id INT,
                                        categoryId INT,
                                        PRIMARY KEY (vehicleId, bookingId, user_id),
                                        FOREIGN KEY (vehicleId) REFERENCES GoRent.Vehicle(vehicleId) ON DELETE CASCADE,
                                        FOREIGN KEY (bookingId) REFERENCES GoRent.booking(bookingId) ON DELETE CASCADE,
                                        FOREIGN KEY (user_id) REFERENCES GoRent.users(user_id) ON DELETE CASCADE,
                                        FOREIGN KEY (categoryId) REFERENCES GoRent.Category(categoryId) ON DELETE CASCADE
);


