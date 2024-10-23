/*
	Day 7
	Oct. 23, 2024
	
*/
USE SQLChallenge;

-- Create the employee_salary table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert all records again to simulate duplicates
INSERT INTO employees(emp_id, name, department, salary) VALUES
(1, 'John Doe', 'Finance', 60000.00),
(2, 'Jane Smith', 'Finance', 65000.00), 
(2, 'Jane Smith', 'Finance', 65000.00),   -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Duplicate
(10, 'Kevin Martinez', 'Sales', 61000.00);


/*

Question: How would you identify duplicate entries in a SQL in given table employees columns are emp_id, name, department, salary

*/
-- Approach 1 using GROUP BY
SELECT
	name,
	COUNT(emp_id) AS No_duplicate_record
FROM employees
GROUP BY emp_id, name
HAVING COUNT(emp_id) > 1;

-- Approach 2 using Subquery
SELECT *
FROM (	
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY name ORDER BY name) as rank
	FROM employees
) as subquery
WHERE rank > 1

-- Approach 3 using CTE
WITH cte AS(	
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY name ORDER BY name) as rank
	FROM employees
)

SELECT *
FROM cte
WHERE rank > 1;

/*
Question: Identify employee details who is appearing more than twice in the table employees
*/

-- Approach 1 using GROUP BY
SELECT 
	emp_id,
	name,
	COUNT(emp_id) AS No_of_duplicate
FROM employees
GROUP BY emp_id, name
HAVING COUNT(emp_id) > 2

-- Approach 2 using SUBQUERY 

SELECT *
FROM (
	SELECT
		*, 
		ROW_NUMBER() OVER(PARTITION BY name ORDER BY name) AS rank
	FROM employees
) AS Subquery
WHERE rank > 2

-- Approach 3 using CTE
WITH cte AS(	
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY name ORDER BY name) as rank
	FROM employees
)

SELECT *
FROM cte
WHERE rank > 2;

