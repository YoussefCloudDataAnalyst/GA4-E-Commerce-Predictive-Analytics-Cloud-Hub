-- ============================================================================
-- AUTHOR: Youssef Jadir
-- DESCRIPTION: Aggregates daily session and user acquisition metrics
-- TABLE: ga4_staging.mart_daily_traffic_acquisition
-- ============================================================================

CREATE OR REPLACE TABLE `ga4-predictive-analytics-cloud.ga4_staging.mart_daily_traffic_acquisition` AS
SELECT
  PARSE_DATE('%Y%m%d', event_date) AS event_date,
  traffic_source.source AS utm_source,
  traffic_source.medium AS utm_medium,
  COUNT(DISTINCT CONCAT(user_pseudo_id, CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING))) AS total_sessions,
  COUNT(DISTINCT user_pseudo_id) AS total_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.ga4_events_*`
GROUP BY 1, 2, 3;
