-- 01. Get all upcoming flights.
SELECT flight_id , flight_number , source , destination , arrival_time , departure_time 
FROM Flights
WHERE departure_time > NOW() ;

-- 02. Get all passengers who made payments made using UPI.
SELECT p.passenger_id , concat(p.first_name ," ", p.last_name ) as name ,p.phone , b.booking_id
FROM Payments pm JOIN Bookings b ON pm.booking_id = b.booking_id JOIN Passengers p ON p.passenger_id = b.passenger_id 
WHERE payment_method = 'UPI' ;

-- 03. Get most common destination across all bookings.
SELECT  f.destination, COUNT(*) AS booking_count
FROM Bookings b JOIN Flights f ON b.flight_id = f.flight_id
GROUP BY f.destination
ORDER BY booking_count DESC
LIMIT 1;

-- 04. Get the flight with most confirmed bookings.
SELECT f.flight_id, f.flight_number, COUNT(b.booking_id) AS confirmed_count
FROM Flights f JOIN Bookings b ON f.flight_id = b.flight_id
WHERE b.status = 'Confirmed'
GROUP BY f.flight_id
ORDER BY confirmed_count DESC
LIMIT 1;

-- 05. Get average ticket price per route (source-destination).
SELECT source , destination , ROUND(AVG(ticket_price),2) AS avg_ticket_price 
FROM Flights
GROUP BY source,destination ;

-- 06. Count total bookings by status (Confirmed, Cancelled, Waiting).
SELECT f.flight_id , b.status , COUNT(*) as count_by_status
FROM Flights f natural join bookings b 
GROUP BY f.flight_id , b.status ;

-- 07. Get passengers who booked more than 2 flights in last 3 months.
SELECT p.passenger_id , concat(p.first_name ," ", p.last_name ) as name , COUNT(b.booking_id) as total_bookings 
FROM Passengers p JOIN Bookings b ON p.passenger_id = b.passenger_id 
WHERE b.booking_date >= DATE_SUB(CURDATE() , INTERVAL 3 MONTH ) AND b.status = 'Confirmed'
GROUP BY p.passenger_id
HAVING total_bookings > 2 ;

-- 08. List passengers who have both Confirmed and Waiting bookings.
SELECT p.passenger_id , concat(p.first_name ," ", p.last_name ) as name , SUM(b.status = 'Confirmed') AS confirmed_bookings , SUM(b.status = 'Waiting') AS waiting_bookings  
FROM Passengers p JOIN Bookings b ON p.passenger_id = b.passenger_id 
GROUP BY p.passenger_id 
HAVING confirmed_bookings >= 1 AND waiting_bookings >= 1 ;

-- 09. List flights with occupancy > 90%.
SELECT f.flight_id , f.flight_number , f.source , f.destination , f.total_seats , COUNT(b.booking_id) AS confirmed_bookings , ROUND((COUNT(b.booking_id) / f.total_seats) * 100, 2) AS occupancy_percentage
FROM Flights f JOIN Bookings b ON f.flight_id = b.flight_id
WHERE b.status = 'Confirmed'
GROUP BY f.flight_id
HAVING occupancy_percentage > 90;

-- 10. List passengers who booked but didn’t pay successfully.
SELECT DISTINCT p.passenger_id , concat(p.first_name ," ", p.last_name ) as name , b.status AS booking_status , pm.status AS payment_status
FROM Passengers p JOIN Bookings b ON p.passenger_id = b.passenger_id JOIN Payments pm ON pm.booking_id = b.booking_id 
WHERE pm.status != 'Success' AND b.status = 'Confirmed';

-- 11. List passengers who were waitlisted but later got confirmed.
SELECT DISTINCT  p.passenger_id , CONCAT(p.first_name, ' ', p.last_name) AS name
FROM Passengers p JOIN Bookings b1 ON p.passenger_id = b1.passenger_id AND b1.status = 'Waiting' JOIN Bookings b2 ON p.passenger_id = b2.passenger_id AND b2.status = 'Confirmed'
WHERE b1.flight_id = b2.flight_id;

-- 12. Find total revenue per destination city.
SELECT f.destination , SUM(p.amount) AS total_revenue
FROM Payments p JOIN Bookings b ON p.booking_id = b.booking_id AND p.status = 'Success' JOIN Flights f ON b.flight_id = f.flight_id
GROUP BY f.destination;

-- 13. Get  revenue trends per city pair (Source → Destination).
SELECT f.source , f.destination , MONTH(p.payment_date) AS month , YEAR(p.payment_date) AS year , SUM(p.amount) AS monthly_revenue
FROM Payments p JOIN Bookings b ON p.booking_id = b.booking_id AND p.status = 'Success' JOIN Flights f ON b.flight_id = f.flight_id
GROUP BY f.source, f.destination, year, month
ORDER BY year DESC, month DESC;

-- 14. Find revenue loss due to cancellations.
SELECT  SUM(p.amount) AS lost_revenue
FROM Payments p JOIN Bookings b ON p.booking_id = b.booking_id
WHERE b.status = 'Cancelled' AND p.status = 'Success';

-- 15. Find the revenue for flight with id = 1 .
CALL CalculateFlightRevenue(1);

-- 16. Initialize the transaction for booking a seat.
CALL BookFlight(12, 1, 'A18', 5000.00, 'UPI');
