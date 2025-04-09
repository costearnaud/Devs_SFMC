select visitor_id, country_code, count(1) as c 
from all_visitors
group by visitor_id, country_code
having count(1) > 1

select visitor_id,country_code, pc_code
from all_visitors
where visitor_id IN ('52d6faa5-d37f-432c-9f00-2111a6a790d9','a9758922-690c-4872-b760-d600aa600ca7','35315639-21b9-46bc-a864-141eb5f68d71','c25e820d-8876-4755-b375-2ace368bc31e','58e9bd38-25be-4be2-865f-e6fd17cc9c36')


select visitor_id,country_code, pc_code
from all_visitors V
where exists (select 1 from all_visitors V2 where V.visitor_id = V2.visitor_id and V.country_code <> V2.country_code )

select
creation_date, update_date, last_visit_date, barcode, account_type, origin_type, email_verified, email_invalid, phone_verified, phone_invalid, email, birthdate, optin_push, optin_geoloc, optin_sms, optin_loyalty, optin_commercial, optin_wallet, commercial_optout_email, loyalty_optout_email, visitor_id, address_zip_code, address_city, address_street, gender, first_name, last_name, timezone, acquisition_pc_code, is_inactive, count_email_4d, count_email_7d, family, fashion, services, sport, food, beauty, home, entertainment, luxury, automotive, technology, travel, phone, is_tlp, pc_code, game_name, start_date, balance, last_purchase_date, is_bank, is_restaurant, is_scan, end_date, threshold, action, wallet_context_id, center_app_id, wallet_pass_name, visitor_private_id, is_favorite, center_company_id, country_code, locale, community_id, community_name, top_segment, community_to_push, client_type, client_type_date, score_nps, nps_date
from ent.ES_Partial_EmailValid E
where pc_code='ES-SC-01060' and not exists (select 1 from ent.ES_Partial_EmailValid E2
    where E.visitor_id = E2.visitor_id and E2.pc_code <> 'ES-SC-01060'
 )

Old version de la Query Hamburg :
Select creation_date, update_date, last_visit_date, barcode, account_type, origin_type, email_verified, email_invalid, phone_verified, phone_invalid, email, birthdate, optin_push, optin_geoloc, optin_sms, optin_loyalty, optin_commercial, optin_wallet, commercial_optout_email, loyalty_optout_email, visitor_id, address_zip_code, address_city, address_street, gender, first_name, last_name, timezone, acquisition_pc_code, is_inactive, count_email_4d, count_email_7d, family, fashion, services, sport, food, beauty, home, entertainment, luxury, automotive, technology, travel, phone, is_tlp, pc_code, game_name, start_date, balance, last_purchase_date, is_bank, is_restaurant, is_scan, end_date, threshold, action, wallet_context_id, center_app_id, wallet_pass_name, visitor_private_id, is_favorite, center_company_id, country_code, locale, community_id, community_name, top_segment, community_to_push, client_type, client_type_date, score_nps, nps_date
From all_visitors av
Where pc_code = 'DE-SC-UB001' and optin_loyalty = 1 and account_type = 'full' and client_type is not null 
and CONVERT(DATE, av.client_type_date) = DATEADD(dd,-1,CONVERT(DATE,GETDATE()))

Version actualisée du 21/05/24 :
Select av.creation_date, update_date, last_visit_date, barcode, account_type, origin_type, email_verified, email_invalid
, phone_verified, phone_invalid, email, birthdate, optin_push, optin_geoloc, optin_sms, optin_loyalty, optin_commercial
, optin_wallet, commercial_optout_email, loyalty_optout_email, av.visitor_id, address_zip_code, address_city
, address_street, gender, first_name, last_name, timezone, acquisition_pc_code, is_inactive, count_email_4d
, count_email_7d, family, fashion, services, sport, food, beauty, home, entertainment, luxury, automotive, technology
, travel, phone, is_tlp, av.pc_code, game_name, start_date, balance, last_purchase_date, is_bank, is_restaurant, is_scan
, end_date, threshold, action, wallet_context_id, center_app_id, wallet_pass_name, av.visitor_private_id, is_favorite
, center_company_id, country_code, locale, community_id, community_name, top_segment, community_to_push, score_nps
, nps_date, ct.client_type, ct.client_type_date
From all_visitors av
Inner Join client_type ct
On av.visitor_id = ct.visitor_id
Where pc_code = 'DE-SC-UB001' and optin_loyalty = 1 and account_type = 'full' and ct.client_type is not null 
and CONVERT(DATE, ct.client_type_date) = DATEADD(dd,-1,CONVERT(DATE,GETDATE()))