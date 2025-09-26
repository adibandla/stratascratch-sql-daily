/*
https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?code_type=1
Find the top 5 states with the most 5 star businesses. Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. In case there are ties in the number of businesses, return all the unique states. If two states have the same result, sort them in alphabetical order.

Difficulty: Hard

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

WITH num_business AS (
    SELECT 
        state, 
        COUNT(*) AS num_business
    FROM yelp_business
    WHERE stars = 5
    GROUP BY state
),
ranked_business AS (
    SELECT
        state,
        num_business,
        DENSE_RANK() OVER (ORDER BY num_business DESC) AS rank
    FROM num_business
)
SELECT
    state,
    num_business
FROM ranked_business
WHERE rank <= 5
ORDER BY 
    rank,
    state;
