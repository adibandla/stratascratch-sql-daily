/*
https://platform.stratascratch.com/coding/9908-customer-orders-and-details?code_type=1
Find the number of orders, the number of customers, and the total cost of orders for each city. Only include cities that have made at least 5 orders and count all customers in each city even if they did not place an order.
Output each calculation along with the corresponding city name.

Difficulty: Medium

Tables:
<customers>
address				text
city				text
first_name			text
id					bigint
last_name			text
phone_number		text

<orders>
cust_id				bigint
id					bigint
order_date			date
order_details		text
total_order_cost	bigint
*/

SELECT
    city,
    COUNT(DISTINCT o.id) AS order_count,
    COUNT(DISTINCT c.id) AS cust_count,
    SUM(total_order_cost) AS city_total
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.cust_id
GROUP By city
HAVING COUNT(o.id) >= 5
