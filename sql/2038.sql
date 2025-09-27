/*
https://platform.stratascratch.com/coding/2038-wfm-brand-segmentation-based-on-customer-activity?code_type=1
WFM would like to segment the customers in each of their store brands into Low, Medium, and High segmentation. The segments are to be based on a customer's average basket size which is defined as (total sales / count of transactions), per customer.

The segment thresholds are as follows:
If average basket size is more than $30, then Segment is “High”.
If average basket size is between $20 and $30, then Segment is “Medium”.
If average basket size is less than $20, then Segment is “Low”.

Summarize the number of unique customers, the total number of transactions, total sales, and average basket size, grouped by store brand and segment for 2017.
Your output should include the brand, segment, number of customers, total transactions, total sales, and average basket size.

Difficulty: Hard

Tables:
<wfm_transactions>
customer_id			bigint
product_id			bigint
sales				bigint
store_id			bigint
transaction_date	date
transaction_id		bigint

<wfm_stores>
location			text
store_brand			text
store_id			bigint
*/

WITH cust_data AS (
    SELECT
        t.customer_id,
        EXTRACT(YEAR FROM t.transaction_date) AS year,
        s.store_brand,
        COUNT(DISTINCT t.transaction_id) AS num_transactions,
        SUM(t.sales) AS total_sales,
        SUM(t.sales)::numeric / NULLIF(COUNT(DISTINCT t.transaction_id), 0) AS basket_size
    FROM wfm_transactions t
    JOIN wfm_stores s USING (store_id)
    GROUP BY
        t.customer_id,
        s.store_brand,
        EXTRACT(YEAR FROM t.transaction_date)
),
cust_segmented AS (
    SELECT
        customer_id,
        year,
        store_brand,
        num_transactions,
        total_sales,
        basket_size,
        CASE
            WHEN basket_size > 30 THEN 'High'
            WHEN basket_size BETWEEN 20 AND 30 THEN 'Medium'
            ELSE 'Low'
        END AS segment
    FROM cust_data
)
SELECT
    store_brand,
    segment,
    COUNT(DISTINCT customer_id) AS num_customers,
    SUM(num_transactions) AS tot_transactions,
    SUM(total_sales) AS total_sales,
    ROUND(SUM(total_sales)::numeric / NULLIF(SUM(num_transactions), 0), 2) AS avg_basket_size
FROM cust_segmented
WHERE year = 2017
GROUP BY store_brand, segment
ORDER BY store_brand, segment;
