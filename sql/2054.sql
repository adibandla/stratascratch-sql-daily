/*
https://platform.stratascratch.com/coding/2054-consecutive-days?code_type=1
Find all the users who were active for 3 consecutive days or more.

Difficulty: Hard

Tables:
<sf_events>
account_id		character varying
record_date		date
user_id			character varying
*/

/* this solution finds all streaks that were a minimum of 3 consecutive days as asked in the question */
WITH date_diff AS(
    SELECT
        record_date,
        user_id,
        (LEAD(record_date, 2) OVER (PARTITION BY user_id ORDER BY record_date)) 
        - record_date AS date_diff
    FROM sf_events
    ORDER BY user_id, record_date
)
SELECT user_id
FROM date_diff
WHERE date_diff = 2

/* an alternative solution is to find all streaks ≥ 3 consecutive days */
WITH streak_groups AS (
    SELECT
        record_date,
        user_id,
        ABS(
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY record_date)
            - (record_date - DATE '2020-01-01')
        ) AS streak_group
    FROM sf_events
)
SELECT 
    user_id
FROM streak_groups
GROUP BY 
    user_id,
    streak_group
HAVING COUNT(*) >= 3;
