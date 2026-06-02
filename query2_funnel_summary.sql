SELECT
  event_name,
  COUNT(DISTINCT CONCAT(
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id'),
    user_pseudo_id
  )) AS session_count,
  CASE event_name
    WHEN 'session_start' THEN 1
    WHEN 'view_item' THEN 2
    WHEN 'add_to_cart' THEN 3
    WHEN 'begin_checkout' THEN 4
    WHEN 'add_shipping_info' THEN 5
    WHEN 'add_payment_info' THEN 6
    WHEN 'purchase' THEN 7
  END AS funnel_step


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


GROUP BY event_name
ORDER BY funnel_step
