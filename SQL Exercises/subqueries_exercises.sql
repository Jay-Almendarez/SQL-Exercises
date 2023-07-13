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


-- Find all the current employees with the same hire date as employee 101010 using a subquery.
SELECT CONCAT(first_name, ' ', last_name) FROM employees e
JOIN dept_emp d_emp
ON d_emp.emp_no = e.emp_no
AND d_emp.to_date > NOW()
WHERE hire_date = 
(
SELECT hire_date 
FROM employees
WHERE emp_no = 101010
);

SELECT first_name, last_name, hire_date
FROM employees
;
/* Solution: Employee 101010 is Demos, Christ, 1990-10-22
(55 Results)
Shigeo Kaiserswerth, Akemi Iwayama, Emran Laventhal, Wayne Schoegge, Zeljko Baik
Rimli Gulla, Eben Callaway, Yannis Kamble, Zhenhua Baja, Oksana Wendorf
Jouko Antonakopoulos, Claudi Talmor, Demos Christ, Golgen Gimarc, Jaber Ariola
Alassane Zastre ,Danil Axelband, Goncalo Brizzi, Adhemar Angiulli, Fan Rothenberg
Diederik Cyre, Tsvetan Farrel, Hsiangchu Ozeki, Yechiam Chinin, Deborah Senzako
Jacopo Joslin, Vitaly Jansch, Vesna Bolsens, Billur Kropf, Susanne Casley
Hidekazu Neimat, Kamakshi Peral, Yongmin Vural, Chuanyi Weisert, Paris Terkki
Yuqun Kaminger, Yakkov DuCasse, Ramalingam Swab, Martine Beerel, Behnaam Ginneken
Sugwoo Zeilberger, Neven Eickenmeyer, Ebbe Papsdorf, Terresa Strandh, Mihalis Gornas
Subhash Kitai, Sariel Kitsuregawa, Kwee Ghazalie, Annemarie Cronan, Irene Reinhart
Urs Spinelli, Subir Gihr, Hisao Stranks, Siddarth Eterovic, Wojceich Gimarc
*/

-- Find all the titles ever held by all current employees with the first name Aamod.
USE employees;

SELECT title AS 'Held Title', CONCAT(a.first_name, ' ', a.last_name) AS 'Name'
FROM 
(
	SELECT * 
	FROM employees e
	WHERE first_name = 'Aamod'
) AS a
JOIN titles
ON titles.emp_no = a.emp_no
WHERE to_date > CURDATE()
ORDER BY title;
-- Solution: Assistant Engineer, Engineer, Senior Engineer, Senior Staff, Staff, Technique Leader


-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
USE employees;
SELECT COUNT(*) AS '#No Longer Employed'
FROM
    (
        SELECT *
        FROM salaries s
        WHERE to_date < CURDATE()
    ) as g
JOIN dept_emp d_emp 
ON g.emp_no = d_emp.emp_no
LIMIT 10;
-- Solution: 2603923


-- Find all the current department managers that are female. List their names in a comment in your code.
SELECT dept_name 'Department', CONCAT(f.first_name, ' ', f.last_name) 'Current Dept. Managers'
FROM
    (
        SELECT *
        FROM employees e
        WHERE gender = 'F'
    ) as f
JOIN dept_manager d_man
ON f.emp_no = d_man.emp_no
JOIN departments d
ON d.dept_no = d_man.dept_no
WHERE to_date > CURDATE();
/* Solution: 
Finance, Isamu Legleitner
Human Resources, Karsten Sigstam
Development, Leon DasSarma
Research, Hilary Kambil */


-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT above_average.full_name 'Name', above_average.salary 'Salary'
FROM 
	(
	SELECT salary, CONCAT(first_name, ' ', last_name) AS full_name
		FROM salaries sls
		JOIN employees e
		ON sls.emp_no = e.emp_no
        AND to_date > CURDATE()
		WHERE salary > (SELECT AVG(salary) AS average_salary FROM salaries)
    ) 	AS above_average
    ORDER BY salary DESC;
-- Solution: 154543 results returned

/* How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) 
What percentage of all salaries is this? */
SELECT COUNT(d.within_one) AS 'Salaries Within 1 Standard Deviation'
FROM
(
	SELECT (MAX(salary) - std(salary)) AS within_one, salary
	FROM salaries
	WHERE to_date > CURDATE()
    GROUP BY salary
    ) d
    WHERE salary >= within_one;
    
    
    SELECT COUNT(*) AS 'Salaries Within 1 Standard Deviation'
FROM
(
	SELECT (MAX(salary) - stddev(salary)) AS within_one, salary
	FROM salaries
	WHERE to_date > CURDATE()
    GROUP BY salary
    ) d
    WHERE salary >= d.within_one;
    
SELECT COUNT(salary) AS total_salaries
FROM
(
	SELECT salary
	FROM salaries
    ) t;
    -- total 2844047, 
    
-- percentage calculation (COUNT(d.within_one) / COUNT(salary))
    SELECT (67724 / 2844047);
-- Solution: 67724, 2.38%

-- Bonus: Who is the highest paid employee within each department.
SELECT
d.dept_name,
d.dept_no, 
MAX(s.salary)
FROM salaries s 
JOIN dept_emp de
ON de.emp_no - s.emp_no
AND s.to_date > NOW()
AND de.to_date > NOW()
JOIN departments d
USING (dept_no)
GROUP BY dept_name;

WITH dept_names AS
(
SELECT
d.dept_name,
d.dept_no, 
MAX(s.salary) AS maxsal
FROM salaries s 
JOIN dept_emp de
ON de.emp_no - s.emp_no
AND s.to_date > NOW()
AND de.to_date > NOW()
JOIN departments d
USING (dept_no)
GROUP BY dept_name
), 
emp_info AS
(
SELECT 
e.first_name, 
e.last_name,
d.dept_no,
s.salary
FROM employees e
JOIN dept_emp
USING (emp_no)
JOIN salaries s
USING (emp_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW()
)
SELECT emp_info.first_name,
emp_info.last_name,
dept_names.dept_name
FROM dept_names
LEFT JOIN emp_info 
ON emp_info.salary = dept_names.maxsal
AND emp_info.dept_no = dept_names.dept_no

SELECT first_name, last_name;