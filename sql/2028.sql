/*
https://platform.stratascratch.com/coding/2028-new-and-existing-users?code_type=1
Calculate the share of new and existing users for each month in the table. Output the month, share of new users, and share of existing users as a ratio.

New users are defined as users who started using services in the current month (there is no usage history in previous months). Existing users are users who used services in the current month, and who also used services in any prior month of 2020.

Assume that the dates are all from the year 2020 and that users are contained in user_id column.

Difficulty: Hard

Tables:
<fact_events>
client_id		text
customer_id		text
event_id		bigint
event_type		text
id				bigint
time_id			date
user_id			text
*/

WITH
  user_time_ranks AS (
    SELECT
      user_id,
      EXTRACT(MONTH FROM time_id) AS month,
      DENSE_RANK() OVER (
        PARTITION BY user_id
        ORDER BY EXTRACT(MONTH FROM time_id)
      ) AS rank
    FROM fact_events
  ),
  user_class AS (
    SELECT DISTINCT
      user_id,
      month,
      CASE
        WHEN rank = 1 THEN 'new'
        ELSE 'existing'
      END AS class
    FROM user_time_ranks
  )
SELECT
  month,
  COUNT(*) FILTER (WHERE class = 'new') / COUNT(*)::numeric AS share_new_users,
  COUNT(*) FILTER (WHERE class = 'existing') / COUNT(*)::numeric AS share_existing_users
FROM user_class
GROUP BY month
ORDER BY month;
