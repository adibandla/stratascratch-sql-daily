/*
https://platform.stratascratch.com/coding/2111-sales-growth-per-territory?code_type=1
Write a query to return Territory and corresponding Sales Growth. Compare growth between periods Q4-2021 vs Q3-2021.
If Territory (say T123) has Sales worth $100 in Q3-2021 and Sales worth $110 in Q4-2021, then the Sales Growth will be 10% [ i.e. = ((110 - 100)/100) * 100 ]
Output the ID of the Territory and the Sales Growth. Only output these territories that had any sales in both quarters.

Difficulty: Hard

Tables:
<fct_customer_sales>
cust_id			text
order_date		date
order_id		text
order_value		bigint
prod_sku_id		text

<map_customer_territory>
cust_id			text
territory_id	text
*/

SELECT
    territory_id,
    100 * (
        SUM(q_sales) FILTER (WHERE quarter = 4)
        - SUM(q_sales) FILTER (WHERE quarter = 3)
    ) / SUM(q_sales) FILTER (WHERE quarter = 3) AS sales_growth
FROM (
    SELECT
        EXTRACT(QUARTER FROM order_date) AS quarter,
        territory_id,
        SUM(order_value) AS q_sales
    FROM fct_customer_sales AS sales
    JOIN map_customer_territory AS territory
    USING (cust_id)
    WHERE 
        EXTRACT(QUARTER FROM order_date) >= 3 
        AND EXTRACT(YEAR FROM order_date) = 2021
    GROUP BY 
        EXTRACT(QUARTER FROM order_date), 
        territory_id
) AS quarterly_sales
GROUP BY territory_id
HAVING COUNT(quarter) > 1;
