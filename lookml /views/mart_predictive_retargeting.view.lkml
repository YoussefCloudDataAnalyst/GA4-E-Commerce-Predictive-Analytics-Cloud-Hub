# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: LookML View for BigQuery ML Propensity Output with Visual Badges
# ============================================================================

view: mart_predictive_retargeting {
  sql_table_name: `ga4-predictive-analytics-cloud.ga4_staging.mart_predictive_retargeting` ;;

  # --------------------------------------------------------------------------
  # DIMENSIONS
  # --------------------------------------------------------------------------
  dimension: user_pseudo_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.user_pseudo_id ;;
  }

  dimension: marketing_action_segment {
    type: string
    sql: ${TABLE}.marketing_action_segment ;;
    description: "Actionable audience tier: High Intent (Target), Med. Intent (Discount), Low Intent (Passive)"
    # Advanced Liquid HTML: Render visual badge indicators directly in Looker tables
    html:
      {% if value == 'High Intent (Target)' %}
        <span style="color: white; background-color: #27ae60; padding: 4px 8px; border-radius: 4px; font-weight: bold;">🎯 High Intent</span>
      {% elsif value == 'Med. Intent (Discount)' %}
        <span style="color: white; background-color: #2980b9; padding: 4px 8px; border-radius: 4px;">🏷️ Med Intent</span>
      {% else %}
        <span style="color: #7f8c8d; background-color: #ecf0f1; padding: 4px 8px; border-radius: 4px;">Low Intent</span>
      {% endif %} ;;
  }

  dimension: propensity_score {
    type: number
    sql: ${TABLE}.propensity_score ;;
    value_format_name: percent_2
  }

  # --------------------------------------------------------------------------
  # MEASURES
  # --------------------------------------------------------------------------
  measure: total_scored_users {
    type: count_distinct
    sql: ${user_pseudo_id} ;;
    value_format_name: decimal_0
  }

  measure: avg_propensity_score {
    type: average
    sql: ${propensity_score} ;;
    value_format_name: percent_2
  }

  measure: high_intent_target_score {
    type: average
    sql: ${propensity_score} ;;
    filters: [marketing_action_segment: "High Intent (Target)"]
    value_format_name: percent_2
    description: "Average propensity score for the high-intent retargeting cohort"
  }
}
