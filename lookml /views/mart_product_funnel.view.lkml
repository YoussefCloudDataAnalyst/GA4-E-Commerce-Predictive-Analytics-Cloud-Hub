# ============================================================================
# AUTHOR: Youssef Jadir
# DESCRIPTION: LookML View using Persistent Derived Tables (PDT) & Advanced Liquid
# ============================================================================

view: mart_product_funnel {
  
  # --------------------------------------------------------------------------
  # PERSISTENT DERIVED TABLE (PDT) DEFINITION
  # --------------------------------------------------------------------------
  # Pre-computes heavy product event unnesting in BigQuery to boost dashboard performance
  derived_table: {
    datagroup_trigger: ga4_daily_etl_datagroup
    cluster_keys: ["item_category"]
    partition_by: {
      field: "created_at"
      data_type: "date"
      granularity: "day"
    }
    sql:
      SELECT
        CURRENT_DATE() AS created_at,
        items.item_name AS item_name,
        items.item_category AS item_category,
        COUNTIF(event_name = 'view_item') AS item_views,
        COUNTIF(event_name = 'add_to_cart') AS cart_adds,
        COUNTIF(event_name = 'purchase') AS purchases,
        SUM(IF(event_name = 'purchase', items.price * items.quantity, 0)) AS total_product_revenue
      FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.ga4_events_*`,
      UNNEST(items) AS items
      GROUP BY 1, 2, 3
    ;;
  }

  # --------------------------------------------------------------------------
  # DIMENSIONS & LIQUID FORMATTING
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
    # Advanced Parameter: Dynamic drill link for self-service analytics
    link: {
      label: "Filter Dashboard by {{ value }}"
      url: "/dashboards/ga4_ecommerce_hub?Category={{ value | url_encode }}"
    }
  }

  dimension_group: created_at {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.created_at ;;
  }

  # --------------------------------------------------------------------------
  # MEASURES & ADVANCED CALCULATED RATIOS
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
    # Visual Polish: Color formatting for zero values
    html: {% if value == 0 or value == null %} <span style="color: #999;">$0</span> {% else %} {{ rendered_value }} {% endif %} ;;
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
