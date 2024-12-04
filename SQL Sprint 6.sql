-- Sprint 6

use hr;

/* Task 1, Extract the structure of the following 7 tables using the 'DESCRIBE' 
SQL command from the HR database using MYSQL workbench */ 

desc countries;
desc departments;
desc employees;
desc job_history;
desc jobs;
desc locations;
desc regions;

-- Task 2a, find the total no.of countries in each region

SELECT regions.region_name, COUNT(countries.country_id) AS total_countries
FROM countries
INNER JOIN regions ON countries.region_id = regions.region_id
GROUP BY regions.region_name;

-- Task 2B, find the top 10 largest cities by population
SELECT city, COUNT(*) AS city_count
FROM locations
GROUP BY city
ORDER BY city_count DESC
LIMIT 10;


-- Task 2C, find the average salary of employees in each department

SELECT departments.department_name, AVG(employees.salary) AS average_salary
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_name;

/* Task 3 Create additional business queries using BARD with the three tables 
jobs, employees, and job_history */

-- 1.Find the total number of employees in each job

SELECT jobs.job_title, COUNT(employees.employee_id) AS total_employees
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id
GROUP BY jobs.job_title;

-- 2.Find the departments with the highest average salary

SELECT departments.department_name, AVG(employees.salary) AS average_salary
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_name
ORDER BY average_salary DESC
LIMIT 1;

-- 3.Find the Job titles with highest average salary

SELECT jobs.job_title, AVG(employees.salary) AS highest_avg_salary_ever
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id
GROUP BY jobs.job_title
ORDER BY highest_avg_salary_ever DESC
LIMIT 1;

/* Task 4, Generate additional business queries using BARD with the three tables
departments, jobs, employees */

-- 1.Find Average salary per job title
SELECT jobs.job_title, AVG(employees.salary) AS avg_salary
FROM employees
INNER JOIN jobs ON employees.job_id = jobs.job_id
GROUP BY jobs.job_title;

-- 2. Identify the busiest month for new employee hires.

SELECT MONTHNAME(hire_date) AS hire_month, COUNT(*) AS total_hires
FROM employees
GROUP BY hire_date
ORDER BY total_hires DESC
LIMIT 1;

-- 3.Find the Total employees in each department

SELECT departments.department_name, COUNT(employee_id) AS total_employees
FROM employees
JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_name;

-- Task 5 - Summary written in the word file.








