/*
https://platform.stratascratch.com/coding/10049-reviews-of-categories?code_type=1
Calculate number of reviews for every business category. Output the category along with the total number of reviews. Order by total reviews in descending order.

Difficulty: Medium

Tables:
<yelp_business>
address				text
business_id			text
categories			text
city				text
is_open				bigint
latitude			double precision
longitude			double precision
name				text
neighborhood		text
postal_code			text
review_count		bigint
stars				double precision
state				text
*/

SELECT
    business_category,
    SUM(review_count) AS total_reviews
FROM yelp_business
CROSS JOIN LATERAL unnest(string_to_array(categories, ';'))
WITH ORDINALITY AS u(business_category)
GROUP BY business_category
ORDER BY 2 DESC
