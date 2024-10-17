DROP DATABASE IF EXISTS SQLChallenge;
CREATE DATABASE SQLChallenge;
USE SQLChallenge;


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


-- Insert new record
INSERT INTO Employee (name, department, salary) VALUES 
('Kim Chui', 'Marketing', 63000),
('Mj Lasti', 'Sales', 63000);

/*

Write the SQL query to find the second highest salary

*/
-- Approach 1
SELECT * FROM Employee
ORDER BY salary DESC
OFFSET 1 ROWS -- OFFSET 1 ROWS will skip the 1st row
FETCH NEXT 1 ROWS ONLY; -- FETCH NEXT 1 ROWS ONLY will retrieve exactly one row after skipping the first (LIMIT in other RDBMS)


-- Added new records
INSERT INTO Employee (name, department, salary) VALUES 
('Kim Chui', 'Marketing', 63000),
('Mj Lasti', 'Sales', 63000);

-- Approach 2 (Window Function DENSE_RANK())
-- SUBQUERY VERSION
SELECT * 
FROM (
	SELECT 
		*,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
	FROM Employee
) AS Subquery
WHERE salary_rank = 2;

-- CTE VERSION
WITH Subquery AS(
	SELECT 
		*,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
	FROM Employee
)

SELECT * FROM Subquery
WHERE salary_rank = 2;

-- Task Question: Get the details of the employee with the second-highest salary from each department
-- SUBQUERY VERSION
SELECT *
FROM(
	SELECT 
		*,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank_per_department
	FROM Employee
) AS Subquery
WHERE salary_rank_per_department = 2;

-- CTE VERSION
WITH Subquery AS(
	SELECT 
		*,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank_per_department
	FROM Employee
) 

SELECT *
FROM Subquery
WHERE salary_rank_per_department = 2;