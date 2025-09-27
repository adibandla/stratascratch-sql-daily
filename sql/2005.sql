
/*
https://platform.stratascratch.com/coding/2005-share-of-active-users?code_type=1
Calculate the percentage of users who are both from the US and have an 'open' status, as indicated in the fb_active_users table.

Difficulty: Medium

Tables:
<fb_active_users>
country		text
name		text
status		text
user_id		bigint
*/

SELECT
  100
  * COUNT(DISTINCT user_id) FILTER (WHERE country = 'USA' AND status = 'open')::numeric
  / COUNT(DISTINCT user_id)::numeric AS usa_active_share
FROM fb_active_users;
