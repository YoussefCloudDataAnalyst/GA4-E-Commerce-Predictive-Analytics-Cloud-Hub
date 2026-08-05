-- ============================================================================
-- AUTHOR: Youssef Jadir
-- DESCRIPTION: Trains BigQuery ML propensity model & scores user target cohorts
-- MODEL: ga4_staging.model_purchase_propensity
-- ============================================================================

-- 1. Train Logistic Regression Model
CREATE OR REPLACE MODEL `ga4-predictive-analytics-cloud.ga4_staging.model_purchase_propensity`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['will_purchase']
) AS
SELECT
  user_pseudo_id,
  total_pageviews,
  total_cart_adds,
  total_time_on_site_seconds,
  will_purchase
FROM `ga4-predictive-analytics-cloud.ga4_staging.train_user_features`;

-- 2. Predict Propensity & Segment Audience Tiers
CREATE OR REPLACE TABLE `ga4-predictive-analytics-cloud.ga4_staging.mart_predictive_retargeting` AS
SELECT
  user_pseudo_id,
  prob AS propensity_score,
  CASE 
    WHEN prob >= 0.75 THEN 'High Intent (Target)'
    WHEN prob BETWEEN 0.25 AND 0.74 THEN 'Med. Intent (Discount)'
    ELSE 'Low Intent (Passive)'
  END AS marketing_action_segment
FROM ML.PREDICT(
  MODEL `ga4-predictive-analytics-cloud.ga4_staging.model_purchase_propensity`,
  (SELECT * FROM `ga4-predictive-analytics-cloud.ga4_staging.test_user_features`)
),
UNNEST(predicted_will_purchase_probs)
WHERE label = 1;
