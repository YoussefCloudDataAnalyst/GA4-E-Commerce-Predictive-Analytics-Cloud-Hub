# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: Enterprise LookML Model Definition for GA4 E-Commerce Analytics
# ============================================================================

connection: "ga4-predictive-analytics-cloud"

# Include all view definitions
include: "/views/*.view.lkml"

label: "GA4 E-Commerce & Predictive Analytics Hub"

# ----------------------------------------------------------------------------
# EXPLORE: Traffic Acquisition & Engagement
# ----------------------------------------------------------------------------
explore: mart_daily_traffic {
  label: "Traffic Acquisition & Channels"
  description: "Session-level and user-level traffic acquisition metrics across clean marketing channels."
}

# ----------------------------------------------------------------------------
# EXPLORE: E-Commerce Product Conversion Funnel
# ----------------------------------------------------------------------------
explore: mart_product_funnel {
  label: "Merchandising & Product Funnel"
  description: "Product-level conversion tracking from detail views to completed purchases."
}

# ----------------------------------------------------------------------------
# EXPLORE: AI Predictive Audience & Retargeting
# ----------------------------------------------------------------------------
explore: mart_predictive_retargeting {
  label: "AI Predictive Retargeting"
  description: "BigQuery ML purchase propensity scoring and automated target audience segmentation."
}
