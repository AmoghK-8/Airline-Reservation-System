USE AirlineReservationSystem ;

-- Index Creation

CREATE INDEX idx_flight_source ON Flights(source);
CREATE INDEX idx_flight_destination ON Flights(destination);
CREATE INDEX idx_booking_status ON Bookings(status); 

-- Cearting Trigger to prevent double booking : 

DELIMITER //
CREATE TRIGGER prevent_double_booking
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
    DECLARE seat_count INT;
    
    SELECT COUNT(*) INTO seat_count
    FROM Bookings
    WHERE flight_id = NEW.flight_id 
    AND seat_number = NEW.seat_number
    AND status = 'Confirmed';
    
    IF seat_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seat already booked for this flight';
    END IF;
END //
DELIMITER ;

-- Creating procedure for revenue calculation per flight : 

DELIMITER //
CREATE PROCEDURE CalculateFlightRevenue(IN flight_id_param INT)
BEGIN
    SELECT 
        f.flight_number,
        f.source,
        f.destination,
        f.departure_time,
        COUNT(b.booking_id) AS total_bookings,
        COALESCE(SUM(p.amount), 0) AS revenue
    FROM Flights f
    LEFT JOIN Bookings b ON f.flight_id = b.flight_id AND b.status = 'Confirmed'
    LEFT JOIN Payments p ON b.booking_id = p.booking_id AND p.status = 'Success'
    WHERE f.flight_id = flight_id_param
    GROUP BY f.flight_id, f.flight_number, f.source, f.destination, f.departure_time;
END //
DELIMITER ;

-- Transaction :

DELIMITER //

CREATE PROCEDURE BookFlight(
    IN p_passenger_id INT,
    IN p_flight_id INT,
    IN p_seat_number VARCHAR(5),
    IN p_amount DECIMAL(10,2),
    IN p_payment_method VARCHAR(20)
)
BEGIN
    DECLARE new_booking_id INT;
    DECLARE new_payment_id INT;

    START TRANSACTION;

    -- Generate new booking ID
    SELECT COALESCE(MAX(booking_id), 0) + 1 INTO new_booking_id FROM Bookings;

    INSERT INTO Bookings (booking_id, passenger_id, flight_id, seat_number)
    VALUES (new_booking_id, p_passenger_id, p_flight_id, p_seat_number);

    -- Generate new payment ID separately
    SELECT COALESCE(MAX(payment_id), 0) + 1 INTO new_payment_id FROM Payments;

    INSERT INTO Payments (payment_id, booking_id, amount, payment_method, status)
    VALUES (new_payment_id, new_booking_id, p_amount, p_payment_method, 'Success');

    COMMIT;
END //

DELIMITER ;
