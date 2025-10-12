/*
https://platform.stratascratch.com/coding/2079-city-with-most-customers?code_type=1
For each city, find the number of rides in August 2021 that were paid without using a promotional code (i.e., where no discount was applied). Output the city or cities where this number was the highest.

Difficulty: Medium

Tables:
<lyft_orders>
city			text
country			text
customer_id		text
driver_id		text
order_id		bigint

<lyft_payments>
order_date		date
order_fare		double precision
order_id		bigint
promo_code		boolean
*/

WITH ranked_cities AS (
    SELECT
        city,
        RANK() OVER (ORDER BY COUNT(DISTINCT order_id) DESC) AS rnk
    FROM lyft_orders o
    JOIN lyft_payments p
        USING (order_id)
    WHERE 
        EXTRACT(YEAR FROM p.order_date) = 2021
        AND EXTRACT(MONTH FROM p.order_date) = 8
        AND promo_code = 'FALSE'
    GROUP BY city
)
SELECT 
    city
FROM ranked_cities
WHERE rnk = 1;
