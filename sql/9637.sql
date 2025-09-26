/*
https://platform.stratascratch.com/coding/9637-growth-of-airbnb?code_type=1
Calculate Airbnb's annual growth rate using the number of registered hosts as the key metric. The growth rate is determined by:
Growth Rate = ((Number of hosts registered in the current year - number of hosts registered in the previous year) / number of hosts registered in the previous year) * 100
Output the year, number of hosts in the current year, number of hosts in the previous year, and the growth rate. Round the growth rate to the nearest percent. Sort the results in ascending order by year.

Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.

Difficulty: Hard

Tables:
<airbnb_search_details>
accommodates			bigint
amenities				text
bathrooms				bigint
bed_type				text
bedrooms				bigint
beds					bigint
cancellation_policy		text
city					text
cleaning_fee			boolean
host_identity_verified	text
host_response_rate		text
host_since				date
id						bigint
neighbourhood			text
number_of_reviews		bigint
price					double precision
property_type			text
review_scores_rating	double precision
room_type				text
zipcode					bigint
*/

WITH hosts_per_year AS (
    SELECT 
        EXTRACT(YEAR FROM host_since) AS year, 
        COUNT(*) AS num_hosts
    FROM airbnb_search_details
    GROUP BY EXTRACT(YEAR FROM host_since)
    ORDER BY 1 DESC
)
SELECT 
    year,
    num_hosts,
    LEAD(num_hosts) OVER (ORDER BY year DESC) AS num_hosts_prev_year,
    ROUND(
        100 * (
            (num_hosts::float - LEAD(num_hosts) OVER (ORDER BY year DESC)::float)
            / LEAD(num_hosts) OVER (ORDER BY year DESC)::float
        )
    ) AS growth_rate
FROM hosts_per_year
ORDER BY year ASC;
