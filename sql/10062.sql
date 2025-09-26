/*
https://platform.stratascratch.com/coding/10062-fans-vs-opposition?code_type=1
Meta/Facebook is quite keen on pushing their new programming language Hack to all their offices. They ran a survey to quantify the popularity of the language and send it to their employees. To promote Hack they have decided to pair developers which love Hack with the ones who hate it so the fans can convert the opposition. Their pair criteria is to match the biggest fan with biggest opposition, second biggest fan with second biggest opposition, and so on. Write a query which returns this pairing. Output employee ids of paired employees. Sort users with the same popularity value by id in ascending order.

Duplicates in pairings can be left in the solution. For example, (2, 3) and (3, 2) should both be in the solution.

Difficulty: Hard

Tables:
<facebook_hack_survey>
age				bigint
employee_id		bigint
gender			text
popularity		bigint
*/

WITH ranked_employees AS(
    SELECT 
        *, 
        DENSE_RANK() OVER (ORDER BY popularity DESC, employee_id) AS ranked_lovers,
        DENSE_RANK() OVER (ORDER BY popularity, employee_id) AS ranked_opp
    FROM facebook_hack_survey
)
SELECT 
    a.employee_id AS employee_fan_id,
    b.employee_id AS employee_opposition_id
FROM ranked_employees a
JOIN ranked_employees b
ON a.ranked_lovers = b.ranked_opp
