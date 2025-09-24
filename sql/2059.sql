/*
https://platform.stratascratch.com/coding/2059-player-with-longest-streak?code_type=1
You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak.

Difficulty: Hard

Tables:
<players_results>
match_date		date
match_result	text
player_id		bigint
*/

WITH streaks AS (
    SELECT
        player_id,
        match_result,
        ROW_NUMBER() OVER (
            PARTITION BY player_id 
            ORDER BY match_date
        )
        - SUM(
            CASE WHEN match_result = 'W' THEN 1 ELSE 0 END
        ) OVER (
            PARTITION BY player_id 
            ORDER BY match_date
        ) AS diff_rn_cumsum_wins
    FROM players_results
),

streak_len AS (
    SELECT 
        player_id,
        COUNT(*) AS streak_len
    FROM streaks
    WHERE match_result = 'W'
    GROUP BY player_id, diff_rn_cumsum_wins
),

ranked_streaks AS (
    SELECT
        player_id,
        streak_len,
        RANK() OVER (
            PARTITION BY player_id 
            ORDER BY streak_len DESC
        ) AS streak_rank
    FROM streak_len
)
	
SELECT
    player_id,
    streak_len
FROM ranked_streaks
WHERE streak_rank = 1;
