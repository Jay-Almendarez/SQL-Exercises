SHOW TABLES;
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
-- emp_no (PK), title (PK), from_date (PK), to_date

-- Use the employees database.
USE employees;


-- Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.
SELECT dept.dept_name AS 'Department Name' , CONCAT(emp.first_name, ' ', emp.last_name) AS 'Department Manager'
FROM employees AS emp
JOIN dept_manager AS d_man
ON d_man.emp_no = emp.emp_no
JOIN departments AS dept
ON dept.dept_no = d_man.dept_no
WHERE to_date > CURDATE()
ORDER BY dept_name;
/* Solution:
Customer Service, Yuchang Weedman
Development, Leon DasSarma
Finance, Isamu Legleitner
Human Resources, Karsten Sigstam
Marketing, Vishwani Minakawa
Production, Oscar Ghazalie
Quality Management, Dung Pesch
Research, Hilary Kambil
Sales, Hauke Zhang
*/


-- Find the name of all departments currently managed by women.
SELECT dept.dept_name AS 'Department Name' , CONCAT(emp.first_name, ' ', emp.last_name) AS 'Department Manager'
FROM employees AS emp
JOIN dept_manager AS d_man
ON d_man.emp_no = emp.emp_no
JOIN departments AS dept
ON dept.dept_no = d_man.dept_no
WHERE to_date > CURDATE() AND gender LIKE 'F'
ORDER BY dept_name;
-- Solution:
-- Development, Leon DasSarma
-- Finance, Isamu Legleitner
-- Human Resources, Karsten Sigstam
-- Research, Hilary Kambil


-- Find the current titles of employees currently working in the Customer Service department.
SELECT title AS 'Title', COUNT(*)
FROM titles AS ts
LEFT JOIN employees AS e
ON ts.emp_no = e.emp_no
LEFT JOIN dept_emp AS d_emp
ON d_emp.emp_no = e.emp_no
LEFT JOIN departments AS d
ON d.dept_no = d_emp.dept_no
WHERE ts.to_date > CURDATE()
AND dept_name 
LIKE 'Customer Service'
GROUP BY title
ORDER BY title;
-- Solution:
-- Assistant Engineer, 68
-- Engineer, 627
-- Manager, 1
-- Senior Engineer, 1790
-- Senior Staff, 12349
-- Staff, 3902
-- Technique Leader, 241


-- Find the current salary of all current managers.
SELECT dept_name AS 'Department Name',CONCAT(first_name, ' ', last_name) AS 'Name', salary AS 'Salary' 
FROM salaries AS sals
JOIN dept_manager AS d_man
ON sals.emp_no = d_man.emp_no
JOIN employees AS e
ON e.emp_no = d_man.emp_no
JOIN departments AS d
ON d.dept_no = d_man.dept_no
WHERE d_man.to_date > CURDATE()
AND sals.to_date > CURDATE()
ORDER BY dept_name;
-- Solution: 
-- Customer Service, Yuchang Weedman, 58745
-- Development, Leon DasSarma, 74510 
-- Finance, Isamu Legleitner, 83457
-- Human Resources, Karsten Sigstam, 65400
-- Marketing, Vishwani Minakawa, 106491
-- Production, Oscar Ghazalie, 56654
-- Quality Management, Dung Pesch, 72876
-- Research, Hilary Kambil, 79393
-- Sales, Hauke Zhang, 101987


-- Find the number of current employees in each department.
SELECT d.dept_no, dept_name, COUNT(*) AS num_employees
FROM dept_emp AS d_emp
JOIN departments AS d
ON d_emp.dept_no = d.dept_no
WHERE d_emp.to_date > CURDATE()
GROUP BY d.dept_no
ORDER BY d.dept_no;
-- Solution: 
 -- d001, Marketing, 14842 
 -- d002, Finance, 12437
 -- d003, Human Resources, 12898 
 -- d004, Production, 53304
 -- d005, Development, 61386
-- d006, Quality Management, 14546
-- d007, Sales, 37701
-- d008, Research, 15441
-- d009, Customer Service, 17569


-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, ROUND(AVG(salary)) AS average_salary
FROM salaries AS sals
JOIN dept_emp AS d_emp
ON sals.emp_no = d_emp.emp_no
JOIN departments AS d
ON d.dept_no = d_emp.dept_no
JOIN dept_manager AS d_man
ON d_man.emp_no = d_emp.emp_no
WHERE d_emp.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;
-- Solution: 
-- Marketing, 88372


-- Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name, salary
FROM salaries AS sals
JOIN dept_emp AS d_emp
ON sals.emp_no = d_emp.emp_no
JOIN departments AS d
ON d.dept_no = d_emp.dept_no
JOIN employees AS e
ON e.emp_no = d_emp.emp_no
WHERE d_emp.to_date > CURDATE()
AND dept_name LIKE 'Marketing'
ORDER BY salary DESC
LIMIT 1;
-- Solution:
-- Akemi, Warwick, 145128


-- Which current department manager has the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM salaries AS sals
JOIN dept_emp AS d_emp
ON sals.emp_no = d_emp.emp_no
JOIN departments AS d
ON d.dept_no = d_emp.dept_no
JOIN dept_manager AS d_man
ON d_man.emp_no = d_emp.emp_no
JOIN employees AS e
ON e.emp_no = d_man.emp_no
WHERE d_man.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;
-- Solution 'Vishwani', 'Minakawa', '106491', 'Marketing'


-- Determine the average salary for each department. Use all salary information and round your results.
SELECT dept_name, ROUND(AVG(salary)) AS average_salary
FROM salaries AS sals
JOIN dept_emp AS d_emp
ON sals.emp_no = d_emp.emp_no
JOIN departments AS d
ON d.dept_no = d_emp.dept_no
GROUP BY dept_name
ORDER BY average_salary DESC;
-- Solution: 
-- Sales, 80668
-- Marketing, 71913
-- Finance, 70489
-- Research, 59665
-- Production, 59605
-- Development, 59479
-- Customer Service, 58770
-- Quality Management, 57251
-- Human Resources, 55575