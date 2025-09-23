/*
https://platform.stratascratch.com/coding/2007-rank-variance-per-country?code_type=1
Compare the total number of comments made by users in each country between December 2019 and January 2020. For each month, rank countries by total 
comments using dense ranking (i.e., avoid gaps between ranks) in descending order. Then, return the names of the countries whose rank improved from December to January.

Difficulty: Hard

Tables:
<fb_comments_count>
created_at			date
number_of_comments	bigint
user_id				bigint

<fb_active_users>
country				text
name				text
status				text
user_id				bigint
*/

WITH comment_totals_per_month AS (
    SELECT 
        country, 
        EXTRACT(MONTH FROM created_at) AS month,
        DENSE_RANK() 
        OVER (
        PARTITION BY EXTRACT(MONTH FROM created_at) 
        ORDER BY SUM(number_of_comments) DESC
        ) AS rank
    FROM fb_comments_count AS c
    JOIN fb_active_users AS u
    USING(user_id)
    WHERE created_at BETWEEN '2019-12-01'::date AND '2020-01-31'::date
    GROUP BY country, EXTRACT(MONTH FROM created_at)
) 
SELECT dec.country
FROM comment_totals_per_month AS dec
JOIN comment_totals_per_month AS jan
ON dec.country = jan.country AND dec.month = 12 AND jan.month = 1
WHERE jan.rank < dec.rank
