/*
https://platform.stratascratch.com/coding/10369-spotify-penetration-analysis?code_type=1
Market penetration is an important metric for understanding Spotify's performance and growth potential in different regions.
You are part of the analytics team at Spotify and are tasked with calculating the active user penetration rate in specific countries.

For this task, 'active_users' are defined based on the  following criterias:
last_active_date: The user must have interacted with Spotify within the last 30 days.
sessions: The user must have engaged with Spotify for at least 5 sessions.
listening_hours: The user must have spent at least 10 hours listening on Spotify.

Based on the condition above, calculate the active 'user_penetration_rate' by using the following formula.
Active User Penetration Rate = (Number of Active Spotify Users in the Country / Total users in the Country)

Total Population of the country is based on both active and non-active users.
​The output should contain 'country' and 'active_user_penetration_rate' rounded to 2 decimals.
Let's assume the current_day is 2024-01-31.

Difficulty: Hard

Tables:
<penetration_analysis>
country				text
last_active_date	date
listening_hours		bigint
sessions			bigint
user_id				bigint
*/

WITH
  active_users AS (
    SELECT
      user_id,
      country,
      CASE
        WHEN last_active_date BETWEEN '2024-01-31'::date - 30 AND '2024-01-31'
          AND sessions >= 5
          AND listening_hours >= 10
        THEN 1
        ELSE 0
      END AS active
    FROM penetration_analysis
  )
SELECT
  country,
  ROUND(
    (COUNT(*) FILTER (WHERE active = 1))::numeric / COUNT(*)::numeric,
    2
  ) AS pen_rate
FROM active_users
GROUP BY country;
