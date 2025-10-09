/*
https://platform.stratascratch.com/coding/9763-most-popular-room-types?code_type=1
Find the room types that are searched by most people. Output the room type alongside the number of searches for it. If the filter for room types has more than one room type, consider only unique room types as a separate row. Sort the result based on the number of searches in descending order.

Difficulty: Hard

Tables:
<airbnb_searches>
ds						date
ds_checkin				date
ds_checkout				date
filter_neighborhoods	text
filter_price_max		double precision
filter_price_min		double precision
filter_room_types		text
id_user					text
n_guests_max			bigint
n_guests_min			bigint
n_nights				double precision
n_searches				bigint
origin_country			text
*/

WITH room_types_unnested AS (
    SELECT DISTINCT
        *,
        UNNEST(
            STRING_TO_ARRAY(
                LTRIM(filter_room_types, ','), 
                ','
            )
        ) AS room_type
    FROM airbnb_searches
)
SELECT 
    room_type, 
    SUM(n_searches) AS num_searches
FROM room_types_unnested
GROUP BY room_type
ORDER BY num_searches DESC;
