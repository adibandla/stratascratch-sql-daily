/*
https://platform.stratascratch.com/coding/2087-negative-reviews-in-new-locations?code_type=1
Find stores that were opened in the second half of 2021 with more than 20% of their reviews being negative. A review is considered negative when the score given by a customer is below 5. Output the names of the stores together with the ratio of negative reviews to positive ones.

Difficulty: Hard

Tables:
<instacart_reviews>
customer_id		bigint
id				bigint
score			bigint
store_id		bigint

<instacart_stores>
id				bigint
name			text
opening_date	date
zipcode			bigint
*/

WITH filtered_stores AS (
    SELECT *
    FROM instacart_stores
    WHERE 
        EXTRACT(QUARTER FROM opening_date) >= 3
        AND EXTRACT(YEAR FROM opening_date) = 2021
)
SELECT
    s.name,
    (COUNT(*) FILTER (WHERE r.score < 5))::numeric /
    COUNT(*) FILTER (WHERE r.score >= 5) AS ratio
FROM instacart_reviews AS r
JOIN filtered_stores AS s
    ON r.store_id = s.id
GROUP BY 
    s.name,
    r.store_id
HAVING 
    COUNT(*) FILTER (WHERE r.score < 5)::numeric / COUNT(*) > 0.2;
