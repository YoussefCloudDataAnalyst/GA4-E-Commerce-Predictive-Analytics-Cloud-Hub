# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: LookML View for E-Commerce Product Funnel & Revenue Metrics
# ============================================================================

view: mart_product_funnel {
  sql_table_name: `ga4-predictive-analytics-cloud.ga4_staging.mart_ecommerce_product_funnel` ;;

  # --------------------------------------------------------------------------
  # DIMENSIONS
  # --------------------------------------------------------------------------
  dimension: item_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.item_name ;;
    description: "Sanitized e-commerce item SKU/Name"
  }

  dimension: item_category {
    type: string
    sql: ${TABLE}.item_category ;;
    description: "Product merchandise category"
  }

  # --------------------------------------------------------------------------
  # MEASURES & CALCULATED RATIOS
  # --------------------------------------------------------------------------
  measure: total_item_views {
    type: sum
    sql: ${TABLE}.item_views ;;
    value_format_name: decimal_0
  }

  measure: total_cart_adds {
    type: sum
    sql: ${TABLE}.cart_adds ;;
    value_format_name: decimal_0
  }

  measure: total_purchases {
    type: sum
    sql: ${TABLE}.purchases ;;
    value_format_name: decimal_0
  }

  measure: total_product_revenue {
    type: sum
    sql: ${TABLE}.total_product_revenue ;;
    value_format_name: usd
  }

  # Conversion Rate Ratios
  measure: cart_to_detail_view_rate {
    type: number
    sql: 1.0 * ${total_cart_adds} / NULLIF(${total_item_views}, 0) ;;
    value_format_name: percent_2
    description: "Percentage of product detail views converting to cart additions"
  }

  measure: purchase_to_cart_rate {
    type: number
    sql: 1.0 * ${total_purchases} / NULLIF(${total_cart_adds}, 0) ;;
    value_format_name: percent_2
    description: "Percentage of cart additions completing a final purchase"
  }
}
