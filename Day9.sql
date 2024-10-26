/*
 Day 9
 Oct 26, 2024
*/

USE SQLChallenge;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(50)
);

-- Create Purchases table
DROP TABLE IF EXISTS Purchases;
CREATE TABLE Purchases (
    PurchaseID INT,
    CustomerID INT,
    ProductName VARCHAR(50),
    PurchaseDate DATE
);

-- Insert sample data into Customers table
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'John'),
(2, 'Emma'),
(3, 'Michael'),
(4, 'Ben'),
(5, 'John')	;

-- Insert sample data into Purchases table
INSERT INTO Purchases (PurchaseID, CustomerID, ProductName, PurchaseDate) VALUES
(100, 1, 'iPhone', '2024-01-01'),
(101, 1, 'MacBook', '2024-01-20'),	
(102, 1, 'Airpods', '2024-03-10'),
(103, 2, 'iPad', '2024-03-05'),
(104, 2, 'iPhone', '2024-03-15'),
(105, 3, 'MacBook', '2024-03-20'),
(106, 3, 'Airpods', '2024-03-25'),
(107, 4, 'iPhone', '2024-03-22'),	
(108, 4, 'Airpods', '2024-03-29'),
(110, 5, 'Airpods', '2024-02-29'),
(109, 5, 'iPhone', '2024-03-22');

/*
Apple data analyst interview question

Question: Given two tables - Customers and Purchases, 
	where Customers contains information about 
	customers and Purchases contains information 
	about their purchases, 

	write a SQL query to find customers who 
	bought Airpods after purchasing an iPhone.

*/
SELECT * FROM Customers
SELECT * FROM Purchases

SELECT c.*
FROM Customers AS c
JOIN Purchases AS p
	ON c.CustomerID = p.CustomerID
WHERE p.ProductName = 'iPhone';

SELECT c.*
FROM Customers AS c
JOIN Purchases AS p
	ON c.CustomerID = p.CustomerID
WHERE p.ProductName = 'Airpods';

SELECT c.*
FROM Customers AS c
JOIN Purchases AS p1
	ON c.CustomerID = p1.CustomerID
JOIN Purchases AS p2
	ON c.CustomerID = p2.CustomerID
WHERE p1.ProductName = 'iPhone'
	AND p2.ProductName = 'Airpods'
	AND p1.PurchaseDate < p2.PurchaseDate;


/*

Question: Find out what is the % of chance is there that the customer who bought MacBook will buy an Airpods

*/

SELECT 
	(COUNT(DISTINCT CASE WHEN p1.ProductName = 'MacBook' AND p2.ProductName = 'Airpods' THEN p1.CustomerID END)
    / COUNT(DISTINCT CASE WHEN p1.ProductName = 'MacBook' THEN p1.CustomerID END)) * 100.00 AS ProbabilityPercentage
FROM Purchases p1
JOIN Purchases p2 
	ON p1.CustomerID = p2.CustomerID;

