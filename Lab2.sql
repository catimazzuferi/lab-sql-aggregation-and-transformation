USE sakila;
#1.You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT * FROM film;
SELECT MAX(length) AS max_daration FROM sakila.film;
SELECT MIN(length) AS min_duration FROM sakila.film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.
SELECT FLOOR(AVG(length)) FROM sakila.film;

SELECT CONCAT(FLOOR(length/60),':',LPAD(MOD(length,60),2,'0')) AS 'movie_duration' FROM sakila.film;
#2You need to gain insights related to rental dates:

#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT * FROM rental
ORDER BY rental_date DESC;
#2006-02-14 15:16:03
SELECT * FROM rental
ORDER BY rental_date ASC;
#2005-05-24 22:53:30
SELECT DATEDIFF('2006-02-14 15:16:03', '2005-05-24 22:53:30') ;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * FROM rental;
SELECT *, date_format(CONVERT(left(rental_date,10),date), '%M') AS 'month of rental'  FROM sakila.rental LIMIT 20;
SELECT *, date_format(CONVERT(left(rental_date,10),date), '%D') AS 'WEEKDAY of rental' FROM sakila.rental LIMIT 20;
#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression.
SELECT *,
       CASE
           WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM sakila.rental;
#3You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.
SELECT title, rental_duration FROM sakila.film;

SELECT IFNULL(rental_duration, 'Not Available') AS rental_duration, title
FROM sakila.film
ORDER BY title ASC;


#4Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

#Challenge 2

#1Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT COUNT(DISTINCT film_id) FROM sakila.film;
#1.2 The number of films for each rating.
SELECT DISTINCT rating FROM sakila.film;
SELECT COUNT(rating) as count, rating
FROM film
GROUP BY rating;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT DISTINCT rating FROM sakila.film;
SELECT COUNT(rating) as count, rating
FROM film
GROUP BY rating
ORDER BY count DESC;
#2Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT * FROM sakila.film;
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING mean_duration > 120;
#3Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;