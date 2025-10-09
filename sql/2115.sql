/*
https://platform.stratascratch.com/coding/2115-more-than-100-dollars?code_type=1
The company for which you work is reviewing its 2021 monthly sales.
For each month of 2021, calculate what percentage of restaurants have reached at least 100$ or more in monthly sales.
Remember that if an order has a blank value for actual_delivery_time, it has been canceled and therefore does not count towards monthly sales.

Difficulty: Hard

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

<order_value>
delivery_id						text
sales_amount					double precision
*/

WITH monthly_sales AS (
    SELECT
        restaurant_id,
        EXTRACT(month FROM actual_delivery_time) AS month,
        SUM(sales_amount) AS monthly_sales
    FROM delivery_orders AS o
    JOIN order_value AS v USING (delivery_id)
    WHERE
        EXTRACT(year FROM actual_delivery_time) = 2021
        AND actual_delivery_time IS NOT NULL
    GROUP BY
        restaurant_id,
        EXTRACT(month FROM actual_delivery_time)
),
per_months AS (
    SELECT
        month,
        100 * (
            COUNT(*) FILTER (WHERE monthly_sales >= 100)::numeric 
            / COUNT(*)
        ) AS per
    FROM monthly_sales
    GROUP BY month
)
SELECT
    b.month,
    COALESCE(a.per, 0) AS per
FROM per_months AS a
RIGHT JOIN (
    SELECT generate_series(1, 12) AS month
) AS b USING (month)
ORDER BY b.month;
