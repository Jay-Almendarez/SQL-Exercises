-- SELECT Statements
SHOW DATABASES;
USE sakila;
SHOW TABLES;
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT * FROM film;
SELECT film_id, title, release_year FROM film;

-- DISTINCT Operator
SELECT * FROM actor;
SELECT DISTINCT last_name FROM actor;
SELECT * FROM address;
SELECT DISTINCT postal_code FROM address;
SELECT * FROM film;
SELECT DISTINCT rating FROM film;

-- Where Clause
SELECT * FROM film;
SELECT title, description, rating, length FROM film WHERE length >=180;
SELECT * FROM payment;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= 05-27-2005;
SELECT * FROM payment;
SELECT amount, payment_date, rental_id AS primary_key from payment WHERE payment_date = 2005-05-27;
SELECT * FROM customer;
SELECT * from customer WHERE first_name LIKE '%N' AND last_name LIKE 'S%';
SELECT * from customer;
SELECT * FROM customer WHERE active = 0 OR last_name LIKE 'M%';
SELECT * FROM customer;


