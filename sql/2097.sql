/*
https://platform.stratascratch.com/coding/2097-premium-acounts?code_type=1
You have a dataset that records daily active users for each premium account. A premium account appears in the data every day as long as it remains premium. However, some premium accounts may be temporarily discounted, meaning they are not actively paying — this is indicated by a final_price of 0.

For each of the first 7 available dates in the dataset, count the number of premium accounts that were actively paying on that day. Then, track how many of those same accounts are still premium and actively paying exactly 7 days later, based solely on their status on that 7th day (i.e., both dates must exist in the dataset). Accounts are only counted if they appear in the data on both dates.

Output three columns:
The date of initial calculation.
The number of premium accounts that were actively paying on that day.
The number of those accounts that remain premium and are still paying after 7 days.

Difficulty: Medium

Tables:
<premium_accounts_by_day>
account_id			text
entry_date			date
final_price			bigint
plan_size			bigint
users_visited_7d	bigint
*/

WITH num_prem_accounts_initial AS (
    SELECT
        entry_date AS initial,
        entry_date + 7 AS d7,
        account_id,
        DENSE_RANK() OVER (ORDER BY entry_date) AS date_rank,
        COUNT(*) OVER (PARTITION BY entry_date) AS num_premium_accounts
    FROM premium_accounts_by_day
    WHERE final_price > 0
)
SELECT DISTINCT
	a.initial,
    a.num_premium_accounts,
    COUNT(*) OVER (PARTITION BY a.initial) AS rem_premium_accounts
FROM num_prem_accounts_initial AS a
JOIN premium_accounts_by_day AS b
	ON a.d7 = b.entry_date
	AND a.account_id = b.account_id
WHERE a.date_rank <= 7
	AND b.final_price > 0
ORDER BY a.initial;
