# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: LookML View mapping the BigQuery staging view `vw_clean_traffic_acquisition`
# ============================================================================

view: mart_clean_traffic_acquisition {
  sql_table_name: `ga4-predictive-analytics-cloud.ga4_staging.vw_clean_traffic_acquisition` ;;

  # --------------------------------------------------------------------------
  # DIMENSIONS
  # --------------------------------------------------------------------------
  dimension: clean_traffic_source {
    type: string
    sql: ${TABLE}.clean_traffic_source ;;
    description: "Cleansed acquisition traffic source (e.g., Google (Organic), Direct, Google Ads (CPC))"
    
    # Visual Polish: Liquid HTML badge rendering for executive tables
    html:
      {% if value == 'Google (Organic)' %}
        <span style="color: #4285F4; font-weight: bold;">🔍 {{ value }}</span>
      {% elsif value == 'Google Ads (CPC)' %}
        <span style="color: #0F9D58; font-weight: bold;">🎯 {{ value }}</span>
      {% elsif value == 'Direct' %}
        <span style="color: #DB4437; font-weight: bold;">⚡ {{ value }}</span>
      {% else %}
        <span>{{ value }}</span>
      {% endif %} ;;
  }

  dimension: clean_traffic_medium {
    type: string
    sql: ${TABLE}.clean_traffic_medium ;;
    description: "Cleansed acquisition medium (e.g., organic, cpc, referral, (none))"
  }

  # --------------------------------------------------------------------------
  # MEASURES
  # --------------------------------------------------------------------------
  measure: total_sessions {
    type: sum
    sql: ${TABLE}.total_sessions ;;
    value_format_name: decimal_0
    description: "Total session volume per acquisition channel"
  }

  measure: total_users {
    type: sum
    sql: ${TABLE}.total_users ;;
    value_format_name: decimal_0
    description: "Total unique users per acquisition channel"
  }
}
