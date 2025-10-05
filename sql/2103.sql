/*
https://platform.stratascratch.com/coding/2103-reviewed-flags-of-top-videos?code_type=1
For the video (or videos) that received the most user flags, how many of these flags were reviewed by YouTube? Output the video ID and the corresponding number of reviewed flags.  Ignore flags that do not have a corresponding flag_id.

Difficulty: Hard

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

WITH flag_counts AS (
    SELECT
        video_id,
        COUNT(*) AS flag_count,
        COUNT(*) FILTER (WHERE reviewed_by_yt = 'TRUE') AS rev_flag_count
    FROM user_flags u
    JOIN flag_review r USING (flag_id)
    WHERE flag_id IS NOT NULL
    GROUP BY video_id
),
ranks AS (
    SELECT
        video_id,
        rev_flag_count,
        RANK() OVER (ORDER BY flag_count DESC) AS rnk
    FROM flag_counts
)
SELECT
    video_id,
    rev_flag_count
FROM ranks
WHERE rnk = 1;
