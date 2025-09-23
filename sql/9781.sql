/*
https://platform.stratascratch.com/coding/9781-find-the-rate-of-processed-tickets-for-each-type?code_type=1
Find the processed rate of tickets for each type. The processed rate is defined as the number of processed tickets divided by the total number of tickets for that type. Round this result to two decimal places.

Difficulty: Medium

Tables:
<facebook_complaints>
complaint_id	bigint
processed		boolean
type			bigint
*/

SELECT
    type,
    COUNT(*) FILTER (WHERE processed = TRUE)::float 
        / COUNT(*)::float AS processed_rate
FROM facebook_complaints
GROUP BY type;
