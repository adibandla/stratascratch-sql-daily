/*
https://platform.stratascratch.com/coding/2033-find-the-most-profitable-location?code_type=1
Find the most profitable location. Write a query that calculates the average signup duration in days and the average transaction amount for each location. Then, calculate the ratio of average transaction amount to average duration.

Your output should include the location, average signup duration (in days), average transaction amount, and the ratio. Sort the results by ratio in descending order.

Difficulty: Hard

Tables:
<signups>
location				text
plan_id					bigint
signup_id				bigint
signup_start_date		date
signup_stop_date		date

<transactions>
amt						double precision
signup_id				bigint
transaction_id			bigint
transaction_start_date	date
*/

WITH signup_period AS (
    SELECT 
        location,
        AVG(signup_stop_date - signup_start_date) AS avg_signup_dur
    FROM signups
    GROUP BY location
),
avg_trans AS (
    SELECT
        s.location,
        AVG(t.amt) AS avg_amt
    FROM transactions AS t
    JOIN signups AS s
        USING (signup_id)
    GROUP BY s.location
)
SELECT
    a.location,
    a.avg_signup_dur,
    b.avg_amt,
    b.avg_amt / a.avg_signup_dur AS ratio
FROM signup_period AS a
JOIN avg_trans AS b
    USING (location)
ORDER BY ratio DESC;
