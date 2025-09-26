/*
https://platform.stratascratch.com/coding/2112-product-market-share?code_type=1
Write a query to find the market share at the product brand level for each territory, for the Q4-2021 time period.
Market share is defined as the number of orders of a certain product brand sold in a territory divided by the total number of orders sold in this territory.
Output the ID of the territory, name of the product brand and the corresponding market share in percentages. Only include these product brands that had at least one sale in a given territory.

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

<dim_product>
market_name		text
prod_brand		text
prod_sku_id		text
prod_sku_name	text
*/

WITH num_orders_per_brand AS (
    SELECT 
        t.territory_id, 
        p.prod_brand, 
        COUNT(*) AS num_orders
    FROM fct_customer_sales AS s
    JOIN dim_product AS p
        USING (prod_sku_id)
    JOIN map_customer_territory AS t
        USING (cust_id)
    WHERE EXTRACT(QUARTER FROM s.order_date) = 4 
      AND EXTRACT(YEAR FROM s.order_date) = 2021
    GROUP BY 
        t.territory_id, 
        p.prod_brand
)
SELECT 
    territory_id, 
    prod_brand, 
    100 * num_orders / SUM(num_orders) OVER (PARTITION BY territory_id) AS mkt_share
FROM num_orders_per_brand;
