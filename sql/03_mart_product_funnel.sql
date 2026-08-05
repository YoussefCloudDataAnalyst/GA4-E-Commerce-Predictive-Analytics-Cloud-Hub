-- ============================================================================
-- AUTHOR: Youssef Jadir
-- DESCRIPTION: Tracks e-commerce merchandise conversion progression per product
-- TABLE: ga4_staging.mart_ecommerce_product_funnel
-- ============================================================================

CREATE OR REPLACE TABLE `ga4-predictive-analytics-cloud.ga4_staging.mart_ecommerce_product_funnel` AS
SELECT
  items.item_name AS item_name,
  items.item_category AS item_category,
  
  -- Funnel Step Aggregations
  COUNTIF(event_name = 'view_item') AS item_views,
  COUNTIF(event_name = 'add_to_cart') AS cart_adds,
  COUNTIF(event_name = 'purchase') AS purchases,
  SUM(IF(event_name = 'purchase', items.price * items.quantity, 0)) AS total_product_revenue

FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.ga4_events_*`,
UNNEST(items) AS items
GROUP BY 1, 2;
