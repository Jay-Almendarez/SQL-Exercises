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