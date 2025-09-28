/*
https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders?code_type=1
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.

Difficulty: Medium

Tables:
<orders>
cust_id				bigint
id					bigint
order_date			date
order_details		text
total_order_cost	bigint

<customers>
address				text
city				text
first_name			text
id					bigint
last_name			text
phone_number		text

*/

SELECT
    AVG((c.address IS NOT NULL)::int) * 100 AS shippable_orders
FROM orders AS o
JOIN customers AS c
    ON o.cust_id = c.id;
