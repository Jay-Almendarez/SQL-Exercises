USE employees;

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
/* Write a query that returns all employees, their department number, their start date, 
their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
DO NOT WORRY ABOUT DUPLICATE EMPLOYEES. */
SELECT CONCAT(first_name, ' ', last_name) 'Full Name', dept_no, from_date start_date, to_date,
IF (to_date > CURDATE(), 1, 0) is_current_employee
FROM employees
JOIN dept_emp AS d_emp
USING (emp_no); 
-- Solution: 

/* Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. */
SELECT CONCAT(first_name, ' ', last_name) 'Full Name', 
CASE 
WHEN SUBSTR(last_name, 1) < 'I' THEN 'A-H'
WHEN SUBSTR(last_name, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
WHEN SUBSTR(last_name, 1) > 'Q' THEN 'R-Z'
END as alpha_group
FROM employees;
-- Solution: 

-- How many employees (current or previous) were born in each decade?
SELECT birth_date FROM employees;
SELECT COUNT(birth_date) AS '# of Employees',
CASE 
WHEN SUBSTR(birth_date, 1,4) BETWEEN '1950' AND '1959' THEN "50's"
WHEN SUBSTR(birth_date, 1,4) BETWEEN '1960' AND '1969' THEN "60's"
WHEN SUBSTR(birth_date, 1,4) BETWEEN '1970' AND '1979' THEN "70's"
WHEN SUBSTR(birth_date, 1,4) BETWEEN '1980' AND '1989' THEN "80's"
WHEN SUBSTR(birth_date, 1,4) BETWEEN '1990' AND '1999' THEN "90's"
ELSE birth_date
END as decades
FROM employees
GROUP BY decades
ORDER BY decades ASC;
-- Solution: 

-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
     SELECT ROUND(AVG(salary),2) AS 'Average Salary',
    CASE
WHEN dept_name IN ('research', 'development') THEN 'R&D'
WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
ELSE 'Customer Service'
END as dept_group
FROM employees e
		JOIN salaries sls
		ON sls.emp_no = e.emp_no
        JOIN dept_emp d_emp
        ON e.emp_no = d_emp.emp_no 
        JOIN departments d
        ON d.dept_no = d_emp.dept_no        
WHERE sls.to_date > CURDATE() AND d_emp.to_date > CURDATE()
GROUP BY dept_group
ORDER BY 'Average Salary';
-- Solution: 