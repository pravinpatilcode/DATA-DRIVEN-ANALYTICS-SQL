-- project 2 task2
use  modelcarsdb;

-- task1 Find the average order amount for each customer.
SELECT
    customerName,
    AVG(creditLimit) AS avg_order_amount
FROM
    customers
GROUP BY
    customerName;

    -- task2 Find the number of orders placed in each month
    SELECT
    DATE_FORMAT(orderDate, '%Y-%m') AS month,
    COUNT(*) AS num_orders
FROM
    orders
GROUP BY
    DATE_FORMAT(orderDate, '%Y-%m')
ORDER BY
    month;

    -- task3 Identify orders that are still pending shipment (status = 'Pending').
    SELECT
   orderNumber,
    orderDate,
   status
FROM
    orders
WHERE
    status = 'In Process';
    
    -- task4. List orders along with customer details.
SELECT
    o.orderNumber,
    o.orderDate,
    o.customerNumber,
    c.customerName,
    c.contactLastName,
    c.contactFirstName,
    c.phone,
    c.addressLine1,
    c.city,
    c.state,
    c.country
FROM
    orders o
JOIN
    customers c ON o.customerNumber = c.customerNumber;

    -- task5    Retrieve the most recent orders (based on order date).
    SELECT *
FROM orders
ORDER BY orderDate DESC
limit 20;

    -- task6 Calculate total sales for each order
    
    SELECT
    o.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM
    orders o
JOIN
    orderDetails od ON o.orderNumber = od.orderNumber
GROUP BY
    o.orderNumber;

    -- task7 Find the highest-value order based on total sales.
    SELECT
    o.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM
    orders o
JOIN
    orderDetails od ON o.orderNumber = od.orderNumber
GROUP BY
    o.orderNumber
ORDER BY
    totalSales DESC
LIMIT 1;

    -- task8 . List all orders with their corresponding order details.
    SELECT
    o.orderNumber,
    o.orderDate,
    od.productCode,
    od.quantityOrdered,
    od.priceEach
FROM
    orders o
JOIN
    orderDetails od ON o.orderNumber = od.orderNumber
ORDER BY
    o.orderNumber, od.productCode;

        -- task9  List the most frequently ordered products.
        SELECT
    productCode,
    COUNT(*) AS orderFrequency
FROM
    orderDetails
GROUP BY
    productCode
ORDER BY
    orderFrequency DESC;
    
        -- task10  Calculate total revenue for each order
        SELECT
    od.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM
    orderDetails od
GROUP BY
    od.orderNumber;
        
        -- task11. Identify the most profitable orders based on total revenue.
        SELECT
    od.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM
    orderDetails od
GROUP BY
    od.orderNumber
ORDER BY
    totalRevenue DESC
LIMIT 1;

        -- task12. List all orders with detailed product information.
        SELECT
    o.orderNumber,
    o.orderDate,
    od.productCode,
    p.productName,
    od.quantityOrdered,
    od.priceEach,
    (od.quantityOrdered * od.priceEach) AS totalRevenuePerProduct
FROM
    orders o
JOIN
    orderDetails od ON o.orderNumber = od.orderNumber
JOIN
    products p ON od.productCode = p.productCode
ORDER BY
    o.orderNumber, od.productCode;
            -- task13. Identify orders with delayed shipping (shippedDate > required Date).
            SELECT orderNumber,
    requiredDate,
    shippedDate
FROM
    orders
WHERE
    shippedDate > requiredDate;

            
			-- task14. Find the most popular product combinations within orders.
                   SELECT
    CONCAT(od1.productCode, '-', od2.productCode) AS productCombination,
    COUNT(*) AS combinationCount
FROM
    orderDetails od1
JOIN
    orderDetails od2 ON od1.orderNumber = od2.orderNumber
                    AND od1.productCode < od2.productCode
GROUP BY
    productCombination
ORDER BY
    combinationCount DESC;
 
                    
			-- task15. Calculate revenue for each order and identify the top 10 most profitable.

SELECT
    o.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM
    orders o
JOIN
    orderDetails od ON o.orderNumber = od.orderNumber
GROUP BY
    o.orderNumber
ORDER BY
    totalRevenue DESC
LIMIT 10;

			-- task16  Create a trigger that automatically updates a customer's credit limit after a new order is placed, reducing it by the order total.
 
DELIMITER //

CREATE TRIGGER update_credit_limit
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE total_order_amount DECIMAL(10,2);
    
    -- Calculate the total order amount for the new order
    SELECT SUM(od.quantityOrdered * od.priceEach)
    INTO total_order_amount
    FROM orderdetails od
    WHERE od.orderNumber = NEW.orderNumber;
    
    -- Update the customer's credit limit
    UPDATE customers
    SET creditLimit = creditLimit - total_order_amount
    WHERE customerNumber = NEW.customerNumber;
END //

DELIMITER ;


			-- task17 Create a trigger that logs product quantity changes whenever an order detail is inserted or updated.
DELIMITER //
CREATE TRIGGER log_product_quantity_changes
AFTER INSERT  ON orderdetails
FOR EACH ROW
BEGIN
    DECLARE action VARCHAR(10);
    DECLARE log_message VARCHAR(255);

    -- Determine the action (INSERT or UPDATE)
    IF INSERTING THEN
        SET action = 'INSERT';
    ELSE
        SET action = 'UPDATE';
    END IF;

    -- Prepare log message
    SET log_message = CONCAT(action, ' - Order Number: ', NEW.orderNumber,
                             ', Product Code: ', NEW.productCode,
                             ', Quantity: ', NEW.quantityOrdered);

    -- Insert log entry into a temporary log table
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_product_quantity_logs (
        log_id INT AUTO_INCREMENT PRIMARY KEY,
        log_message VARCHAR(255),
        log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    INSERT INTO temp_product_quantity_logs (log_message)
    VALUES (log_message);
END //

DELIMITER ;