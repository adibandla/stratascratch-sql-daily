/*
https://platform.stratascratch.com/coding/10048-top-businesses-with-most-reviews?code_type=1
Find the top 5 businesses with most reviews. Assume that each row has a unique business_id such that the total reviews for each business is listed on each row. Output the business name along with the total number of reviews and order your results by the total reviews in descending order.


If there are ties in review counts, businesses with the same number of reviews receive the same rank, and subsequent ranks are skipped accordingly (e.g., if two businesses tie for rank 4, the next business receives rank 6, skipping rank 5).

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
    name,
    review_count
FROM(
    SELECT
        name,
        review_count,
        RANK() OVER (ORDER BY review_count DESC) AS score_rank
    FROM yelp_business
)
WHERE score_rank <= 5
ORDER BY month
