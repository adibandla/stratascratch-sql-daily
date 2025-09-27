/*
https://platform.stratascratch.com/coding/10141-apple-product-counts?code_type=1
We’re analyzing user data to understand how popular Apple devices are among users who have performed at least one event on the platform. Specifically, we want to measure this popularity across different languages. Count the number of distinct users using Apple devices —limited to "macbook pro", "iphone 5s", and "ipad air" — and compare it to the total number of users per language.

Present the results with the language, the number of Apple users, and the total number of users for each language. Finally, sort the results so that languages with the highest total user count appear first.

Difficulty: Medium

Tables:
<playbook_events>
device			text
event_name		text
event_type		text
location		text
occurred_at		timestamp without time zone
user_id			bigint

<playbook_users>
activated_at	date
company_id		bigint
created_at		timestamp without time zone
language		text
state			text
user_id			bigint
*/

SELECT
  u.language,
  COUNT(DISTINCT u.user_id) FILTER (
    WHERE e.device IN ('macbook pro', 'iphone 5s', 'ipad air')
  ) AS num_apple_users,
  COUNT(DISTINCT u.user_id) AS num_users
FROM playbook_events AS e
JOIN playbook_users  AS u USING (user_id)
GROUP BY u.language
ORDER BY num_users DESC;
