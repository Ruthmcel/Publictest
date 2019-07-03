view: bi_demo_sales_eps_tx_tp_transmit_reject {
  label: "Transmit Reject"
  sql_table_name: edw.F_TX_TP_TRANSMIT_REJECT ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_transmit_reject_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
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

  dimension: tx_tp_transmit_reject_id {
    label: "Tx Tp Transmit Reject Id"
    type: number
    description: "Unique Identification Value for the tx_tp_transmit_reject record"
    hidden: yes
    sql: ${TABLE}.TX_TP_TRANSMIT_REJECT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem."
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_transmit_queue_id {
    label: "Tx Tp Transmit Queue Id"
    type: number
    description: "ID of the third party transaction record associated with a third party transmit queue record.  Foreign Key to TX_TP table"
    hidden: yes
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ID ;;
  }

  ############################################################## Dimensions ######################################################

  dimension: tx_tp_transmit_reject_counter {
    label: "Transmit Reject Counter"
    description: "Transmit Reject Counter is populated by the system if more than one reject code is returned for a claim. If only one reject code is returned, the COUNTER column is null."
    type: number
    sql: ${TABLE}.TX_TP_TRANSMIT_REJECT_COUNTER ;;
  }

  dimension: standard_service_code_id {
    label: "Standard Service Code ID"
    description: "ID of the third party reject code record corresponding to a third party transmit reject record."
    type: number
    sql: ${TABLE}.STORE_STANDARD_SERVICE_CODE_ID ;;
  }

  dimension: tx_tp_transmit_reject_code {
    label: "Transmit Reject Code"
    description: "This is used when a non-standard reject code is received from third party.Meaning, we cannot find it in the STANDARD_SERVICE_CODES table.We write the code returned by the processor here."
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_REJECT_CODE ;;
  }

  dimension: tx_tp_transmit_reject_field_occurrence {
    label: "Transmit Reject Field Occurrence"
    description: "Identifies the counter number or occurrence of the field that is being rejected. Used to indicate rejects for repeating fields."
    type: number
    sql: ${TABLE}.TX_TP_TRANSMIT_REJECT_FIELD_OCCURRENCE ;;
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

  #ERXDWPS-7260 - Sync EPS TP_TRANSMIT_REJECTS to EDW
  dimension_group: tx_tp_transmit_reject_source_create {
    label: "Transmit Reject Source Create"
    description: "This is the date and time at which the record was created in the source application"
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }
}
