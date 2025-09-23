/*
https://platform.stratascratch.com/coding/10315-cities-with-the-most-expensive-homes?code_type=1
Write a query that identifies cities with higher than average home prices when compared to the national average. Output the city names.

Difficulty: Medium

Tables:
<zillow_transactions>
city			text
id				bigint
mkt_price		bigint
state			text
street_address	text
*/

SELECT city
FROM zillow_transactions
GROUP BY city
HAVING AVG(mkt_price) > (SELECT AVG(mkt_price) FROM zillow_transactions)
