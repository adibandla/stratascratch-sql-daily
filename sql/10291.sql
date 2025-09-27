/*
https://platform.stratascratch.com/coding/10291-sms-confirmations-from-users?code_type=1
Meta/Facebook sends SMS texts when users attempt to 2FA (2-factor authenticate) into the platform to log in. In order to successfully 2FA they must confirm they received the SMS text message. Confirmation texts are only valid on the date they were sent.

Unfortunately, there was an ETL problem with the database where friend requests and  invalid confirmation-type messages records were inserted into the logs, which are stored in the fb_sms_sends table. These message types should not be in the table. These message types should not be in the table and should be ignored.

Fortunately, the fb_confirmers table contains valid confirmation records so you can use this table to identify SMS text messages that were confirmed by the user.
Calculate the percentage of confirmed SMS texts for August 4, 2020. Be aware that there are multiple message types — only rows with type = 'message' represent actual 2FA messages that should be considered.

Difficulty: Medium

Tables:
<fb_sms_sends>
carrier			text
country			text
ds				date
phone_number	bigint
type			text

<fb_confirmers>
date			date
phone_number	bigint
*/

SELECT 100 * (COUNT(*) FILTER(WHERE date IS NOT NULL) / COUNT(*)::numeric) AS conf_users
FROM fb_sms_sends s
LEFT JOIN fb_confirmers c
ON s.ds = c.date AND s.phone_number = c.phone_number
WHERE s.type = 'message' AND s.ds = '2020-08-04'::date
