# sql-project
# ✈️ Airline Reservation System Database Project

## 📘 Overview

This project is a relational **Airline Reservation System Database** that demonstrates the modeling, creation, manipulation, and querying of data related to users, passengers, flights, bookings, payments, and administrators.

Built using **SQL**, this system showcases the essential backend functionality required in an airline booking and management system.

---

## 🧱 Database Structure

### ✅ Tables Created

- **User**: Stores user details like name, email, and phone number.
- **Passenger**: Inherits from `User` and includes passport details.
- **Admin**: Inherits from `User` and includes credentials and role.
- **Flight**: Stores details of flights, such as source, destination, and timings.
- **Booking**: Manages bookings for flights made by passengers.
- **Payment**: Tracks payment information for each booking.

---

## 🗃️ SQL Operations

### 🔨 Table Creation

The schema uses **primary and foreign keys** to maintain referential integrity. Tables for `Passenger` and `Admin` inherit from the `User` table using foreign keys.

### 📥 Data Insertion

Sample data has been inserted into all tables to simulate real-world scenarios, including users, flights, bookings, and payments.

### 🔍 Sample Queries

- **Join queries** to fetch detailed booking and payment reports.
- **Group By** to summarize bookings and revenue per flight.
- **Subqueries** to get passenger-wise booking counts.
- **Update** statements to modify phone numbers, statuses, and flight details.
- **Delete** operations for cleaning data.
- **Error-handling**: Includes an incorrect query on a non-existent table `FlightZ` to simulate debugging.

---

## 🔎 Notable Query Examples

```sql
-- Join Passenger with User
SELECT * FROM Passenger
JOIN User ON Passenger.UserID = User.UserID;

-- Booking and Flight Info by Passenger
SELECT U.Name, F.AirlineName, F.Source, F.Destination, B.SeatNumber, B.Status
FROM Booking B
JOIN Passenger P ON B.PassengerID = P.UserID
JOIN User U ON P.UserID = U.UserID
JOIN Flight F ON B.FlightID = F.FlightID;

-- Payments by Passenger
SELECT U.Name, P.PaymentDate, P.Amount, P.PaymentMode
FROM Payment P
JOIN Booking B ON P.BookingID = B.BookingID
JOIN Passenger Pa ON B.PassengerID = Pa.UserID
JOIN User U ON Pa.UserID = U.UserID;

-- Flights with No Bookings
SELECT F.FlightID, F.AirlineName, F.Source, F.Destination
FROM Flight F
LEFT JOIN Booking B ON F.FlightID = B.FlightID
WHERE B.BookingID IS NULL;

Airline-Reservation-System/
│
├── create_airline.sql         # All table definitions
├── insert_data.sql            # Insert statements for sample data
├── queries.sql                # All select, update, delete queries
├── README.md                  # This readme file
└── airline_db_report.docx     # Project documentation (optional)
