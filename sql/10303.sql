/*
https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=1
We want to identify the most suspicious claims in each state. We'll consider the top 5 percentile of claims with the highest fraud scores in each state as potentially fraudulent.
Your output should include the policy number, state, claim cost, and fraud score.

Difficulty: Hard

Tables:
<fraud_score>
claim_cost		bigint
fraud_score		double precision
policy_num		text
state			text
*/

WITH per_rank_data AS (
    SELECT
        *,
        100 * PERCENT_RANK() OVER (
            PARTITION BY state 
            ORDER BY fraud_score DESC
        ) AS per_rank
    FROM fraud_score
)
SELECT
    policy_num,
    state,
    claim_cost,
    fraud_score
FROM per_rank_data
WHERE per_rank <= 5
ORDER BY policy_num;
