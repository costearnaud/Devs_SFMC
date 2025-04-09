SELECT country, type, email_name, email_code, block_name,
'HeaderHtml' as snippet,
'Header' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_header'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'SubjectPreheaderHtml' as snippet,
'Subject and Preheader' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_subject_preheader'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'Intro1Html' as snippet,
'Intro One' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_intro1'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'Intro2Html' as snippet,
'Intro Two' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_intro2'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'Intro3Html' as snippet,
'Intro Three' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_intro3'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'Intro4Html' as snippet,
'Intro Four' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_intro4'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'ComPillarsHtml' as snippet,
'Four Pillars' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_fourpillars'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'AtfHtml' as snippet,
'Add us to Favorites' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_addustoyourfavorites'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'FooterHtml' as snippet,
'Footer' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_footer'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'AppDownloadHtml' as snippet,
'App Download' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_appdownload'

- snippets to create --> TODO
- data_email_composition to update --> DONE

SELECT country, type, email_name, email_code, block_name,
'WalletDownloadHtml' as snippet,
'Wallet Download' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_walletdownload'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'WalletPromoHtml' as snippet,
'Wallet Promotion' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_wallet_promotion'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'OffersHtml' as snippet,
'Offers' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_offers'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'TwoPillarsHtml' as snippet,
'Two Pillars' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_two_pillars'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'ReviewHtml' as snippet,
'Review' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_review'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'InteractiveInterestHtml' as snippet,
'Interactive interest' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_interactive_interest'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'SliderHtml' as snippet,
'Slider' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_slider'
--> DONE

SELECT country, type, email_name, email_code, block_name,
'SliderFixeHtml' as snippet,
'Slider One Slide' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_slider_fixe'
--> NOT TODO

SELECT country, type, email_name, email_code, block_name,
'???' as snippet,
'???' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_title_text_cta'
--> NOT TODO

SELECT country, type, email_name, email_code, block_name,
'OneMessageHtml' as snippet,
'One Message' as block_label
FROM ent.data_email_composition
WHERE block_name = 'data_trad_one_message'
--> DONE
