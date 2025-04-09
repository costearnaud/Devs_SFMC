SELECT CONVERT(DATE, GETDATE(), 120) as KPIsDate, 
count(case when account_type='partial' and optin_commercial = 1 then 1 end) as partialOptin,
count(case when account_type='full' and optin_commercial = 1 and optin_loyalty = 1 then 1 end) as fullOptin,
count(case when account_type='full' and optin_commercial = 1 and optin_loyalty = 0 then 1 end) as fullOptinCommercial,
count(case when account_type='full' and optin_commercial = 0 and optin_loyalty = 1 then 1 end) as fullOptinLoyalty,
count(case when account_type='full' and optin_commercial = 0 and optin_loyalty = 0 then 1 end) as fullOptout
FROM ent.visitor_repository
WHERE ingestion_date GETUTCDATE()

select top 100 visitor_id, ingestion_date, update_date
FROM ent.visitor_repository
ORDER BY CONVERT(DATE, update_date, 112) desc

SELECT GETDATE() AS CurrentTime, GETUTCDATE() AS UTCTime

SELECT CONVERT(datetime,ingestion_date)
    AT TIME ZONE 'UTC'


France <=> ??

    Central European Standard Time

    select top 100 visitor_id, ingestion_date, CONVERT(CHAR(8), ingestion_date, 112) as ingestion_date_NEW, CONVERT(CHAR(8), GETDATE(), 112) as DateCourante
FROM ent.visitor_repository
ORDER BY CAST(CONVERT(CHAR(19), ingestion_date, 120) as DATETIME) desc
SELECT TOP 10 ingestion_date
AT TIME ZONE 'UTC' 
AT TIME ZONE 'Central European Standard Time' as ingestion_date
FROM ent.visitor_repository
ORDER BY CAST(CONVERT(CHAR(19), ingestion_date, 120) as DATETIME) desc

SELECT TOP 10 DATEADD(hour, 6, ingestion_date
AT TIME ZONE 'UTC' 
AT TIME ZONE 'Central European Standard Time') as ingestion_date_CET
FROM ent.visitor_repository
ORDER BY CAST(CONVERT(CHAR(19), ingestion_date, 120) as DATETIME) desc

SELECT TOP 10 FORMAT(ingestion_date,'yyyy-MM-dd:HH') as ingestion,
FORMAT(GETDATE(),'yyyy-MM-dd:HH') as currentDate
FROM ent.visitor_repository
ORDER BY CAST(CONVERT(CHAR(19), ingestion_date, 120) as DATETIME) desc

SELECT TOP 10 FORMAT(ingestion_date,'yyyy-MM-dd:HH') as ingestion,
FORMAT(GETDATE(),'yyyy-MM-dd:HH') as currentDate
FROM ent.DEV_visitor_repository
ORDER BY CAST(CONVERT(CHAR(19), ingestion_date, 120) as DATETIME) desc