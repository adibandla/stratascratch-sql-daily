/*
https://platform.stratascratch.com/coding/2090-first-day-retention-rate?code_type=1
Calculate the first-day retention rate of a group of video game players. The first-day retention occurs when a player logs in 1 day after their first-ever log-in.
Return the proportion of players who meet this definition divided by the total number of players.

Difficulty: Hard

Tables:
<players_logins>
login_date	date
player_id	bigint
*/

SELECT
    COUNT(DISTINCT player_id) FILTER(WHERE diff = 1 AND rank = 1) 
    / 
    COUNT(DISTINCT player_id)::float AS pct_rtn
FROM(
    SELECT
        player_id,
        LEAD(login_date) 
        OVER (PARTITION BY player_id ORDER BY login_date) - login_date AS diff,
        RANK() OVER (PARTITION BY player_id ORDER BY login_date) AS rank
    FROM players_logins
)
