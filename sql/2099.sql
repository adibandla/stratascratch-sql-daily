/*
https://platform.stratascratch.com/coding/2099-election-results?code_type=1
The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates. For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each. Some voters have chosen not to vote, which explains the blank entries in the dataset.

Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie. To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.

Difficulty: Medium

Tables:
<voting_results>
candidate		text
voter			text
*/

WITH vote_counts AS (
    SELECT
        voter,
        candidate,
        1::numeric / COUNT(*) OVER (PARTITION BY voter) AS num_votes
    FROM voting_results
    WHERE candidate IS NOT NULL
),
total_votes AS (
    SELECT 
        candidate,
        ROUND(SUM(num_votes), 3) AS tot_votes
    FROM vote_counts
    GROUP BY candidate
),
ranked_candidates AS (
    SELECT
        candidate,
        RANK() OVER (ORDER BY tot_votes DESC) AS rank
    FROM total_votes
)
SELECT candidate
FROM ranked_candidates
WHERE rank = 1;
