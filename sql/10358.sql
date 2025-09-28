/*
https://platform.stratascratch.com/coding/10358-friday-purchases?code_type=1
IBM is working on a new feature to analyze user purchasing behavior for all Fridays in the first quarter of the year. In this question first quarter is defined as first 13 weeks. For each Friday separately, calculate the average amount users have spent per order. The output should contain the week number of that Friday and average amount spent.

Difficulty: Hard

Tables:
<user_purchases>
amount_spent		double precision
date				date
day_name			text
user_id				bigint
*/

WITH pur_amt_q1 AS (
    SELECT
        user_id,
        date,
        day_name,
        SUM(amount_spent) AS amt_spent,
        COUNT(*) AS num_purchases,
        EXTRACT(WEEK FROM date) AS week
    FROM user_purchases
    GROUP BY
        user_id,
        date,
        day_name
    HAVING EXTRACT(WEEK FROM date) <= 13
)
SELECT
    week,
    COALESCE(
        SUM(amt_spent) FILTER (WHERE day_name = 'Friday') / 
		SUM(num_purchases) FILTER (WHERE day_name = 'Friday'), 0
	) AS avg_amt_per_friday
FROM pur_amt_q1
GROUP BY week
ORDER BY week;
