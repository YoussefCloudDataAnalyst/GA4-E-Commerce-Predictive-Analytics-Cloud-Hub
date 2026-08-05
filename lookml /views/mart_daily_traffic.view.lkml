# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: LookML View for Traffic Acquisition Staging Data Mart
# ============================================================================

view: mart_daily_traffic {
  sql_table_name: `ga4-predictive-analytics-cloud.ga4_staging.vw_clean_traffic_acquisition` ;;

  # --------------------------------------------------------------------------
  # DIMENSIONS
  # --------------------------------------------------------------------------
  dimension: clean_traffic_source {
    type: string
    sql: ${TABLE}.clean_traffic_source ;;
    description: "Cleansed acquisition traffic source (e.g., Google Organic, Direct, Google Ads)"
  }

  dimension: clean_traffic_medium {
    type: string
    sql: ${TABLE}.clean_traffic_medium ;;
    description: "Cleansed acquisition medium (e.g., organic, cpc, referral)"
  }

  # --------------------------------------------------------------------------
  # MEASURES
  # --------------------------------------------------------------------------
  measure: total_sessions {
    type: sum
    sql: ${TABLE}.total_sessions ;;
    value_format_name: decimal_0
    description: "Total session volume across acquisition channels"
  }

  measure: total_users {
    type: sum
    sql: ${TABLE}.total_users ;;
    value_format_name: decimal_0
    description: "Distinct count of active users"
  }

  measure: avg_sessions_per_user {
    type: number
    sql: 1.0 * ${total_sessions} / NULLIF(${total_users}, 0) ;;
    value_format_name: decimal_2
    description: "Average session intensity per unique user"
  }
}
