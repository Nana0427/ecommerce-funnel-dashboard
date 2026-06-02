SELECT
  event_date,
 
  -- Günlük toplam oturum sayısı
  COUNT(DISTINCT CASE WHEN event_name = 'session_start'
    THEN CONCAT(
      CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING),
      user_pseudo_id
    ) END) AS total_sessions,


  -- Günlük toplam sipariş sayısı  
  COUNT(DISTINCT CASE WHEN event_name = 'begin_checkout'
    THEN CONCAT(
      CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING),
      user_pseudo_id
    ) END) AS total_orders,


  -- Günlük toplam satış (purchase) sayısı
  COUNT(DISTINCT CASE WHEN event_name = 'purchase'
    THEN CONCAT(
      CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING),
      user_pseudo_id
    ) END) AS total_purchases,


  -- Günlük toplam gelir
  SUM(CASE WHEN event_name = 'purchase'
    THEN ecommerce.purchase_revenue ELSE 0 END) AS total_revenue,


  -- Segmentler
  device.category AS device_category,
  device.language AS device_language,
  device.operating_system AS operating_system,
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  traffic_source.name AS campaign,
 
  -- Açılış sayfası
  (SELECT value.string_value FROM UNNEST(event_params)
    WHERE key = 'page_location') AS landing_page


FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`


WHERE
  event_name IN (
    'session_start',
    'begin_checkout',
    'purchase'
  )


GROUP BY
  event_date,
  device_category,
  device_language,
  operating_system,
  source,
  medium,
  campaign,
  landing_page


ORDER BY event_date
