use sakila ;
-- task 1
SELECT * FROM Customer WHERE active = 0;

-- task 2
SELECT first_name, last_name, email FROM Customer WHERE active = 0;

-- task 3
SELECT store_id, COUNT(*) AS inactive_count
FROM Customer
WHERE active = 0
GROUP BY store_id
ORDER BY inactive_count DESC
LIMIT 1;

-- task 4
SELECT title FROM Film WHERE rating = 'PG-13';

-- task 5
SELECT title, length
FROM Film
WHERE rating = 'PG-13'
ORDER BY length DESC
LIMIT 3;

-- task 6
SELECT film_id FROM Film WHERE rating = 'PG-13';

SELECT f.title, COUNT(*) AS rental_count
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.film_id IN (SELECT film_id FROM Film WHERE rating = 'PG-13')
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

-- task 7
SELECT AVG(rental_rate) AS average_rental_cost
FROM Film;


-- task 8
SELECT SUM(replacement_cost) AS total_replacement_cost
FROM Film;

-- task 9
SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM film_category fc
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Animation', 'Children')
GROUP BY c.category_id, c.name
ORDER BY c.name;
