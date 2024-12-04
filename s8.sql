
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

 insert into order_items (order_id, product_id , quantity)
 values (1,3,1);
 

-- TASK 2a

Alter table orders add column total_amount decimal(10,2);

set sql_safe_updates = 0;
update orders set total_amount = 0;

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

  set sql_safe_updates = 0;
  UPDATE orders
  SET total_amount = new_total
  WHERE order_id = NEW.order_id;

  INSERT INTO daily_sales (sale_date, total_sales)
  VALUES (CURDATE(), new_total);
END$$
DELIMITER ;


set foreign_key_checks = 0;
insert into order_items (order_id, product_id, quantity)
values
(11,1,2);










