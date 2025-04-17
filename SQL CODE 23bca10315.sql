create database airline;
use airline;


-- Table: User
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15)
);

-- Table: Passenger (inherits from User)
CREATE TABLE Passenger (
    UserID INT PRIMARY KEY,
    PassportNumber VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Table: Admin (inherits from User)
CREATE TABLE Admin (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(100),
    Role VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Table: Flight
CREATE TABLE Flight (
    FlightID INT PRIMARY KEY,
    AirlineName VARCHAR(100),
    Source VARCHAR(100),
    Destination VARCHAR(100),
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    TotalSeats INT
);

-- Table: Booking
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    PassengerID INT,
    FlightID INT,
    BookingDate DATE,
    SeatNumber VARCHAR(10),
    Status VARCHAR(20),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(UserID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Table: Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMode VARCHAR(50),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);
INSERT INTO User (UserID, Name, Email, PhoneNumber)
VALUES
(1, 'Alice Sharma', 'alice@example.com', '9876543210'),
(2, 'Raj Verma', 'raj@example.com', '9123456789');
INSERT INTO Passenger (UserID, PassportNumber)
VALUES
(1, 'P12345678'),
(2, 'P87654321');
INSERT INTO Admin (UserID, Username, Password, Role)
VALUES
(3, 'admin01', 'admin@123', 'Manager');

INSERT INTO Flight (FlightID, AirlineName, Source, Destination, DepartureTime, ArrivalTime, TotalSeats)
VALUES
(101, 'IndiGo', 'Delhi', 'Mumbai', '2025-05-10 10:00:00', '2025-05-10 12:00:00', 180),
(102, 'Air India', 'Chennai', 'Kolkata', '2025-05-12 15:00:00', '2025-05-12 18:00:00', 160);

INSERT INTO Booking (BookingID, PassengerID, FlightID, BookingDate, SeatNumber, Status)
VALUES
(501, 1, 101, '2025-04-10', '12A', 'Confirmed'),
(502, 2, 102, '2025-04-11', '16B', 'Confirmed');

INSERT INTO Payment (PaymentID, BookingID, PaymentDate, Amount, PaymentMode)
VALUES
(901, 501, '2025-04-10', 4500.00, 'UPI'),
(902, 502, '2025-04-11', 5200.00, 'Card');

SELECT * FROM Passenger
JOIN User ON Passenger.UserID = User.UserID;

SELECT U.Name, F.AirlineName, F.Source, F.Destination, B.SeatNumber, B.Status
FROM Booking B
JOIN Passenger P ON B.PassengerID = P.UserID
JOIN User U ON P.UserID = U.UserID
JOIN Flight F ON B.FlightID = F.FlightID;

SELECT U.Name, P.PaymentDate, P.Amount, P.PaymentMode
FROM Payment P
JOIN Booking B ON P.BookingID = B.BookingID
JOIN Passenger Pa ON B.PassengerID = Pa.UserID
JOIN User U ON Pa.UserID = U.UserID;

SELECT * FROM FlightZ
WHERE Source = 'Delhi' AND Destination = 'Mumbai';

UPDATE User
SET PhoneNumber = '9988776655'
WHERE UserID = 1;

UPDATE Booking
SET Status = 'Cancelled'
WHERE BookingID = 501;

UPDATE Flight
SET DepartureTime = '2025-05-10 11:00:00'
WHERE FlightID = 101;

UPDATE Admin
SET Password = 'newSecurePassword123'
WHERE UserID = 3;

UPDATE Payment
SET PaymentMode = 'Credit Card'
WHERE PaymentID = 901;
--
DELETE FROM Payment
WHERE PaymentID = 901;

DELETE FROM Booking
WHERE BookingID = 501;

DELETE FROM User
WHERE UserID = 1;

DELETE FROM Passenger
WHERE UserID = 1;
DELETE FROM Flight
WHERE FlightID = 101;





SELECT F.FlightID, F.DAirlineName, COUNT(B.BookingID) AS BookingCount
FROM Flight F
LEFT JOIN Booking B ON F.FlightID = B.FlightID
GROUP BY F.FlightID, F.AirlineName;

SELECT F.FlightID, F.AirlineName, SUM(P.Amount) AS TotalPayments
FROM Flight F
JOIN Booking B ON F.FlightID = B.FlightID
JOIN Payment P ON B.BookingID = P.BookingID
GROUP BY F.FlightID, F.AirlineName;

SELECT F.FlightID, F.AirlineName, F.Source, F.Destination
FROM Flight F
LEFT JOIN Booking B ON F.FlightID = B.FlightID
WHERE B.BookingID IS NULL;

SELECT U.UserID, U.Name, U.Email, 
       (SELECT COUNT(*) FROM Booking WHERE PassengerID = U.UserID) AS TotalBookings
FROM User U
JOIN Passenger P ON U.UserID = P.UserID;


