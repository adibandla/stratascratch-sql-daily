/*
https://platform.stratascratch.com/coding/10314-revenue-over-time?code_type=1
Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented 
by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.


A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.

Difficulty: Hard

Tables:
<amazon_purchases>
created_at		date
purchase_amt	bigint
user_id			bigint
*/

SELECT
    year_month,
    AVG(monthly_totals) OVER (ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM (
    SELECT 
        to_char(created_at, 'YYYY-MM') AS year_month,
        SUM(purchase_amt) AS monthly_totals 
    FROM amazon_purchases
    WHERE purchase_amt > 0
    GROUP BY to_char(created_at, 'YYYY-MM')
    ORDER BY year_month ASC
)
