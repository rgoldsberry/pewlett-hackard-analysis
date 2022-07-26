-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Generate retirement_info table 
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no

-- Creating retirement table with just current employees 
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')

-- Employee count by department number
SELECT de.dept_no, 
	COUNT(ce.emp_no)
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY 1
ORDER BY 1;

-- Salary by gender
SELECT e.gender, ROUND(AVG(s.salary),2)
FROM employees as e
LEFT JOIN salaries as s ON e.emp_no = s.emp_no
GROUP BY 1;

-- Building list 1: employee info 
SELECT
	e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Building list 2: Active Managers per department
SELECT
	ce.emp_no,
	dm.dept_no,
	d.dept_name,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
FROM current_emp as ce
INNER JOIN dept_manager as dm on (ce.emp_no = dm.emp_no)
INNER JOIN departments as d on (dm.dept_no = d.dept_no)
ORDER BY 2;

-- Building list 3: Adding department to current employee list 
SELECT 
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d ON (de.dept_no = d.dept_no);

-- Tailored list: current employees retiring from sales
SELECT 
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
FROM current_emp as ce
INNER JOIN dept_emp as de on (ce.emp_no = de.emp_no)
INNER JOIN departments as d ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- Tailored list: current employees retiring from sales and development 
SELECT 
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
FROM current_emp as ce
INNER JOIN dept_emp as de on (ce.emp_no = de.emp_no)
INNER JOIN departments as d ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');