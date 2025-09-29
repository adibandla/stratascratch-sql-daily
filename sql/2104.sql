/*
https://platform.stratascratch.com/coding/2104-user-with-most-approved-flags?code_type=1
Which user flagged the most distinct videos that ended up approved by YouTube? Output, in one column, their full name or names in case of a tie. In the user's full name, include a space between the first and the last name.

Difficulty: Medium

Tables:
<user_flags>
flag_id				text
user_firstname		text
user_lastname		text
video_id			text

<flag_review>
flag_id				text
reviewed_by_yt		boolean
reviewed_date		date
reviewed_outcome	text
*/

WITH app_video_counts AS (
    SELECT
        user_firstname,
        user_lastname,
        COUNT(DISTINCT video_id) AS video_count
    FROM user_flags AS f
    JOIN flag_review AS r
        USING (flag_id)
    WHERE reviewed_outcome = 'APPROVED'
    GROUP BY 
        user_firstname, 
        user_lastname
),
ranked AS (
    SELECT
        CONCAT(user_firstname, ' ', user_lastname) AS name,
        RANK() OVER (ORDER BY video_count DESC) AS rnk
    FROM app_video_counts
)
SELECT name
FROM ranked
WHERE rnk = 1;
