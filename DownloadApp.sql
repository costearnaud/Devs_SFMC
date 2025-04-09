select
av.creation_date, av.update_date, av.last_visit_date, av.barcode, av.account_type, av.origin_type, av.email_verified, av.email_invalid, av.phone_verified, av.phone_invalid, av.email, av.birthdate, av.optin_push, av.optin_geoloc, av.optin_sms, av.optin_loyalty, av.optin_commercial, av.optin_wallet, av.commercial_optout_email, av.loyalty_optout_email, av.visitor_id, av.address_zip_code, av.address_city, av.address_street, av.gender, av.first_name, av.last_name, av.timezone, av.acquisition_pc_code, av.is_inactive, av.count_email_4d, av.count_email_7d, av.family, av.fashion, av.services, av.sport, av.food, av.beauty, av.home, av.entertainment, av.luxury, av.automotive, av.technology, av.travel, av.phone, av.is_tlp, pc_code, av.game_name, av.start_date, av.balance, av.last_purchase_date, av.is_bank, av.is_restaurant, av.is_scan, av.end_date, av.threshold, av.action, av.wallet_context_id, av.center_app_id, av.wallet_pass_name, av.visitor_private_id, av.is_favorite, av.center_company_id, av.country_code, av.locale, av.community_id, av.community_name, av.top_segment, av.community_to_push
from all_visitors av
left join ent.device_app a on  av.visitor_id = a.visitor_id
where
a.visitor_id is null
and av.account_type = 'full'
and av.pc_code NOT IN ('US-SC-001', 'US-SC-004', 'US-SC-006', 'US-SC-021', 'US-SC-020', 'US-SC-024', 'US-SC-025', 'US-SC-039', 'US-SC-040', 'US-SC-045', 'US-SC-046', 'US-SC-056', 'US-SC-062', 'US-SC-067', 'US-SC-070', 'US-SC-071', 'US-SC-078', 'US-SC-088', 'US-SC-050', 'US-SC-069') 
and av.email_invalid = 'false'
and av.optin_loyalty = 'true'
and av.acquisition_pc_code = av.pc_code

--> devient

select
av.creation_date, av.update_date, av.last_visit_date, av.barcode, av.account_type, av.origin_type, av.email_verified, av.email_invalid, av.phone_verified, av.phone_invalid, av.email, av.birthdate, av.optin_push, av.optin_geoloc, av.optin_sms, av.optin_loyalty, av.optin_commercial, av.optin_wallet, av.commercial_optout_email, av.loyalty_optout_email, av.visitor_id, av.address_zip_code, av.address_city, av.address_street, av.gender, av.first_name, av.last_name, av.timezone, av.acquisition_pc_code, av.is_inactive, av.count_email_4d, av.count_email_7d, av.family, av.fashion, av.services, av.sport, av.food, av.beauty, av.home, av.entertainment, av.luxury, av.automotive, av.technology, av.travel, av.phone, av.is_tlp, pc_code, av.game_name, av.start_date, av.balance, av.last_purchase_date, av.is_bank, av.is_restaurant, av.is_scan, av.end_date, av.threshold, av.action, av.wallet_context_id, av.center_app_id, av.wallet_pass_name, av.visitor_private_id, av.is_favorite, av.center_company_id, av.country_code, av.locale, av.community_id, av.community_name, av.top_segment, av.community_to_push
from all_visitors av
-- Exclure les visitor_id qui ont un pc_code associé à une app dans device_app
not exists(select 1 from ent.PROD_center_details c inner join ent.device_app d
    on c.center_app_id = d.app_name where c.pc_code = av.pc_code)
and av.account_type = 'full'
and av.pc_code NOT IN ('US-SC-001', 'US-SC-004', 'US-SC-006', 'US-SC-021', 'US-SC-020', 'US-SC-024', 'US-SC-025', 'US-SC-039', 'US-SC-040', 'US-SC-045', 'US-SC-046', 'US-SC-056', 'US-SC-062', 'US-SC-067', 'US-SC-070', 'US-SC-071', 'US-SC-078', 'US-SC-088', 'US-SC-050', 'US-SC-069') 
and av.email_invalid = 'false'
and av.optin_loyalty = 'true'
and av.acquisition_pc_code = av.pc_code