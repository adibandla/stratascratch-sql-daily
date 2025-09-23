/*
https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1
Calculate the friend acceptance rate for each date when friend requests were sent. A request is sent if action = sent and accepted if action = accepted. 
If a request is not accepted, there is no record of it being accepted in the table. The output will only include dates where requests were sent and at least one of them was accepted, 
as the acceptance rate can only be calculated for those dates. Show the results ordered from the earliest to the latest date.

Difficulty: Medium

Tables:
<fb_friend_requests>
action			text
date			date
user_id_receiver	text
user_id_sender		text
*/

SELECT 
    a.date,
    (COUNT(b.action) FILTER(WHERE b.action = 'accepted')::float / COUNT(a.action)::float)
FROM (SELECT * FROM fb_friend_requests WHERE action = 'sent') AS a
LEFT JOIN (SELECT * FROM fb_friend_requests WHERE action = 'accepted') AS b
USING(user_id_sender, user_id_receiver)
GROUP BY a.date
