use modelcarsdb;
--                    task 3
-- task 1 Count the number of products in each product line.
select productLine, count(*) as productCount  from products
group by productLine;

-- task 2 Find the product line with the highest average product price.
SELECT productLine, AVG(MSRP) AS average_price
FROM products
GROUP BY productLine
ORDER BY average_price DESC
LIMIT 1;

-- task 3 
SELECT productCode, productName, msrp
FROM products
WHERE msrp BETWEEN 50 AND 100;

-- task4
SELECT pl.productline, SUM(od.quantityordered * od.priceeach) AS total_sales_amount
FROM productlines pl
JOIN products p ON pl.productline = p.productline
JOIN orderdetails od ON p.productcode = od.productcode
GROUP BY pl.productline;

-- task5
SELECT productcode, productname, quantityinstock
FROM products
WHERE quantityinstock < 10;

-- task6
SELECT productcode, productname, msrp
FROM products
ORDER BY msrp DESC
LIMIT 1;

-- task7
SELECT p.productcode, p.productname, SUM(od.quantityordered * od.priceeach) AS total_sales
FROM products p
JOIN orderdetails od ON p.productcode = od.productcode
GROUP BY p.productcode, p.productname;

-- task8
CALL GetTopSellingProducts(5);

-- task9
SELECT p.productcode, p.productname, p.quantityinstock, pl.productline
FROM products p
JOIN productlines pl ON p.productline = pl.productline
WHERE p.quantityinstock < 10
AND pl.productline IN ('Classic Cars', 'Motorcycles');

-- task10
SELECT p.productname
FROM products p
JOIN orderdetails od ON p.productcode = od.productcode
JOIN orders o ON od.ordernumber = o.ordernumber
GROUP BY p.productname
HAVING COUNT(DISTINCT o.customernumber) > 10;

-- task11
WITH product_order_counts AS (
    SELECT p.productcode, p.productname, p.productline, COUNT(od.ordernumber) AS total_orders
    FROM products p
    JOIN orderdetails od ON p.productcode = od.productcode
    GROUP BY p.productcode, p.productname, p.productline
),
average_orders_per_productline AS (
    SELECT productline, AVG(total_orders) AS avg_orders
    FROM product_order_counts
    GROUP BY productline
)
SELECT poc.productname
FROM product_order_counts poc
JOIN average_orders_per_productline aop ON poc.productline = aop.productline
WHERE poc.total_orders > aop.avg_orders;

