USE employees;
SELECT * FROM employees;
DESCRIBE employees;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya'
-- using IN. What is the employee number of the top three results? 
SELECT emp_no FROM employees where first_name IN ('Irena', 'Vidya', 'Maya');
-- results 10200, 10397, 10610

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- as in Q2, but use OR instead of IN. What is the employee number of the top three results? 
-- Does it match the previous question?
SELECT emp_no FROM employees where first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya';
-- results 10397, 10610, 10821. We got different results

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- using OR, and who is male. What is the employee number of the top three results.
SELECT emp_no, gender FROM employees where gender = 'M' 
AND first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya';
-- results 10200, 10397, 10821

-- Find all unique last names that start with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%';

-- Find all unique last names that start or end with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%'
OR last_name Like '%E';

-- Find all unique last names that end with E, but does not start with E?
SELECT DISTINCT last_name from employees WHERE last_name LIKE '%E' 
AND last_name NOT LIKE 'E%';

-- Find all unique last names that start and end with 'E'.
SELECT DISTINCT last_name from employees WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E';

-- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
SELECT * FROM employees;
SELECT emp_no, hire_date FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- results 10008, 10011, 10012

-- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT emp_no, hire_date FROM employees WHERE hire_date LIKE '%-12-25';
-- results 10050, 10456, 10463

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
SELECT emp_no, hire_date FROM employees WHERE hire_date LIKE '%-12-25' 
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- results 10050, 10517, 13922

-- Find all unique last names that have a 'q' in their last name.
SELECT * FROM employees;
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%';
-- Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

SELECT * FROM employees;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
-- order your results returned by first name. In your comments, answer: 
-- What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name FROM employees WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya'
ORDER BY first_name ASC;
-- results Irena Reutenauer, Vidya Simmen


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
-- order your results returned by first name and then last name. In your comments, answer: 
-- What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name FROM employees WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya'
ORDER BY first_name ASC, last_name ASC;
-- results Irena Acton, Vidya Zweizig

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
-- order your results returned by last name and then first name. In your comments, answer: 
-- What was the first and last name in the first row of the results?  
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name FROM employees WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
ORDER BY last_name ASC, first_name ASC;
-- results Irena Acton, Maya Zyda

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. Enter a comment with the number of employees 
-- returned, the first employee number and their first and last name, and the last employee 
-- number with their first and last name.
SELECT * FROM employees;
SELECT emp_no, first_name, last_name 
FROM employees 
WHERE last_name 
LIKE 'E%E'
ORDER BY emp_no ASC;
-- results total retured rows 899, 10021 Ramzi Erde, 499648 Tadahiro Erde

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, 
-- and the name of the oldest employee.
SELECT * FROM employees;
SELECT emp_no, first_name, last_name, hire_date 
FROM employees 
WHERE last_name
LIKE 'E%E'
ORDER BY hire_date ASC;
-- results total returned rows 899, newest employee Teiji Eldridge (11-27-1999) 
-- oldest employee Sergi Erde (02-02-1985), 

-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee 
-- who was hired last, and the name of the youngest employee who was hired first.
SELECT * FROM employees;
SELECT first_name, last_name, hire_date, birth_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;
-- results 362 rows returned, Oldest employee hired most recently is 
-- Khun Bernini (hired 08-31-1999, born 12-25-1952), 
-- the youngest employee hired the least recently is 
-- Douadi Pettis (hired 05-04-1990, born 12-25-1964)