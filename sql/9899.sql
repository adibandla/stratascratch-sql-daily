/*
https://platform.stratascratch.com/coding/9899-percentage-of-total-spend?code_type=1
Calculate the ratio of the total spend a customer spent on each order. Output the customer’s first name, order details, and ratio of the order cost to their total spend across all orders.
Assume each customer has a unique first name (i.e., there is only 1 customer named Karen in the dataset) and that customers place at most only 1 order a day.
Percentages should be represented as decimals

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
    c.first_name,
    o.order_details,
    total_order_cost / SUM(total_order_cost) OVER (PARTITION BY cust_id) AS ratio
FROM orders AS o
JOIN customers AS c
ON o.cust_id = c.id
