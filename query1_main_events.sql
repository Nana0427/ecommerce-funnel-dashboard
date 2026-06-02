SELECT
  event_date,
  TIMESTAMP_MICROS(event_timestamp) AS event_time,
  event_name,
 
  -- Oturum ID
  (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
 
  -- Trafik kaynağı
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  traffic_source.name AS campaign,
 
  -- Cihaz bilgileri
  device.category AS device_category,
  device.language AS device_language,
  device.operating_system AS operating_system,
 
  -- Açılış sayfası
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS landing_page,
 
  -- Satın alma geliri
  ecommerce.purchase_revenue AS revenue


FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`


WHERE
  event_name IN (
    'session_start',
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'add_shipping_info',
    'add_payment_info',
    'purchase'
  )
