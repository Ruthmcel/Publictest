view: rx_tx_lot_number {
  sql_table_name: EDW.F_TX_LOT_NUMBER ;;

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_tx_lot_number_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_LOT_NUMBER_ID ;;
  }

  dimension: rx_tx_lot_number_unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${rx_tx_lot_number_id} ;; #ERXLPS-1649
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: lot_number {
    type: string
    label: "Prescription Lot Number"
    description: "Prescription transaction lot number"
    sql: ${TABLE}.TX_LOT_NUMBER ;;
  }

  dimension: lot_number_counter {
    type: number
    label: "Prescription Lot Number Counter"
    description: "Counter that increments with each record added for a given transaction number."
    sql: ${TABLE}.TX_LOT_NUMBER_COUNTER ;;
  }

  dimension_group: lot_number_drug_expiration {
    label: "Prescription Lot Number Drug Exp"
    description: "Transaction lot Drug expiration date"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.TX_LOT_NUMBER_DRUG_EXPIRE_DATE ;;
  }

  measure: rx_tx_lot_number_count {
    label: "Prescription Lots Count"
    type: count
    value_format: "#,##0"
  }
}
