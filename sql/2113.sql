/*
https://platform.stratascratch.com/coding/2113-extremely-late-delivery?code_type=1
To remain competitive, the company you work with must reduce the number of extremely late deliveries.
A delivery is flagged as extremely late if the actual delivery time is more than 20 minutes (not inclusive) after the predicted delivery time.
You have been asked to calculate the percentage of orders that arrive extremely late each month.
Your output should include the month in the format 'YYYY-MM' and the percentage of extremely late orders as a percentage of all orders placed in that month.

Difficulty: Medium

Tables:
<delivery_orders>
actual_delivery_time			timestamp without time zone
consumer_id						text
delivery_id						text
delivery_rating					double precision
driver_id						text
order_placed_time				timestamp without time zone
predicted_delivery_time			timestamp without time zone
restaurant_id					text
*/

WITH delivery_time_diff AS (
    SELECT
        delivery_id,
        TO_CHAR(order_placed_time, 'YYYY-MM') AS month,
        EXTRACT(
            EPOCH FROM (actual_delivery_time - predicted_delivery_time)
        ) / 60 AS time_diff
    FROM delivery_orders
    WHERE actual_delivery_time IS NOT NULL
)
SELECT
    month,
    ROUND(
        100 * (COUNT(DISTINCT delivery_id) FILTER (WHERE time_diff > 20) / 
		COUNT(DISTINCT delivery_id)::numeric),
        2
    ) AS per_ext_delayed
FROM delivery_time_diff
GROUP BY month
ORDER BY month;
