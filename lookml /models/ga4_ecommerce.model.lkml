# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: Enterprise LookML Model Definition with Caching & Governance
# ============================================================================

connection: "ga4-predictive-analytics-cloud"

include: "/views/*.view.lkml"

label: "GA4 E-Commerce & Predictive Analytics Hub"

# ----------------------------------------------------------------------------
# ENTERPRISE CACHING POLICY (DATAGROUP)
# ----------------------------------------------------------------------------
# Invalidates cache daily at midnight or when new BigQuery partitions land
datagroup: ga4_daily_etl_datagroup {
  sql_trigger: SELECT MAX(PARSE_DATE('%Y%m%d', event_date)) FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.ga4_events_*` ;;
  max_cache_age: "24 hours"
}

persist_with: ga4_daily_etl_datagroup

# ----------------------------------------------------------------------------
# EXPLORE DEFINITIONS WITH ADVANCED JOINS & CACHING
# ----------------------------------------------------------------------------
explore: mart_daily_traffic {
  label: "1. Traffic Acquisition & Channel Attribution"
  description: "Session-level and user-level traffic acquisition metrics across clean marketing channels."
  persist_with: ga4_daily_etl_datagroup
}

explore: mart_product_funnel {
  label: "2. Merchandising & Conversion Funnel"
  description: "Product-level conversion tracking from detail views to completed purchases."
  persist_with: ga4_daily_etl_datagroup
}

explore: mart_predictive_retargeting {
  label: "3. AI Predictive Audience & Retargeting"
  description: "BigQuery ML purchase propensity scoring and automated target audience segmentation."
  persist_with: ga4_daily_etl_datagroup
}
