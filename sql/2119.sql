/*
https://platform.stratascratch.com/coding/2119-most-lucrative-products?code_type=1
You have been asked to find the 5 most lucrative products (including ties) in terms of total revenue for the first half of 2022 (from January to June inclusive).
Output their IDs and the total revenue. There may be more than 5 rows in the output since you are including ties.

Difficulty: Medium

Tables:
<online_orders>
cost_in_dollars			bigint
customer_id				bigint
date_sold				date
product_id				bigint
promotion_id			bigint
units_sold				bigint
*/

WITH ranked_total_revenue AS(
    SELECT
        product_id,
        SUM(cost_in_dollars * units_sold) AS total_revenue,
        RANK() OVER (ORDER BY SUM(cost_in_dollars * units_sold) DESC) AS rnk
    FROM online_orders
    WHERE EXTRACT(QUARTER FROM date_sold) <= 2 AND
          EXTRACT(YEAR FROM date_sold) = 2022
    GROUP BY product_id
)
SELECT
    product_id,
    total_revenue
FROM ranked_total_revenue
WHERE rnk <= 5;
