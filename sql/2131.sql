/*
https://platform.stratascratch.com/coding/2131-user-streaks?code_type=1
Provided a table with user id and the dates they visited the platform, find the top 3 users with the longest continuous streak of visiting the platform as of August 10, 2022. Output the user ID and the length of the streak.

In case of a tie, display all users with the top three longest streaks.

Difficulty: Hard

Tables:
<user_streaks>
date_visited		date
user_id				text
*/

WITH visits AS (
    SELECT DISTINCT 
        user_id, 
        date_visited
    FROM user_streaks
    WHERE date_visited <= '2022-08-10'::date
),
streaks AS (
    SELECT
        user_id,
        gap,
        SUM(
            CASE 
                WHEN gap > 1 THEN 1 ELSE 0 
            END
        ) OVER (PARTITION BY user_id ORDER BY date_visited) AS streak_id
    FROM (
        SELECT
            user_id,
            date_visited,
            COALESCE(
                date_visited - LAG(date_visited) 
                    OVER (PARTITION BY user_id ORDER BY date_visited),
                2
            ) AS gap
        FROM visits
    ) g
),
streak_count AS (
    SELECT
        user_id,
        COUNT(*) AS streak_len
    FROM streaks
    GROUP BY user_id, streak_id
),
rankings AS (
    SELECT
        user_id,
        MAX(streak_len) AS max_streak_len,
        DENSE_RANK() OVER (ORDER BY MAX(streak_len) DESC) AS rnk
    FROM streak_count
    GROUP BY user_id
)
SELECT 
    user_id,
    max_streak_len
FROM rankings
WHERE rnk <= 3;
