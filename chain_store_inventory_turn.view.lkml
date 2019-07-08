view: chain_store_inventory_turn {
  sql_table_name: REPORT_TEMP.CHAIN_STORE_INVENTORY_TURN ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_drug_dispensed_id} || '@'|| ${inventory_date};;
  }

  dimension: chain_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_drug_dispensed_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.RX_TX_DRUG_DISPENSED_ID ;;
  }

  dimension: days_diff_between_inv_date_and_earliest_wc_date {
    hidden:  yes
    type: number
    sql: ${TABLE}.DAYS_DIFF_BETWEEN_INV_DATE_AND_EARLIEST_WC_DATE ;;
  }

  dimension_group: inventory {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.INVENTORY_DATE ;;
  }

  measure: sum_cogs_30 {
    label: "Total COGS (30)"
    description: "Total Cost of Goods Sold in last 30 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.COGS_30 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_cogs_30 {
    label: "Average COGS (30)"
    description: "Average Cost of Goods Sold in last 30 days of dispensing activity based on the inventory period selected"
    type: average
    sql: ${TABLE}.COGS_30 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_cogs_180 {
    label: "Total COGS (180)"
    description: "Total Cost of Goods Sold in last 180 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.COGS_180 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_cogs_180 {
    label: "Average COGS (180)"
    description: "Average Cost of Goods Sold in last 180 days of dispensing activity based on the inventory period selected"
    type: average
    sql: ${TABLE}.COGS_180 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_cogs_365 {
    label: "Total COGS (365)"
    description: "Total Cost of Goods Sold in last 365 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.COGS_365 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_cogs_365 {
    label: "Average COGS (365)"
    description: "Average Cost of Goods Sold in last 365 days of dispensing activity based on the inventory period selected"
    type: average
    sql: ${TABLE}.COGS_365 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_inventory_turns_180 {
    label: "Total Inventory Turns (180)"
    hidden: yes
    description: "Total Inventory Turns in last 180 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.INVENTORY_TURNS_180 ;;
    value_format: "#,##0.00"
  }

  measure: avg_inventory_turns_180 {
    label: "Average Inventory Turns (180)"
    description: "Average Inventory Turns in last 180 days of dispensing activity based on the inventory period selected"
    type: number
    sql: ((SUM(${TABLE}.COGS_180)/180)*365)/nullif(SUM(${TABLE}.ENDING_INVENTORY, 0)) ;;
    value_format: "#,##0.00"
  }

  measure: sum_inventory_turns_30 {
    label: "Total Inventory Turns (30)"
    hidden: yes
    description: "Total Inventory Turns in last 30 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.INVENTORY_TURNS_30 ;;
    value_format: "#,##0.00"
  }

  measure: avg_inventory_turns_30 {
    label: "Average Inventory Turns (30)"
    description: "Average Inventory Turns in last 30 days of dispensing activity based on the inventory period selected"
    type: number
    sql: ((SUM(${TABLE}.COGS_30)/30)*365)/nullif(SUM(${TABLE}.ENDING_INVENTORY), 0) ;;
    value_format: "#,##0.00"
  }

  measure: sum_inventory_turns_365 {
    label: "Total Inventory Turns (365)"
    hidden: yes
    description: "Total Inventory Turns in last 365 days of dispensing activity based on the inventory period selected"
    type: sum
    sql: ${TABLE}.INVENTORY_TURNS_365 ;;
    value_format: "#,##0.00"
  }

  measure: avg_inventory_turns_365 {
    label: "Average Inventory Turns (365)"
    description: "Average Inventory Turns in last 365 days of dispensing activity based on the inventory period selected"
    type: number
    sql: SUM(${TABLE}.COGS_365)/nullif(SUM(${TABLE}.ENDING_INVENTORY, 0)) ;;
    value_format: "#,##0.00"
  }

  measure: sum_ending_inventory {
    label: "Total Ending Inventory"
    description: "Total Ending Inventory based on the inventory period selected"
    type: sum
    sql: ${TABLE}.ENDING_INVENTORY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_ending_inventory {
    label: "Average Ending Inventory"
    description: "Average Ending Inventory based on the inventory period selected"
    type: sum
    sql: ${TABLE}.ENDING_INVENTORY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: drug_local_setting_on_hand {
    hidden:  yes
    type: number
    sql: ${TABLE}.DRUG_LOCAL_SETTING_ON_HAND ;;
  }

  measure: sum_store_drug_cost_unit_cost {
    hidden:  yes
    type: sum
    sql: ${TABLE}.STORE_DRUG_COST_UNIT_COST ;;
  }
}
