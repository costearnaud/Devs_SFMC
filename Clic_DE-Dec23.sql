select top 100 C.SubscriberKey, C.EventDate, S.visitor_private_id from _click C
INNER JOIN (
select visitor_id from ent.PROD_email_send_log
Where email_name = 'DE_RUH_MONO_NSEG_RuPa_FroheWeihnachten_12-23_ENT_NA'
and visitor_id not like 'SEED_VID%') S
ON C.SubscriberKey = S.SubscriberKey
where IsUnique = 1 and LinkName = 'unsubscribeLink'
AND CONVERT(DATE,EventDate) >= CONVERT(DATE,'2023-12-01')
