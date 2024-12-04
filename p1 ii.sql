--                    task 2
use modelcarsdb ;
-- task 1 Count the number of employees working in each office.
SELECT e.officeCode, COUNT(*) AS employee_count
FROM employees e
GROUP BY e.officeCode;

-- task 2 Identify the offices with less than a certain number of employees
SELECT e.officeCode
FROM employees e
GROUP BY e.officeCode
HAVING COUNT(*) < 1;

-- task 3 List offices along with their assigned territories.
SELECT employees.officeCode AS office, employees.firstName, employees.lastName, offices.territory
FROM employees
INNER JOIN offices ON employees.officeCode = offices.officeCode
WHERE offices.territory IS NOT NULL;

-- task4   Find the offices that have no employees assigned to them.
SELECT o.officeCode AS office
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode
HAVING COUNT(e.officeCode) = 0;

-- task 5 Retrieve the most profitable office based on total sales.
SELECT o.officeCode, o.city, SUM(od.priceEach * od.quantityOrdered) AS total_sales
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders ord ON c.customerNumber = ord.customerNumber
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
GROUP BY o.officeCode, o.city
ORDER BY total_sales DESC
LIMIT 1;



-- task 6 Find the office with the highest number of employees
SELECT officeCode AS offices, COUNT(*) AS employee_count
FROM employees
GROUP BY officeCode
ORDER BY employee_count DESC
LIMIT 1;

-- task 7 Find the average credit limit for customers in each office.

SELECT AVG(creditLimit) AS average_credit_limit
FROM customers;

-- task 8 Find the number of offices in each country.
SELECT country, COUNT(*) AS office_count
FROM offices
GROUP BY country;
