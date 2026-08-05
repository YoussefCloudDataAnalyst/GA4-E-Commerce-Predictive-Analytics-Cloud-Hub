-- ============================================================================
-- AUTHOR: Youssef Jadir
-- DESCRIPTION: Cleanses raw UTM parameters & system masks from GA4 export
-- VIEW: ga4_staging.vw_clean_traffic_acquisition
-- ============================================================================

CREATE OR REPLACE VIEW `ga4-predictive-analytics-cloud.ga4_staging.vw_clean_traffic_acquisition` AS
SELECT
  -- Cleaned Traffic Source Dimension
  CASE 
    WHEN LOWER(utm_source) LIKE '%data delet%' 
      OR LOWER(utm_source) LIKE '%<other>%' 
      OR utm_source IS NULL THEN 'Unassigned / Privacy Masked'
    
    WHEN LOWER(utm_source) LIKE '%google%' AND LOWER(utm_medium) = 'organic' THEN 'Google (Organic)'
    WHEN LOWER(utm_source) LIKE '%google%' AND LOWER(utm_medium) IN ('cpc', 'ppc') THEN 'Google Ads (CPC)'
    WHEN LOWER(utm_source) LIKE '%shop.google%' THEN 'Google Store Referral'
    WHEN LOWER(utm_source) = '(direct)' THEN 'Direct'
    
    ELSE INITCAP(utm_source)
  END AS clean_traffic_source,

  -- Cleaned Traffic Medium Dimension
  CASE 
    WHEN LOWER(utm_medium) LIKE '%data delet%' 
      OR LOWER(utm_medium) LIKE '%<other>%' 
      OR utm_medium IS NULL THEN 'Other / Unassigned'
    ELSE utm_medium
  END AS clean_traffic_medium,
  
  -- Metrics Aggregation
  SUM(total_sessions) AS total_sessions,
  SUM(total_users) AS total_users

FROM `ga4-predictive-analytics-cloud.ga4_staging.mart_daily_traffic_acquisition`
GROUP BY 1, 2;
