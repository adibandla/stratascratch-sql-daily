/*
https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=1
Find the best-selling item for each month (no need to separate months by year). The best-selling item is determined by the highest total sales amount, calculated as: 
total_paid = unitprice * quantity. Output the month, description of the item, and the total amount paid.

Difficulty: Hard

Tables:
<online_retail>
country			text
customerid		double precision
description		text
invoicedate		date
invoiceno		text
quantity		bigint
stockcode		text
unitprice		double precision
*/

SELECT
    month,
    description,
    total_paid_monthly
FROM (SELECT
            stockcode,
            description,
            SUM(unitprice * quantity) AS total_paid_monthly,
            EXTRACT(MONTH FROM invoicedate) AS month,
            RANK() 
            OVER (PARTITION BY EXTRACT(MONTH FROM invoicedate) 
                  ORDER BY SUM(unitprice * quantity) DESC) 
            AS rank
      FROM online_retail
      GROUP BY stockcode, month, description
      ORDER BY stockcode
)
WHERE rank = 1
ORDER BY month
