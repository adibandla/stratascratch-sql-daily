/*
https://platform.stratascratch.com/coding/10060-top-cool-votes?code_type=1
Find the review_text that received the highest number of  cool votes.
Output the business name along with the review text with the highest number of cool votes.

Difficulty: Medium

Tables:
<yelp_reviews>
business_name		text
cool				bigint
funny				bigint
review_date			date
review_id			text
review_text			text
stars				text
useful				bigint
user_id				text
*/

WITH ranked_data AS (
SELECT
    business_name,
    review_text,
    cool,
    RANK() OVER (ORDER BY cool DESC) AS cool_rank
FROM yelp_reviews
)
SELECT
    business_name,
    review_text
FROM ranked_data
WHERE cool_rank = 1
