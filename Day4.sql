/*
	Day 4
	Oct. 20, 2024
*/

USE SQLChallenge;

CREATE TABLE Orders_Info(
  	category VARCHAR(20),
	product VARCHAR(20),
	user_id INT , 
  	spend INT,
  	transaction_date DATE
);

INSERT INTO Orders_Info VALUES
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');

/*

Question: Find the top 2 products in the top 2 categories based on spend amount?

*/

SELECT * FROM Orders_Info;

-- Top 2 category based on spend
WITH cte AS(
	SELECT 
		category,
		SUM(spend) AS total_spend_cat,
		DENSE_RANK() OVER(ORDER BY SUM(spend) DESC) AS cat_rank
	FROM Orders_Info
	GROUP BY category
)

-- Top 2 products in the Top 2 category
SELECT
	*
FROM (
	SELECT 
		o.category,
		o.product,
		SUM(o.spend) AS total_spend,
		DENSE_RANK() OVER(PARTITION BY o.category ORDER BY SUM(o.spend) DESC) AS product_rank_per_category
	FROM Orders_Info AS o
	JOIN cte AS c
		ON o.category = c.category
	WHERE cat_rank <= 2
	GROUP BY o.category, o.product
) AS subquery
WHERE product_rank_per_category <= 2
ORDER BY total_spend DESC;

/*

Question: Get the details of the employee with the second-highest salary from each department

*/
-- Creating Table 
CREATE TABLE Employee(
	employee_id INT IDENTITY(1,1)  PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(50),
	salary DECIMAL (10, 2)
);

INSERT INTO Employee (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);

-- 2nd highest salary per department
SELECT * FROM Employee;

SELECT 
	*
FROM (
	SELECT 
		*,
		DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS salary_rank
	FROM Employee
) AS subquery
WHERE salary_rank = 2 
ORDER BY salary DESC;