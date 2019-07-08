view: bi_demo_sales_eps_tx_tp_other_payer_reject {
  label: "Tx Tp Other Payer Reject"
  sql_table_name: edw.f_tx_tp_other_payer_reject ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_other_payer_reject_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_other_payer_reject_id {
    label: "Tx Tp Other Payer Reject Id"
    type: number
    description: "Unique ID of the TP_OTHER_PAYER_REJECTS record"
    hidden: yes
    sql: ${TABLE}.tx_tp_other_payer_reject_id ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem."
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_other_payer_id {
    label: "TX_TP Other Payer Id"
    type: number
    description: "Foreign key to the TP_OTHER_PAYERS record"
    hidden: yes
    sql: ${TABLE}.tx_tp_other_payer_id ;;
  }

  ############################################################## Dimensions ######################################################

  dimension: tx_tp_other_payer_reject_code {
    label: "Other Payer Reject Code"
    description: "Error encountered by the previous other payer"
    type: string
    sql: ${TABLE}.tx_tp_other_payer_reject_code ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    hidden: yes
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}
