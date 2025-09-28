/*
https://platform.stratascratch.com/coding/10301-expensive-projects?code_type=1
Find the top 5 states with the most 5 star businesses. Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. In case there are ties in the number of businesses, return all the unique states. If two states have the same result, sort them in alphabetical order.

Difficulty: Medium

Tables:
<ms_projects>
budget		bigint
id			bigint
title		text

<ms_emp_projects>
emp_id		bigint
project_id	bigint
*/

SELECT 
    DISTINCT p.title,
    ROUND((budget / COUNT(e.emp_id) OVER (PARTITION BY id)::numeric)) AS budget_per_emp
FROM ms_projects p
JOIN ms_emp_projects e
ON p.id = e.project_id
ORDER BY 2 DESC
