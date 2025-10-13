/*
https://platform.stratascratch.com/coding/9668-english-german-french-spanish-speakers?code_type=1
Find company IDs with more than 2 unique users who speak any of the following languages: English, German, French, or Spanish.

Difficulty: Medium

Tables:
<playbook_users>
activated_at		date
company_id			bigint
created_at			timestamp without time zone
language			text
state				text
user_id				bigint
*/

SELECT company_id
FROM playbook_users
WHERE language IN ('english', 'spanish', 'german', 'french')
GROUP BY company_id
HAVING COUNT(DISTINCT user_id) > 2
