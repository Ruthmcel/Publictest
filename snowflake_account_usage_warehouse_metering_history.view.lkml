view: snowflake_account_usage_warehouse_metering_history {
  sql_table_name: SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${warehouse_name} ||'@'|| ${start_time} ||'@'|| ${end_time} ;;
  }

  dimension: warehouse_name {
    label: "Warehouse"
    description: "Name of the warehouse"
    type: string
    sql: ${TABLE}.WAREHOUSE_NAME ;;
  }

  dimension: environment {
    label: "Environment"
    description: "Name of the Environment (NON-PRODUCTION vs. PRODUCTION). DEV, QA, CUST_TEST gets rolled into NON-PRODUCTION"
    type: string
    sql: CASE WHEN ${TABLE}.WAREHOUSE_NAME LIKE '%DEV_QA%' OR ${TABLE}.WAREHOUSE_NAME LIKE '%CUST_TEST%' OR ${TABLE}.WAREHOUSE_NAME LIKE '%NON_PROD%' THEN 'NON-PRODUCTION'
         WHEN ${TABLE}.WAREHOUSE_NAME = 'SFSUPPORT_WH' THEN 'SNOWFLAKE SUPPORT'
         ELSE 'PRODUCTION' END;;
  }

  dimension: chain_name {
    label: "Chain"
    description: "Name of the Chain"
    type: string
    sql: CASE WHEN ${TABLE}.WAREHOUSE_NAME LIKE 'XT_%' THEN SUBSTRING(${TABLE}.WAREHOUSE_NAME,POSITION('XT' IN ${TABLE}.WAREHOUSE_NAME)+3) ELSE 'PDX' END ;;
  }

# ERXDWPS-6673 Changes
  dimension: product_name {
    label: "Product"
    description: "Name of the product"
    type: string
    sql: CASE WHEN ${TABLE}.WAREHOUSE_NAME LIKE '%INVENTORY%' THEN 'TurnRx'
              WHEN ${TABLE}.WAREHOUSE_NAME = 'PDX_CUST_TEST_RPT' THEN 'TurnRx'
              WHEN ${TABLE}.WAREHOUSE_NAME LIKE '%ABSOLUTE_AR%' THEN 'Absolute AR'
              WHEN ${TABLE}.WAREHOUSE_NAME LIKE '%CARE_RX%' THEN 'CareRx'
              ELSE 'Explore Dx' END;;
  }

  dimension_group: start {
    label: "Warehouse Start"
    description: "The beginning of the hour in which this warehouse usage took place"
    type: time
#     timeframes: [
#       raw,
#       time,
#       hour_of_day,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.START_TIME) ;;
    sql: ${TABLE}.START_TIME ;;
  }


  dimension_group: end {
    label: "Warehouse End"
    description: "The end of the hour in which this warehouse usage took place"
    type: time
#     timeframes: [
#       raw,
#       time,
#       hour_of_day,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.END_TIME) ;;
    sql: ${TABLE}.END_TIME ;;
  }

  measure: sum_warehouses {
    label: "Total Warehouses"
    description: "Total Number of warehouses in this hour"
    type: count_distinct
    sql: ${warehouse_name} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_credits_used {
    label: "Total Warehouse Credits Billed/Used"
    description: "Total Number of credits billed for this warehouse in this hour"
    type: sum
    sql: ${TABLE}.CREDITS_USED ;;
    value_format: "#,##0.000;(#,##0.000)"
  }

  measure: avg_credits_used {
    label: "Average Warehouse Credits Billed/Used"
    description: "Average Number of credits billed for this warehouse in this hour"
    type: average
    sql: ${TABLE}.CREDITS_USED ;;
    value_format: "#,##0.000;(#,##0.000)"
  }

  measure: sum_dollars_spent_per_credit {
    label: "Total Dollars Spent"
    description: "Total dollars spent in this hour"
    type: sum
    sql: (${TABLE}.CREDITS_USED*2.65) ;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

  measure: avg_dollars_spent_per_credit {
    label: "Average Dollars Spent"
    description: "Average dollars spent in this hour"
    type: sum
    sql: (${TABLE}.CREDITS_USED*2.65) ;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

# ERXDWPS-6019 Changes to revenue stream bucket
  measure: sum_revenu_per_credit {
    label: "Total Revenue"
    description: "Total revenue in this hour"
    type: sum
    sql: CASE WHEN ${chain_name} <> 'PDX' THEN (${TABLE}.CREDITS_USED*5.50) ELSE NULL END;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

  measure: avg_revenue_per_credit {
    label: "Average Revenue"
    description: "Average revenue in this hour"
    type: average
    sql: CASE WHEN ${chain_name} <> 'PDX' THEN (${TABLE}.CREDITS_USED*5.50) ELSE NULL END;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

  measure: sum_gross_margin_per_credit {
    label: "Total Gross Margin"
    description: "Total gross margin in this hour"
    type: number
    sql: ${sum_revenu_per_credit} - ${sum_dollars_spent_per_credit} ;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

  measure: avg_gross_margin_per_credit {
    label: "Average Gross Margin"
    description: "Average gross margin in this hour"
    type: number
    sql: ${avg_revenue_per_credit} - ${avg_dollars_spent_per_credit} ;;
    value_format: "$#,##0.000;($#,##0.000)"
  }

  measure: hours_used {
    label: "Hours Used"
    description: "Indicates 1, if a query was initiated by a user during a specific hour. Please use this measure wisely !!!"
      type: count_distinct # max can sometime overstate this number so usage of this measure depends on the level of the grain you are.
    sql: ${start_hour};;
  }
}
