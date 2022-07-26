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