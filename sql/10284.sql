/*
https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=1
Find the popularity percentage for each user on Meta/Facebook. The dataset contains two columns, user1 and user2, which represent pairs of friends. Each row indicates a mutual friendship between user1 and user2, meaning both users are friends with each other. A user's popularity percentage is calculated as the total number of friends they have (counting connections from both user1 and user2 columns) divided by the total number of unique users on the platform. Multiply this value by 100 to express it as a percentage.

Output each user along with their calculated popularity percentage. The results should be ordered by user ID in ascending order.

Difficulty: Hard

Tables:
<facebook_friends>
user1		bigint
user2		bigint
*/

WITH num_friends AS (
    SELECT 
        user1,
        COUNT(*) AS num_friends
    FROM (
        SELECT user1 
        FROM facebook_friends
        UNION ALL
        SELECT user2 
        FROM facebook_friends
    ) AS all_friends
    GROUP BY user1
)
SELECT
    user1,
    100 * (num_friends / COUNT(*) OVER ()::float) AS popularity_percent
FROM num_friends
ORDER BY user1;
