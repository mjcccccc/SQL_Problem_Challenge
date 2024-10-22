/*
	Day 6
	Oct. 22, 2024

*/

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT ,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);


-- Inserting sample customers
INSERT INTO customers (customer_id, name, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Sam B', 'sb@example.com'),
(5, 'John Smith', 'j@example.com')	
;

-- Inserting sample orders
INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(1, 1, '2024-03-05', 50.00), 
(2, 2, '2024-03-10', 75.00), 
(5, 4, '2024-04-02', 45.00), 
(5, 2, '2024-04-02', 45.00),
(3, 4, '2024-04-15', 100.00), 
(4, 1, '2024-04-01', 60.00), 
(5, 5, '2024-04-02', 45.00); 

SELECT * FROM customers;
SELECT * FROM orders;

/*

Question: Write an SQL query to find customers who haven't made any purchases in the last month, assuming today's date is April 2, 2024. 

*/
SELECT 
	*
FROM customers
WHERE customer_id NOT IN (
							SELECT customer_id FROM orders
							WHERE MONTH(order_date) = MONTH('2024-04-02') - 1 AND
							YEAR(order_date) = YEAR('2024-04-02')
)

/*

Question: Your task Find customer who has done purchase this month and also last month

*/

SELECT 
	* 
FROM customers 
WHERE customer_id IN( -- Subquery to find customers who made a purchase in the previous month
						SELECT customer_id
						FROM orders
						WHERE MONTH(order_date) = MONTH('2024-04-02') -1
						AND YEAR(order_date) = YEAR('2024-04-02')
) AND customer_id IN( -- Subquery to find customers who made a purchase in the current month
						SELECT customer_id
						FROM orders
						WHERE MONTH(order_date) = MONTH('2024-04-02')
						AND YEAR(order_date) = YEAR('2024-04-02')
)