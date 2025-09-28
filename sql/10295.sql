/*
https://platform.stratascratch.com/coding/10295-most-active-users-on-messenger?code_type=1
Meta/Facebook Messenger stores the number of messages between users in a table named 'fb_messages'. In this table 'user1' is the sender, 'user2' is the receiver, and 'msg_count' is the number of messages exchanged between them.

Find the top 10 most active users on Meta/Facebook Messenger by counting their total number of messages sent and received. Your solution should output usernames and the count of the total messages they sent or received

Difficulty: Medium

Tables:
<fb_messages>
date		date
id			bigint
msg_count	bigint
user1		text
user2		text
*/

WITH all_msgs AS (
  SELECT user1, msg_count FROM fb_messages
  UNION ALL
  SELECT user2 AS user1, msg_count FROM fb_messages
),
totals AS (
  SELECT
    user1,
    SUM(msg_count) AS tot_msgs
  FROM all_msgs
  GROUP BY user1
),
ranked AS (
  SELECT
    user1,
    tot_msgs,
    RANK() OVER (ORDER BY tot_msgs DESC) AS rnk
  FROM totals
)
SELECT
  user1,
  tot_msgs
FROM ranked
WHERE rnk <= 10
ORDER BY rnk;
