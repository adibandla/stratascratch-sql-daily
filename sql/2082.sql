/*
https://platform.stratascratch.com/coding/2082-minimum-number-of-platforms?code_type=1
You are given a day worth of scheduled departure and arrival times of trains at one train station. One platform can only accommodate one train from the beginning of the minute it's scheduled to arrive until the end of the minute it's scheduled to depart. Find the minimum number of platforms necessary to accommodate the entire scheduled traffic.

Difficulty: Hard

Tables:
<train_arrivals>
arrival_time		text
train_id			bigint

<train_departures>
departure_time		text
train_id			bigint
*/

WITH time_delta AS (
    SELECT 
        train_id, 
        arrival_time::time AS timing, 
        1 AS delta
    FROM train_arrivals
    UNION ALL
    SELECT 
        train_id, 
        departure_time::time + INTERVAL '1 MINUTE' AS timing, 
        -1 AS delta
    FROM train_departures
),
train_counter AS (
    SELECT
        timing,
        SUM(delta) OVER (
            ORDER BY timing 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS concurrent_trains
    FROM time_delta
)
SELECT 
    MAX(concurrent_trains) AS min_num_platforms
FROM train_counter;
