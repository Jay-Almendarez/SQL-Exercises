SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Find all previous or current employees hired in the 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by sorting by hire date and 
-- limiting your results to the first 5 records. 
-- Write a comment in your code that lists the five names of the employees returned.
SELECT * FROM employees;
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND hire_date LIKE '%-12-25'
ORDER BY hire_date DESC
Limit 5;
-- Aamer Tsukuda, Tetsushi Ladret, Shen Gecsei, Vidya Vanscheik, Angel Ellozy


-- Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. 
-- The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND hire_date LIKE '%-12-25'
ORDER BY hire_date DESC
Limit 50;
-- Miyeon Poujol, Yagil Mapelli, Hein Klassen, Lucian Menhoudj, Shooichi Servieres
-- LIMIT and OFFSET can be used to create multiple pages of data. 
-- What is the relationship between OFFSET (number of results to skip), 
-- LIMIT (number of results per page), and the page number?