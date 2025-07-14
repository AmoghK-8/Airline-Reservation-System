USE AirlineReservationSystem ;

INSERT INTO Passengers VALUES
(1, 'Amit', 'Sharma', 'amit@gmail.com', '9876543210', 'B-12 Malviya Nagar, Delhi', '1990-05-15', CURRENT_TIMESTAMP),
(2, 'Priya', 'Verma', 'priya@gmail.com', '9876543211', '204 Andheri West, Mumbai', '1992-07-22', CURRENT_TIMESTAMP),
(3, 'Rahul', 'Gupta', 'rahul@gmail.com', '9876543212', '45 MG Road, Bangalore', '1985-11-30', CURRENT_TIMESTAMP),
(4, 'Neha', 'Singh', 'neha@gmail.com', '9876543213', '123 Park Street, Kolkata', '1995-02-18', CURRENT_TIMESTAMP),
(5, 'Vikram', 'Reddy', 'vikram@gmail.com', '9876543214', '56 Jubilee Hills, Hyderabad', '1988-09-10', CURRENT_TIMESTAMP),
(6, 'Kavita', 'Iyer', 'kavita@gmail.com', '9876543215', '78 Navrangpura, Ahmedabad', '1991-03-25', CURRENT_TIMESTAMP),
(7, 'Suresh', 'Patel', 'suresh@gmail.com', '9876543216', '112 Aundh, Pune', '1987-12-05', CURRENT_TIMESTAMP),
(8, 'Meena', 'Chopra', 'meena@gmail.com', '9876543217', '34 Civil Lines, Jaipur', '1993-08-14', CURRENT_TIMESTAMP);

INSERT INTO Flights VALUES
(1, 'AI100', 'Delhi', 'Mumbai', '2023-12-01 08:00:00', '2023-12-01 10:00:00', 200, 5000.00),
(2, 'AI200', 'Mumbai', 'Chennai', '2023-12-02 09:00:00', '2023-12-02 11:30:00', 150, 4500.00),
(3, 'SG101', 'Bangalore', 'Hyderabad', '2023-12-03 10:00:00', '2023-12-03 11:30:00', 180, 4000.00),
(4, '6E300', 'Kolkata', 'Delhi', '2023-12-04 07:00:00', '2023-12-04 09:30:00', 220, 4800.00),
(5, 'G840', 'Ahmedabad', 'Pune', '2023-12-05 14:00:00', '2023-12-05 16:00:00', 170, 3500.00);

INSERT INTO Bookings VALUES
(1, 1, 1, '1A', CURRENT_TIMESTAMP, 'Confirmed'),
(2, 2, 1, '1B', CURRENT_TIMESTAMP, 'Confirmed'),
(3, 3, 2, '2A', CURRENT_TIMESTAMP, 'Confirmed'),
(4, 4, 3, '3B', CURRENT_TIMESTAMP, 'Confirmed'),
(5, 5, 4, '4C', CURRENT_TIMESTAMP, 'Confirmed'),
(6, 6, 5, '5A', CURRENT_TIMESTAMP, 'Confirmed'),
(7, 7, 1, '1C', CURRENT_TIMESTAMP, 'Cancelled'),
(8, 8, 2, '2B', CURRENT_TIMESTAMP, 'Confirmed');

INSERT INTO Payments VALUES
(1, 1, 5000.00, CURRENT_TIMESTAMP, 'Credit Card', 'Success'),
(2, 2, 5000.00, CURRENT_TIMESTAMP, 'Debit Card', 'Success'),
(3, 3, 4500.00, CURRENT_TIMESTAMP, 'Net Banking', 'Success'),
(4, 4, 4000.00, CURRENT_TIMESTAMP, 'UPI', 'Success'),
(5, 5, 4800.00, CURRENT_TIMESTAMP, 'Credit Card', 'Success'),
(6, 6, 3500.00, CURRENT_TIMESTAMP, 'Debit Card', 'Success'),
(7, 7, 5000.00, CURRENT_TIMESTAMP, 'Credit Card', 'Failed'),
(8, 8, 4500.00, CURRENT_TIMESTAMP, 'UPI', 'Success');
