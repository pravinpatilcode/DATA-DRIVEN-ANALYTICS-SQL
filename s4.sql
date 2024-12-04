use hr;
-- task 1
SELECT employee_id, first_name, last_name
FROM employees 
INNER JOIN departments  ON employees.department_id = departments.department_id
WHERE department_name = 'IT_PROG';

-- task 2
SELECT department_name AS department, MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM employees 
INNER JOIN departments department ON employees .department_id = department.department_id
GROUP BY department.department_id, department_name;

-- task 3
SELECT l.city, COUNT(*) AS employee_count
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY l.city
ORDER BY employee_count DESC
LIMIT 10;

-- task 4
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
INNER JOIN job_history jh ON e.employee_id = jh.employee_id
WHERE jh.end_date = '1999-12-31';

-- task 5
SELECT  e.employee_id,
    e.first_name,
    d.department_name,
    TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS total_experience
FROM  employees e
JOIN departments d ON e.department_id = d.department_id
WHERE TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) >= 25;
