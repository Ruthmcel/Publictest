view: eps_rx_tx_payment {
  label: "Rx Tx Payment"
  sql_table_name: EDW.F_RX_TX_PAYMENT ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_payment_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN."
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_payment_id {
    label: "Rx Tx Payment Id"
    description: "Unique Id number identifying this record"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_PAYMENT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: sum_rx_tx_payment_amount {
    label: "Total Transaction Payment Amount"
    description: "Total patient net payment due; including discount but not tax from an individual precription filling (RX_TX record)"
    type: sum
    sql: ${TABLE}.RX_TX_PAYMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_payment_tax_amount {
    label: "Total Transaction Payment Tax Amount"
    description: "Total patient tax due from an individual prescription filling (RX_TX record)"
    type: sum
    sql: ${TABLE}.RX_TX_PAYMENT_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "Unique ID of RX_TX record associated with this payment"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: payment_id {
    label: "Payment Id"
    description: "Unique ID of PAYMENT record"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Rx Tx Payment Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis."
    hidden: yes
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  set: explore_rx_rx_tx_payment_4_13_candidate_list {
    fields: [
      sum_rx_tx_payment_amount,
      sum_rx_tx_payment_tax_amount
    ]
  }
}
