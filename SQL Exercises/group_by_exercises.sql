USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT * FROM titles;
SELECT DISTINCT title, count(*) as unique_titles
FROM titles
GROUP BY title;

SELECT COUNT(DISTINCT title) FROM titles;
-- There are 7 unique titles


-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
SELECT * FROM employees;
 
SELECT DISTINCT last_name, COUNT(last_name)
FROM employees
WHERE last_name 
LIKE 'E%E'
GROUP BY last_name;


-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT * FROM employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, COUNT(*)
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY full_name;


-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT DISTINCT last_name 
FROM employees 
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%';
-- Chleq, Lindqvist, Qiwen


-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
SELECT DISTINCT last_name, COUNT(*)
FROM employees 
WHERE last_name LIKE '%q%' 
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- 189 for Chleq, 190 for Lindqvist, and 168 for Qiwen


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
SELECT * FROM employees;
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
-- 441 Male, 268 Female


-- Using your query that generates a username for all employees, generate a count of employees with each unique username.
SELECT CONCAT(LOWER(SUBSTR(first_name, 1,1)), 
LOWER(SUBSTR(last_name, 1,4)), 
'_', 
SUBSTR(birth_date, 6,2), 
SUBSTR(birth_date, 3,2))
AS username, count(*) AS dup_count
FROM employees
GROUP BY username
ORDER BY dup_count DESC;


-- From your previous query, are there any duplicate usernames? 
-- What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
SELECT CONCAT(LOWER(SUBSTR(first_name, 1,1)), 
LOWER(SUBSTR(last_name, 1,4)), 
'_', 
SUBSTR(birth_date, 6,2), 
SUBSTR(birth_date, 3,2))
AS username, count(*) AS unique_username
FROM employees
GROUP BY username
HAVING unique_username > 1;
-- yes, 6 is the highest. A total of 13251 duplicates

-- BONUS
SELECT CONCAT(LOWER(SUBSTR(first_name, 1,1)), 
LOWER(SUBSTR(last_name, 1,4)), 
'_', 
SUBSTR(birth_date, 6,2), 
SUBSTR(birth_date, 3,2))
AS username, count(*) AS unique_username
FROM employees
GROUP BY username
HAVING unique_username > 1;