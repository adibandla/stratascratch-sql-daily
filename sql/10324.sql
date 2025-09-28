/*
https://platform.stratascratch.com/coding/10324-distances-traveled?code_type=1
Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.

Difficulty: Medium

Tables:
<lyft_rides_log>
distance		bigint
id				bigint
user_id			bigint

<lyft_users>
id				bigint
name			text
*/

WITH user_dist_ranked AS(
    SELECT
        u.id,
        u.name,
        SUM(distance) AS tot_dist,
        RANK() OVER (ORDER BY SUM(distance) DESC) AS user_rank
    FROM lyft_rides_log AS l
    JOIN lyft_users AS u
        ON l.user_id = u.id
    GROUP BY 
        u.id, 
        u.name
)
SELECT
    id,
    name,
    tot_dist
FROM user_dist_ranked
WHERE user_rank <= 10;
