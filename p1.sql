--                    task 1
use modelcarsdb ;
-- task  1
SELECT customerNumber, contactFirstName, contactLastName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 10;

-- task  2
select country, AVG(creditLimit) AS avg_credit_limit
FROM customers
GROUP BY country;

-- task  3
select state, count( * ) AS number_of_customers
from customers
group by state;

-- task  4
SELECT customerNumber,  contactFirstName, contactLastName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);

-- task  5
SELECT customers.customerNumber,  customers.contactFirstName, customers.contactLastName, SUM(salesRepEmployeeNumber) AS total_sales
FROM customers 
INNER JOIN orders ON customers.customerNumber= customers.customerNumber
GROUP BY customers.customerNumber, customers.contactFirstName, customers.contactLastName;

-- task 6
select customernumber, customername, employees.firstname, employees.lastname from customers
join employees on customers.salesrepemployeenumber = employees.employeenumber;

-- task 7
select customername, payments.amount, payments.paymentDate from customers
join payments on customers.customerNumber = payments.customerNumber
order by payments.paymentDate desc ;

-- task 8
select customername, payments.amount, creditLimit from customers
join payments on customers.customerNumber = payments.customerNumber
where  payments.amount >  customers.creditLimit ;

-- task 9
select customername, products.productLine from customers
join orders on customers.customerNumber = orders.customerNumber
join orderdetails on orders.orderNumber = orderdetails.orderNumber
join products on orderdetails.productCode = products.productCode 
where products.productLine = 'Vintage Cars';

-- task 10
select customername, orderdetails.priceEach as expensive from customers
join orders on customers.customerNumber = orders.customerNumber
join orderdetails on orders.orderNumber = orderdetails.orderNumber
order by orderdetails.priceEach desc
limit 20 ;

