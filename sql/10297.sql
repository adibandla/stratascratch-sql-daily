/*
https://platform.stratascratch.com/coding/10297-comments-distribution?code_type=1
Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.

The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. Your left column in the output will be the number of comments while your right column in the output will be the number of users. Sort the output from the least number of comments to highest.

To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result.

Difficulty: Hard

Tables:
<fb_users>
city_id		bigint
device		bigint
id			bigint
joined_at	date
name		text

<fb_comments>
body		text
created_at	date
user_id		bigint
*/

WITH num_comments_per_user AS (
    SELECT 
        u.id,
        COUNT(*) AS comment_count
    FROM fb_users u
    JOIN fb_comments c 
    	ON u.id = c.user_id
    WHERE created_at >= joined_at 
      AND joined_at BETWEEN '2018-01-01'::date AND '2020-12-31'::date 
      AND created_at BETWEEN '2020-01-01'::date AND '2020-01-31'::date
    GROUP BY u.id
)
SELECT
    comment_count,
    COUNT(*) AS freq
FROM num_comments_per_user
GROUP BY comment_count
ORDER BY freq;
