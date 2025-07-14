-- DATABASE CREATION : 

CREATE DATABASE AirlineReservationSystem;
USE AirlineReservationSystem;

-- Table Creation

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50)  ,
    last_name VARCHAR(50)  ,
    email VARCHAR(100) UNIQUE  ,
    phone VARCHAR(15)  ,
    address VARCHAR(200),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10)  ,
    source VARCHAR(50)  ,
    destination VARCHAR(50)  ,
    departure_time DATETIME  ,
    arrival_time DATETIME  ,
    total_seats INT  ,
    ticket_price DECIMAL(10, 2)  
);



CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT  ,
    flight_id INT  ,
    seat_number VARCHAR(5)  ,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Confirmed', 'Cancelled', 'Waiting') DEFAULT 'Confirmed',
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    CONSTRAINT unique_flight_seat UNIQUE (flight_id, seat_number)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT  ,
    amount DECIMAL(10, 2)  ,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Credit Card', 'Debit Card', 'Net Banking', 'UPI')  ,
    status ENUM('Success', 'Failed', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);
