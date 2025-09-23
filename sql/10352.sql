/*
https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1
Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit. Assume each user has only one session per day. 
If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit. 
Only consider sessions where the page_load occurs before the page_exit on the same day. Output the user_id and their average session time.

Difficulty: Medium

Tables:
<facebook_web_log>
action		text
timestamp	timestamp without time zone
user_id		bigint
*/

WITH page_events AS (
    SELECT
        user_id,
        timestamp::date AS date,
        MAX(timestamp) FILTER(WHERE action = 'page_load') AS latest_page_load,
        MIN(timestamp) FILTER(WHERE action = 'page_exit') AS earliest_page_exit
    FROM facebook_web_log
    WHERE action IN ('page_load', 'page_exit')
    GROUP BY user_id, timestamp::date
)
SELECT 
    user_id,
    AVG(earliest_page_exit::time - latest_page_load::time) AS avg_session_time
FROM page_events
WHERE latest_page_load IS NOT NULL 
    AND earliest_page_exit IS NOT NULL 
    AND latest_page_load < earliest_page_exit
GROUP BY user_id
