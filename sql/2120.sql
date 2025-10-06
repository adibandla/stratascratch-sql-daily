/*
https://platform.stratascratch.com/coding/2120-first-and-last-day?code_type=1
The marketing team is evaluating the performance of their previously ran promotions.
They are particularly interested in comparing the number of transactions on the first and last day of each promotion.
Segment the results by promotion and calculate the percentage of total transactions that occurred on these days.
Your output should include the promotion ID, the percentage of transactions on the first day, and the percentage of transactions on the last day.

Difficulty: Hard

Tables:
<online_sales_promotions>
cost			bigint
end_date		date
media_type		text
promotion_id	bigint
start_date		date

<online_orders>
cost_in_dollars	bigint
customer_id		bigint
date_sold		date
product_id		bigint
promotion_id	bigint
units_sold		bigint
*/

WITH transactions AS (
    SELECT 
        promotion_id,
        date_sold,
        COUNT(*) AS num_transactions
    FROM online_orders
    GROUP BY 
        promotion_id, 
        date_sold
),
total_sold AS (
    SELECT
        promotion_id,
        COUNT(*) AS tot_trans
    FROM online_orders
    GROUP BY promotion_id
)
SELECT
    p.promotion_id,
    COALESCE(
        ROUND(100 * (a.num_transactions / c.tot_trans::numeric), 2),
        0
    ) AS per_sold_start,
    COALESCE(
        ROUND(100 * (b.num_transactions / c.tot_trans::numeric), 2),
        0
    ) AS per_sold_end
FROM online_sales_promotions AS p
LEFT JOIN transactions AS a
    ON p.promotion_id = a.promotion_id 
    AND p.start_date = a.date_sold
LEFT JOIN transactions AS b
    ON p.promotion_id = b.promotion_id
    AND p.end_date = b.date_sold
LEFT JOIN total_sold AS c
    ON p.promotion_id = c.promotion_id;
