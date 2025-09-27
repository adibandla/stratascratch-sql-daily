/*
https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?code_type=1
Identify the most engaged guests by ranking them according to their overall messaging activity. The most active guest, meaning the one who has exchanged the most messages with hosts, should have the highest rank. If two or more guests have the same number of messages, they should have the same rank. Importantly, the ranking shouldn't skip any numbers, even if many guests share the same rank. Present your results in a clear format, showing the rank, guest identifier, and total number of messages for each guest, ordered from the most to least active.

Difficulty: Medium

Tables:
<airbnb_contacts>
ds_checkin				date
ds_checkout				date
id_guest				text
id_host					text
id_listing				text
n_guests				bigint
n_messages				bigint
ts_accepted_at			timestamp without time zone
ts_booking_at			timestamp without time zone
ts_contact_at			timestamp without time zone
ts_reply_at				timestamp without time zone
*/

WITH tot_guest_messages AS (
  SELECT
    id_guest,
    SUM(n_messages) AS tot_messages
  FROM airbnb_contacts
  GROUP BY id_guest
)
SELECT
  DENSE_RANK() OVER (ORDER BY tot_messages DESC) AS rank,
  id_guest,
  tot_messages
FROM tot_guest_messages
ORDER BY rank;
