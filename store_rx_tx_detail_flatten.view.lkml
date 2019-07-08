#[ERXDWPS-8260] COSTCO SOW - Moving Average Cost - Sales Looker Dimensions and Measures
view: store_rx_tx_detail_flatten {
  sql_table_name: EDW.F_STORE_RX_TX_DETAIL_FLATTEN ;;

  dimension: chain_id {
    type: string
    hidden: yes
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension: nhin_store_id {
    type: string
    hidden: yes
    sql: ${TABLE}."NHIN_STORE_ID" ;;
  }

  dimension: rx_id {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_ID" ;;
  }

  dimension: rx_tx_drug_dispensed_id {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_TX_DRUG_DISPENSED_ID" ;;
  }

  dimension_group: rx_tx_fill {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RX_TX_FILL_DATE" ;;
  }

  dimension: rx_tx_fill_quantity {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_TX_FILL_QUANTITY" ;;
  }

  dimension: rx_tx_id {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_TX_ID" ;;
  }

  dimension: rx_tx_moving_average_cost_per_unit_at_fill_date {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_TX_MOVING_AVERAGE_COST_PER_UNIT_AT_FILL_DATE" ;;
  }

  dimension_group: rx_tx_reportable_sales {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RX_TX_REPORTABLE_SALES_DATE" ;;
  }

  dimension_group: rx_tx_returned {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RX_TX_RETURNED_DATE" ;;
  }

  dimension: rx_tx_total_moving_average_cost_at_fill_date {
    type: string
    hidden: yes
    sql: ${TABLE}."RX_TX_TOTAL_MOVING_AVERAGE_COST_AT_FILL_DATE" ;;
  }

  dimension_group: rx_tx_will_call_picked_up {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RX_TX_WILL_CALL_PICKED_UP_DATE" ;;
  }

  dimension: source_system_id {
    type: string
    hidden: yes
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

}
