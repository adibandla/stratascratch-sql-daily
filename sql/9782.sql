/*
https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?code_type=1
Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019. An active user is a customer who made at least one transaction in March 2019.
Output the revenue along with the customer id and sort the results based on the revenue in descending order.

Difficulty: Medium

Tables:
<orders>
cust_id				bigint
id					bigint
order_date			date
order_details		text
total_order_cost	bigintn
*/

SELECT 
    cust_id,
    SUM(total_order_cost) AS total_mar_rev
FROM orders
WHERE order_date BETWEEN '2019-03-01'::date AND '2019-03-31'::date
GROUP BY cust_id
ORDER BY 2 DESC
