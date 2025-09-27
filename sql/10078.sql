/*
https://platform.stratascratch.com/coding/10078-find-matching-hosts-and-guests-in-a-way-that-they-are-both-of-the-same-gender-and-nationality?code_type=1
Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.

Difficulty: Medium

Tables:
<airbnb_hosts>
age				bigint
gender			text
host_id			bigint
nationality		text

<airbnb_guests>
age				bigint
gender			text
guest_id		bigint
nationality		text
*/

SELECT 
    DISTINCT host_id, 
    guest_id
FROM airbnb_hosts h
JOIN airbnb_guests g
  ON h.gender = g.gender 
 AND h.nationality = g.nationality
