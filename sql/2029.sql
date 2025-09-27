/*
https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls/solutions?code_type=1
Select the most popular client_id based on the number of users who individually have at least 50% of their events from the following list: 'video call received', 'video call sent', 'voice call received', 'voice call sent'.

Difficulty: Hard

Tables:
<fact_events>
client_id			text
customer_id			text
event_id			bigint
event_type			text
id					bigint
time_id				date
user_id				text
*/

WITH event_per AS (
    SELECT
        user_id,
        COUNT(*) FILTER (
            WHERE event_type IN (
                'video call received', 
                'video call sent', 
                'voice call received', 
                'voice call sent'
            )
        ) / COUNT(*)::float AS per_events
    FROM fact_events
    GROUP BY user_id
)
SELECT client_id
FROM fact_events
JOIN event_per USING (user_id)
WHERE per_events >= 0.5
GROUP BY client_id
ORDER BY COUNT(DISTINCT user_id) DESC
LIMIT 1;
