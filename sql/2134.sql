/*
https://platform.stratascratch.com/coding/2134-completed-trip-within-168-hours?code_type=1
For each city and date, determine the percentage of successful signups in the first 7 days of 2022 that completed a trip within 168 hours of the signup date.

A trip is considered completed if the status column in the trip_details table is marked as 'completed', and the actual_time_of_arrival occurs within 168 hours of the signup timestamp. The driver_id column in trip_details corresponds to the rider_id column in signup_events.

Difficulty: Hard

Tables:
<signup_events>
city_id						text
event_name					text
rider_id					text
timestamp					timestamp without time zone

<trip_details>
actual_time_of_arrival		timestamp without time zone
city_id						text
client_id					text
client_rating				double precision
driver_id					text
driver_rating				double precision
id							text
predicted_eta				timestamp without time zone
request_at					timestamp without time zone
status						text
*/

WITH signups AS (
    SELECT DISTINCT
        rider_id, 
        city_id,
        timestamp
    FROM signup_events
    WHERE 
        event_name = 'su_success'
        AND timestamp BETWEEN '2022-01-01'::date AND '2022-01-08'::date
),
trips AS (
    SELECT 
        s.rider_id,
        s.city_id,
        SUM(
            CASE 
                WHEN 
                    EXTRACT(EPOCH FROM (t.actual_time_of_arrival - s.timestamp)) / 3600 <= 168
                    AND t.status = 'completed'
                THEN 1 
                ELSE 0
            END
        ) AS trip_status
    FROM trip_details t 
    JOIN signups s
        ON t.driver_id = s.rider_id
    GROUP BY
        s.rider_id,
        s.city_id
)
SELECT
    a.city_id,
    a.timestamp::date AS date,
    ROUND(
        100 * COUNT(*) FILTER (WHERE b.trip_status > 0) / COUNT(*)::numeric,
        2
    ) AS per
FROM signups a
LEFT JOIN trips b
    USING (rider_id, city_id)
GROUP BY 
    a.city_id, 
    a.timestamp::date
ORDER BY 
    a.city_id, 
    date;
