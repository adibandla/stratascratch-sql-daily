/*
https://platform.stratascratch.com/coding/10171-find-the-genre-of-the-person-with-the-most-number-of-oscar-winnings?code_type=1
Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. Use the names as keys when joining the tables.

Difficulty: Hard

Tables:
<oscae_nominees>
category		text
id				bigint
movie			text
nominee			text
winner			boolean
year			bigint

<nominee_information>
amg_person_id		character varying
birthday			date
id					bigint
name				character varying
top_genre			character varying
*/

WITH wins AS (
    SELECT DISTINCT
        a.nominee,
        b.top_genre,
        COUNT(*) OVER (PARTITION BY a.nominee) AS wins
    FROM oscar_nominees AS a
    JOIN nominee_information AS b
        ON a.nominee = b.name
    WHERE a.winner = 'TRUE'
),
ranked_wins AS (
    SELECT
        nominee,
        top_genre,
        RANK() OVER (ORDER BY wins DESC, nominee) AS rnk
    FROM wins
)
SELECT
    top_genre
FROM ranked_wins
WHERE rnk = 1;
