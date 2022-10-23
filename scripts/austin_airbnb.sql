/* Test to see if tables were successfully imported

SELECT *
FROM listings

SELECT *
FROM reviews */

--==============================================================================================================--
--1. How much are the Top AirBnB earners making?

--Let's get rid of the dollar sign ($) in the price column

SELECT *, price, CAST(REPLACE(price,'$','') AS UNSIGNED) AS price_clean
FROM listings

USE airbnb; 
SELECT id, 
listing_url, 
name, 
30 - availability_30 AS booked_out_30 , 
CAST(REPLACE(price,'$','') AS UNSIGNED) AS price_clean, 
CAST(REPLACE(price,'$','') AS UNSIGNED)*(30 - availability_30) / beds AS proj_rev_30
FROM listings 
ORDER BY proj_rev_30 DESC 
LIMIT 20; 

--Price per night ranges from $950 - $999 for the top 20 AirBnB operators in Austin.
--Projected Revenue ranges from $28,500 - $29,970 for the top 20 AirBnB operators in Austin.

--==============================================================================================================--
--2. Potential Customer list for an AirBnB cleaning business

SELECT host_id, 
       host_url, 
	   host_name, 
	   COUNT(*) AS num_dirty_reviews
	   FROM reviews AS r
	   INNER JOIN listings AS l
	   ON r.listing_id = l.listings.id
WHERE comments LIKE "%dirty%"
GROUP BY host_id, host_url, host_name 
ORDER BY num_dirty_reviews DESC;

