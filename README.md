# ✈️ Airline Reservation System (SQL Project)

This project implements a complete Airline Reservation System database using MySQL. It covers all key components of an airline system — including passengers, flights, bookings, and payments — with realistic logic and optimized querying support.

---

## 📁 File Structure

- **DATABASE_AND_TABLE_CREATION.SQL**  
  Defines all core tables with relationships, constraints, and data types.

- **INSERT_DATA.SQL**  
  Inserts sample entries into each table for testing and demonstration.

- **INDEX_TRIGGERS_PROCEDURES_TRANSACTION.SQL**  
  Adds indexes for faster queries, a trigger to prevent double booking,  
  stored procedures for flight revenue and booking transaction logic.

- **Queries.sql**  
  Contains SQL queries which includes filtering, aggregation, joins, subqueries, and trend analysis.

---

## 🧱 Schema Overview

| Table       | Description                                      |
|-------------|--------------------------------------------------|
| `Passengers`| Stores passenger information                     |
| `Flights`   | Holds flight details like source, destination, price |
| `Bookings`  | Records each passenger’s seat and booking status |
| `Payments`  | Tracks payment method, status, and amount        |

---

## 🔗 Relationships

- One **Passenger** can have multiple **Bookings**  
- One **Flight** can be booked by many **Passengers**  
- Each **Booking** has a related **Payment**

---

## 🔍 Query Highlights

- Upcoming and overbooked flights  
- Passengers who booked using specific methods (e.g. UPI)  
- Most common destinations and routes  
- Revenue tracking per destination, per route  
- Booking trends, waitlist upgrades, and cancellation losses  
- Occupancy analytics and multi-booking detection

All queries are organized and commented in `Queries.sql`.

---
