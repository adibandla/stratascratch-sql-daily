/*
https://platform.stratascratch.com/coding/2102-flags-per-video?code_type=1
For each video, find how many unique users flagged it. A unique user can be identified using the combination of their first name and last name. Do not consider rows in which there is no flag ID.

Difficulty: Medium

Tables:
<user_flags>
flag_id				text
user_firstname		text
user_lastname		text
video_id			text
*/

SELECT
    video_id,
    COUNT(DISTINCT CONCAT(user_firstname, user_lastname)) AS num_flagged
FROM user_flags
WHERE flag_id IS NOT NULL
GROUP BY video_id
ORDER BY 2 DESC
