/*
	Day 5
	Oct. 21, 2024
*/
USE SQLChallenge;

-- Create the Employee table
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample records into the Employee table
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(101, 'John Smith', 'Sales', 60000.00, '2022-01-15'),
(102, 'Jane Doe', 'Marketing', 55000.00, '2022-02-20'),
(103, 'Michael Johnson', 'Finance', 70000.00, '2021-12-10'),
(104, 'Emily Brown', 'Sales', 62000.00, '2022-03-05'),
(106, 'Sam Brown', 'IT', 62000.00, '2022-03-05'),	
(105, 'Chris Wilson', 'Marketing', 58000.00, '2022-01-30');

/*

Question: Write a SQL query to retrieve the third highest salary from the Employee table.

*/

SELECT
	*
FROM(
	SELECT 
		*,
		DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
	FROM Employees
) AS subquery
WHERE salary_rank = 3;

/*

Question: Find the employee details who has highest salary from each department

*/
SELECT
	*
FROM(
	SELECT 
		*,
		DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS salary_rank
	FROM Employees
) AS subquery
WHERE salary_rank = 1
ORDER BY salary_rank DESC;