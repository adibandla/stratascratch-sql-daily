/*
https://platform.stratascratch.com/coding/10300-premium-vs-freemium?code_type=1
Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. 
The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. Hint: In Oracle you should use "date" 
when referring to date column (reserved keyword).

Difficulty: Medium

Tables:
<ms_user_dimension>
acc_id			bigint
user_id			bigint

<ms_acc_dimension>
acc_id			bigint
paying_customer	text

<ms_download_facts>
date			date
downloads		bigint
user_id			bigint
*/
WITH stats AS (SELECT
    date,
    SUM(downloads) FILTER(WHERE paying_customer = 'no') AS non_paying,
    SUM(downloads) FILTER (WHERE paying_customer = 'yes') AS paying
FROM 
    ms_user_dimension AS u
    JOIN ms_acc_dimension AS a
    USING(acc_id)
    JOIN ms_download_facts AS d
    USING(user_id)
    GROUP BY date
    ORDER BY date
)
SELECT
    date,
    non_paying,
    paying
FROM stats
WHERE non_paying > paying
