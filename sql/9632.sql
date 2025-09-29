/*
https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?code_type=1
You are given a table named airbnb_host_searches that contains data for rental property searches made by users. Determine the minimum, average, and maximum rental prices for each popularity-rating bucket. A popularity-rating bucket should be assigned to every record based on its number_of_reviews (see rules below).

The host’s popularity rating is defined as below:
0 reviews: "New"
1 to 5 reviews: "Rising"
6 to 15 reviews: "Trending Up"
16 to 40 reviews: "Popular"
More than 40 reviews: "Hot"

Tip: The id column in the table refers to the search ID.
Output host popularity rating and their minimum, average and maximum rental prices. Order the solution by the minimum price.

Difficulty: Medium

Tables:
<airbnb_host_searches>
accommodates				bigint
amenities					text
bathrooms					bigint
bed_type					text
bedrooms					bigint
beds						bigint
cancellation_policy			text
city						text
cleaning_fee				boolean
host_identity_verified		text
host_response_rate			text
host_since					date
id							bigint
neighbourhood				text
number_of_reviews			bigint
price						double precision
property_type				text
review_scores_rating		double precision
room_type					text
zipcode						bigint
*/

WITH pop_rating AS (
SELECT
    *,
    CASE
        WHEN number_of_reviews = 0 THEN 'New'
        WHEN number_of_reviews > 40 THEN 'Hot'
        WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
        WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
        WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
        ELSE 'NA'
    END AS popularity_rating
FROM airbnb_host_searches
)
SELECT
    popularity_rating,
    MIN(price) AS min_price,
    AVG(price) AS avg_price,
    MAX(price) AS max_price
FROM pop_rating
GROUP BY popularity_rating;
