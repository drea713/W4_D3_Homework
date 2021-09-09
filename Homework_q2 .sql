-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, payment.customer_id, amount
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT * 
FROM (
	SELECT first_name, last_name, customer.customer_id, amount, SUM(amount) AS summ
	FROM Customer
	INNER JOIN payment
	ON payment.customer_id = customer.customer_id
	GROUP BY 1,2,3,4
) AS cus
WHERE amount > 175;
-- *There are no payments over 175 based on this data pull.

-- 4. List all customers that live in Nepal (use the citytable)
SELECT first_name, last_name, customer.address_id, city
FROM (
	SELECT *
	FROM city
	JOIN address ON city.city_id = address.city_id
) AS city_address
JOIN customer ON customer.address_id = city_address.address_id
WHERE city='Nepal';
-- *There are no customers that live in Nepal based on this date pull.

-- 5. Which staff member had the most transactions?
SELECT *
FROM
	(SELECT staff.staff_id, first_name, last_name, amount
	FROM staff
	JOIN payment ON staff.staff_id = payment.staff_id
	GROUP BY 1,2,3,4) AS staff_payment;
-- Not sure how to round up staff member numbers together to get the sum of the winner.

--6. How many movies of each rating are there?
SELECT *
FROM 
	(SELECT rating, title
	FROM film
	GROUP BY 1,2) rate;
-- Not sure how to combine number of movies with number of ratings.

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT *
FROM 
	(SELECT first_name, last_name, customer.customer_id, amount
	FROM customer
	INNER JOIN payment ON customer.customer_id = payment.customer_id
	GROUP BY 1,2,3,4) AS cus
WHERE amount > 6.99;

-- 8. How many free rentals did our stores give away?
SELECT first_name, last_name, store_id, amount
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
WHERE amount = 0.00
-- Answer: 24 give aways