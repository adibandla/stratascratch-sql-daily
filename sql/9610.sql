/*
https://platform.stratascratch.com/coding/9610-find-students-with-a-median-writing-score?code_type=1
Identify the IDs of students who scored exactly at the median for the SAT writing section.

Difficulty: Medium

Tables:
<sat_scores>
average_sat				double precision
hrs_studied				double precision
id						bigint
love					double precision
sat_math				double precision
sat_verbal				double precision
sat_writing				double precision
school					text
student_id				double precision
teacher					text
*/

WITH median_sat AS (
    SELECT 
        PERCENTILE_CONT(0.5) 
        WITHIN GROUP (ORDER BY sat_writing) AS median_sat
    FROM sat_scores
)
SELECT 
    id
FROM sat_scores
WHERE sat_writing = (
    SELECT median_sat 
    FROM median_sat
);
