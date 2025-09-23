/*
https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1
Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. Ignore same-day purchases. Output a list of these user_ids.

Difficulty: Medium

Tables:
<amazon_transactions>
created_at		date
id				bigint
item			text
revenue			bigint
user_id			bigint
*/
SELECT user_id
FROM (
    SELECT 
        DISTINCT user_id, 
        created_at,
        LEAD(created_at) 
        OVER (PARTITION BY user_id ORDER BY created_at) - created_at AS diff,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at) AS row_num
    FROM amazon_transactions
    )
WHERE diff BETWEEN 1 AND 7
AND row_num = 1
