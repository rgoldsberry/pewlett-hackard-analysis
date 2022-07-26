-- Deliverable 1: List of Retiring Employees by Title
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	tl.title,
	tl.from_date,
	tl.to_date
INTO retire_by_title
FROM employees as e
INNER JOIN titles as tl ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY 1;

-- Deliverable 1: List of Retiring Employees by Title - Unique Employee ID 
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	tl.title
INTO retire_by_title_unique
FROM employees as e
INNER JOIN titles as tl ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (tl.to_date = '9999-01-01')
ORDER BY 1, 4 DESC;

-- Deliverable 1: Number of Retiring Employees by Title 
SELECT COUNT(title), title
INTO num_retire_by_title
FROM retire_by_title_unique
GROUP BY title
ORDER BY 1 DESC;


-- Deliverable 2: Employees eligible for Mentorship Program
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl ON (e.emp_no = tl.emp_no)
-- challenge said to filter the dept_emp.to_date col, but that just gave current employees, 
-- not necessarily their most recent title. filtering the title.to_date col instead
WHERE (tl.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, de.to_date DESC;