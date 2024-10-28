/*
	Day 11
	Oct 29, 2024
*/

USE SQLChallenge;

-- Create the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id VARCHAR(10),
    customer_id VARCHAR(10),
    order_date DATE,
    product_id VARCHAR(10),
    quantity INT
);

-- Create the returns table
DROP TABLE IF EXISTS returns;
CREATE TABLE returns (
    return_id VARCHAR(10),
    order_id VARCHAR(10)
    );

-- Insert sample records into the orders table
INSERT INTO orders (order_id, customer_id, order_date, product_id, quantity)
VALUES
    ('1001', 'C001', '2023-01-15', 'P001', 4),
    ('1002', 'C001', '2023-02-20', 'P002', 3),
    ('1003', 'C002', '2023-03-10', 'P003', 8),
    ('1004', 'C003', '2023-04-05', 'P004', 2),
    ('1005', 'C004', '2023-05-20', 'P005', 3),
    ('1006', 'C002', '2023-06-15', 'P001', 6),
    ('1007', 'C003', '2023-07-20', 'P002', 1),
    ('1008', 'C004', '2023-08-10', 'P003', 2),
    ('1009', 'C005', '2023-09-05', 'P002', 3),
    ('1010', 'C001', '2023-10-20', 'P002', 1);

-- Insert sample records into the returns table
INSERT INTO returns (return_id, order_id)
VALUES
    ('R001', '1001'),
    ('R002', '1002'),
    ('R003', '1005'),
    ('R004', '1008'),
    ('R005', '1007');

/*

Question: Identify returning customers based on their order history. 
Categorize customers as "Returning" if they have placed more than one return, 
and as "New" otherwise. 

Considering you have two table orders has information about sale
and returns has information about returns 

*/
SELECT * FROM orders;
SELECT * FROM returns;

SELECT
	o.customer_id,
	COUNT(o.customer_id) AS total_order,
	COUNT(return_id) AS total_return,
	CASE 
		WHEN COUNT(return_id) > 1 THEN 'Returning'
		ELSE 'New'
	END AS customerCategory
FROM orders AS o
JOIN returns AS r
	ON o.order_id = r.order_id
GROUP BY o.customer_id;

/*
Question:
	Categorize products based on their quantity sold into three categories:

	"Low Demand": Quantity sold less than or equal to 5.
	"Medium Demand": Quantity sold between 6 and 10 (inclusive).
	"High Demand": Quantity sold greater than 10.
	Expected Output:

	Product ID
	Quantity Sold
	Demand Category
*/

SELECT 
	product_id,
	SUM(quantity) AS QuantitySold,
	CASE	
		WHEN SUM(quantity) > 10 THEN 'High Demand'
		WHEN SUM(quantity) BETWEEN 6 AND 10 THEN 'Medium Demand'
		ELSE 'Low Demand'
	END AS DemandCategory
FROM orders
GROUP BY product_id;
