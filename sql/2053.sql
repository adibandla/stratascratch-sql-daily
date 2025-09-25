/*
https://platform.stratascratch.com/coding/2053-retention-rate?code_type=1
You are given a dataset that tracks user activity. The dataset includes information about the date of user activity, the account_id associated with the activity, and the user_id of the user performing the activity. Each row in the dataset represents a user’s activity on a specific date for a particular account_id.

Your task is to calculate the monthly retention rate for users for each account_id for December 2020 and January 2021. The retention rate is defined as the percentage of users active in a given month who have activity in any future month.

For instance, a user is considered retained for December 2020 if they have activity in December 2020 and any subsequent month (e.g., January 2021 or later). Similarly, a user is retained for January 2021 if they have activity in January 2021 and any later month (e.g., February 2021 or later).

The final output should include the account_id and the ratio of the retention rate in January 2021 to the retention rate in December 2020 for each account_id. If there are no users retained in December 2020, the retention rate ratio should be set to 0.

Difficulty: Hard

Tables:
<sf_events>
account_id		character varying
record_date		date
user_id			character varying
*/

WITH dec_retention AS (
    SELECT 
        a.account_id,
        COUNT(b.user_id)::float / COUNT(a.user_id)::float AS dec_ret_rate
    FROM (
        SELECT DISTINCT account_id, user_id
        FROM sf_events
        WHERE record_date BETWEEN '2020-12-01' AND '2020-12-31'
    ) a
    LEFT JOIN (
        SELECT DISTINCT user_id
        FROM sf_events
        WHERE record_date > '2020-12-31'
    ) b ON a.user_id = b.user_id
    GROUP BY a.account_id
),
jan_retention AS (
    SELECT 
        a.account_id,
        COUNT(b.user_id)::float / COUNT(a.user_id)::float AS jan_ret_rate
    FROM (
        SELECT DISTINCT account_id, user_id
        FROM sf_events
        WHERE record_date BETWEEN '2021-01-01' AND '2021-01-31'
    ) a
    LEFT JOIN (
        SELECT DISTINCT user_id
        FROM sf_events
        WHERE record_date > '2021-01-31'
    ) b ON a.user_id = b.user_id
    GROUP BY a.account_id
)
SELECT 
    COALESCE(d.account_id, j.account_id) AS account_id,
    j.jan_ret_rate / d.dec_ret_rate AS ratio
FROM dec_retention d
FULL OUTER JOIN jan_retention j 
    ON d.account_id = j.account_id;
