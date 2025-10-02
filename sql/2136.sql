/*
https://platform.stratascratch.com/coding/2136-customer-tracking?code_type=1
Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.
Note: The session starts when state=1 and ends when state=0.

Difficulty: Hard

Tables:
<customer_tracking>
cust_id			text
state			bigint
timestamp		timestamp without time zone
*/

WITH paired_logs AS(
    SELECT
        cust_id,
        state,
        timestamp,
        LEAD(state) OVER (PARTITION BY cust_id ORDER BY timestamp) AS next_state,
        LEAD(timestamp) OVER (PARTITION BY cust_id ORDER BY timestamp) AS exit_stamp
    FROM cust_tracking
)
SELECT 
    cust_id,
    SUM(exit_stamp - timestamp) / 3600 AS hours_active
FROM paired_logs
WHERE 
    state = 1 
    AND next_state = 0
GROUP BY cust_id
