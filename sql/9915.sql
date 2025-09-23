/*
https://platform.stratascratch.com/coding/9915-highest-cost-orders
Find the customers with the highest daily total order cost between 2019-02-01 and 2019-05-01.
If a customer had more than one order on a certain day, sum the order costs on a daily basis. Output each customer's first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique.

Difficulty: Medium

Tables:
<customer>
address			text
city			text
first_name		text
id			bigint
last_name		text
phone_number		text

<orders>
cust_id			bigint
id			bigint
order_date		date
order_details		text
total_order_cost	bigint
*/

WITH cust_daily_totals AS (
    SELECT 
    c.first_name, 
    order_date, 
    SUM(total_order_cost) AS total_order_cost,
    RANK() OVER (PARTITION BY o.order_date ORDER BY SUM(total_order_cost) DESC
    )
    FROM customers AS c
    JOIN orders AS o
    ON c.id = o.cust_id
    WHERE order_date BETWEEN '2019-02-01'::date AND '2019-05-01'::date
    GROUP BY c.id, o.order_date, c.first_name
)
    SELECT first_name, order_date, total_order_cost
    FROM cust_daily_totals
    WHERE rank = 1
