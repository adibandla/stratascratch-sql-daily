/*
https://platform.stratascratch.com/coding/10302-distance-per-dollar?code_type=1
You’re given a dataset of Uber rides with the traveling distance (distance_to_travel) and cost (monetary_cost) for each ride. First, find the difference between the distance-per-dollar for each ride and the monthly distance-per-dollar for that year-month.

Distance-per-dollar for each ride is defined as the distance traveled divided by the cost of the ride. Monthly distance-per-dollar is defined as the total distance traveled in that month divided by the total cost for that month.

Use the calculated difference on each date to calculate absolute average difference in distance-per-dollar metric on monthly basis (year-month).
The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).

You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

Difficulty: Hard

Tables:
<uber_request_logs>
distance_to_travel			double precision
driver_to_client_distance	double precision
monetary_cost				double precision
request_date				date
request_id					bigint
request_status				text
*/

WITH dist_per_dollar AS (
    SELECT
        request_id,
        request_date,
        distance_to_travel,
        monetary_cost,
        TO_CHAR(request_date, 'YYYY-MM') AS year_month,
        distance_to_travel / monetary_cost::float AS dist_per_dollar
    FROM uber_request_logs
),
mon_dist_per_dollar AS (
    SELECT
        year_month,
        dist_per_dollar,
        SUM(distance_to_travel) OVER (PARTITION BY year_month)
        /
        SUM(monetary_cost) OVER (PARTITION BY year_month) AS mon_dist_per_dollar
    FROM dist_per_dollar
)
SELECT 
    year_month,
    AVG(ABS(dist_per_dollar - mon_dist_per_dollar)) AS avg_abs_diff
FROM mon_dist_per_dollar
GROUP BY year_month
ORDER BY year_month;
