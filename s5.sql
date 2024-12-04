
use hr;


/* Task 1; Display the employee ID, first names, last names, and department names of all employees using subquery.
Hint: The employee and department details are in two separate tables*/
SELECT e.employee_id, e.first_name, e.last_name,
(SELECT d.department_name FROM departments d WHERE d.department_id = e.department_id) AS department_name
FROM employees e;

/*Task 2; Display the first names, last names, and salaries of the employees whose salaries are greater than the average salary of all employees, grouped by the department IDs.
Hint: This query involves only one table. Try to use aggregate function.*/

SELECT  department_id, first_name, last_name, salary
FROM  employees WHERE salary > (SELECT AVG(salary) FROM employees)
GROUP BY  department_id, first_name, last_name, salary;

/* Task 3;  Display the first names and last names of those employees of the sales department who have a salary less than the average salary of all employees of the sales department.
Hints:
i. The data for the above task resides in two separate tables, which you should not join.
ii. There would be different types of Sales department Do consider all of them for the above task */

SELECT first_name, last_name FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE department_name LIKE '%sales%')
AND salary < (SELECT AVG(salary) FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE department_name LIKE '%sales%'));

/* Task 4; Display the first names, last names, and salaries of the employees who have a salary higher than the salaries of all IT programmers. Display the details of the employees in the ascending order of salary, using subqueries.
Hint: ( JOBID = Pi \ PROG)*/
SELECT first_name, last_name, salary
FROM employees WHERE salary >(SELECT MAX(salary) FROM employees WHERE job_id ='IT_PROG')
ORDER BY salary ASC;

/* Task 5; Display the records of the employee(s) with the minimum salary in the employees table, grouped by the job_id column and arranged in ascending order of salaries.
Hint: The data for the above task is present in a single  */
SELECT job_id, employee_id, first_name, last_name, salary
FROM  employees WHERE (job_id, salary) IN (
SELECT job_id, MIN(salary) AS min_salary
FROM  employees GROUP BY job_id ) ORDER BY job_id, salary ASC;

/* Task 6;Display the first names, last names, and department IDs of the employees whose salary is greater than 60% of the sum of the salaries of all employees of their respective departments.
Hints:
i. The data for the above task is present in a single
ii. Try to use comparison operator. */
SELECT first_name, last_name, department_id
FROM employees e WHERE salary > 0.6 * (SELECT SUM(salary) FROM employees WHERE department_id = e.department_id);

/* Task 7;Display the first names and last names of all those employees who have their managers based out of UK, using subquery.
Hint: The data for the above task is present in three different table. */

SELECT e.first_name, e.last_name FROM  employees e
WHERE e.manager_id IN ( SELECT manager_id FROM  employees
WHERE department_id IN (SELECT department_id FROM  departments
WHERE location_id IN (SELECT location_id FROM locations
WHERE country_id = 'UK')));

/* Display the first names, last names, and salaries of the top 5 highest-paid employees and export the output as a CSV file. Use data export technique.
Sample output:
Steven, King, 24000.00
Neena, Kochhar, 17000.00
Lex, De Haan, 17000.00
John, Russell, 14000.00
Karen, Partners, 13500.00
Michael, Hartstein, 13000.00 */

SELECT *
INTO OUTFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\File1.csv' from employees;

FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';