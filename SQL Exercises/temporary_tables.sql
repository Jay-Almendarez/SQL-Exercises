DESCRIBE departments;
-- dept_no (PK), dept_name (UNI)
DESCRIBE dept_emp;
-- emp_no (PK), dept_no (PK), from_date, to_date
DESCRIBE dept_manager;
-- emp_no (PK), dept_no (PK), from_date, to_date
DESCRIBE employees;
-- emp_no (PK), birth_date, first_name, last_name, gender, hire_date
DESCRIBE salaries;
-- emp_no (PK), salary, from_date (PK), to_date
DESCRIBE titles;
SHOW DATABASES;
USE robinson_2281;
/* 
1. Using the example from the lesson, create a temporary table called employees_with_departments that contains 
first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read. */
CREATE TEMPORARY TABLE robinson_2281.employees_with_departments
AS (
	SELECT first_name, last_name, dept_name
	FROM employees.employees e
	JOIN employees.dept_emp d_emp
	USING (emp_no)
	JOIN employees.departments d
	USING (dept_no)
	WHERE d_emp.to_date > NOW()
	);
    
DESCRIBE employees_with_departments;
SELECT * FROM employees_with_departments;
-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE employees_with_departments
ADD full_name VARCHAR(30);
SELECT * FROM employees_with_departments;
-- Solution: 

-- b. Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM employees_with_departments;
-- Solution: 
-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments
DROP first_name;
ALTER TABLE employees_with_departments
DROP last_name;
SELECT * FROM employees_with_departments;
-- Solution: 
-- d. What is another way you could have ended up with this same table?
/* Solution: 
CREATE TEMPORARY TABLE robinson_2281.employees_with_departments
AS (
	SELECT CONCAT(first_name, ' ', last_name), dept_name
	FROM employees e
	JOIN dept_emp d_emp
	USING (emp_no)
	JOIN departments d
	USING (dept_no)
	WHERE d_emp.to_date > NOW()
	); */

/* 2. Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
For example, 1.99 should become 199. */
USE sakila;
SHOW TABLES;
SELECT * FROM payment;
SELECT * FROM customer;
SELECT * FROM rental;
CREATE TEMPORARY TABLE robinson_2281.sak_pay
AS (SELECT * FROM sakila.payment);
USE robinson_2281;
SELECT * FROM sak_pay;
DESCRIBE sak_pay;
ALTER TABLE sak_pay
MODIFY amount decimal(6,2);
UPDATE sak_pay
SET amount = ROUND(amount * 100);
ALTER TABLE sak_pay
MODIFY amount int;
SELECT * FROM sak_pay;

-- Solution: 


/*
3. Go back to the employees database. Find out how the current average pay in each department compares 
to the overall current pay for everyone at the company. 
For this comparison, you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst? */
-- (departments average salary - overall average salary) / stdev of all salaries

USE employees;
CREATE TEMPORARY TABLE robinson_2281.dept_avgs (
SELECT dept_name, AVG(salary) AS dept_avg
FROM employees.departments d
JOIN employees.dept_emp d_emp
USING(dept_no)
JOIN employees.salaries sls
USING(emp_no)
WHERE d_emp.to_date > NOW()
AND sls.to_date > NOW()
GROUP BY dept_name
);

CREATE TEMPORARY TABLE robinson_2281.metrics (
SELECT AVG(salary) AS overall,
STDDEV(salary) AS stdv
FROM employees.salaries s
WHERE to_date > NOW()
);

USE robinson_2281;
SELECT * FROM dept_avgs;

ALTER TABLE dept_avgs
ADD overall_avg FLOAT;

ALTER TABLE dept_avgs
ADD overall_std FLOAT;

ALTER TABLE dept_avgs
ADD zscore FLOAT;

UPDATE dept_avgs
SET overall_avg =
(
SELECT overall FROM metrics
);

SELECT * FROM dept_avgs;

UPDATE dept_avgs
SET overall_std =
(
SELECT stdv FROM metrics);

UPDATE dept_avgs
SET zscore = (dept_avg - overall_avg) / overall_std;

SELECT dept_name, zscore
FROM dept_avgs
ORDER BY zscore DESC;
