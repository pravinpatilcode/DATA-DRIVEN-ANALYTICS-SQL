Use hr;

/* Task 1 : Extract the structures of the following 7 tables using 'DESCRIBE' SQL command from the HR database:
1. regions
2. countries
3. locations
4. departments
5. jobs
6. employees
7. job_ */

-- Describe the 'regions' table
SHOW COLUMNS FROM regions;
-- Describe the 'countries' table
SHOW COLUMNS FROM countries;
-- Describe the 'locations' table
SHOW COLUMNS FROM locations;
-- Describe the 'departments' table
SHOW COLUMNS FROM departments;
-- Describe the 'jobs' table
SHOW COLUMNS FROM jobs;
-- Describe the 'employees' table
SHOW COLUMNS FROM employees;

/* Task 2 : Following sub-tasks have been generated using 4 tables: regions, countries, locations, departments. Generate MySQL queries for all the following sub-tasks using BARD. Then, execute these queries in MySQL to produce the actual outputs.
a) Find the total number of countries in each region. b) Find the top 10 largest cities by population.
c) Find the average salary of employees in each department.
 d) Find the total sales for each country in the last quarter.
e) Find the top 10 most popular products, based on th number of orders.
f) Find the customers who have placed the most orders in the last year.
g) Find the employees who have generated the most sales in the last quarter */

SELECT r.region_name, COUNT(c.country_id) AS total_countries FROM regions r JOIN countries c ON r.region_id = c.region_id
GROUP BY r.region_name;
SELECT city_name, population FROM locations ORDER BY population DESC LIMIT 10;
SELECT d.department_name, AVG(e.salary) AS average_salary FROM departments d JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
SELECT c.country_name, SUM(sales_amount) AS total_sales FROM countries c
JOIN sales_table s ON c.country_id = s.country_id
WHERE sales_date BETWEEN '2023-10-01' AND '2023-12-31'
GROUP BY c.country_name;
SELECT product_id, COUNT(order_id) AS order_count FROM orders GROUP BY product_id ORDER BY order_count DESC LIMIT 10;
SELECT customer_id, COUNT(order_id) AS order_count FROM orders WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY customer_id ORDER BY order_count DESC LIMIT 1;
SELECT employee_id, SUM(sales_amount) AS total_sales FROM sales_table
WHERE sales_date BETWEEN '2023-10-01' AND '2023-12-31' GROUP BY employee_id ORDER BY total_sales DESC
LIMIT 1;

/* Task 3;Generate MySQL queries using BARD with these 3 tables: jobs, employees, job_history. Then, execute these queries in MySQL to produce the actual outputs. */

SELECT job_title, AVG(salary) AS average_salary FROM employees
JOIN jobs ON employees.job_id = jobs.job_id GROUP BY job_title;

/* Task 4:Generate MySQL queries using BARD with the 3 tables: departments, jobs, employees. Then, execute these queries in MySQL to produce the actual output */
SELECT d.department_name, COUNT(e.employee_id) AS total_employees FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;
SELECT d.department_name, AVG(e.salary) AS average_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;
SELECT d.department_name, MAX(e.salary) AS highest_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;

/* Task 5; User Extract the unique queries from tasks 2-4. Based on the output from these unique queries, write the summary of your analysis*/
SELECT d.department_name, AVG(e.salary) AS average_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;
SELECT d.department_name, MAX(e.salary) AS highest_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;
SELECT d.department_name, AVG(e.salary) AS average_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;
SELECT d.department_name, MAX(e.salary) AS highest_salary FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.department_name;