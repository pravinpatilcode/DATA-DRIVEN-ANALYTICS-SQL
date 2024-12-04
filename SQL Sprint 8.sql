-- SQL Sprint 8
use ecommerceinvdb;

-- Task 1

DELIMITER ;

DELIMITER //
CREATE TRIGGER validate_order_item_insert
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  DECLARE current_stock INT;
  
  SELECT stock_level INTO current_stock FROM products WHERE product_id = NEW.product_id;

  IF NEW.quantity <= 0 OR current_stock < NEW.quantity THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid order quantity. Please check product stock level.';
  END IF;
END;
//
DELIMITER ;


insert into order_items (order_id, product_id , quantity)
values (1,3,0);
/* Output : 10:59:33	insert into order_items (order_id, product_id , quantity) values  (1,3,0)	
 Error Code: 1644. Invalid order quantity. Please check product stock level.	0.000 sec */
 
-- error code with signel " Invalid order quantity. Please check product stock level." given successfully


 insert into order_items (order_id, product_id , quantity)
 values (1,3,1);
 /* output : 11:01:56	insert into order_items (order_id, product_id , quantity)  values (1,3,1)	
1 row(s) affected	0.016 sec */

-- interpretation : Trigger is created and tested successfully

-- TASK 2a

-- add new column named total_amount to orders
Alter table orders add column total_amount decimal(10,2);

-- query to update total_amount value of all orders to 0
set sql_safe_updates = 0;
update orders set total_amount = 0;

-- create a daily_sales table 
create table daily_sales 
( id int primary key auto_increment ,
sale_date date,
total_sales decimal(10,2)
);


-- Task 2b

DROP TRIGGER IF EXISTS `ecommerceinvdb`.`update_order_total`;

DELIMITER $$
USE `ecommerceinvdb`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `order_items_AFTER_INSERT` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
declare	new_total decimal(10, 2);

SELECT orders.total_amount + (products.price * NEW.quantity) INTO new_total
  FROM orders 
  join order_items on orders.order_id = order_items.order_id
  JOIN products ON order_items.product_id = products.product_id
  WHERE orders.order_id = NEW.order_id;

  -- Update the order total
  set sql_safe_updates = 0;
  UPDATE orders
  SET total_amount = new_total
  WHERE order_id = NEW.order_id;

  -- Update daily sales table with new order total
  INSERT INTO daily_sales (sale_date, total_sales)
  VALUES (CURDATE(), new_total);
END$$
DELIMITER ;


set foreign_key_checks = 0;
insert into order_items (order_id, product_id, quantity)
values
(11,1,2);
 /* output : 17:51:08	insert into order_items (order_id, product_id, quantity) values (11,1,2)	
 1 row(s) affected	0.031 sec */

-- interpretation : Trigger is created and tested successfully

-- sprint 8 completed








